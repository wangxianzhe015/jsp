/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/impl/OrgServiceImpl.java,v 1.2 2012/12/07 02:29:59 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/07 02:29:59 $
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

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.dao.OrgDao;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.OrgService;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.crowdfunding.console.util.DynaTreeUtil;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

public class OrgServiceImpl implements OrgService {

	@Reference
	private OrgDao orgDAO;

	DynaTreeUtil treeUtil = new DynaTreeUtil();

	public void addOrg(Org org) {
		orgDAO.addOrg(org);

	}

	public void updateOrgInfo(Org org) {
		orgDAO.updateOrg(org);
	}

	public void deleteOrg(Org org) {
		orgDAO.deleteOrg(org);
	}

	public Org fetchSingleOrgInfo(Org org) {
		return orgDAO.findOrgInfo(org);
	}

	public List<Org> fetchOrgsWithPage(Org org, Page page) {
		List<Org> olist = orgDAO.fetchAllOrgWithPage(org, page);
		return olist;
	}

	public List<Org> fetchAllOrg() {
		List<Org> olist = new ArrayList<Org>();
		olist = orgDAO.fetchAllOrgInfos();
		return olist;
	}


	public List<TreeNodeBean> fetchOrgTreeNodes(String orgId, String porgId) {
		String[] orgIds = null;// 初始化的选中的节点
		List<Org> orgs = fetchAllOrg();// 查询所有机构，而非查询父机构，所有显示某些分组就不好用。porgId暂时没用到
		
		java.util.Collections.sort(orgs, new Comparator<Org>(){

			public int compare(Org o1, Org o2) {
				return o1.getOrgPath().compareTo(o2.getOrgPath());
			}
			
		});
		
		Map<String,TreeNodeBean> allCache=new HashMap<String, TreeNodeBean>();
		Map<String,TreeNodeBean> resultCache=new HashMap<String,TreeNodeBean>();
		
		for (Org org : orgs) {
			String path = org.getOrgPath();// 获得这个path
			String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
			
			TreeNodeBean treeNode = new TreeNodeBean();
			if (treeUtil.isInArray(org.getOrgId().toString(), orgIds)) {
				treeNode.setSelect(true);// checkbox选中状态
				treeNode.setActivate(true);// 选项active状态
				treeNode.setPersistState(TreeNodeBean.PERSIST_STATE_EXIST);
			}
			treeNode.setKey(path);
			treeNode.setNodeType(TreeNodeBean.NODE_TYPE_ORG);
			treeNode.setTitle(org.getOrgName());
			treeNode.setAttrId(org.getOrgId().toString());
			treeNode.setDisplayNo((org.getOrgNo()!=null&&org.getOrgNo().trim().length()>0)?Integer.parseInt(org.getOrgNo()):0);
			
			allCache.put(path, treeNode);
			
			if(pathArray.length==2)
			{
				resultCache.put(path, treeNode);
			}else{
				String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
				TreeNodeBean parentNode=allCache.get(parentPath);
				if(parentNode!=null){
					if (treeNode.getSelect() || treeNode.getExpand() || treeNode.getActivate()) {
						parentNode.setExpand(true);
					}
					parentNode.setIsFolder(true);
					parentNode.getChildren().add(treeNode);
					
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

	/*
	 * @see
	 * org.venus.iplatform.gas.service.IOrgService#deleteOrgs(org.venus.iplatform
	 * .gas.model.Org[])
	 * 
	 * @param orgs
	 */
	public void deleteOrgs(Org[] orgs) {
		for (Org org : orgs) {
			deleteOrg(org);
		}

	}

}
