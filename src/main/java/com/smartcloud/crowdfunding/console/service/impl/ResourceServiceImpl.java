package com.smartcloud.crowdfunding.console.service.impl;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.dao.AppDao;
import com.smartcloud.crowdfunding.console.dao.FunctionDao;
import com.smartcloud.crowdfunding.console.dao.ModuleDao;
import com.smartcloud.crowdfunding.console.dao.RoleFunctionDao;
import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.RoleFunction;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.ResourceTreeNode;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.crowdfunding.console.service.RoleService;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.crowdfunding.console.util.DynaTreeUtil;
import com.smartcloud.crowdfunding.console.util.GraphNode;
import com.smartcloud.platform.component.mvc.framework.Framework;
import com.smartcloud.platform.component.mvc.service.internal.ActionBean;
import com.smartcloud.platform.component.mvc.service.internal.ActionParser;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;
import com.smartcloud.platform.component.webservice.WebServiceHelper;

import edu.emory.mathcs.backport.java.util.Collections;


public class ResourceServiceImpl implements ResourceService {

	@Reference
	private ModuleDao moduleDao;

	@Reference
	private FunctionDao functionDAO;

	@Reference
	private AppDao appDao;
	
	@Reference
	private RoleFunctionDao roleFunctionDao;
	
	@Reference
	private RoleService roleService;

	private DynaTreeUtil treeUtil = new DynaTreeUtil();

	public void addFuncs(Function[] funcs) {
		for (Function func : funcs) {
			functionDAO.addFunc(func);
		}
	}

	public void addModule(Module module) {
		moduleDao.addModule(module);
	}

	public void deleteFuncs(Function[] funcs) {
		for (Function func : funcs) {
			deleteFunc(func);

		}
	}

	public void deleteFunc(Function func) {
		functionDAO.deleteFunc(func);
		RoleFunction rf = new RoleFunction();
		rf.setFunctionId(func.getFunctionId());
		roleFunctionDao.deleteRoleFunction(rf);

	}

	public void deleteModule(Module module) {
		moduleDao.deleteModule(module);

	}

	public void updateModule(Module module) {
		moduleDao.updateModule(module);

	}

	public List<Function> fetchFunctionsWithPage(Function function, Page page) {
		List<Function> flist = new ArrayList<Function>();
		flist = functionDAO.fetchAllFunctionsWithPage(function, page);
		return flist;
	}

	public List<Module> fetchModulesWithPage(Module module, Page page) {
		List<Module> mlist = new ArrayList<Module>();
		mlist = moduleDao.fetchAllModulesWithPage(module, page);
		return mlist;
	}

	/**
	 * 获得功能树,层级：应用，模块（函数），函数（模块）
	 * 
	 * 
	 */
	public List<TreeNodeBean> fetchFuncTreeWithModule(String[] initId, String moduleId) {
		List<TreeNodeBean> tree = new ArrayList<TreeNodeBean>();
		List<Application> applications = getAllApps();
		for (Application app : applications) {// 应用全部显示出来
			ResourceTreeNode appNode = new ResourceTreeNode();
			appNode.setAttrId(app.getAppId().toString());
			appNode.setAppId(app.getAppId().toString());
			appNode.setTitle(app.getAppDesc());
			appNode.setTooltip(app.getAppName());
			appNode.setNodeType(TreeNodeBean.NODE_TYPE_APP);
			appNode.setIsFolder(true);
			appNode.setKey("a" + app.getAppId());

			List<Module> modules = fetchModulesByApp(app);
			List<TreeNodeBean> moduleTree=buildModuleTree(modules, initId,true);
			appNode.setChildren(moduleTree);
			
			tree.add(appNode);
		}

		return tree;
	}


	private void fetchFunctionTreeNodes(TreeNodeBean moduleNode,String[] initId) {
		List<Function> functions  = functionDAO.fetchFuncsByModule(moduleNode.getAttrId());
		if(functions!=null && functions.size()>0){
			moduleNode.setIsFolder(true);
			for (Function func : functions) {
				TreeNodeBean functionNode = new TreeNodeBean();
				functionNode.setTitle(func.getDescription());
				functionNode.setTooltip(func.getDescription());
				functionNode.setAttrId(func.getFunctionId().toString());
				functionNode.setNodeType(TreeNodeBean.NODE_TYPE_FUNCTION);
				functionNode.setKey(moduleNode.getKey() + "," + functionNode.getAttrId());
				functionNode.setIcon("leaf.gif");
				if (treeUtil.isInArray(func.getFunctionId().toString(), initId)) {
					functionNode.setActivate(true);
					functionNode.setSelect(true);
					functionNode.setExpand(true);// 如果是选中,就将父节点展开
					functionNode.setPersistState(TreeNodeBean.PERSIST_STATE_EXIST);
				}
				
				moduleNode.getChildren().add(functionNode);
			}
		}

	}

	public Map<String, TreeNodeBean> fetchFuncTreeWithModule(String[] initId, String[] moduleId) {
		Map<String, TreeNodeBean> groups = new HashMap<String, TreeNodeBean>();
		// TODO 参照上面完成fetchFuncTreeWithModule(String[] initId, String[]
		// moduleId)
		return groups;
	}

	/**
	 * 将模块集合转为树列表
	 * 
	 * @param modules
	 * @param initId
	 * @param hasFunctionNode 是否包含功能节点
	 * @return
	 */
	private List<TreeNodeBean> buildModuleTree(List<Module> modules, String[] initId,boolean hasFunctionNode) {
		java.util.Collections.sort(modules, new Comparator<Module>(){

			public int compare(Module o1, Module o2) {
				return o1.getModulePath().compareTo(o2.getModulePath());
			}
			
		});
		
		Map<String,ResourceTreeNode> allCache=new HashMap<String, ResourceTreeNode>();
		Map<String,ResourceTreeNode> resultCache=new HashMap<String,ResourceTreeNode>();
		for(Module module : modules)
		{
			String path = module.getModulePath();
			String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
			
			ResourceTreeNode moduleNode = new ResourceTreeNode();
			if (treeUtil.isInArray(module.getModuleId().toString(), initId)) {
				moduleNode.setSelect(true);// checkbox选中状态
				moduleNode.setActivate(true);// 选项active状态
			}
			
			moduleNode.setKey(path);
			moduleNode.setTitle(module.getModuleDesc());
			moduleNode.setTooltip(module.getModuleName());
			moduleNode.setAttrId(module.getModuleId().toString());
			moduleNode.setNodeType(TreeNodeBean.NODE_TYPE_MODULE);
			System.out.println(">>> moduleId="+module.getModuleId());
			moduleNode.setAppId(module.getApp().getAppId().toString());
			moduleNode.setDisplayNo(module.getModuleNo()==null?0:Integer.parseInt(module.getModuleNo()));
			// 不是叶子节点就是folder
			if (!"Y".equals(module.getIsLeaf())) 
				moduleNode.setIsFolder(true);

			if(hasFunctionNode){
				this.fetchFunctionTreeNodes(moduleNode,initId);
			}
			
			allCache.put(path, moduleNode);
			
			if(pathArray.length==2)
			{
				resultCache.put(path, moduleNode);
			}else{
				String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
				ResourceTreeNode parentNode=allCache.get(parentPath);
				if(parentNode!=null){
					if (moduleNode.getSelect() || moduleNode.getExpand() || moduleNode.getActivate()) {
						parentNode.setExpand(true);
					}
					parentNode.getChildren().add(moduleNode);
					
					java.util.Collections.sort(parentNode.getChildren(), new Comparator<TreeNodeBean>(){
						public int compare(TreeNodeBean o1, TreeNodeBean o2) {
							return o1.getDisplayNo()-o2.getDisplayNo();
						}
						
					});
				}else{
					System.out.println("path="+path);
				}
			}
		}
		

		List<TreeNodeBean> results=new ArrayList<TreeNodeBean>(resultCache.values());
		java.util.Collections.sort(results, new Comparator<TreeNodeBean>(){
			public int compare(TreeNodeBean o1, TreeNodeBean o2) {
				return o1.getDisplayNo()-o2.getDisplayNo();
			}
		});
		return results;
	}
	

	public Map<String, TreeNodeBean> fetchModuleTree(String[] initId, String groupId) {
		Map<String, TreeNodeBean> groups = new HashMap<String, TreeNodeBean>();
		List<Application> applications = getAllApps();
		for (Application app : applications) {
			ResourceTreeNode node = new ResourceTreeNode();
			node.setAttrId(app.getAppId().toString());
			node.setTitle(app.getAppDesc());
			node.setTooltip(app.getAppName());
			node.setKey("a" + node.getAttrId());// 没有modulePath，module中的modulePath也不出现app的Id
			node.setIsFolder(true);// 应用全部是folder
			List<TreeNodeBean> children = getChildrenOfApp(app, initId);
			node.setNodeType(TreeNodeBean.NODE_TYPE_APP);
			node.setAppId(app.getAppId().toString());
			node.setChildren(children);
			// 遍历子节点，如果自己点被选择或者expand，则该应用也展开，因为当前app没在module-func的递归方法当中
			for (TreeNodeBean tb : children) {
				if (tb.getSelect() || tb.getExpand()) {
					node.setExpand(true);
				}

			}

			groups.put(node.getKey(), node);
		}
		return groups;
	}

	/**
	 * 获得app树的children
	 * 
	 * @param app
	 * @return
	 */
	private List<TreeNodeBean> getChildrenOfApp(Application app, String[] initId) {
		List<Module> modules = fetchModulesByApp(app);// 获得所有的module
		return buildModuleTree(modules, initId,false);
	}

	public List<Application> getAllApps() {
		return appDao.getAllApps();
	}

	public Module fetchModule(Module module) {
		module = moduleDao.fecthModule(module);
		return module;
	}

	public Module fetchModuleByModuleId(String moduleId) {
		Module m = new Module();
		m.setModuleId(Long.parseLong(moduleId));
		m = fetchModule(m);
		return m;
	}

	public List<ActionBean> fetchMethodsByModuleId(String moduleId,String username) {
		Module module = fetchModuleByModuleId(moduleId);
		//String contextName=module.getApp().getAppContext();
		//String appName=StringUtils.substringBeforeLast(contextName, "/");
		//if(appName.equals(""))
		//	appName=contextName;
		String appName=Framework.getInstance().getAppConfiguration().getAppName();
		if("ROOT".equals(appName)){
			appName="";
		}
		String protocol=module.getApp().getProtocol();
		String ip=module.getApp().getAppIp();
		String port=module.getApp().getAppPort();
		StringBuilder endpointBuffer=new StringBuilder().append(protocol).append("://").append(ip).append(":").append(port).append("/").append(appName);
		endpointBuffer.append("/webservice/ActionParser");
		
		System.out.println(">>>Call Resource WebService:"+endpointBuffer.toString());
		
		ActionParser service=WebServiceHelper.lookupWS(endpointBuffer.toString(), ActionParser.class, username, null);
		return service.parseAction(module.getEntryUrl());

	}

	public List<Function> fetchFuncsByModuleId(String moduleId) {
		return functionDAO.fetchFuncsByModule(moduleId);
	}

	public Function fetchFunctionByFuncId(String functionId) {
		Function func = new Function();
		func.setFunctionId(Long.parseLong(functionId));
		func = functionDAO.getFunctionById(func);
		return func;
	}

	public void updateFunction(Function function) {
		functionDAO.updateFunction(function);
	}

	public Application addApp(Application app) {
		app = appDao.addApp(app);
		return app;
	}

	public void deleteApp(Application app) {
		appDao.deleteApp(app);
	}

	public Application getApp(Application app) {
		app = appDao.getApp(app);
		return app;
	}

	public Application updateApp(Application app) {
		app = appDao.updateApp(app);
		return app;
	}

	public List<Module> fetchModulesByApp(Application app) {
		return moduleDao.fetchModulesbyApp(app);
	}

	public List<Function> fetchFuncsByRoles(String[] roleIds) {
		return functionDAO.fetchFuncsByRoles(roleIds);
	}

	public List<Function> fetchFuncsByRoles(String[] roleIds, Module module) {
		return functionDAO.fetchFuncsByRolesAndModule(roleIds, module);
	
	}

	public Application getAppByFunc(Function function) {
		Application app = null;
		if (function.getModulePath() != null) {
			app = appDao.getAppByFunc(function);
		}
		return app;
	}


	public List<Application> fetchAppsByRoles(String[] roleIds) {
		return this.getAppsByPermission(roleIds);
	}
	
	
	private List<Application> getAppsByPermission(String[] roleIds){
		String[] tmps = new String[roleIds.length];
		for (int i = 0; i < roleIds.length; i++) {
			String cons = "'" + roleIds[i] + "'";
			tmps[i] = cons;
		}
		
		if(tmps.length==0){//没有角色
			tmps=new String[]{"'NULL'"};
		}
		
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("roleIds", StringUtils.join(tmps, ","));
		return appDao.executeNamedNativeQuery(Application.GET_APP_BY_PERMISSION,params);
	}
	
	private List<Module> getModulesByPermission(String[] roleIds,String appId){
		String[] tmps = new String[roleIds.length];
		for (int i = 0; i < roleIds.length; i++) {
			String cons = "'" + roleIds[i] + "'";
			tmps[i] = cons;
		}
		
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("roleIds", StringUtils.join(tmps, ","));
		params.put("appId", appId);
		return moduleDao.executeNamedNativeQuery(Module.GET_MODULE_BY_PERMISSION,params);
	}

	private List<Function> getFunctionsByPermission(String[] roleIds,String moduleId){
		String[] tmps = new String[roleIds.length];
		for (int i = 0; i < roleIds.length; i++) {
			String cons = "'" + roleIds[i] + "'";
			tmps[i] = cons;
		}
		
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("roleIds", StringUtils.join(tmps, ","));
		params.put("moduleId", moduleId);
		return functionDAO.executeNamedNativeQuery(Function.GET_FUNC_BY_PERMISSION,params);
	}
	

	public List<Function> getFunctionMenusByPermission(String[] roleIds,String moduleId){
		String[] tmps = new String[roleIds.length];
		for (int i = 0; i < roleIds.length; i++) {
			String cons = "'" + roleIds[i] + "'";
			tmps[i] = cons;
		}
		
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("roleIds", StringUtils.join(tmps, ","));
		params.put("moduleId", moduleId);
		return functionDAO.executeNamedNativeQuery(Function.GET_FUNC_MENU_BY_PERMISSION,params);
	}


	// 以app分组，获得各应用下的模块的集合
	public List<Module> fetchModulesOfRolesGroupByApp(String[] roleIds, Application app) {
		if(app==null)
			return new ArrayList<Module>();
		
		List<Module> modules = getModulesByPermission(roleIds,String.valueOf(app.getAppId()));
		Collections.sort(modules, new Comparator<Module>(){

			public int compare(Module o1, Module o2) {
				return Integer.parseInt(o1.getModuleNo())-Integer.parseInt(o2.getModuleNo());
			}
			
		});
		return modules;
	}


	public List<Function> fetchFuncsNeedNoAccess() {
		List<Function> flist = new ArrayList<Function>();
		flist = functionDAO.fetchFuncsNoPermission();
		return flist;
	}

	/**
	 * 根据user生成权限树，权限的资源
	 */
	public List<ResourceTreeNode> fetchPermissionTree(String[] initIds, String funcSwitch, com.smartcloud.platform.component.mvc.User webUser) {
		List<ResourceTreeNode> tree=new ArrayList<ResourceTreeNode>();
		
		List<Application> applications = this.getAppsByPermission(webUser.getRoleIds());
		for (Application app : applications) {
			ResourceTreeNode appNode = new ResourceTreeNode();
			appNode.setAttrId(app.getAppId().toString());
			appNode.setTitle(app.getAppDesc());
			appNode.setTooltip(app.getAppName());
			appNode.setKey("a" + appNode.getAttrId());//
			appNode.setHideCheckbox(true);
			appNode.setIsFolder(true);// 应用全部是folder
			appNode.setNodeType(TreeNodeBean.NODE_TYPE_APP);
			appNode.setAppId(app.getAppId().toString());
			
			List<Module> modules = this.getModulesByPermission(webUser.getRoleIds(),String.valueOf(app.getAppId()));
			java.util.Collections.sort(modules, new Comparator<Module>(){
				public int compare(Module o1, Module o2) {
					return o1.getModulePath().compareTo(o2.getModulePath());
				}
				
			});
			
			Map<String,ResourceTreeNode> allCache=new HashMap<String, ResourceTreeNode>();
			Map<String,ResourceTreeNode> resultCache=new HashMap<String,ResourceTreeNode>();
			for(Module module : modules)
			{
				String path = module.getModulePath();
				String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
				
				ResourceTreeNode moduleNode = new ResourceTreeNode();
				moduleNode.setKey(path);
				moduleNode.setTitle(module.getModuleDesc());
				moduleNode.setTooltip(module.getModuleName());
				moduleNode.setAttrId(module.getModuleId().toString());
				moduleNode.setNodeType(TreeNodeBean.NODE_TYPE_MODULE);
				moduleNode.setAppId(module.getApp().getAppId().toString());
				moduleNode.setDisplayNo(module.getModuleNo()==null?0:Integer.parseInt(module.getModuleNo()));
				// 不是叶子节点就是folder
				if (!"Y".equals(module.getIsLeaf())) 
					moduleNode.setIsFolder(true);

				if("open".equals(funcSwitch)){
					List<Function> functions  =this.getFunctionsByPermission(webUser.getRoleIds(),String.valueOf(module.getModuleId()));
					if(functions!=null && functions.size()>0){
						moduleNode.setIsFolder(true);
						
						for (Function func : functions) {
							TreeNodeBean functionNode = new TreeNodeBean();
							functionNode.setTitle(func.getDescription());
							functionNode.setTooltip(func.getDescription());
							functionNode.setAttrId(func.getFunctionId().toString());
							functionNode.setNodeType(TreeNodeBean.NODE_TYPE_FUNCTION);
							functionNode.setKey(moduleNode.getKey() + "," + functionNode.getAttrId());
							functionNode.setIcon("leaf.gif");
							if (treeUtil.isInArray(func.getFunctionId().toString(), initIds)) {
								functionNode.setActivate(true);
								functionNode.setSelect(true);
								//functionNode.setPersistState(TreeNodeBean.PERSIST_STATE_EXIST);
								moduleNode.setSelect(true);
								moduleNode.setPersistState(TreeNodeBean.PERSIST_STATE_EXIST);
								moduleNode.setExpand(true);// 如果是选中,就将父节点展开
							}
							
							moduleNode.getChildren().add(functionNode);
						}
					}
				}
				
				
				allCache.put(path, moduleNode);
				
				if(pathArray.length==2)
				{
					resultCache.put(path, moduleNode);
				}else{
					String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
					ResourceTreeNode parentNode=allCache.get(parentPath);
					if(parentNode!=null){
						if (moduleNode.getSelect() || moduleNode.getExpand() || moduleNode.getActivate()) {
							parentNode.setExpand(true);
						}
						parentNode.getChildren().add(moduleNode);
						
						java.util.Collections.sort(parentNode.getChildren(), new Comparator<TreeNodeBean>(){
							public int compare(TreeNodeBean o1, TreeNodeBean o2) {
								return o1.getDisplayNo()-o2.getDisplayNo();
							}
							
						});
					}else{
						System.out.println("path="+path);
					}
				}
			}
			

			List<TreeNodeBean> results=new ArrayList<TreeNodeBean>(resultCache.values());
			java.util.Collections.sort(results, new Comparator<TreeNodeBean>(){
				public int compare(TreeNodeBean o1, TreeNodeBean o2) {
					return o1.getDisplayNo()-o2.getDisplayNo();
				}
			});
			appNode.getChildren().addAll(results);
			
			tree.add(appNode);
		}
			
		return tree;
	}


	/**
	 * 根据user生成权限树，权限的资源
	 */
	public List<GraphNode> getPermssionGraphic(User user) {
		List<GraphNode> tree=new ArrayList<GraphNode>();
		List<Role> roles=roleService.fetchRolesByUser(user);
		String[] roleIds=new String[roles.size()];
		for(int i=0;i<roles.size();i++){
			Role role=roles.get(i);
			roleIds[i]=role.getRoleId();
		}
		
		
		List<Application> applications = this.getAppsByPermission(roleIds);
		for (Application app : applications) {
			GraphNode appNode = new GraphNode();
			appNode.setId("app_"+app.getAppId());
			appNode.setName(app.getAppDesc());
			appNode.setLevel(1);
			appNode.setType("app");
			
			tree.add(appNode);
			
			List<Module> modules = this.getModulesByPermission(roleIds,String.valueOf(app.getAppId()));
			java.util.Collections.sort(modules, new Comparator<Module>(){
				public int compare(Module o1, Module o2) {
					return o1.getModulePath().compareTo(o2.getModulePath());
				}
				
			});
			
			Map<String,GraphNode> allCache=new HashMap<String, GraphNode>();
			Map<String,GraphNode> resultCache=new HashMap<String,GraphNode>();
			for(Module module : modules)
			{
				String path = module.getModulePath();
				String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
				
				GraphNode moduleNode = new GraphNode();
				moduleNode.setId("module_"+module.getModuleId());
				moduleNode.setName(module.getModuleDesc());
				moduleNode.setType("module");
				moduleNode.setLevel(2);
				
				appNode.addTargetId(moduleNode.getId());
				
				List<Function> functions  =this.getFunctionsByPermission(roleIds,String.valueOf(module.getModuleId()));
				if(functions!=null && functions.size()>0){

					for (Function func : functions) {
						GraphNode functionNode = new GraphNode();
						functionNode.setId("func_"+func.getFunctionId());
						functionNode.setName(func.getDescription());
						functionNode.setType("func");
						functionNode.setLevel(3);
						functionNode.addTargetId("end");
						
						moduleNode.addTargetId(functionNode.getId());
						
						tree.add(functionNode);
					}
				}else{
					moduleNode.addTargetId("end");
				}
				
				tree.add(moduleNode);
				
			}
			
			tree.add(appNode);
		}
		
		// 添加汇聚节点
		GraphNode computeResult = new GraphNode();
		computeResult.setId("end");
		computeResult.setName("权限结果");
		computeResult.setType("end");
		computeResult.setLevel(4);
		tree.add(computeResult);
		
		return tree;
	}


	
	

}
