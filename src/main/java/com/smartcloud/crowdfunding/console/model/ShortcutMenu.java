package com.smartcloud.crowdfunding.console.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "GAS_SHORTCUT_MENU")
public class ShortcutMenu implements Serializable {
	public static final String DELETE_SHORTCUT_MENU = "DELETE_SHORTCUT_MENU";
	public static final String QUERY_SHORTCUT_MENUS_OF_USER = "QUERY_SHORTCUT_MENUS_OF_USER";

	@Id
	@Column(name = "SHORTCUT_MENU_ID")
	private Long shortcutMenuId;

	@Column(name = "USER_ID")
	private Long userId;

	@Column(name = "MODULE_ID")
	private Long moduleId;

	private String shortcutMenuUrl;

	private String shortcutMenuName;

	private String menuPath;
	
	private String ip;
	
	private String port;
	
	private String webContext;
	
	private String protocol;
	

	public Long getShortcutMenuId() {
		return shortcutMenuId;
	}

	public void setShortcutMenuId(Long shortcutMenuId) {
		this.shortcutMenuId = shortcutMenuId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getModuleId() {
		return moduleId;
	}

	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}

	public String getShortcutMenuUrl() {
		return new StringBuilder().append(protocol).append("://").append(ip).append(":").append(port).append(webContext).append(shortcutMenuUrl).toString();
	}

	public void setShortcutMenuUrl(String shortcutMenuUrl) {
		this.shortcutMenuUrl = shortcutMenuUrl;
	}

	public String getShortcutMenuName() {
		return shortcutMenuName;
	}

	public void setShortcutMenuName(String shortcutMenuName) {
		this.shortcutMenuName = shortcutMenuName;
	}


	public String getMenuPath() {
		return menuPath;
	}

	public void setMenuPath(String menuPath) {
		this.menuPath = menuPath;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getWebContext() {
		return webContext;
	}

	public void setWebContext(String webContext) {
		this.webContext = webContext;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	
}
