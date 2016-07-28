/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model.bean;

import com.smartcloud.crowdfunding.console.model.UserPortal;

public class UserPortalBean {
	public static final String PERSIST_STATE_EXIST = "exist";

	private UserPortal userPortal;
	private String persistState;

	public UserPortal getUserPortal() {
		return userPortal;
	}

	public void setUserPortal(UserPortal userPortal) {
		this.userPortal = userPortal;
	}

	public String getPersistState() {
		return persistState;
	}

	public void setPersistState(String persistState) {
		this.persistState = persistState;
	}

}
