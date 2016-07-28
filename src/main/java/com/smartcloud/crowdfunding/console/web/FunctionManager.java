package com.smartcloud.crowdfunding.console.web;

import java.util.ArrayList;
import java.util.List;

import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.ResourceTreeNode;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.crowdfunding.console.util.GraphNode;
import com.smartcloud.crowdfunding.console.util.ResourceHelper;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.mvc.service.internal.ActionBean;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/function/*",description="功能管理")
public class FunctionManager extends WebAction {

	@Reference
	ResourceService resourceService;

	@Action(description = "进入功能树", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/function/funcTree.jsp")) 
			})
	public String index() {
		return SUCCESS;
	}

	/**
	 * funcIds是初始化显示多少个
	 * 
	 * groupId是显示多少分组
	 * 
	 * @return
	 */
	@Action(description = "生成功能树", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initFuncTree() {

		try {
			String funcId = (String) request.getRequestParameter("initId");
			String groupId = (String) request.getRequestParameter("groupId");
			String[] funcIds = null;
			if (funcId != null && !"".equals(funcId)) {
				funcIds = funcId.split(",");
			}

			List<TreeNodeBean> tree= resourceService.fetchFuncTreeWithModule(funcIds, groupId);
			this.response.addToRequest("children", tree);// 返回children：[]的格式
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "根据角色生成权限树", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initPermissionTree() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			String initId = (String) request.getRequestParameter("initId");
			String funcSwitch = (String) request.getRequestParameter("funcSwtich");// 默认为空和open显示函数，为close
			// 的时候关闭函数
			String[] initIds = null;
			if (initId != null && !"".equals(initId)) {
				initIds = initId.split(",");
			}
			List<ResourceTreeNode> tree = resourceService.fetchPermissionTree(initIds, funcSwitch, webUser);
			this.response.addToRequest("children", tree);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "获得库中已保存的方法", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initFunclistByModuleId() {
		try {
			String moduleId = (String) request.getRequestParameter("moduleId");
			List<Function> flist = new ArrayList<Function>();
			flist = resourceService.fetchFuncsByModuleId(moduleId);
			response.addToRequest("flist", flist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "获得功能列表", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String fetchFunclistByModuleId() {
		try {
			String moduleId = (String) request.getRequestParameter("moduleId");
			com.smartcloud.platform.component.mvc.User user =(com.smartcloud.platform.component.mvc.User)request.getSessionContext().get(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);

			List<ActionBean> actionBeans = resourceService.fetchMethodsByModuleId(moduleId,user.getUserName());// action中方法
			List<Function> functions =  resourceService.fetchFuncsByModuleId(moduleId);// 表中数据
			actionBeans = ResourceHelper.compareLists(actionBeans, functions);

			response.addToRequest("fclist", actionBeans);

		} catch (Exception e) {

			e.printStackTrace();
		}

		return SUCCESS;

	}

	@Action(description = "新增功能", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String addFuncs(Function[] funcs) {
		resourceService.addFuncs(funcs);
		response.addToRequest("lent", funcs.length);

		return SUCCESS;
	}

	@Action(description = "删除功能", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String delete() {
		try {
			// 使用jquery.form的时候，是动态生成dom节点的表单元素，然后在方法中以形参的形式出现
			// 直接使用jquery的ajax是用data传进参数，只能使用request.getParameter获得
			Object functionIds = request.getRequestParameter("functionId[]");
			if (functionIds instanceof String) {
				String funcId = (String) functionIds;
				Function func = new Function();
				func.setFunctionId(Long.parseLong(funcId));
				resourceService.deleteFunc(func);

			} else if (functionIds instanceof String[]) {
				String[] funcIds = (String[]) functionIds;
				Function[] funcs = new Function[funcIds.length];
				for (int i = 0; i < funcIds.length; i++) {
					funcs[i] = new Function();
					funcs[i].setFunctionId(Long.parseLong(funcIds[i]));
				}
				resourceService.deleteFuncs(funcs);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}

	@Action(description = "修改功能", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String updateFunc(Function function) {
		System.out.println(function.getFunctionId());
		System.out.println(function.getDescription());
		resourceService.updateFunction(function);
		return SUCCESS;
	}

	@Action(description = "根据功能ID获得功能", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String fetchFuncByFuncId() {
		try {
			String funcId = (String) request.getRequestParameter("funcId");
			Function func = resourceService.fetchFunctionByFuncId(funcId);
			response.addToRequest("func", func);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	@Action(description = "展示权限地图", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/permission/graphic.jsp")) })
	public String showPermissionGraphic(User user){
		response.addToRequest("user", user);
		return SUCCESS;
	}

	@Action(description = "计算权限地图", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String getPermissionGraphic(User user){
		try{
			List<GraphNode> graphicNodes=resourceService.getPermssionGraphic(user);
			response.addToRequest("nodes", graphicNodes.toArray(new GraphNode[graphicNodes.size()]));
		}catch(Exception e){
			
		}
		return SUCCESS;
	}
}