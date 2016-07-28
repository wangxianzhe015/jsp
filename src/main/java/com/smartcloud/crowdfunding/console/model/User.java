/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/User.java,v 1.5 2012/12/31 02:01:04 supyuser Exp $
 * $Revision: 1.5 $
 * $Date: 2012/12/31 02:01:04 $
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

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;


@Entity
@Table(name = "GAS_USER")
public class User implements java.io.Serializable {
	public static final String QUERY_WITH_PAGE = "QUERY_WITH_PAGE";
	public static final String QUERY_USER_FOR_LOGIN = "QUERY_USER_FOR_LOGIN";
	public static final String QUERY_USER_WITH_ORGINFO = "QUERY_USER_WITH_ORGINFO";
	public static final String QUERY_USER_WITH_ORGINFO_BY_ORG = "QUERY_USER_WITH_ORGINFO_BY_ORG";
	public static final String QUERY_USER_NO_ORG = "QUERY_USER_NO_ORG";

	@Id
	@Column(name = "USER_ID")
	private Long userId;

	@Column(name = "PASSWORD")
	private String password;

	@Condition(operator = OPERATOR.LIKE)
	@Column(name = "USER_NAME")
	private String userName;

	@Condition(operator = OPERATOR.LIKE)
	@Column(name = "NICK_NAME")
	private String nickName;

	@JoinColumn(name = "EMPLOYEE_ID")
	private Employee employee;

	@Column(name = "IS_VALID")
	private State valid;

	@JoinColumn(name = "roles", columnDefinition = "SELECT b.* FROM GAS_USER_ROLE a JOIN GAS_ROLE b ON a.ROLE_ID=b.ROLE_ID WHERE a.USER_ID = $USER_ID")
	private List<Role> roles;

	@JoinColumn(name = "ORG_ID")
	private Org org;

	private String orgId;

	private String orgName;

	private String orgPath;

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

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

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public State getValid() {
		return valid;
	}

	public void setValid(State valid) {
		this.valid = valid;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

}
