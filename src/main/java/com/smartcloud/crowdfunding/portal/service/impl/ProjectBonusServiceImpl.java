package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectBonus;
import com.smartcloud.crowdfunding.portal.service.ProjectBonusService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectBonusServiceImpl extends DAOSupport<ProjectBonus> implements ProjectBonusService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public void saveProjectBonus(ProjectBonus bonus) {
		ProjectBonus pb=getProjectBonus(bonus.getProjectId());
		
		if(pb!=null){
			this.update(bonus);
		}else{
			this.insert(bonus);
		}
	}

	public ProjectBonus getProjectBonus(Long projectId) {
		ProjectBonus bonus=new ProjectBonus();
		bonus.setProjectId(projectId);
		return this.find(bonus);
	}

	public void removeProjectBonus(Long projectId) {
		ProjectBonus bonus=new ProjectBonus();
		bonus.setProjectId(projectId);
		this.delete(bonus);
	}
	
	


}
