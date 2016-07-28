package com.smartcloud.crowdfunding.console.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.ShortcutMenu;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.UserPortal;
import com.smartcloud.crowdfunding.console.model.bean.DictBean;
import com.smartcloud.crowdfunding.console.model.bean.MenuBean;
import com.smartcloud.crowdfunding.console.model.bean.ShortcutMenuBean;
import com.smartcloud.crowdfunding.console.service.LoginService;
import com.smartcloud.crowdfunding.console.service.PortalService;
import com.smartcloud.crowdfunding.console.service.ResourceService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Alert;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.mvc.web.dict.DictEntry;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="登录管理",portal=true,path="/console/login/*")
public class LoginManager extends WebAction {
	
	@Reference
	LoginService loginService;
	@Reference
	ResourceService resourceService;
	@Reference
	PortalService portalService;


	/**
	 * 系统用户登录
	 * 
	 *TODO 用户名密码不正确/用户名不存在/角色关闭(全部角色关闭没有初始菜单(提示出错)/部分角色存在初始化部分菜单，提示某角色失效)
	 * 
	 * @param user
	 * @return
	 * 
	 * @created at 2012-10-9上午08:39:24
	 */
	@Action(responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/mainFrame.jsp")), 
			@Response(name = FAILURE, forward=@Forward(url = "/console/login.jsp")) 
			})
	public String login(User user) {
		User currentUser = loginService.login(user);
		if (currentUser != null) {
			String[] roleIds = new String[0];
			if (currentUser.getRoles() != null)
				roleIds = new String[currentUser.getRoles().size()];// 多个角色
			try {
				WebUser webUser = new WebUser();// userId/userName/orgId/roleIds[]
				if (currentUser.getEmployee() != null)
					webUser.setOrgId(String.valueOf(currentUser.getEmployee().getOrg().getOrgId()));
				webUser.setUserId(currentUser.getUserId().toString());// 保存数字Id
				webUser.setUserName(currentUser.getNickName());// 保存昵称
				
				if (currentUser.getRoles() != null) {
					for (int i = 0; i < currentUser.getRoles().size(); i++) {
						roleIds[i] = currentUser.getRoles().get(i).getRoleId();
					}
					webUser.setRoleIds(roleIds);
				}
				this.response.addToSession(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION, webUser);// webuser信息保存在session中
			} catch (Exception e) {
				e.printStackTrace();
			}
			// TODO
			// 当前登录动作之后差一步取出所有function，然后拼接成权限串，对页面上的带有action的按钮和view进行隐藏与显示(取action接口已实现)
			this.response.addToRequest("userInfo", currentUser);
			return SUCCESS;
		} else {
			this.response.addToRequest("errorMsg", "用户名或密码错误！");
			return FAILURE;
		}
	}

	@Action(responses = { @Response(name = SUCCESS, alert=@Alert(url = "/console/login.jsp", message="注销成功!")) })
	public String logout() {
		this.request.getSessionContext().destory();
		return SUCCESS;
	}

	/**
	 * 初始化portal的布局可选信息
	 * 
	 * @return
	 * 
	 * @created at 2012-12-19下午02:09:24
	 */
	@Action(responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal.jsp")) })
	public String index() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			//获取数据字典中文描述名称
			String dictName = 
					DictionaryFactory.getInstance().getDictName("portal_layout");
			//获取portal_layout数据字典项列表
			List<DictEntry> dlist = 
					DictionaryFactory.getInstance().getDictType("portal_layout");

			// 获得用户当前的portal_layout
			List<UserPortal> portals = portalService.fetchUserPortalsOfCurrentUser(webUser);
			String currentPL = "";
			if (portals.size() > 0) {
				currentPL = portals.get(0).getPortalLayout();
			} else {
				currentPL = UserPortal.DEFAULT_PORTAL_LAYOUT;
			}
			List<DictBean> dictlist = new ArrayList<DictBean>();
			for (DictEntry dictEntry : dlist) {
				DictBean dbean = new DictBean();
				dbean.setDictEntry(dictEntry);
				if (currentPL.equals(dictEntry.getDictId())) {
					dbean.setInUse(true);
				}
				dictlist.add(dbean);
			}

			response.addToRequest("dicName", dictName);
			response.addToRequest("dictlist", dictlist);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return SUCCESS;
	}
	
	

	/**
	 * 拼接快捷菜单
	 * 
	 * @return
	 * 
	 * @created at 2012-10-11下午03:56:02
	 */
	@Action(description = "获得快捷菜单", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String getShortcutMenus() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			List<ShortcutMenuBean> shortcutMenus = loginService.getShortcutMenus(webUser);
			response.addToRequest("smlist", shortcutMenus);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "进入快捷菜单设置页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/manageShortcutMenu.jsp")) })
	public String entryShortcutPage() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			List<ShortcutMenu> shortcutMenus = new ArrayList<ShortcutMenu>();
			shortcutMenus = loginService.getShorcutMenuBo(webUser);// 获得该用户所有在快捷菜单表中的moduleId的数据，而非算法合并之后的占栏位的模块id
			String[] mids = new String[shortcutMenus.size()];
			for (int i = 0; i < shortcutMenus.size(); i++) {
				mids[i] = shortcutMenus.get(i).getModuleId().toString();
			}
			response.addToRequest("mids", StringUtils.join(mids, ","));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "配置快捷菜单", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String operateShortcutMenus(ShortcutMenu[] addShortcutMenu, ShortcutMenu[] deleteShortcutMenu) {
		loginService.operateShortcutMenus(addShortcutMenu, deleteShortcutMenu);
		return SUCCESS;
	}

	/**
	 * 
	 * @return 
	 *         {AppNameA:[moduleA:{menuName:***,children:[]}],AppNameB:[moduleB:{
	 *         }]}
	 * 
	 * @created at 2012-10-31上午08:55:54
	 */
	@Action(description = "获得系统主菜单", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String getMainMenus() {
		try {
			com.smartcloud.platform.component.mvc.User webUser = (com.smartcloud.platform.component.mvc.User) request.getSessionParameter(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION);
			Map<String, List<MenuBean>> menus = loginService.getMenus(webUser);
			this.response.addToRequest("menus", menus);
			this.response.addToRequest("menusCount", menus.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

}
