/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model.bean;

import java.util.ArrayList;
import java.util.List;

import com.smartcloud.crowdfunding.console.model.ShortcutMenu;



public class ShortcutMenuBean {
	
	private ShortcutMenu shortcutMenu;
	
	private List<ShortcutMenuBean> children=new ArrayList<ShortcutMenuBean>();

	public ShortcutMenu getShortcutMenu() {
		return shortcutMenu;
	}

	public void setShortcutMenu(ShortcutMenu shortcutMenu) {
		this.shortcutMenu = shortcutMenu;
	}

	public List<ShortcutMenuBean> getChildren() {
		return children;
	}

	public void setChildren(List<ShortcutMenuBean> children) {
		this.children = children;
	}

}
