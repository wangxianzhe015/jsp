/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/IEmployeeService.java,v 1.1 2012/12/04 07:35:18 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:18 $
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

package com.smartcloud.crowdfunding.console.service;

import java.util.List;

import com.smartcloud.crowdfunding.console.model.Employee;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface EmployeeService {
	/**
	 * 新增职员
	 * 
	 * @param employee
	 */

	public Employee addEmployee(Employee employee);

	/**
	 * 删除职员信息
	 * 
	 * @param employee
	 * @return
	 */
	public void deleteEmployee(Employee employee);

	/**
	 * 修改职员信息
	 * 
	 * @param employee
	 * @return
	 */
	public int updateEmployee(Employee employee);

	/**
	 * 分页查询符合条件的职员
	 * 
	 * @param employee
	 * @param page
	 * @return
	 */
	public List<Employee> fetchEmployeesWithPage(Employee employee, Page page);

	/**
	 * 查询所有职员信息不分页
	 * 
	 * @param employee
	 * @return
	 */
	public Employee fetchEmployee(Employee employee);

	/**
	 * 获得某机构下的机构职员树
	 * @param employeeId
	 * @param orgId
	 * @return
	 *
	 * @created at 2012-11-7上午09:11:33
	 */
	public List<TreeNodeBean> fetchEmployeeWithOrgTree(String[] employeeId, String orgId);

}
