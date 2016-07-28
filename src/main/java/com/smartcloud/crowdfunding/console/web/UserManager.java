/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/web/UserManager.java,v 1.2 2012/12/07 09:11:00 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/07 09:11:00 $
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

import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.UserService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Alert;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/user/*",description="用户管理")
public class UserManager extends WebAction {

	@Reference
	private UserService userService;

	@Action(description = "新增用户", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/user/index.action")) })
	public String addUser(User user) {
		userService.addUser(user);
		return SUCCESS;
	}

	@Action(description = "打开新增页面", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/user/add_user.jsp")) })
	public String entryAdd() {
		return SUCCESS;
	}

	@Action(description = "打开修改页面", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/user/update_user.jsp")) })
	public String entryUpdate(User user) {
		user = userService.getUser(user);
		response.addToRequest("user", user);
		return SUCCESS;
	}

	@Action(description = "修改用户", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/user/index.action")) })
	public String updateUser(User user) {
		userService.updateUser(user);
		return SUCCESS;
	}

	@Action(description = "删除用户", responses = { @Response(name = SUCCESS,alert=@Alert(url = "/console/user/index.action", message = "删除成功!")) })
	public String deleteUser(User[] user) {
		for (User u : user) {
			userService.removeUser(u);
		}
		return SUCCESS;
	}

	@Action(description = "用户查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/user/user_list.jsp")) })
	public String index(User user) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);

		List<User> users = userService.findUsers(user, page);
		response.addToRequest("users", users);
		response.addToRequest("page", page);
		response.addToRequest("user", user);

		return SUCCESS;
	}

	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/user/user_list.jsp")) })
	public String pageQuery(User user, Page page) {
		List<User> users = userService.findUsers(user, page);
		response.addToRequest("users", users);
		response.addToRequest("page", page);
		response.addToRequest("user", user);
		return SUCCESS;
	}

	@Action(description = "进入加载树页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/user/userTree.jsp")) })
	public String entryUserTree() {
		try {
			String initValue = (String) request.getRequestParameter("employee.org.orgId");
			// 需要初始化树的属性id

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	/**
	 * 已机构分组，传入不同的机构id，就会得到不同的树
	 * 
	 * TODO 负责人是多个的情况，初始化是个字符串数组
	 * 
	 * @return
	 */
	@Action(description = "生成系统用户树", responses = { @Response(name = SUCCESS, json=@JSON()) })
	public String initUserTree() {
		try {
			String userId = (String) request.getRequestParameter("initId");
			String orgId = (String) request.getRequestParameter("groupId");
			String[] userIds = null;
			if (userId != null && !"".equals(userId)) {
				userIds = userId.split(",");
			}

			List<TreeNodeBean> tree= userService.fetchUserWithOrgTree(userIds, orgId);
			this.response.addToRequest("children", tree);// 返回children：[]的格式

		} catch (Exception e) {
			e.printStackTrace();

		}

		return SUCCESS;
	}

}
