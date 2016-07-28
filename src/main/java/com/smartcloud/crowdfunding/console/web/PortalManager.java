/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/web/PortalManager.java,v 1.4 2012/12/21 02:58:30 supyuser Exp $
 * $Revision: 1.4 $
 * $Date: 2012/12/21 02:58:30 $
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
 * Created on 2012-6-8
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.Portal;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.bean.PortalRoleBean;
import com.smartcloud.crowdfunding.console.service.PortalService;
import com.smartcloud.crowdfunding.console.service.RoleService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 管理员后台管理protal栏目
 * 
 * @author fred_2012-11-29上午08:45:06
 * 
 */
@URI(path="/console/portal/*",description="栏目管理")
public class PortalManager extends WebAction {

	@Reference
	private PortalService portalService;

	@Reference
	private RoleService roleService;

	@Action(description = "初始化栏目列表", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/portalManager.jsp")) })
	public String index(Portal portal) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);
		if (portal == null)
			portal = new Portal();

		List<Portal> plist = portalService.fetchPortalsWithPage(portal, page);
		this.response.addToRequest("portal", portal);
		this.response.addToRequest("plist", plist);
		this.response.addToRequest("page", page);

		return SUCCESS;
	}

	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/portalManager.jsp")) })
	public String pageQuery(Portal portal, Page page) {
		List<Portal> plist = portalService.fetchPortalsWithPage(portal, page);
		this.response.addToRequest("portal", portal);
		this.response.addToRequest("plist", plist);
		this.response.addToRequest("page", page);
		return SUCCESS;
	}

	@Action(description = "进入新增栏目页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/addPortal.jsp")) })
	public String entryAdd() {
		List<Role> rlist = roleService.fetchAllRoles();
		response.addToRequest("rlist", rlist);
		return SUCCESS;
	}

	@Action(description = "新增栏目", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/index.action")) })
	public String add(Portal portal) {
		portalService.addPortal(portal);
		return SUCCESS;
	}

	@Action(description = "进入修改页面", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/portal/updatePortal.jsp")) })
	public String entryUpdate(Portal portal) {
		portal = portalService.getSinglePortalInfo(portal);

		List<Role> rlist = roleService.fetchAllRoles();
		Map<String, PortalRoleBean> prMap = new HashMap<String, PortalRoleBean>();
		List<String> _total_roleIds = new ArrayList<String>();
		for (Role role : rlist) {
			PortalRoleBean prbean = new PortalRoleBean();
			_total_roleIds.add(role.getRoleId());
			prbean.setRole(role);
			prMap.put(role.getRoleId(), prbean);
		}
		String[] roleIds = StringUtils.split(portal.getRoleIds(), ",");
		List<String> _selected_roleIds = Arrays.asList(roleIds);
		Collection<String> c = CollectionUtils.intersection(_total_roleIds, _selected_roleIds);
		for (String tmp : c) {
			prMap.get(tmp).setSelected(true);
		}
		Collection<PortalRoleBean> prc = prMap.values();
		response.addToRequest("portal", portal);
		response.addToRequest("pRoles", prc);
		return SUCCESS;
	}

	/**
	 * TODO 管理员修改portal权限的时候，userPortal表中存在的数据该状态
	 * 
	 * @param portal
	 * @return
	 * 
	 * @created at 2012-12-21上午10:58:49
	 */
	@Action(description = "修改栏目", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/index.action")) })
	public String update(Portal portal) {
		portalService.updatePortal(portal);
		return SUCCESS;
	}

	/**
	 * TODO 管理员删除portal的时候，userPortal表中存在的数据也删除
	 * 
	 * @param portal
	 * @return
	 * 
	 * @created at 2012-12-21上午11:01:24
	 */
	@Action(description = "删除栏目", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/portal/index.action")) })
	public String delete(Portal[] portal) {
		portalService.deletePortal(portal);
		return SUCCESS;
	}

}
