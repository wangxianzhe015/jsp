package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectCert;
import com.smartcloud.crowdfunding.portal.service.ProjectCertService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectCertServiceImpl extends DAOSupport<ProjectCert> implements ProjectCertService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	@Override
	protected EntityManager getEntityManager() {
		
		return em;
	}
	public ProjectCert getProjectCert(Long projectId) {
		ProjectCert audit=new ProjectCert();
		audit.setProjectId(projectId);
		return this.find(audit);
	}
	
	public int saveProjectCert(ProjectCert cert) {
		ProjectCert dbCert=this.getProjectCert(cert.getProjectId());
		if(dbCert==null){
			this.insert(cert);
		}else{
			this.update(cert);
		}
		return 1;
	}
	
	public void deleteProjectCert(Long projectId) {
		ProjectCert cert=new ProjectCert();
		cert.setProjectId(projectId);
		
		this.delete(cert);
		
	}



}
