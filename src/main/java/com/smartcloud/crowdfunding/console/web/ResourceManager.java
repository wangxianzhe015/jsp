package com.smartcloud.crowdfunding.console.web;

import java.util.HashMap;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/resource/*",description="模块管理")
public class ResourceManager extends WebAction {

	@Reference
	ResourceService resourceService;

	@Action(description = "进入功能树", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/resource/moduleTree.jsp")) })
	public String entryModuleTree() {

		return SUCCESS;
	}

	
	@Action(description = "生成功能树", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initModuleTree() {
		try {
			String moduleId = (String) request.getRequestParameter("initId");// 初始化选中模块
			String appId = (String) request.getRequestParameter("groupId");// 显示哪几个应用
			String[] moduleIds = null;
			if (moduleId != null && !"".equals(moduleId)) {
				moduleIds = moduleId.split(",");
			}
			Map<String, TreeNodeBean> groups = new HashMap<String, TreeNodeBean>();
			groups = resourceService.fetchModuleTree(moduleIds, appId);
			this.response.addToRequest("children", groups.values());// 返回children：[]的格式

		} catch (Exception e) {

			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(description = "进入资源管理页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/resource/rsManager.jsp")) })
	public String index() {
		return SUCCESS;
	}

	@Action(description = "更新模块", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String updateModule(Module module) {

		resourceService.updateModule(module);

		return SUCCESS;
	}

	@Action(description = "新增模块", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String addModule(Module module) {
		resourceService.addModule(module);
		response.addToRequest("moduleId", module.getModuleId());
		return SUCCESS;
	}

	@Action(description = "根据模块ID获得模块", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String fetchModuleByModuleId() {
		try {
			String moduleId = (String) request.getRequestParameter("moduleId");
			Module module = new Module();
			module.setModuleId(Long.parseLong(moduleId));
			module = resourceService.fetchModule(module);
			response.addToRequest("module", module);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "删除模块", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String delete() {
		try {
			String moduleId = (String) request.getRequestParameter("moduleId");
			Module module = new Module();
			module.setModuleId(Long.parseLong(moduleId));
			resourceService.deleteModule(module);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

}
