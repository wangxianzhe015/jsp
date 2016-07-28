/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/Org.java,v 1.1 2012/12/04 07:35:11 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:11 $
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
@Table(name = "GAS_ORG")
public class Org implements java.io.Serializable {
	public static final String QUERY_CHILDREN_ORGINFO_DEEPLY="QUERY_CHILDREN_ORGINFO_DEEPLY"; 
	public static final String QUERY_ORGINFO_WITH_PARENT = "QUERY_ORGINFO_WITH_PARENT";
	public static final String QUERY_CHILDREN_ORGINFO = "QUERY_CHILDREN_ORGINFO";
	public static final String QUERY_ROOT_ORGINFO = "QUERY_ROOT_ORGINFO";
	public static final String GET_ALL_ORG="GET_ALL_ORG"; 
	public static final String GET_CHILDREN_ORG="GET_CHILDREN_ORG"; 
	
	

	@Id
	@Column(name = "ORG_ID")
	private Long orgId;

	@Condition(operator = OPERATOR.LIKE, alias = "a.ORG_NAME")
	@Column(name = "ORG_NAME")
	private String orgName;

	@Column(name = "ORG_MANAGER")
	@Condition(operator = OPERATOR.LIKE, alias = "a.ORG_MANAGER")
	private String orgManager;

	@Column(name = "ORG_MANAGER_NAME")
	private String orgManagerName;

	@Column(name = "PARENT_ORG_ID")
	private Long parentOrgId;

	@Column(name = "ORG_DESC")
	private String orgDesc;
	@Column(name = "ORG_PATH")
	private String orgPath;

	@JoinColumn(name = "roles", columnDefinition = "select b.* from GAS_ORG_ROLE a left join GAS_ROLE b on a.role_id=b.role_id where a.org_ID=$ORG_ID")
	private List<Role> roles;
	
	@Column(name = "ORG_NO")
	private String orgNo;

	private String parentOrgName;

	private String parentOrgPath;

	private String parentOrgManager;

	public String getParentOrgManager() {
		return parentOrgManager;
	}

	public void setParentOrgManager(String parentOrgManager) {
		this.parentOrgManager = parentOrgManager;
	}

	public String getParentOrgPath() {
		return parentOrgPath;
	}

	public void setParentOrgPath(String parentOrgPath) {
		this.parentOrgPath = parentOrgPath;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getOrgManager() {
		return orgManager;
	}

	public void setOrgManager(String orgManager) {
		this.orgManager = orgManager;
	}

	public Long getParentOrgId() {
		return parentOrgId;
	}

	public void setParentOrgId(Long parentOrgId) {
		this.parentOrgId = parentOrgId;
	}

	public String getOrgPath() {
		return orgPath;
	}

	public void setOrgPath(String orgPath) {
		this.orgPath = orgPath;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public String getParentOrgName() {
		return parentOrgName;
	}

	public void setParentOrgName(String parentOrgName) {
		this.parentOrgName = parentOrgName;
	}

	public String getOrgDesc() {
		return orgDesc;
	}

	public void setOrgDesc(String orgMemo) {
		this.orgDesc = orgMemo;
	}

	public String getOrgManagerName() {
		return orgManagerName;
	}

	public void setOrgManagerName(String orgManagerName) {
		this.orgManagerName = orgManagerName;
	}

	public String getOrgNo() {
		return orgNo;
	}

	public void setOrgNo(String displayNo) {
		this.orgNo = displayNo;
	}

	
}
