/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/impl/UserServiceImpl.java,v 1.3 2012/12/24 02:36:41 supyuser Exp $
 * $Revision: 1.3 $
 * $Date: 2012/12/24 02:36:41 $
 *
 *==============================================================================
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 * 
 * Created on 2012-5-14
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.service.impl;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.dao.OrgDao;
import com.smartcloud.crowdfunding.console.dao.UserDao;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.UserService;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.crowdfunding.console.util.DigestMessage;
import com.smartcloud.crowdfunding.console.util.DynaTreeUtil;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 删除和更新user的时候，用户角色也会变化
 * 
 * @author fred_2012-9-20
 * 
 */

public class UserServiceImpl implements UserService{

	@Reference
	private UserDao userDAO;// 注入此dao

	@Reference
	private OrgDao orgDAO;

	DynaTreeUtil treeUtil = new DynaTreeUtil();

	public void addUser(User user) {
		DigestMessage dm;
		try {
			dm = new DigestMessage(DigestMessage.ALG_MD5);
			user.setPassword(dm.cryptPassword(user.getPassword()));
		} catch (NoSuchAlgorithmException e) {
		}
		userDAO.addUser(user);
	}

	public User getUser(User user) {
		return userDAO.findUser(user);
	}

	public List<User> findUsers(User user, Page page) {
		return userDAO.findUsersWithPage(user, page);
	}

	public void removeUser(User user) {
		userDAO.removeUser(user);
	}

	public void updateUser(User user) {
		userDAO.updateUser(user);
	}

	/**
	 * orgId为登录用户的orgId,为root，一开始为空说明全查
	 * 
	 * org的attrId是o+主键，user的attrId是主键
	 * 
	 */

	public List<TreeNodeBean> fetchUserWithOrgTree(String[] userIds, String orgId) {
	
		List<TreeNodeBean> tree=new ArrayList<TreeNodeBean>();
		
		List<Org> orgs = new ArrayList<Org>();
		List<User> users = new ArrayList<User>();
		if (StringUtils.isEmpty(orgId)) {
			orgs = orgDAO.getAllOrgs();// 获得根机构和没机构的用户
			users = userDAO.findAllUsersNoOrg();
		} else {
			Org org=new Org();
			org.setOrgId(Long.parseLong(orgId));
			org=orgDAO.find(org);
			orgs=orgDAO.getChildrenOrgs(org.getOrgPath());
		}
		
		for (User user : users) {
			TreeNodeBean userNode = new TreeNodeBean();
			userNode.setTitle(user.getNickName());
			userNode.setAttrId(user.getUserId().toString());// attrId是主键
			userNode.setKey("u" + userNode.getAttrId());// key(path)是[orgPath+]u+主键
			userNode.setNodeType(TreeNodeBean.NODE_TYPE_USER);
			userNode.setIcon("user.gif");
			if (treeUtil.isInArray(user.getUserId().toString(), userIds)) {
				userNode.setSelect(true);
				userNode.setActivate(true);
				userNode.setExpand(true);// 已在最外层
			}
			tree.add(userNode);
		}

		List<TreeNodeBean> orgNodes = fetchOrgTreeNodes(userIds, orgs);
		tree.addAll(tree.size(),orgNodes);
		
		return tree;
	}

	/**
	 * 
	 * @param userIds
	 *            用来初始化
	 * @param orgs
	 *            子机构的集合
	 * @return
	 */
	private List<TreeNodeBean> fetchOrgTreeNodes(String[] userIds, List<Org> orgs) {
		java.util.Collections.sort(orgs, new Comparator<Org>(){

			public int compare(Org o1, Org o2) {
				return o1.getOrgPath().compareTo(o2.getOrgPath());
			}
			
		});
		
		Map<String,TreeNodeBean> allCache=new HashMap<String, TreeNodeBean>();
		Map<String,TreeNodeBean> resultCache=new HashMap<String,TreeNodeBean>();
		
		int firstLevelLen=-1;
		
		for (Org org : orgs) {
			String path = org.getOrgPath();// 获得这个path
			String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
			if(firstLevelLen==-1)
				firstLevelLen=pathArray.length;
			
			TreeNodeBean orgNode = new TreeNodeBean();
			
			orgNode.setTitle(org.getOrgName());
			orgNode.setAttrId(org.getOrgId().toString());
			orgNode.setNodeType(TreeNodeBean.NODE_TYPE_ORG);
			orgNode.setKey(org.getOrgPath());
			orgNode.setDisplayNo((org.getOrgNo()!=null&&org.getOrgNo().trim().length()>0)?Integer.parseInt(org.getOrgNo()):0);
			orgNode.setHideCheckbox(true);
			orgNode.setIsFolder(true);
			
			allCache.put(path, orgNode);
			
			List<User> users = userDAO.findAllUsers(org.getOrgId().toString());// 这个机构下的用户
			
			for (User user : users) {
				TreeNodeBean userNode = new TreeNodeBean();
				userNode.setTitle(user.getNickName());
				userNode.setAttrId(user.getUserId().toString());
				userNode.setKey(org.getOrgPath() + ",u" + userNode.getAttrId());
				userNode.setNodeType(TreeNodeBean.NODE_TYPE_USER);
				userNode.setIcon("user.gif");
				orgNode.getChildren().add(userNode);
				
				if (treeUtil.isInArray(user.getUserId().toString(), userIds)) {
					userNode.setActivate(true);
					userNode.setSelect(true);
					orgNode.setExpand(true);// 如果是选中,就将父节点展开
				}
				
			}
			

			if(pathArray.length==firstLevelLen)
			{
				resultCache.put(path, orgNode);
				
			}else{
				String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
				TreeNodeBean parentNode=allCache.get(parentPath);
				if(parentNode!=null){
					if (orgNode.getSelect() || orgNode.getExpand() || orgNode.getActivate()) {
						parentNode.setExpand(true);
					}
					parentNode.setIsFolder(true);
					parentNode.getChildren().add(orgNode);
					
					java.util.Collections.sort(parentNode.getChildren(), new Comparator<TreeNodeBean>(){
						public int compare(TreeNodeBean o1, TreeNodeBean o2) {
							return o1.getDisplayNo()-o2.getDisplayNo();
						}
						
					});
				}else{
					System.out.println("path="+path);
				}
			}
		}

		List<TreeNodeBean> results=new ArrayList<TreeNodeBean>(resultCache.values());
		java.util.Collections.sort(results, new Comparator<TreeNodeBean>(){
			public int compare(TreeNodeBean o1, TreeNodeBean o2) {
				return o1.getDisplayNo()-o2.getDisplayNo();
			}
		});
		
		return results;
	}
}
