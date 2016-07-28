package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.crowdfunding.portal.service.ProjectCityService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectCityServiceImpl extends DAOSupport<ProjectCity> implements ProjectCityService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public List<ProjectCity> getProvinces() {
		return CityDictionaryFactory.getInstance().getProvinces();
	}

	public List<ProjectCity> getCitys(String id) {
		return CityDictionaryFactory.getInstance().getCitys(id);
	}


}
