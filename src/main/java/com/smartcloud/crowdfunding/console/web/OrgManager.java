/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/web/OrgManager.java,v 1.3 2012/12/07 09:10:59 supyuser Exp $
 * $Revision: 1.3 $
 * $Date: 2012/12/07 09:10:59 $
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

package com.smartcloud.crowdfunding.console.web;

import java.util.List;

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.OrgService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 机构管理action
 * 
 * @author dgw
 * 
 */
@URI(path="/console/org/*",description="机构管理")
public class OrgManager extends WebAction {

	@Reference
	private OrgService orgService;

	@Action(description = "进入加载树页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/orgTree.jsp")) })
	public String entryOrgTree() {
		// TODO 加一些条件进入加载树页面
		return SUCCESS;
	}

	/**
	 * 使用json前台需要在ajax或者js中取值，要不会生成文件格式
	 * 
	 * TODO 分配角色给机构的时候也可以选择多个机构，也是字符串数组
	 * 
	 * @return
	 */
	@Action(description = "生成树", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initOrgTree() {
		try {
			String orgId = (String) request.getRequestParameter("initId");// 用来初始化选中groupId
			String porgId = (String) request.getRequestParameter("groupId");
			List<TreeNodeBean> orgTree= orgService.fetchOrgTreeNodes(orgId, porgId);
			this.response.addToRequest("children", orgTree);// 返回children：[]的格式
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}


	@Action(description = "机构管理首页", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/org/orgManager.jsp")), 
			@Response(name = FAILURE, forward=@Forward(url = "org/orgManager.jsp")) 
			})
	public String index(Org org,String testId) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);
		if (org == null) {
			org = new Org();
		}
		List<Org> olist = orgService.fetchOrgsWithPage(org, page);
		response.addToRequest("org", org);
		response.addToRequest("olist", olist);
		response.addToRequest("page", page);
		return SUCCESS;
	}

	/**
	 * 分页查询
	 * 
	 * @return
	 */
	@Action(description = "分页查询", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/org/orgManager.jsp")), 
			@Response(name = FAILURE, forward=@Forward(url = "org/orgManager.jsp")) 
			})
	public String pageQuery(Org org, Page page) {
		List<Org> orgs = orgService.fetchOrgsWithPage(org, page);
		response.addToRequest("org", org);
		response.addToRequest("olist", orgs);
		response.addToRequest("page", page);
		return SUCCESS;
	}

	@Action(description = "进入新增页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/addOrg.jsp")) })
	public String entryAdd() {
		return SUCCESS;
	}

	@Action(description = "新增部门机构", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/index.action")) })
	public String add(Org org) {
		orgService.addOrg(org);
		return SUCCESS;
	}

	@Action(description = "进入修改页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/updateOrg.jsp")) })
	public String entryUpdate(Org org) {
		org = orgService.fetchSingleOrgInfo(org);
		response.addToRequest("org", org);
		return SUCCESS;
	}

	@Action(description = "修改机构", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/index.action")) })
	public String update(Org org) {
		orgService.updateOrgInfo(org);
		response.addToRequest("testId", "oneoneone!");
		return SUCCESS;
	}

	/**
	 * 删除机构，机构下的用户没删除
	 * 
	 * @param org
	 * @return
	 * 
	 * @created at 2012-10-11下午01:46:41
	 */
	@Action(description = "删除机构", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/org/index.action")) })
	public String deleteOrg(Org[] org) {
		orgService.deleteOrgs(org);
		return SUCCESS;
	}

}
