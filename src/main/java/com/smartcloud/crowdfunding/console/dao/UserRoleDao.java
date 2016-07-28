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

import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.UserRole;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

/**
 * @author fred_2012-9-24
 * 
 */
public class UserRoleDao extends DAOSupport<UserRole> {
	@PersistenceUnit(name = "default")
	private EntityManager em;



	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public void addUserRole(UserRole userRole) {
		userRole = PrimaryKeyUtils.getPrimaryKey(userRole);
		this.em.persist(userRole);

	}


	public int deleteUserRole(UserRole userRole) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("userId", userRole.getUserId() == null ? "" : userRole.getUserId().trim());
		param.put("roleId", userRole.getRoleId() == null ? "" : userRole.getRoleId().toString().trim());
		int i = executeNamedNativeUpdateQuery(Role.DELETE_USER_ROLE, param);
		return i;
	}


	public List<UserRole> queryUserRolesByOrgRole(Long orgId, Long roleId) {
		List<UserRole> urlist = new ArrayList<UserRole>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("orgId", orgId);
		param.put("roleId", roleId);
		urlist = executeNamedNativeQuery(Role.QUERY_USERROLE_BY_ORGROLE, param);
		return urlist;
	}

}
