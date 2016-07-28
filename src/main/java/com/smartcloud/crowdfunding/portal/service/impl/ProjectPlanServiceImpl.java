package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectPlan;
import com.smartcloud.crowdfunding.portal.service.ProjectPlanService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectPlanServiceImpl extends DAOSupport<ProjectPlan> implements ProjectPlanService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public ProjectPlan getProjectPlan(Long projectId) {
		ProjectPlan plan=new ProjectPlan();
		plan.setProjectId(projectId);
		return this.find(plan);
	}

	public void saveProjectPlan(ProjectPlan plan) {
		ProjectPlan p=getProjectPlan(plan.getProjectId());
		if(p==null){
			this.insert(plan);
		}else{
			this.update(plan);
		}
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public void deleteProjectPlan(Long projectId) {
		ProjectPlan plan=new ProjectPlan();
		plan.setProjectId(projectId);
		this.delete(plan);
		
	}


}
