package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.crowdfunding.console.model.RoleFunction;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class RoleFunctionDao extends DAOSupport<RoleFunction> {

	@PersistenceUnit(name = "default")
	private EntityManager em;


	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public RoleFunction getSingleRoleFunction(RoleFunction roleFunction) {
		return em.find(RoleFunction.class, roleFunction.getId());
	}


	public List<RoleFunction> getRoleFunctionListByRole(Role role) {
		List<RoleFunction> rflist = new ArrayList<RoleFunction>();
		Map<String, String> param = new HashMap<String, String>();
		param.put("roleId", role.getRoleId().toString());
		rflist = this.executeNamedNativeQuery(RoleFunction.QUERY_FUNCS_BY_ROLE, param);
		return rflist;
	}


	public int deleteRoleFunction(RoleFunction roleFunction) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("roleId", roleFunction.getRoleId() == null ? "" : roleFunction.getRoleId().toString());
		param.put("functionId", roleFunction.getFunctionId() == null ? "" : roleFunction.getFunctionId().toString());
		return this.executeNamedNativeUpdateQuery(RoleFunction.DELETE_ROLE_FUNC, param);
	}


	public void addRoleFunction(RoleFunction roleFunction) {
		roleFunction = PrimaryKeyUtils.getPrimaryKey(roleFunction);
		em.persist(roleFunction);
	}

}
