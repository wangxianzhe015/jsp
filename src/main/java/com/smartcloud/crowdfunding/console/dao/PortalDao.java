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

import com.smartcloud.crowdfunding.console.model.Portal;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

/**
 * @author fred_2012-11-28����09:01:00
 * 
 */
public class PortalDao extends DAOSupport<Portal> {
	@PersistenceUnit(name = "default")
	private EntityManager em;



	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public List<Portal> fetchPortalsWithPage(Portal portal, Page page) {
		List<Portal> plist = new ArrayList<Portal>();
		plist = this.executeEntitiesPageQuery(portal, page);
		return plist;
	}


	public void addPortal(Portal portal) {
		portal = PrimaryKeyUtils.getPrimaryKey(portal);
		this.em.persist(portal);
	}


	public void updatePortal(Portal portal) {
		this.update(portal);
	}


	public Portal getPortalInfo(Portal portal) {
		portal = this.em.find(Portal.class, portal.getCatalogId());
		return portal;
	}


	public void deletePortal(Portal portal) {
		em.remove(portal);
	}


	public void deleteUserPortalsByPortal(Portal portal) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("catalogId", portal.getCatalogId());
		this.executeNamedNativeUpdateQuery(Portal.DELETE_USERPORTALS_BY_PORTAL, paramMap);

	}


	public List<Portal> fetchAllPortals() {
		List<Portal> plist = new ArrayList<Portal>();
		plist = this.findAll(Portal.class);
		return plist;
	}

}
