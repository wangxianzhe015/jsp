/*******************************************************************************
 * $Header$
 * $Revision$
 * $Date$
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
 * Created on 2013-5-7
 *******************************************************************************/


package com.smartcloud.crowdfunding.console.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.OrgRole;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.UserRole;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.OrgService;
import com.smartcloud.crowdfunding.console.service.RoleService;
import com.smartcloud.crowdfunding.console.service.UserService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/permission/*",description="权限管理")
public class PermissionManager extends WebAction {
	
	@Reference
	private RoleService roleService;

	@Reference
	private OrgService orgService;

	@Reference
	private UserService userService;

	

	@Action(description = "权限配置页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/permission/allotPermission.jsp")) })
	public String index() {

		// User user = new User();// 当前用户
		// Org org = user.getOrg();
		// List<Role> rlist = user.getRoles();// 获得当前用户的所有角色
		this.response.addToRequest("showWhich", "userWithOrg");

		return SUCCESS;
	}
	
	
	@Action(description = "执行分配权限给用户", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String allotPToUser(UserRole[] addUserRole, UserRole[] deleteUserRole) {
		roleService.allotPermissionToUser(addUserRole, deleteUserRole);
		return SUCCESS;
	}

	@Action(description = "执行分配权限给机构", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String allotPToOrg(OrgRole[] addOrgRole, OrgRole[] deleteOrgRole) {
		roleService.allotPermissionToOrg(addOrgRole, deleteOrgRole);
		return SUCCESS;
	}

	/**
	 * 将资源分配给角色
	 * 
	 * @return
	 */
	@Action(description = "权限配置给机构", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/permission/allotPermission.jsp")) })
	public String entryAPToOrg(Org[] org) {
		String paramId = null;
		if (org.length == 1) {
			paramId = org[0].getOrgId().toString();
		}
		this.response.addToRequest("paramId", paramId);
		this.response.addToRequest("showWhich", "org");
		return SUCCESS;
	}
	
	
	/**
	 * TODO 权限配置给用户的界面，角色来自于所在部门的角色集合,有部门的就取直属部门集合，没部门就取全部角色
	 * 
	 * @param user
	 * @return
	 * 
	 * @created at 2012-11-2下午04:04:03
	 */
	@Action(description = "权限配置给用户", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/permission/allotPermission.jsp")) })
	public String entryAPToUser(User[] user) {
		String paramId = null;
		if (user.length == 1) {
			paramId = user[0].getUserId().toString();
		}
		this.response.addToRequest("paramId", paramId);
		this.response.addToRequest("showWhich", "userOnly");
		return SUCCESS;
	}

	@Action(description = "获得某机构的所有角色", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String fetchRolesOfOrgCond() {
		try {
			String cond = (String) this.request.getRequestParameter("condition");
			Org org = new Org();
			org.setOrgId(Long.parseLong(cond));
			org = orgService.fetchSingleOrgInfo(org);
			List<Role> roles = roleService.fetchRolesByOrg(org);// 获得当前机构所包含的角色
			String[] initId = new String[roles.size()];
			for (int i = 0; i < roles.size(); i++) {
				initId[i] = roles.get(i).getRoleId();
			}
			Map<String, TreeNodeBean> groups = new HashMap<String, TreeNodeBean>();
			groups = roleService.fetchRolesTree(initId, String.valueOf(org.getParentOrgId()));
			response.addToRequest("rlist", roles);
			response.addToRequest("children", groups.values());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "获得某用户的所有角色", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String fetchRolesOfUserCond() {
		try {
			String cond = (String) this.request.getRequestParameter("condition");
			User user = new User();
			user.setUserId(Long.parseLong(cond));
			user = userService.getUser(user);
			List<Role> rlist = new ArrayList<Role>();
			rlist = roleService.fetchRolesByUser(user);
			String[] initId = new String[rlist.size()];
			for (int i = 0; i < rlist.size(); i++) {
				initId[i] = rlist.get(i).getRoleId();
			}
			Map<String, TreeNodeBean> groups = new HashMap<String, TreeNodeBean>();
			groups = roleService.fetchRolesTree(initId, user.getOrg() == null ? null : user.getOrg().getOrgId().toString());
			response.addToRequest("rlist", rlist);
			response.addToRequest("children", groups.values());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	

}
