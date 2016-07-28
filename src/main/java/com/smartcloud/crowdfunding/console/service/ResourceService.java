package com.smartcloud.crowdfunding.console.service;

import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.ResourceTreeNode;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.util.GraphNode;
import com.smartcloud.platform.component.mvc.service.internal.ActionBean;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 资源接口,supadmin操作角色和资源的关系的service
 * 
 * @author dgw
 * 
 */
@Service
public interface ResourceService {
	
	public static final String PATH_SPILT_FLAG="|";
	
	public Application addApp(Application app);

	public Application updateApp(Application app);

	public Application getApp(Application app);

	public void deleteApp(Application app);

	public void updateFunction(Function function);

	/**
	 * 根据module获得完整的module实体
	 * 
	 * @param module
	 * @return
	 */
	public Module fetchModule(Module module);

	/**
	 * 根据模块id获得模块的实体
	 * 
	 * @param moduleId
	 * @return
	 */
	public Module fetchModuleByModuleId(String moduleId);

	/**
	 * 新增模块
	 * 
	 * @param module
	 */
	public void addModule(Module module);

	/**
	 * 删除模块
	 * 
	 * @param module
	 */
	public void deleteModule(Module module);

	/**
	 * 修改模块的基本信息
	 * 
	 * @param module
	 */
	public void updateModule(Module module);

	/**
	 * 新增功能到模块
	 * 
	 * @param func
	 * @param module
	 */
	public void addFuncs(Function[] funcs);

	/**
	 * 删除功能，需删除对应的role_func
	 * 
	 * @param func
	 */
	public void deleteFuncs(Function[] func);

	public void deleteFunc(Function func);

	/**
	 * 根据主键id获得功能数据
	 * 
	 * @param functionId
	 * @return
	 */
	public Function fetchFunctionByFuncId(String functionId);

	/**
	 * 根据app获得app下的所有模块
	 * 
	 * @param app
	 * @return
	 */
	public List<Module> fetchModulesByApp(Application app);

	/**
	 * 查询所有功能点
	 * 
	 * @param function
	 * @param page
	 * @return
	 */
	public List<Function> fetchFunctionsWithPage(Function function, Page page);

	/**
	 * 获得所有的模块
	 * 
	 * @param module
	 * @param page
	 * @return
	 */
	public List<Module> fetchModulesWithPage(Module module, Page page);

	/**
	 * 功能树
	 * 
	 * @param initId
	 * @param moduleId
	 *            是树组，可以显示多个分组
	 * @return
	 */
	public Map<String, TreeNodeBean> fetchFuncTreeWithModule(String[] initId, String[] moduleId);

	/**
	 * 
	 * @param initId
	 * @param moduleId
	 *            不是数组，不为空时只显示一个分组，为空时全部显示
	 * @return
	 */
	public List<TreeNodeBean> fetchFuncTreeWithModule(String[] initId, String moduleId);

	/**
	 * 根据user生成权限树
	 * 
	 * @param initId
	 * @param appId
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-11-13下午02:50:58
	 */
	public List<ResourceTreeNode> fetchPermissionTree(String[] initId, String appId, com.smartcloud.platform.component.mvc.User webUser);

	/**
	 * 
	 * @param initId
	 *            需要初始化选中的模块
	 * @param appId
	 *            需要显示的应用
	 * @return
	 */
	public Map<String, TreeNodeBean> fetchModuleTree(String[] initId, String appId);

	public List<Application> getAllApps();

	/**
	 * 根据模块id，模块对应的action的methods
	 * 
	 * @param moduleId
	 * @return
	 */
	public List<ActionBean> fetchMethodsByModuleId(String moduleId,String username);

	/**
	 * 根据moduleid获得表中所有该模块已存在的数据
	 * 
	 * @param moduleId
	 * @return
	 */
	public List<Function> fetchFuncsByModuleId(String moduleId);

	/**
	 * 根据roleIds获得功能
	 * 
	 * @param roleIds
	 * @return
	 */
	public List<Function> fetchFuncsByRoles(String[] roleIds);
	/**
	 * 根据roleIds获得资源功能，并以module筛选
	 * @param roleIds
	 * @param module
	 * @return
	 */
	public List<Function> fetchFuncsByRoles(String[] roleIds,Module module);

	/**
	 * 根据功能取得对应的应用
	 * 
	 * @param function
	 * @return
	 */
	public Application getAppByFunc(Function function);

	/**
	 * 根据角色集合获得应用集合
	 * 
	 * @param roleIds
	 * @return
	 */
	public List<Application> fetchAppsByRoles(String[] roleIds);

	/**
	 * 以app分组获得角色集合的模块集合
	 * 
	 * @param roleIds
	 *            角色集合
	 * @param app
	 *            分组应用
	 * @return
	 */
	public List<Module> fetchModulesOfRolesGroupByApp(String[] roleIds, Application app);

	/**
	 * 获得没有权限要求的功能
	 * 
	 * @return
	 */
	public List<Function> fetchFuncsNeedNoAccess();
	
	
	/**
	 * 获取当前角色拥有作为菜单的功能
	 * @param roleIds 角色ID
	 * @param moduleId 模块ID
	 * @return
	 */
	public List<Function> getFunctionMenusByPermission(String[] roleIds,String moduleId);
	

	public List<GraphNode> getPermssionGraphic(User user);
}
