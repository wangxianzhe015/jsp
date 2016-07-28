/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/impl/EmployeeServiceImpl.java,v 1.2 2012/12/07 02:29:59 supyuser Exp $
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

import com.smartcloud.crowdfunding.console.dao.EmployeeDao;
import com.smartcloud.crowdfunding.console.dao.OrgDao;
import com.smartcloud.crowdfunding.console.model.Employee;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.EmployeeService;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.crowdfunding.console.util.DynaTreeUtil;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 人员employee和部门挂钩
 * 
 * @author fred_2012-9-20
 * 
 */

public class EmployeeServiceImpl implements EmployeeService {
	@Reference
	private EmployeeDao edao;

	@Reference
	private OrgDao orgDAO;

	private DynaTreeUtil treeUtil = new DynaTreeUtil();

	
	public Employee addEmployee(Employee employee) {
		employee = edao.addEmployee(employee);
		return employee;
	}

	public void deleteEmployee(Employee employee) {

		edao.deleteEmployee(employee);

	}

	public Employee fetchEmployee(Employee employee) {
		return edao.findEmployee(employee);
	}

	public List<Employee> fetchEmployeesWithPage(Employee employee, Page page) {
		return edao.queryAllEmployeeWithPage(employee, page);

	}

	public int updateEmployee(Employee employee) {
		edao.updateEmployee(employee);
		return 0;
	}

	public List<TreeNodeBean> fetchEmployeeWithOrgTree(String[] employeeIds, String orgId) {
		List<TreeNodeBean> employeeTree = new ArrayList<TreeNodeBean>();
		List<Org> orgs = new ArrayList<Org>();
		List<Employee> employees = new ArrayList<Employee>();

		if (StringUtils.isEmpty(orgId)) {
			orgs = orgDAO.getAllOrgs();// 获得所有机构
			employees = edao.findAllEmployeesNoOrg();
		} else {
			Org org=new Org();
			org.setOrgId(Long.parseLong(orgId));
			org=orgDAO.find(org);
			orgs=orgDAO.getChildrenOrgs(org.getOrgPath());//获取当前机构以及子机构
		}
		
		for (Employee employee : employees) {
			TreeNodeBean employeeNode = new TreeNodeBean();
			employeeNode.setTitle(employee.getEmployeeName());
			employeeNode.setAttrId(employee.getEmployeeId().toString());
			employeeNode.setKey("e" + employeeNode.getAttrId());// key(path)是[orgPath+]u+主键
			employeeNode.setNodeType(TreeNodeBean.NODE_TYPE_EMPLOYEE);
			employeeNode.setIcon("user.gif");
			
			if (treeUtil.isInArray(employee.getEmployeeId().toString(), employeeIds)) {
				employeeNode.setSelect(true);
				employeeNode.setActivate(true);
				employeeNode.setExpand(true);// 已在最外层
			}
			employeeTree.add(employeeNode);
		}
		
		List<TreeNodeBean> orgNodes = fetchOrgTreeNodes(employeeIds, orgs);
		employeeTree.addAll(employeeTree.size(),orgNodes);

		return employeeTree;
	}

	/**
	 * 
	 * @param employeeIds
	 *            用来初始化
	 * @param orgs
	 *            子机构的集合
	 * @return
	 */
	private List<TreeNodeBean> fetchOrgTreeNodes(String[] employeeIds, List<Org> orgs) {
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
			orgNode.setHideCheckbox(true);
			orgNode.setDisplayNo((org.getOrgNo()!=null&&org.getOrgNo().trim().length()>0)?Integer.parseInt(org.getOrgNo()):0);

			orgNode.setIsFolder(true);
			
			allCache.put(path, orgNode);
			
			List<Employee> employees = edao.findAllUsers(org.getOrgId().toString());
			for (Employee employee : employees) {
				TreeNodeBean employeeNode = new TreeNodeBean();
				employeeNode.setTitle(employee.getEmployeeName());
				employeeNode.setAttrId(employee.getEmployeeId().toString());
				employeeNode.setKey(org.getOrgPath() + ",u" + employeeNode.getAttrId());
				employeeNode.setNodeType(TreeNodeBean.NODE_TYPE_EMPLOYEE);
				employeeNode.setIcon("user.gif");//TODO ICON信息，定义在userBean中
				
				if (treeUtil.isInArray(employee.getEmployeeId().toString(), employeeIds)) {
					employeeNode.setActivate(true);
					employeeNode.setSelect(true);
					orgNode.setExpand(true);// 如果是选中,就将父节点展开
				}
				orgNode.getChildren().add(employeeNode);
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
