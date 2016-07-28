/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/RoleFunction.java,v 1.1 2012/12/04 07:35:12 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:12 $
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
 * Created on 2012-5-14
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "GAS_ROLE_FUNCTION")
public class RoleFunction implements java.io.Serializable {

	public static final String QUERY_FUNCS_BY_ROLE = "QUERY_FUNCS_BY_ROLE";
	public static final String DELETE_ROLE_FUNC="DELETE_ROLE_FUNC";

	@Id
	@Column(name = "ROLE_FUNC_ID")
	private Long id;

	@Column(name = "ROLE_ID")
	private Long roleId;

	@Column(name = "FUNCTION_ID")
	private Long functionId;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	public Long getFunctionId() {
		return functionId;
	}

	public void setFunctionId(Long functionId) {
		this.functionId = functionId;
	}


}
