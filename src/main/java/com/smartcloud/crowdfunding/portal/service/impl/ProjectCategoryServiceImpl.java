package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.crowdfunding.portal.service.ProjectCategoryService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectCategoryServiceImpl extends DAOSupport<ProjectCategory> implements ProjectCategoryService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<ProjectCategory> getProjectCategories() {
		List<ProjectCategory> projectCategories=(List<ProjectCategory>)this.createUnnamedNativeQuery("SELECT * FROM PORTAL_PROJECT_CATEGORY WHERE PARENT_CATEGORY_ID IS NULL ", ProjectCategory.class).getResultList();
		return projectCategories;
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}



}
