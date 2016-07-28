/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.web;

import java.util.List;

import com.smartcloud.crowdfunding.console.model.Portal;
import com.smartcloud.crowdfunding.console.model.UserPortal;
import com.smartcloud.crowdfunding.console.model.bean.PortalBean;
import com.smartcloud.crowdfunding.console.model.bean.UserPortalBean;
import com.smartcloud.crowdfunding.console.service.PortalService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * @author fred_2012-12-6下午02:42:40
 * 
 */
@URI(path="/console/userportal/*",description="栏目定制管理")
public class UserPortalManager extends WebAction {
	@Reference
	private PortalService portalService;

	/**
	 * 1、显示首页portal 2、初始化用户可选的portalCatalog，并默认选中已选择的
	 * 
	 * @return
	 * 
	 * @created at 2012-11-30下午01:17:57
	 */
	@Action(description = "初始化显示portal栏目", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initPortal() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			List<UserPortalBean> uplist = portalService.fetchUserPortalsOfCurrentUser_withStatus(webUser);
			String portalLayout = "";
			if (uplist != null && uplist.size() > 0) {
				UserPortalBean tmp = uplist.get(0);
				portalLayout = tmp.getUserPortal().getPortalLayout();
			}
			response.addToRequest("uplist", uplist);// 用户的portlets
			response.addToRequest("portalLayout", portalLayout);// 布局设置
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 添加portal
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-12-20下午04:24:28
	 */
	@Action(description = "用户端新增Portlet", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String addUserPortal(UserPortal userPortal) {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			userPortal.setUserId(Long.parseLong(webUser.getUserId()));
			userPortal = portalService.addUserPortal(userPortal);
			response.addToRequest("userPortal", userPortal);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	/**
	 * 获得某userPortal信息用于更改布局，名称信息
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-12-6下午02:52:42
	 */
	@Action(description = "更改栏目", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String entryUpdateUserPortal(UserPortal userPortal) {
		userPortal = portalService.getUserPortalInfo(userPortal);
		response.addToRequest("upInfo", userPortal);
		return SUCCESS;
	}

	@Action(description = "获得选中的栏目信息", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String getSelectedPortal(Portal portal) {
		portal = portalService.getSinglePortalInfo(portal);
		response.addToRequest("portal", portal);
		return SUCCESS;
	}

	/**
	 * 每个portal上的配置修改按钮
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-12-24上午10:31:20
	 */
	@Action(description = "更改栏目信息", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String updateUserPortal(UserPortal userPortal) {
		userPortal = portalService.updateUserPortal(userPortal);
		response.addToRequest("userPortal", userPortal);
		return SUCCESS;
	}

	@Action(description = "删除栏目", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String deleteUserPortal(UserPortal userPortal) {
		portalService.deleteuserPortal(userPortal);
		return SUCCESS;
	}

	@Action(description = "初始化栏目，并默认选中已有的", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initPortletsCanBeSelected() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			List<PortalBean> pllist = portalService.fetchAllPortalsByUser(webUser);
			response.addToRequest("pllist", pllist);// 用户可选的portalCatalog
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	/**
	 * 点击保存按钮，保存portal配置的action
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-12-6下午02:50:23
	 */
	@Action(description = "保存栏目模块配置", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String savaUserPortalSettings(UserPortal[] addUserPortal, UserPortal[] deleteUserPortal, UserPortal[] updateUserPortal) {
		portalService.saveUserPortalsSettings(addUserPortal, deleteUserPortal, updateUserPortal);
		return SUCCESS;
	}

	@Action(description = "测试userPortal的iframe", responses = { @Response(name = SUCCESS, forward=@Forward(url = "testPortalIframe.jsp")) })
	public String testuserportal() {
		response.addToRequest("random", "随机数:" + (int) (Math.random() * 100));

		return SUCCESS;
	}
}
