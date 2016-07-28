/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/web/EmployeeManager.java,v 1.3 2012/12/07 09:02:58 supyuser Exp $
 * $Revision: 1.3 $
 * $Date: 2012/12/07 09:02:58 $
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

import java.util.ArrayList;
import java.util.List;

import com.smartcloud.crowdfunding.console.model.Employee;
import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.crowdfunding.console.service.EmployeeService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Alert;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(path="/console/employee/*",description="员工管理")
public class EmployeeManager extends WebAction {

	@Reference
	private EmployeeService employeeService;

	/**
	 * 初始化查出所有职员信息list
	 * 
	 * @param page
	 * @return
	 */
	@Action(description = "员工查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/employee/employeeList.jsp")) })
	public String index(Employee employee) {
		Page page = new Page();
		page.setBeginPage(1);
		page.setPageSize(10);
		page.setCount(true);
		if (employee == null)
			employee = new Employee();
		List<Employee> employees = employeeService.fetchEmployeesWithPage(employee, page);
		this.response.addToRequest("employee", employee);
		this.response.addToRequest("elist", employees);
		this.response.addToRequest("page", page);
		return SUCCESS;
	}

	/**
	 * 分页查询
	 * 
	 * @param page
	 * @return
	 */
	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/employee/employeeList.jsp")) })
	public String pageQuery(Employee employee, Page page) {
		List<Employee> elist = employeeService.fetchEmployeesWithPage(employee, page);
		this.response.addToRequest("employee", employee);
		this.response.addToRequest("elist", elist);
		this.response.addToRequest("page", page);
		return SUCCESS;
	}

	@Action(description = "打开新增页面", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/employee/addEmployee.jsp")) })
	public String entryAdd() {
		// 初始化部门list
		List<Org> olist = new ArrayList<Org>();

		this.response.addToRequest("olist", olist);

		return SUCCESS;

	}

	@Action(description = "新增员工", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/employee/index.action")) })
	public String add(Employee employee) {
		employee = employeeService.addEmployee(employee);
		return SUCCESS;

	}

	/**
	 * 进入更新页面，要不要带入page信息
	 * 
	 * @param employee
	 * @return
	 */
	@Action(description = "打开修改页面", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/employee/updateEmployee.jsp")), 
			@Response(name = FAILURE, alert=@Alert(message = "请选择一位员工!")) 
			})
	public String entryUpdate(Employee employee) {
		if (employee == null) {
			return FAILURE;
		}
		employee = employeeService.fetchEmployee(employee);
		this.response.addToRequest("employee", employee);
		// this.response.addToRequest("page", page);
		return SUCCESS;

	}

	@Action(description = "修改员工", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/employee/index.action")) })
	public String update(Employee employee) {
		employeeService.updateEmployee(employee);
		// this.response.addToRequest("page", page);//修改成功之后返回原页面
		return SUCCESS;

	}

	@Action(description = "删除员工", responses = { 
			@Response(name = SUCCESS, alert=@Alert(message = "删除成功!", url = "/console/employee/index.action")) 
			})
	public String delete(Employee[] employee) {
		for (Employee e : employee) {
			employeeService.deleteEmployee(e);
		}
		return SUCCESS;
	}

	/**
	 * 进入employee树加载页面
	 * 
	 * @return
	 * 
	 * @created at 2012-11-7上午09:08:11
	 */
	@Action(description = "进入加载树页面", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url = "/console/employee/employeeTree.jsp")) })
	public String entryEmployeeTree() {
		try {
			// 需要初始化树的属性id

		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	@Action(description = "生成机构职员树", responses = { @Response(name = SUCCESS, json=@JSON())})
	public String initEmployeeTree() {
		try {
			String employeeId = (String) request.getRequestParameter("initId");
			String orgId = (String) request.getRequestParameter("groupId");
			String[] employeeIds = null;
			if (employeeId != null && !"".equals(employeeId)) {
				employeeIds = employeeId.split(",");
			}

			List<TreeNodeBean> employeeTree = employeeService.fetchEmployeeWithOrgTree(employeeIds, orgId);
			this.response.addToRequest("children", employeeTree);// 返回children：[]的格式

		} catch (Exception e) {
			e.printStackTrace();

		}

		return SUCCESS;
	}

}