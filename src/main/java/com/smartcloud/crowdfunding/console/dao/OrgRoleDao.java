/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.model.OrgRole;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

/**
 * @author fred_2012-9-24
 * 
 */
public class OrgRoleDao extends DAOSupport<OrgRole> {
	@PersistenceUnit(name = "default")
	private EntityManager em;



	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public void addOrgRole(OrgRole orgRole) {
		orgRole = PrimaryKeyUtils.getPrimaryKey(orgRole);
		em.persist(orgRole);

	}


	public int deleteOrgRole(OrgRole orgRole) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("orgId", orgRole.getOrgId() == null ? "" : orgRole.getOrgId().toString().trim());
		param.put("roleId", orgRole.getRoleId() == null ? "" : orgRole.getRoleId().toString().trim());
		int i = executeNamedNativeUpdateQuery(Role.DELETE_ORG_ROLE, param);
		return i;
	}


	public List<OrgRole> fetchOrgRoles(OrgRole orgRole) {
		List<OrgRole> orlist = new ArrayList<OrgRole>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("orgId", orgRole.getOrgId() == null ? "" : orgRole.getOrgId().toString().trim());
		param.put("roleId", orgRole.getRoleId() == null ? "" : orgRole.getRoleId().toString().trim());
		orlist = executeNamedNativeQuery(OrgRole.QUERY_ORG_ROLES, param);
		return orlist;
	}

}
