/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/impl/RoleServiceImpl.java,v 1.2 2012/12/07 02:29:58 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/07 02:29:58 $
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.dao.OrgDao;
import com.smartcloud.crowdfunding.console.dao.OrgRoleDao;
import com.smartcloud.crowdfunding.console.dao.RoleDao;
import com.smartcloud.crowdfunding.console.dao.RoleFunctionDao;
import com.smartcloud.crowdfunding.console.dao.UserDao;
import com.smartcloud.crowdfunding.console.dao.UserRoleDao;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.OrgRole;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.RoleFunction;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.UserRole;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.OrgService;
import com.smartcloud.crowdfunding.console.service.RoleService;
import com.smartcloud.crowdfunding.console.util.DynaTreeUtil;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;


public class RoleServiceImpl implements RoleService {
	@Reference
	private RoleDao roleDAO;
	@Reference
	private OrgRoleDao orgRoleDao;
	@Reference
	private UserRoleDao userRoleDao;
	@Reference
	private RoleFunctionDao roleFunctionDao;
	@Reference
	private UserDao userDAO;
	@Reference
	private OrgDao orgDAO;

	@Reference
	private OrgService orgService;

	private DynaTreeUtil treeUtil = new DynaTreeUtil();

	public List<Role> fetchRolesWithPage(Role role, Page page) {
		List<Role> rlist = roleDAO.fetchAllRoleWithPage(role, page);
		return rlist;
	}

	public List<Role> fetchRolesByOrg(Org org) {

		Org tmp = orgDAO.findOrgInfo(org);

		return tmp.getRoles();
	}

	public List<Role> fetchAllRoles() {
		List<Role> rlist = new ArrayList<Role>();
		rlist = roleDAO.fetchAllRoleInfos();
		return rlist;

	}

	public List<Role> fetchRolesByUser(User user) {
		List<Role> rlist = new ArrayList<Role>();
		User temp = userDAO.findUser(user);// 形参user只需有个userId属性即可
		rlist = temp.getRoles();

		return rlist;
	}


	public Map<String, TreeNodeBean> fetchRolesTree(String[] initId, String groupId) {
		Map<String, TreeNodeBean> group = new HashMap<String, TreeNodeBean>();
		TreeNodeBean rootNode = new TreeNodeBean();
		List<Role> roles = new ArrayList<Role>();
		if (groupId == null || "".equals(groupId)) {
			rootNode.setTitle("所有角色");
			roles = roleDAO.fetchAllRoleInfos();
		} else {
			Org org = new Org();
			org.setOrgId(Long.parseLong(groupId));
			org = orgService.fetchSingleOrgInfo(org);
			rootNode.setTitle("[" + org.getOrgName() + "]下所有角色");
			roles = roleDAO.fetchRoleInfosOfOrg(org);
		}
		rootNode.setAttrId(null);
		rootNode.setKey("root");
		rootNode.setIsFolder(true);
		List<TreeNodeBean> children = new ArrayList<TreeNodeBean>();
		for (Role role : roles) {
			TreeNodeBean checkboxNode = new TreeNodeBean();
			if (Role.ROLE_STATE_CLOSE.equals(role.getRoleState())) {
				checkboxNode.setAddClass("errorNodeClass");
				checkboxNode.setTooltip("[已关闭]" + role.getRoleMemo());
			} else {
				checkboxNode.setTooltip(role.getRoleMemo());
			}
			checkboxNode.setKey(role.getRoleId());
			checkboxNode.setTitle(role.getRoleName());
			checkboxNode.setAttrId(role.getRoleId());
			// cbean.setTooltip("创建人:" + role.getUserId());
			if (treeUtil.isInArray(role.getRoleId().toString(), initId)) {
				checkboxNode.setSelect(true);
				checkboxNode.setPersistState(TreeNodeBean.PERSIST_STATE_EXIST);
			}
			children.add(checkboxNode);
		}
		
		treeUtil.expandNodeByChildren(rootNode, children);
		rootNode.setChildren(children);
		group.put(rootNode.getKey(), rootNode);

		return group;
	}

	public void allotPermissionToOrg(OrgRole[] addOrgRoles, OrgRole[] deleteOrgRoles) {
		addPermissionToOrg(addOrgRoles);
		deletePermissionOfOrg(deleteOrgRoles);

	}

	public void addPermissionToOrg(OrgRole[] orgRoles) {
		if (orgRoles!=null && orgRoles.length > 0) {
			for (OrgRole orgRole : orgRoles) {
				orgRoleDao.addOrgRole(orgRole);
			}
		}
	}

	public void allotPermissionToUser(UserRole[] addUserRoles, UserRole[] deleteUserRoles) {
		addPermissionToUser(addUserRoles);
		deletePermissionOfUser(deleteUserRoles);
	}

	public void addPermissionToUser(UserRole[] addUserRoles) {
		if(addUserRoles!=null){
			for (UserRole userRole : addUserRoles) {
				userRoleDao.addUserRole(userRole);
			}
		}

	}

	public int deletePermissionOfOrg(OrgRole[] orgRoles) {
		int deleteNum = 0;
		if (orgRoles!=null && orgRoles.length > 0) {
			for (OrgRole orgRole : orgRoles) {
				int i = deletePermissionOfOrg(orgRole);
				deleteNum += i;
			}
		}
		return deleteNum;
	}

	/**
	 * 删除角色与部门关系，删除的时候，该机构下的成员与该角色的关系也删除
	 * 
	 * @param orgRole
	 * @return
	 */
	private int deletePermissionOfOrg(OrgRole orgRole) {
		int i = orgRoleDao.deleteOrgRole(orgRole);
		deletePermissionOfOrgUsers(orgRole);// 删除此部门下所有用户与该角色的关联
		deletePermissionOfOrgWithChildrenOrg(orgRole);// 删除子机构与该角色的关联
		return i;
	}

	Map<String, List<Org>> tmpOLMap = new HashMap<String, List<Org>>();

	public void deletePermissionOfOrgWithChildrenOrg(OrgRole orgRole) {
		List<Org> oList = null;
		if (tmpOLMap.get(orgRole.getOrgId()) != null) {
			oList = tmpOLMap.get(orgRole.getOrgId());
		} else {
			oList = orgDAO.fetchChildrenOrgInfos(orgRole.getOrgId().toString(), true);
			tmpOLMap.put(orgRole.getOrgId().toString(), oList);
		}

		for (Org org : oList) {
			OrgRole temp = new OrgRole();
			temp.setOrgId(org.getOrgId());
			temp.setRoleId(orgRole.getRoleId());
			deletePermissionOfOrg(temp);
		}
	}


	public void deletePermissionOfOrgUsers(Long orgId, Long roleId) {
		List<UserRole> urlist = userRoleDao.queryUserRolesByOrgRole(orgId, roleId);
		for (UserRole userRole : urlist) {
			userRoleDao.deleteUserRole(userRole);
		}
	}


	public void deletePermissionOfOrgUsers(OrgRole orgRole) {
		deletePermissionOfOrgUsers(orgRole.getOrgId(), orgRole.getRoleId());
	}

	public int deletePermissionOfUser(UserRole[] userRoles) {
		int deleteNum = 0;
		if(userRoles!=null){
			if (userRoles.length > 0) {
				for (UserRole userRole : userRoles) {
					int i = userRoleDao.deleteUserRole(userRole);
					deleteNum += i;
				}
			}
		}
		return deleteNum;

	}

	public Role addRole(Role role, RoleFunction[] roleFunctions, OrgRole[] addOrgRoles) {
		Role roleTemp = addRoleEntity(role);
		if (roleTemp != null && (roleTemp.getRoleId() != null || !"".equals(roleTemp.getRoleId()))) {
			String roleId = roleTemp.getRoleId();
			if(addOrgRoles!=null){
				for (OrgRole orgRole : addOrgRoles) {
					orgRole.setRoleId(Long.parseLong(roleId));
				}
				
				addPermissionToOrg(addOrgRoles);
			}
			
			if(roleFunctions!=null){
				for (RoleFunction roleFunction : roleFunctions) {
					roleFunction.setRoleId(Long.parseLong(roleId));
				}
				
				addRoleFunctions(roleFunctions);
			}
			
			
		}
		return roleTemp;
	}


	public Role addRoleEntity(Role role) {
		role = roleDAO.addRole(role);
		return role;
	}


	public void addRoleFunctions(RoleFunction[] roleFunctions) {
		if(roleFunctions!=null && roleFunctions.length > 0){
				for (RoleFunction roleFunction : roleFunctions) {
					roleFunctionDao.addRoleFunction(roleFunction);
				}
		}
	}


	public void deleteRole(Role[] roles) {
		if(roles!=null && roles.length > 0){
			for (Role role : roles) {
				roleDAO.deleteRole(role);// 删除角色
				deleteRoleFunctions(role);// 删除角色资源
				deletePermissionOfOrg(role);
			}
		}
	}


	public void deleteRoleFunctions(RoleFunction[] roleFunctions) {
		
		if (roleFunctions!=null && roleFunctions.length > 0) {
			for (RoleFunction roleFunction : roleFunctions) {
				roleFunctionDao.deleteRoleFunction(roleFunction);
			}
		}

	}


	public void deleteRoleFunctions(Role role) {
		List<RoleFunction> rflist = new ArrayList<RoleFunction>();
		rflist = getRoleFunctionListByRole(role);
		RoleFunction[] roleFunctions = new RoleFunction[rflist.size()];
		if (rflist != null && rflist.size() > 0) {
			for (int i = 0; i < rflist.size(); i++) {
				roleFunctions[i] = rflist.get(i);
			}
			deleteRoleFunctions(roleFunctions);
		}

	}


	public void updateRole(Role role, RoleFunction[] addRoleFunctions, RoleFunction[] deleteRoleFunctions, OrgRole[] addOrgRoles, OrgRole[] deleteOrgRoles) {
		roleDAO.updateRole(role);
		addRoleFunctions(addRoleFunctions);
		deleteRoleFunctions(deleteRoleFunctions);
		allotPermissionToOrg(addOrgRoles, deleteOrgRoles);// 调用分配角色

	}


	public List<RoleFunction> getRoleFunctionListByRole(Role role) {
		return roleFunctionDao.getRoleFunctionListByRole(role);
	}


	public Role fetchSingleRoleInfo(Role role) {
		return roleDAO.getRoleInfo(role);
	}

	public void deletePermissionOfOrg(Role role) {
		OrgRole orgRole = new OrgRole();// 删除部门角色
		orgRole.setRoleId(Long.parseLong(role.getRoleId()));
		orgRoleDao.deleteOrgRole(orgRole);

	}


	public List<OrgRole> fetchOrgRolesByRole(Role role) {
		OrgRole orgRole = new OrgRole();
		orgRole.setRoleId(Long.parseLong(role.getRoleId()));

		return orgRoleDao.fetchOrgRoles(orgRole);

	}

}
