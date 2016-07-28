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

import com.smartcloud.crowdfunding.console.model.UserPortal;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;


public class UserPortalDao extends DAOSupport<UserPortal> {
	@PersistenceUnit(name = "default")
	private EntityManager em;



	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public void addUserPortal(UserPortal userPortal) {
		userPortal = PrimaryKeyUtils.getPrimaryKey(userPortal);
		this.em.persist(userPortal);
	}


	public void deleteUserPortal(UserPortal userPortal) {
		this.em.remove(userPortal);
	}
	
	


	public void updateUserPortal(UserPortal userPortal) {
		this.update(userPortal);
	}


	public UserPortal getSingleUserPortalInfo(UserPortal userPortal) {
		userPortal = this.em.find(UserPortal.class, userPortal.getUserPortalId());
		return userPortal;
	}


	public List<UserPortal> fetchUserPortalsByCon(UserPortal userPortal) {
		List<UserPortal> uplist = new ArrayList<UserPortal>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userPortal.getUserId() == null ? "" : userPortal.getUserId().toString());
		uplist = this.executeNamedNativeQuery(UserPortal.QUERY_USER_PORTALS_BY_CON, paramMap);
		return uplist;
	}


	public void changeUserPortalLayout(UserPortal userPortal) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userId", userPortal.getUserId());
		paramMap.put("newPortalLayout", userPortal.getPortalLayout());
		this.executeNamedNativeUpdateQuery(UserPortal.CHANGE_USERS_PORTAL_LAYOUT, paramMap);
	}

}
