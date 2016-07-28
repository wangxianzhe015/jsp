/*******************************************************************************
 * $Header: /cvslv/source/eos/java/venusframework/src/org/venus/framework/mvc/web/WebUser.java,v 1.1 2012/07/23 06:41:13 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/07/23 06:41:13 $
 *
 *==============================================================================
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 * 
 * Created on 2012-5-25
 *******************************************************************************/
package com.smartcloud.crowdfunding.console.web;

import com.smartcloud.platform.component.mvc.User;


public class WebUser implements User{
	
	private String userId;
	
	private String userName;
	
	private String orgId;
	
	private boolean admin;
	
	private String[] roleIds;
	
	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String[] getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String[] roleIds) {
		this.roleIds = roleIds;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public String getUserName() {
		return userName;
	}

}
