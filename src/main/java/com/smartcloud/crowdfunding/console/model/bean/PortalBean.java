/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model.bean;

import com.smartcloud.crowdfunding.console.model.Portal;

/**
 * 属性继承自portal实体，添加库存状态属性，用来保存用户配置的时候区分是否新加portal
 * 
 * @author fred_2012-11-29下午02:57:57
 * 
 */
public class PortalBean {

	public static final String PERSIST_STATE_EXIST = "exist";// 库中已经存在

	private Portal portal;
	private String persistState;// 是否库中存在

	public String getPersistState() {
		return persistState;
	}

	public void setPersistState(String persistState) {
		this.persistState = persistState;
	}

	public Portal getPortal() {
		return portal;
	}

	public void setPortal(Portal portal) {
		this.portal = portal;
	}

}