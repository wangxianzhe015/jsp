package com.smartcloud.crowdfunding.console.service.impl;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.dao.ShortcutMenuDao;
import com.smartcloud.crowdfunding.console.dao.UserDao;
import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.crowdfunding.console.model.ShortcutMenu;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.MenuBean;
import com.smartcloud.crowdfunding.console.model.bean.ShortcutMenuBean;
import com.smartcloud.crowdfunding.console.service.LoginService;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.crowdfunding.console.util.DigestMessage;
import com.smartcloud.platform.component.rpc.annotation.Reference;

public class LoginServiceImpl implements LoginService {

	@Reference
	private UserDao userDao;

	@Reference
	private ShortcutMenuDao shortcutMenuDAO;

	@Reference
	private ResourceService resourceService;

	public User login(User user) {
		User dbUser = userDao.fetchUser(user);
		if (dbUser != null) {
			try {
				// 用户密码加密
				DigestMessage dm = new DigestMessage(DigestMessage.ALG_MD5);
				boolean right = dm.checkPassword(user.getPassword(), dbUser.getPassword());
				if (right)
					return dbUser;
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void logout(User user) {
		System.out.println(user.getUserName());
	}

	public Map<String, List<MenuBean>> getMenus(com.smartcloud.platform.component.mvc.User webUser) {
		Map<String, List<MenuBean>> menuMap = new HashMap<String, List<MenuBean>>();
		String[] roleIds = webUser.getRoleIds();
		List<Application> applications = resourceService.fetchAppsByRoles(roleIds);
		for (Application app : applications) {
			List<Module> modules = resourceService.fetchModulesOfRolesGroupByApp(roleIds, app);// 获得模块集合[子模块和父模块在同一个list中]，取到所有模块
			List<MenuBean> menus = createMenuBeanByModule(app,modules,roleIds);
			menuMap.put(app.getAppName(), menus);// key-value形式,key是app,value是module组成的MenuBean（模块组成的bean）
		}
		return menuMap;
	}

	

	
	/**
	 * 根据模块生成菜单
	 * 
	 * @param modules
	 * @param menuBean
	 * @param roleIds
	 * @return
	 */
	private List<MenuBean> createMenuBeanByModule(Application app,List<Module> modules,String[] roleIds) {
		
		java.util.Collections.sort(modules, new Comparator<Module>(){

			public int compare(Module o1, Module o2) {
				return o1.getModulePath().compareTo(o2.getModulePath());
			}
			
		});
		
		Map<String,MenuBean> allCache=new HashMap<String, MenuBean>();
		Map<String,MenuBean> resultCache=new HashMap<String,MenuBean>();
		
		for(Module module : modules)
		{
			if("N".equals(module.getIsMenu()))
				continue;
			
			String path = module.getModulePath();
			String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
			
			MenuBean menuBean = new MenuBean();
			menuBean.setMenuId(module.getModuleId().toString());// 设成moduleId
			menuBean.setMenuName(module.getModuleDesc());
			menuBean.setParentMenuId(module.getParentModuleId().toString());// 设成parentModuleId
			menuBean.setMenuUrl(module.getEntryUrl());// 为空就转一下
			menuBean.setIconPath("icon.png");// menu的图标路径
			menuBean.setContextPath(app.getAppContext());
			menuBean.setIp(app.getAppIp());
			menuBean.setPort(app.getAppPort());
			menuBean.setProtocol(app.getProtocol());
			menuBean.setDisplayNo(module.getModuleNo()==null?0:Integer.parseInt(module.getModuleNo()));
			menuBean.setLeaf("Y".equals(module.getIsLeaf()));
			
			if(menuBean.isLeaf()){
				List<Function> functions=resourceService.getFunctionMenusByPermission(roleIds, module.getModuleId().toString());
				for(Function f:functions){
					MenuBean leafMenu = new MenuBean();
					leafMenu.setMenuId("f"+f.getFunctionId());// 设成moduleId
					leafMenu.setMenuName(f.getDescription());
					leafMenu.setParentMenuId(menuBean.getMenuId());// 设成parentModuleId
					leafMenu.setMenuUrl(f.getFunctionUrl());// 为空就转一下
					leafMenu.setIconPath("icon.png");// menu的图标路径
					leafMenu.setContextPath(app.getAppContext());
					leafMenu.setIp(app.getAppIp());
					leafMenu.setPort(app.getAppPort());
					leafMenu.setProtocol(app.getProtocol());
					leafMenu.setDisplayNo(f.getDisplayNo());
					leafMenu.setLeaf(true);
					
					menuBean.getChildren().add(leafMenu);
				}
			}

			allCache.put(path, menuBean);
			
			
			
			if(pathArray.length==2)
			{
				resultCache.put(path, menuBean);
				
			}else{
				String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
				MenuBean parentNode=allCache.get(parentPath);
				if(parentNode!=null){
					parentNode.getChildren().add(menuBean);

					java.util.Collections.sort(parentNode.getChildren(), new Comparator<MenuBean>(){
						public int compare(MenuBean o1, MenuBean o2) {
							return o1.getDisplayNo()-o2.getDisplayNo();
						}
						
					});
				}else{
					System.out.println("path="+path);
				}
			}
		}
		

		List<MenuBean> results=new ArrayList<MenuBean>(resultCache.values());
		java.util.Collections.sort(results, new Comparator<MenuBean>(){
			public int compare(MenuBean o1, MenuBean o2) {
				return o1.getDisplayNo()-o2.getDisplayNo();
			}
		});
		return results;
	

	}


	public List<ShortcutMenuBean> getShortcutMenus(com.smartcloud.platform.component.mvc.User webUser) {
		ShortcutMenu shortcutMenu = new ShortcutMenu();
		shortcutMenu.setUserId(Long.parseLong(webUser.getUserId()));
		List<ShortcutMenu> shortcutMenus = shortcutMenuDAO.fetchShortcutMenusOfUser(shortcutMenu);
		
		java.util.Collections.sort(shortcutMenus, new Comparator<ShortcutMenu>(){

			public int compare(ShortcutMenu o1, ShortcutMenu o2) {
				return o1.getMenuPath().compareTo(o2.getMenuPath());
			}
			
		});
		
		
		Map<String,ShortcutMenuBean> allCache=new HashMap<String, ShortcutMenuBean>();
		Map<String,ShortcutMenuBean> resultCache=new HashMap<String,ShortcutMenuBean>();

		int firstLevelLen=-1;
		
		for (ShortcutMenu shortcut : shortcutMenus) {
			String path = shortcut.getMenuPath();
			String[] pathArray=path.split("\\"+Constants.PATH_FLAG);
			if(firstLevelLen==-1)
				firstLevelLen=pathArray.length;
			
			ShortcutMenuBean menuBean = new ShortcutMenuBean();
			menuBean.setShortcutMenu(shortcut);

			allCache.put(path, menuBean);
			
			
			if(pathArray.length==firstLevelLen)
			{
				resultCache.put(path, menuBean);
				
			}else{
				String parentPath=StringUtils.substringBeforeLast(path, Constants.PATH_FLAG);
				ShortcutMenuBean parentNode=allCache.get(parentPath);
				if(parentNode!=null){
					parentNode.getChildren().add(menuBean);

					java.util.Collections.sort(parentNode.getChildren(), new Comparator<ShortcutMenuBean>(){
						public int compare(ShortcutMenuBean o1, ShortcutMenuBean o2) {
							return o1.getShortcutMenu().getShortcutMenuName().compareTo(o2.getShortcutMenu().getShortcutMenuName());
						}
						
					});
				}else{
					System.out.println("path="+path);
				}
			}
			
		}
		List<ShortcutMenuBean> results=new ArrayList<ShortcutMenuBean>(resultCache.values());

		return results;
	}





	public List<ShortcutMenu> getShorcutMenuBo(com.smartcloud.platform.component.mvc.User webUser) {
		List<ShortcutMenu> slist = new ArrayList<ShortcutMenu>();
		ShortcutMenu shortcutMenu = new ShortcutMenu();
		shortcutMenu.setUserId(Long.parseLong(webUser.getUserId()));
		slist = shortcutMenuDAO.fetchShortcutMenusOfUser(shortcutMenu);
		return slist;
	}

	public void addShortcutMenus(ShortcutMenu[] addShortcutMenus) {
		if(addShortcutMenus!=null){
			for (ShortcutMenu shortcutMenu : addShortcutMenus) {
				shortcutMenuDAO.addShortcutMenuMenu(shortcutMenu);
			}
		}

	}

	public void deleteShortcutMenus(ShortcutMenu[] deleteShortcutMenus) {
		if(deleteShortcutMenus!=null){
			for (ShortcutMenu shortcutMenu : deleteShortcutMenus) {
				shortcutMenuDAO.deleteShortcutMenu(shortcutMenu);
			}
		}

	}

	public void operateShortcutMenus(ShortcutMenu[] addShortcutMenu, ShortcutMenu[] deleteShortcutMenu) {
		addShortcutMenus(addShortcutMenu);
		deleteShortcutMenus(deleteShortcutMenu);

	}

}
