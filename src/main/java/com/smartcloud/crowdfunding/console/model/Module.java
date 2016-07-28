/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/Module.java,v 1.1 2012/12/04 07:35:11 supyuser Exp $
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
@Table(name = "GAS_MODULE")
public class Module implements java.io.Serializable {

	public static final String GET_MODULE_BY_ROLE="GET_MODULE_BY_ROLE";
	
	public static final String GET_MODULE_BY_PERMISSION="GET_MODULE_BY_PERMISSION";
	public static final String QUERY_ROOT_MODULE = "QUERY_ROOT_MODULE";
	public static final String QUERY_MODULES_BY_MODULE = "QUERY_MODULES_BY_MODULE";
	public static final String QUERY_MODULES_BY_APP = "QUERY_MODULES_BY_APP";

	public static final String MODULE_NEED_ACCESS = "Y";
	public static final String MODULE_NOT_NEED_ACCESS = "N";

	@Id
	@Column(name = "MODULE_ID")
	private Long moduleId;

	@Condition(operator = OPERATOR.LIKE)
	@Column(name = "MODULE_NAME")
	private String moduleName;

	@Column(name = "MODULE_DESC")
	@Condition(operator = OPERATOR.LIKE)
	private String moduleDesc;

	@Column(name = "PARENT_MODULE_ID")
	private Long parentModuleId;


	private String parentModuleName;

	@Column(name = "ENTRY_URL")
	private String entryUrl;


	@Column(name = "MODULE_PATH")
	private String modulePath;

	@Column(name = "MODULE_NO")
	private String moduleNo;

	@Column(name = "IS_LEAF")
	private String isLeaf;

	@JoinColumn(name = "APP_ID", referencedColumnName = "APP_ID", table = "GAS_APPLICATION")
	private Application app;

	@Column(name = "ICON_PATH")
	private String iconPath;
	
	@Column(name = "IS_MENU")
	private String isMenu;
	
	@Column(name = "ACCESS_FLAG")
	private String accessFlag;

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

	public Application getApp() {
		return app;
	}

	public void setApp(Application app) {
		this.app = app;
	}



	public Long getModuleId() {
		return moduleId;
	}

	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}

	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	public String getModuleDesc() {
		return moduleDesc;
	}

	public void setModuleDesc(String moduleMemo) {
		this.moduleDesc = moduleMemo;
	}

	public String getEntryUrl() {
		return entryUrl;
	}

	public void setEntryUrl(String entryUrl) {
		this.entryUrl = entryUrl;
	}

	public String getModulePath() {
		return modulePath;
	}

	public void setModulePath(String modulePath) {
		this.modulePath = modulePath;
	}


	public String getModuleNo() {
		return moduleNo;
	}

	public void setModuleNo(String moduleNo) {
		this.moduleNo = moduleNo;
	}

	public Long getParentModuleId() {
		return parentModuleId;
	}

	public void setParentModuleId(Long parentModuleId) {
		this.parentModuleId = parentModuleId;
	}

	public String getParentModuleName() {
		return parentModuleName;
	}

	public void setParentModuleName(String parentModuleName) {
		this.parentModuleName = parentModuleName;
	}

	public String getIsMenu() {
		return isMenu;
	}

	public void setIsMenu(String isMenu) {
		this.isMenu = isMenu;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public String getAccessFlag() {
		return accessFlag;
	}

	public void setAccessFlag(String accessFlag) {
		this.accessFlag = accessFlag;
	}
	
	
}
