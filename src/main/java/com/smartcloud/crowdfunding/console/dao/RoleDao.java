/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/dao/RoleDao.java,v 1.1 2012/12/07 02:30:14 supyuser Exp $
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

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class RoleDao extends DAOSupport<Role> {
	@PersistenceUnit(name = "default")
	private EntityManager em;

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public List<Role> fetchAllRoleInfos() {
		List<Role> rlist = this.findAll(Role.class);
		return rlist;
	}

	public List<Role> fetchRoleInfosOfOrg(Org org) {
		List<Role> rlist = new ArrayList<Role>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orgId", org.getOrgId());
		rlist = this.executeNamedNativeQuery(Role.QUERY_ROLE_BY_ORG, param);
		return rlist;
	}


	public List<Role> fetchAllRoleWithPage(Role role, Page page) {
		List<Role> rlist = new ArrayList<Role>();
		rlist = this.executeNamedNativePageQuery(Role.QUERY_ALL_ROLE_WITH_ORG, role, page);
		return rlist;
	}


	public Role addRole(Role role) {
		role = PrimaryKeyUtils.getPrimaryKey(role);
		em.persist(role);
		return role;
	}


	public void deleteRole(Role role) {
		this.em.remove(role);
	}


	public void updateRole(Role role) {
		this.update(role);
	}


	public Role getRoleInfo(Role role) {
		role = em.find(Role.class, role.getRoleId());
		return role;
	}

}
