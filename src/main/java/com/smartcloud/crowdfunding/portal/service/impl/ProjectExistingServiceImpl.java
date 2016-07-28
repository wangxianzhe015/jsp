package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectExistingProfile;
import com.smartcloud.crowdfunding.portal.service.ProjectExistingService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectExistingServiceImpl extends DAOSupport<ProjectExistingProfile> implements ProjectExistingService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public ProjectExistingProfile getExistingProfile(Long projectId) {
		ProjectExistingProfile profile=new ProjectExistingProfile();
		profile.setProjectId(projectId);
		return find(profile);
	}

	public void saveExistingProfile(ProjectExistingProfile profile) {
		ProjectExistingProfile p=getExistingProfile(profile.getProjectId());
		if(p!=null){
			this.update(profile);
		}else{
			this.insert(profile);
		}
	}

	@Override
	protected EntityManager getEntityManager() {
		// TODO Auto-generated method stub
		return em;
	}

	public void deleteExistingProfile(Long projectId) {
		// TODO Auto-generated method stub
		ProjectExistingProfile profile=new ProjectExistingProfile();
		profile.setProjectId(projectId);
		
		this.delete(profile);
	}

	
}
