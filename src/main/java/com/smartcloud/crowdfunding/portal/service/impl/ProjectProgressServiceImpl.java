package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectProgress;
import com.smartcloud.crowdfunding.portal.service.ProjectProgressService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectProgressServiceImpl extends DAOSupport<ProjectProgress> implements ProjectProgressService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	public List<ProjectProgress> getProjectProgresses(Long projectId) {
		return em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_PROGRESS WHERE PROJECT_ID=?",ProjectProgress.class).setParameter(1, projectId).getResultList();
	
	}

	public void addProjectProgress(ProjectProgress progress) {
		ProjectProgress pp=(ProjectProgress)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_PROGRESS WHERE PROJECT_ID=? AND PROJECT_STATE=?", ProjectProgress.class).setParameter(1, progress.getProjectId()).setParameter(2, progress.getProjectState()).getSingleResult();
		if(pp==null)
			this.insert(progress);
		
	}

	public int removeProjectProgress(ProjectProgress progress) {
		this.delete(progress);
		return 1;
	}

	public int updateProjectProgress(ProjectProgress progress) {
		this.update(progress);
		return 1;
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public ProjectProgress getProgress(Long projectId, String projectState) {
		
		return (ProjectProgress)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_PROGRESS WHERE PROJECT_ID=? AND PROJECT_STATE=?",ProjectProgress.class).
				setParameter(1, projectId).
				setParameter(2,projectState).getSingleResult();
	}

	public void deleteProjectProgress(Long projectId) {
		this.em.createNativeQuery("DELETE FROM PORTAL_PROJECT_PROGRESS WHERE PROJECT_ID=?").setParameter(1,projectId).executeUpdate();	
	
	}


}
