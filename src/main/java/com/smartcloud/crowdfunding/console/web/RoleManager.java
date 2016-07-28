/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/web/RoleManager.java,v 1.2 2012/12/07 09:11:00 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/07 09:11:00 $
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

package com.smartcloud.crowdfunding.console.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.OrgRole;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.RoleFunction;
import com.smartcloud.crowdfunding.console.service.OrgService;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.crowdfunding.console.service.RoleService;
import com.smartcloud.crowdfunding.console.util.ResourceHelper;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/role/*",description="角色管理")
public class RoleManager extends WebAction {
	@Reference
	private RoleService roleService;

	@Reference
	private OrgService orgService;
	
	@Reference
	private ResourceService resourceService;

	@Action(description = "角色查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/role/roleList.jsp")) })
	public String index(Role role) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);
		if (role == null) {
			role = new Role();
		}
		List<Role> roles = roleService.fetchRolesWithPage(role, page);
		response.addToRequest("rlist", roles);
		response.addToRequest("page", page);
		response.addToRequest("role", role);
		return SUCCESS;
	}

	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/role/roleList.jsp")) })
	public String pageQuery(Role role, Page page) {
		List<Role> roles = roleService.fetchRolesWithPage(role, page);
		response.addToRequest("rlist", roles);
		response.addToRequest("page", page);
		response.addToRequest("role", role);
		return SUCCESS;
	}

	@Action(description = "进入角色新增页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/role/addRole.jsp")) })
	public String entryAdd() {
		List<Function> flist = resourceService.fetchFuncsNeedNoAccess();

		String[] funcsStr = new String[flist.size()];
		for (int i = 0; i < flist.size(); i++) {
			funcsStr[i] = flist.get(i).getFunctionId().toString();
		}
		response.addToRequest("funcsStr", ResourceHelper.convertArrayToString(funcsStr));
		return SUCCESS;
	}

	@Action(description = "进入角色修改页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/role/updateRole.jsp")) })
	public String entryUpdate(Role role) {
		role = roleService.fetchSingleRoleInfo(role);// 获得角色信息
		List<RoleFunction> rflist = roleService.getRoleFunctionListByRole(role);
		String[] roleFuncsStr = new String[rflist.size()];
		for (int i = 0; i < rflist.size(); i++) {
			roleFuncsStr[i] = rflist.get(i).getFunctionId().toString();
		}
		List<OrgRole> orlist = new ArrayList<OrgRole>();
		orlist = roleService.fetchOrgRolesByRole(role);
		String[] orsOrgIds = new String[orlist.size()];
		String[] orsOrgNames = new String[orlist.size()];
		for (int i = 0; i < orlist.size(); i++) {
			orsOrgIds[i] = orlist.get(i).getOrgId().toString();
			Org org = new Org();
			org.setOrgId(orlist.get(i).getOrgId());
			orsOrgNames[i] = orgService.fetchSingleOrgInfo(org).getOrgName();
		}

		response.addToRequest("role", role);
		response.addToRequest("roleFuncsStr", ResourceHelper.convertArrayToString(roleFuncsStr));
		response.addToRequest("initOrgTreeId", ResourceHelper.convertArrayToString(orsOrgIds));
		response.addToRequest("initOrgTreeName", ResourceHelper.convertArrayToString(orsOrgNames));

		return SUCCESS;
	}

	/**
	 * 新增角色
	 * 
	 * @param role
	 * @param roleFunction
	 * @param addOrgRole
	 * @return
	 * 
	 * @created at 2012-9-28上午09:06:24
	 */
	@Action(description = "角色新增", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String addRole(Role role, RoleFunction[] roleFunction, OrgRole[] addOrgRole) {
		/**
		 * 保留在当前页面，防止重复提交token
		 */
		WebUser webUser = new WebUser();
		try {
			webUser = (WebUser) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
		} catch (Exception e) {
			e.printStackTrace();
		}
		role.setUserId(webUser.getUserId());
		role.setCreatedTime(new Date());
		Role hasAddRole = roleService.addRole(role, roleFunction, addOrgRole);
		response.addToRequest("role", hasAddRole);// 返回已新增的
		return SUCCESS;
	}

	/**
	 * 修改角色和资源
	 * 
	 * @param role  更新角色
	 * @param addRoleFunction 需新增的资源
	 * @param deleteRoleFunction 需删除的资源
	 * @return
	 */
	@Action(description = "角色修改", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String updateRole(Role role, RoleFunction[] addRoleFunction, RoleFunction[] deleteRoleFunction, OrgRole[] addOrgRole, OrgRole[] deleteOrgRole) {
		roleService.updateRole(role, addRoleFunction, deleteRoleFunction, addOrgRole, deleteOrgRole);
		return SUCCESS;
	}

	@Action(description = "删除角色", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/role/index.action")) })
	public String delete(Role[] role) {
		roleService.deleteRole(role);
		return SUCCESS;
	}




}
