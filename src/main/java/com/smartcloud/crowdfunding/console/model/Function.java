/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/Function.java,v 1.1 2012/12/04 07:35:12 supyuser Exp $
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
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;


@Entity
@Table(name = "GAS_FUNCTION")
public class Function implements java.io.Serializable {

	public static final String GET_FUNC_BY_PERMISSION="GET_FUNC_BY_PERMISSION";
	
	public static final String GET_FUNC_MENU_BY_PERMISSION="GET_FUNC_MENU_BY_PERMISSION";
	
	public static final String QUERY_FUNCS_BY_MODULE = "QUERY_FUNCS_BY_MODULE";

	public static final String QUERY_FUNCS_BY_ROLE = "QUERY_FUNCS_BY_ROLE";

	public static final String QUERY_FUNCS_IN_ROLEIDS = "QUERY_FUNCS_IN_ROLEIDS";
	
	public static final String QUERY_FUNCS_IN_ROLEIDS_AND_MODULE = "QUERY_FUNCS_IN_ROLEIDS_AND_MODULE";
	
	public static final String QUERY_FUNCS_NO_ACCESS = "QUERY_FUNCS_NO_ACCESS";

	@Id
	@Column(name = "FUNCTION_ID")
	private Long functionId;

	@Column(name = "FUNCTION_NAME")
	@Condition(operator = OPERATOR.LIKE)
	private String functionName;
	
	@Column(name = "FUNCTION_DESC")
	private String description;

	@Column(name="FUNCTION_URL")
	private String functionUrl;
	
	@Column(name = "IS_MENU")
	private String isMenu;
	
	@Column(name = "ACCESS_FLAG")
	private String accessFlag;
	
	
	@JoinColumn(name = "MODULE_ID", table = "GAS_MODULE", referencedColumnName = "MODULE_ID")
	private Module module;

	@Column(name = "MODULE_PATH")
	private String modulePath;//

	@Column(name="DISPLAY_NO")
	private int displayNo;

	private String pmoduleId;

	private String pmoduleName;

	private String pmoduleMemo;

	private String pmodulePath;

	public String getPmoduleId() {
		return pmoduleId;
	}

	public void setPmoduleId(String pmoduleId) {
		this.pmoduleId = pmoduleId;
	}

	public String getPmoduleName() {
		return pmoduleName;
	}

	public void setPmoduleName(String pmoduleName) {
		this.pmoduleName = pmoduleName;
	}

	public String getPmoduleMemo() {
		return pmoduleMemo;
	}

	public void setPmoduleMemo(String pmoduleMemo) {
		this.pmoduleMemo = pmoduleMemo;
	}

	public String getPmodulePath() {
		return pmodulePath;
	}

	public void setPmodulePath(String pmodulePath) {
		this.pmodulePath = pmodulePath;
	}

	public Long getFunctionId() {
		return functionId;
	}

	public void setFunctionId(Long functionId) {
		this.functionId = functionId;
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public String getModulePath() {
		return modulePath;
	}

	public void setModulePath(String modulePath) {
		this.modulePath = modulePath;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String memo) {
		this.description = memo;
	}

	public String getFunctionUrl() {
		return functionUrl;
	}

	public void setFunctionUrl(String functionUrl) {
		this.functionUrl = functionUrl;
	}

	public String getIsMenu() {
		return isMenu;
	}

	public void setIsMenu(String isMenu) {
		this.isMenu = isMenu;
	}

	public String getAccessFlag() {
		return accessFlag;
	}

	public void setAccessFlag(String accessFlag) {
		this.accessFlag = accessFlag;
	}

	public int getDisplayNo() {
		return displayNo;
	}

	public void setDisplayNo(int displayNo) {
		this.displayNo = displayNo;
	}

	
}
