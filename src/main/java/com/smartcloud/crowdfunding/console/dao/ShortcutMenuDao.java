/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.model.ShortcutMenu;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

/**
 * @author fred_2012-9-19
 * 
 */
public class ShortcutMenuDao extends DAOSupport<ShortcutMenu> {

	@PersistenceUnit(name = "default")
	private EntityManager em;


	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public void addShortcutMenuMenu(ShortcutMenu shortcutMenu) {
		shortcutMenu = PrimaryKeyUtils.getPrimaryKey(shortcutMenu);
		em.persist(shortcutMenu);
	}


	public int deleteShortcutMenu(ShortcutMenu shortcutMenu) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", shortcutMenu.getUserId() == null ? "" : shortcutMenu.getUserId().toString());
		param.put("moduleId", shortcutMenu.getModuleId() == null ? "" : shortcutMenu.getModuleId().toString());
		return this.executeNamedNativeUpdateQuery(ShortcutMenu.DELETE_SHORTCUT_MENU, param);
	}


	public List<ShortcutMenu> fetchShortcutMenusOfUser(ShortcutMenu shortcutMenu) {
		List<ShortcutMenu> slist = new ArrayList<ShortcutMenu>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", shortcutMenu.getUserId() == null ? "" : shortcutMenu.getUserId().toString());
		param.put("moduleId", shortcutMenu.getModuleId() == null ? "" : shortcutMenu.getModuleId().toString());
		slist = this.executeNamedNativeQuery(ShortcutMenu.QUERY_SHORTCUT_MENUS_OF_USER, param);
		return slist;
	}

}
