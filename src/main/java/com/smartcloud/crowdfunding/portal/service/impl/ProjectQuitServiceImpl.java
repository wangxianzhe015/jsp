package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectQuit;
import com.smartcloud.crowdfunding.portal.service.ProjectQuitService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectQuitServiceImpl extends DAOSupport<ProjectQuit> implements ProjectQuitService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public ProjectQuit getProjectQuitSolution(Long projectId) {

		ProjectQuit quit=new ProjectQuit();
		quit.setProjectId(projectId);
		return find(quit);
	}

	public void saveProjectQuitSolution(ProjectQuit quit) {
		ProjectQuit p=this.getProjectQuitSolution(quit.getProjectId());
		if(p==null){
			this.insert(quit);
		}else{
			this.update(quit);
		}
	}

	@Override
	protected EntityManager getEntityManager() {
		// TODO Auto-generated method stub
		return em;
	}

	public void deleteProjectQuitSolution(Long projectId) {
		// TODO Auto-generated method stub
		ProjectQuit quit=new ProjectQuit();
		quit.setProjectId(projectId);
		
		this.delete(quit);
	}


}
