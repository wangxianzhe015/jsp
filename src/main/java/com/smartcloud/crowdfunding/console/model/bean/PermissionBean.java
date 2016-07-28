/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/bean/PermissionBean.java,v 1.1 2012/12/04 07:35:16 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:16 $
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
 * Created on 2012-5-28
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.model.bean;

import java.util.List;

import com.smartcloud.crowdfunding.console.model.Module;


/**
 * 拼接权限资源树使用；依照取权限菜单的逻辑取权限
 * @author fred_2012-11-14上午10:24:13
 *
 */
public class PermissionBean {

	private Module module;
	private List<PermissionBean> children;// 子模块

	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public List<PermissionBean> getChildren() {
		return children;
	}

	public void setChildren(List<PermissionBean> children) {
		this.children = children;
	}

}
