/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model.bean;

import com.smartcloud.crowdfunding.console.model.Role;



public class PortalRoleBean {
	private Role role;
	private Boolean selected;

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

}
