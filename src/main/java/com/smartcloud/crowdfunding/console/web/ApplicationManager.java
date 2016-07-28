package com.smartcloud.crowdfunding.console.web;

import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/application/*",description="应用管理")
public class ApplicationManager extends WebAction {

	@Reference
	private ResourceService resourceService;

	@Action(description = "新增应用", responses = { @Response(name = SUCCESS, json = @JSON())})
	public String addApp(Application app) {
		app = resourceService.addApp(app);
		this.response.addToRequest("app", app);

		return SUCCESS;
	}

	@Action(description = "修改应用", responses = { @Response(name = SUCCESS, json = @JSON()) })
	public String updateApp(Application app) {
		app = resourceService.updateApp(app);
		this.response.addToRequest("app", app);
		return SUCCESS;
	}

	@Action(description = "删除应用", responses = { @Response(name = SUCCESS, json = @JSON()) })
	public String deleteApp() {
		try {
			String appId = (String) request.getRequestParameter("appId");
			if (appId != null && !"".equals(appId)) {
				Application app = new Application();
				app.setAppId(Long.parseLong(appId));
				resourceService.deleteApp(app);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(description = "查询应用", responses = { @Response(name = SUCCESS, json = @JSON()) })
	public String getApp() {
		try {
			String appId = (String) request.getRequestParameter("appId");
			if (appId != null && !"".equals(appId)) {
				Application app = new Application();
				app.setAppId(Long.parseLong(appId));
				app = resourceService.getApp(app);
				this.response.addToRequest("app", app);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

}