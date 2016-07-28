package com.smartcloud.crowdfunding.mobile.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Alert;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="用户管理",path="/mobile/usermgr/*")
public class PortalUserManager extends WebAction{

	@Reference
	private PortalUserService userService;
	
	@Action(description = "用户查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/mobile/usermgr/user_list.jsp")) })
	public String index(PortalUser user) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);

		List<PortalUser> users = userService.findUsers(user, page);
		response.addToRequest("users", users);
		response.addToRequest("page", page);
		response.addToRequest("user", user);

		return SUCCESS;
	}

	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/mobile/usermgr/user_list.jsp")) })
	public String pageQuery(PortalUser user, Page page) {
		List<PortalUser> users = userService.findUsers(user, page);
		response.addToRequest("users", users);
		response.addToRequest("page", page);
		response.addToRequest("user", user);
		return SUCCESS;
	}
	

	@Action(description = "打开修改页面", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/mobile/usermgr/update_user.jsp")) })
	public String entryUpdate(PortalUser user) {
		user = userService.getUserById(user.getUserId());
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		response.addToRequest("provinces", provinces);
		response.addToRequest("user", user);
		return SUCCESS;
	}
	
	
	@Action(description = "修改用户", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/mobile/usermgr/index.action")) })
	public String updateUser(PortalUser user) {
		userService.updateUser(user);
		return SUCCESS;
	}

	
	@Action(description = "删除用户", responses = { @Response(name = SUCCESS,alert=@Alert(url = "/mobile/usermgr/index.action", message = "删除成功!")) })
	public String deleteUser(PortalUser[] user) {
		for (PortalUser u : user) {
			userService.removeUser(u);
		}
		return SUCCESS;
	}
	
	@Action(description = "新增用户", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/mobile/usermgr/index.action")) })
	public String addUser(PortalUser user) {
		userService.addUser(user);
		return SUCCESS;
	}

	@Action(description = "打开新增页面", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/mobile/usermgr/add_user.jsp")) })
	public String entryAdd() {
		return SUCCESS;
	}
}
