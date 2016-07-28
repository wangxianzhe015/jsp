package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.PortalPattern;
import com.smartcloud.crowdfunding.portal.service.PortalPatternService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class PortalPatternServiceImpl extends DAOSupport<PortalPattern> implements PortalPatternService {
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public List<PortalPattern> getAllPortalPatterns() {
		List<PortalPattern> patterns=this.findAll(PortalPattern.class);
		Collections.sort(patterns, new Comparator<PortalPattern>(){

			public int compare(PortalPattern o1, PortalPattern o2) {
				return o1.getOrderNo()-o2.getOrderNo();
			}
			
		});
		return patterns;
	}

	public List<PortalPattern> findAllPortalPatterns(PortalPattern portalPattern, Page page) {
		return this.executeEntitiesPageQuery(portalPattern, page);
	}

	public PortalPattern getPortalPattern(Long patternId) {
		PortalPattern pattern=new PortalPattern();
		pattern.setPatternId(patternId);
		return this.find(pattern);
	}

	public void removePortalPattern(Long patternId) {
		PortalPattern pattern=new PortalPattern();
		pattern.setPatternId(patternId);
		delete(pattern);
	}

	public void addPortalPattern(PortalPattern portalPattern) {
		insert(portalPattern);
	}

	public void updatePortalPattern(PortalPattern portalPattern) {
		update(portalPattern);
		
	}

}
