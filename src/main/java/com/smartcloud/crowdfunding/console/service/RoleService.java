/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/IRoleService.java,v 1.1 2012/12/04 07:35:18 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:18 $
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
 * Created on 2012-5-10
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.service;

import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.OrgRole;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.RoleFunction;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.UserRole;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface RoleService {
	/**
	 * 添加角色实体
	 * 
	 * @param role
	 * @return
	 */
	public Role addRoleEntity(Role role);

	/**
	 * 添加角色资源
	 * 
	 * @param roleFunctions
	 */
	public void addRoleFunctions(RoleFunction[] roleFunctions);

	/**
	 * 删除角色资源
	 * 
	 * @param roleFunctions
	 */
	public void deleteRoleFunctions(RoleFunction[] roleFunctions);

	/**
	 * 根据角色删除资源
	 * 
	 * @param role
	 * 
	 * @created at 2012-9-21下午01:19:42
	 */
	public void deleteRoleFunctions(Role role);

	/**
	 * 添加角色和资源，添加部门角色
	 * 
	 * @param role
	 * @param roleFunctions
	 * @param addOrgRoles
	 * 
	 * @created at 2012-9-24上午10:06:23
	 */
	public Role addRole(Role role, RoleFunction[] roleFunctions, OrgRole[] addOrgRoles);

	/**
	 * 更新角色，添加角色资源，删除角色资源,分配角色给部门
	 * 
	 * @param role
	 * @param addRoleFunctions
	 * @param deleteRoleFunctions
	 * @param addOrgRoles
	 * @param deleteOrgRoles
	 * 
	 * @created at 2012-9-24上午10:04:35
	 */
	public void updateRole(Role role, RoleFunction[] addRoleFunctions, RoleFunction[] deleteRoleFunctions, OrgRole[] addOrgRoles, OrgRole[] deleteOrgRoles);

	/**
	 * 删除角色和角色资源
	 * 
	 * @param role
	 *            []
	 * 
	 * @created at 2012-9-21下午01:33:16
	 */
	public void deleteRole(Role[] roles);

	/**
	 * 根据角色获得角色资源
	 * 
	 * @param role
	 * @return
	 * 
	 * @created at 2012-9-21下午01:33:33
	 */
	public List<RoleFunction> getRoleFunctionListByRole(Role role);

	/**
	 * 获得所有角色信息
	 * 
	 * @return
	 */
	public List<Role> fetchAllRoles();

	/**
	 * 修改角色：获得角色信息
	 * 
	 * @param role
	 * @return
	 * 
	 * @created at 2012-9-21下午02:06:28
	 */
	public Role fetchSingleRoleInfo(Role role);

	/**
	 * 根据部门信息查询当前部门的所有角色信息
	 * 
	 * @param org
	 * @return
	 */
	public List<Role> fetchRolesByOrg(Org org);

	/**
	 * 根据用户信息，查询当前用户拥有的所有角色信息
	 * 
	 * @param user
	 * @return
	 */
	public List<Role> fetchRolesByUser(User user);

	/**
	 * 分页查询角色信息
	 * 
	 * @param role
	 * @param page
	 * @return
	 */
	public List<Role> fetchRolesWithPage(Role role, Page page);

	/**
	 * 分配权限给用户
	 * 
	 * @param addUserRoles
	 * @param deleteUserRoles
	 */
	public void allotPermissionToUser(UserRole[] addUserRoles, UserRole[] deleteUserRoles);

	/**
	 * 分配权限给部门
	 * 
	 * @param addOrRoles
	 * @param deleteOrgRoles
	 */
	public void allotPermissionToOrg(OrgRole[] addOrRoles, OrgRole[] deleteOrgRoles);

	/**
	 * 新增部门角色
	 * 
	 * @param orRoles
	 */
	public void addPermissionToOrg(OrgRole[] orRoles);

	/**
	 * 新增资源角色
	 * 
	 * @param addUserRoles
	 */
	public void addPermissionToUser(UserRole[] addUserRoles);

	/**
	 * 根据角色获得部门角色信息(有哪些部门拥有该角色)
	 * 
	 * @param role
	 * @return
	 * 
	 * @created at 2012-9-24下午01:02:40
	 */
	public List<OrgRole> fetchOrgRolesByRole(Role role);

	/**
	 * 删除用户角色
	 * 
	 * @param userRoles
	 * @return
	 */
	public int deletePermissionOfUser(UserRole[] userRoles);

	/**
	 * 删除某机构下的角色的同时，删除该机构下所有用户与该角色的关联关系
	 * 
	 * @param orgId
	 * @param roleId
	 * 
	 * @created at 2012-11-8上午10:31:26
	 */
	public void deletePermissionOfOrgUsers(Long orgId, Long roleId);

	public void deletePermissionOfOrgUsers(OrgRole orgRole);

	/**
	 * 根据部门角色，删除其所有子部门与该角色关联
	 * 
	 * @param orgRole
	 * 
	 * @created at 2012-11-12下午04:04:59
	 */
	public void deletePermissionOfOrgWithChildrenOrg(OrgRole orgRole);

	/**
	 * 删除部门角色
	 * 
	 * @param orgRoles
	 * @return
	 */
	public int deletePermissionOfOrg(OrgRole[] orgRoles);

	/**
	 * 已知角色，删除部门角色中所有与该角色关联的数据
	 * 
	 * @param role
	 * 
	 * @created at 2012-11-12下午04:08:40
	 */
	public void deletePermissionOfOrg(Role role);

	/**
	 * 权限设置的角色树，数据来源自父机构的角色集合
	 * 
	 * @param initId
	 * @param groupId
	 * @return
	 * 
	 * @created at 2012-11-7下午03:04:01
	 */
	public Map<String, TreeNodeBean> fetchRolesTree(String[] initId, String groupId);

}