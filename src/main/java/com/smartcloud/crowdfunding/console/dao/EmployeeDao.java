/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/dao/EmployeeDao.java,v 1.1 2012/12/07 02:30:14 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/07 02:30:14 $
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

package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.model.Employee;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class EmployeeDao extends DAOSupport<Employee> {

	@PersistenceUnit(name = "default")
	private EntityManager em;

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public Employee findEmployee(Employee employee) {

		return em.find(Employee.class, employee.getEmployeeId());
	}


	public List<Employee> queryAllEmployeeWithPage(Employee employee, Page page) {
		List<Employee> list = this.executeEntitiesPageQuery(employee, page);
		// return this.createNamedNativePageQuery("QUERY_ALL_EMPLOYEE",
		// page,employee);
		return list;
	}

	public Employee addEmployee(Employee employee) {

		employee = PrimaryKeyUtils.getPrimaryKey(employee);
		em.persist(employee);
		return employee;

	}

	public void updateEmployee(Employee employee) {
		this.em.merge(employee);

	}

	public void deleteEmployee(Employee employee) {
		em.remove(employee);
	}


	public List<Employee> findAllEmployeesNoOrg() {

		List<Employee> elist = new ArrayList<Employee>();
		elist = (List<Employee>) this.createNamedNativeQuery(Employee.QUERY_EMPLOYEE_NO_ORG).getResultList();
		return elist;

	}

	public List<Employee> findAllUsers(String orgId) {

		List<Employee> elist = new ArrayList<Employee>();

		Map<String, String> param = new HashMap<String, String>();
		param.put("orgId", orgId);
		elist = this.executeNamedNativeQuery(Employee.QUERY_EMPLOYEE_WITH_ORGINFO_BY_ORG, param);
		return elist;

	}

}
