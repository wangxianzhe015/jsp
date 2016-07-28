package com.smartcloud.crowdfunding.console.service;

import java.util.List;
import java.util.Map;

import com.smartcloud.crowdfunding.console.model.ShortcutMenu;
import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.MenuBean;
import com.smartcloud.crowdfunding.console.model.bean.ShortcutMenuBean;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface LoginService {

	/**
	 * 用户登录<BR>
	 * 登录用户需要校验用户正确性以及获取用户相关信息,如果不成功，提示”用户名或密码不正确“
	 * 
	 * @param user
	 * @return
	 */
	public User login(User user);

	/**
	 * 注销当前用户<BR>
	 * 需要记录登出日志
	 * 
	 * @param user
	 */
	public void logout(User user);

	/**
	 * 根据user获得菜单
	 * 
	 * @param user
	 * @return
	 * 
	 * @created at 2012-10-12上午09:47:26
	 */
	public Map<String, List<MenuBean>> getMenus(com.smartcloud.platform.component.mvc.User webUser);

	/**
	 * 根据user获得快捷菜单
	 * 
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-11-13上午10:19:59
	 */
	public List<ShortcutMenuBean> getShortcutMenus(com.smartcloud.platform.component.mvc.User webUser);

	/**
	 * 根据user获得ShortcutMenu实体
	 * 
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-11-16下午02:54:55
	 */
	public List<ShortcutMenu> getShorcutMenuBo(com.smartcloud.platform.component.mvc.User webUser);

	/**
	 * 设置快捷菜单
	 * 
	 * @param addShortcutMenu
	 * @param deleteShortcutMenu
	 * 
	 * @created at 2012-11-22下午03:45:03
	 */
	public void operateShortcutMenus(ShortcutMenu[] addShortcutMenu, ShortcutMenu[] deleteShortcutMenu);

	/**
	 * 新增快捷菜单
	 * 
	 * @param addShortcutMenus
	 * 
	 * @created at 2012-11-22下午03:45:13
	 */
	public void addShortcutMenus(ShortcutMenu[] addShortcutMenus);

	/**
	 * 删除快捷菜单
	 * 
	 * @param deleteShortcutMenus
	 * 
	 * @created at 2012-11-22下午03:45:23
	 */
	public void deleteShortcutMenus(ShortcutMenu[] deleteShortcutMenus);

}
