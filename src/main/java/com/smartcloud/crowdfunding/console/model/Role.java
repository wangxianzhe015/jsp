/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/Role.java,v 1.2 2012/12/28 07:41:56 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/28 07:41:56 $
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
 * Created on 2012-5-10
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;

@Entity
@Table(name = "GAS_ROLE")
public class Role implements java.io.Serializable {
	public static final String QUERY_ALL_ROLE_WITH_ORG = "QUERY_ALL_ROLE_WITH_ORG";// ��ѯ
	public static final String DELETE_USER_ROLE = "DELETE_USER_ROLE";
	public static final String DELETE_ORG_ROLE = "DELETE_ORG_ROLE";
	public static final String QUERY_USERROLE_BY_ORGROLE = "QUERY_USERROLE_BY_ORGROLE";
	public static final String QUERY_ROLE_BY_ORG="QUERY_ROLE_BY_ORG";
	public static final String ROLE_STATE_OPEN="1";
	public static final String ROLE_STATE_CLOSE="0";
	@Id
	@Column(name = "ROLE_ID")
	private String roleId;

	@Condition(operator = OPERATOR.LIKE)
	@Column(name = "ROLE_NAME")
	private String roleName;

	@Column(name = "ROLE_TYPE")
	private String roleType;

	@Column(name = "USER_ID")
	private String userId;

	private String userName;// created user name

	@Column(name = "CREATED_TIME")
	private Date createdTime;

	@Column(name = "ROLE_STATE")
	private String roleState;

	@Column(name = "ROLE_MEMO")
	private String roleMemo;


	private Long orgId;

	@Condition(operator = OPERATOR.LIKE)
	private String orgName;

	private String orgPath;

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgPath() {
		return orgPath;
	}

	public void setOrgPath(String orgPath) {
		this.orgPath = orgPath;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public String getRoleState() {
		return roleState;
	}

	public void setRoleState(String roleState) {
		this.roleState = roleState;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRoleMemo() {
		return roleMemo;
	}

	public void setRoleMemo(String roleMemo) {
		this.roleMemo = roleMemo;
	}

}
