package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectSubscribe;
import com.smartcloud.crowdfunding.portal.service.ProjectSubscribeService;
import com.smartcloud.platform.component.common.utils.StringUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectSubscribeServiceImpl extends DAOSupport<ProjectSubscribe> implements ProjectSubscribeService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public void addSubscribe(ProjectSubscribe subscribe) {
		this.insert(subscribe);
	}

	public void updateSubscribe(ProjectSubscribe subscribe) {
		this.update(subscribe);
	}

	public int removeSubscribe(Long subscribeId) {
		ProjectSubscribe subscribe=new ProjectSubscribe();
		subscribe.setSubscribeId(subscribeId);
		this.delete(subscribe);
		return 1;
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public List<ProjectSubscribe> findSubscribes(Long projectId) {
		ProjectSubscribe subscribe=new ProjectSubscribe();
		subscribe.setProjectId(projectId);
		Page page=new Page();
		page.setCount(false);
		
		return this.executeEntitiesPageQuery(subscribe, page);
	}

	public List<ProjectSubscribe> queryAllSubscribes(String projectState,String projectName, Page page) {
		Map<String,String> params=new HashMap<String,String>();
		params.put("projectState",projectState);
		if(StringUtils.isNotNullAndBlank(projectName))
			params.put("projectName", "%"+projectName+"%");
		
		return (List<ProjectSubscribe>)this.executeUnnamedNativePageQuery(
				"SELECT a.*,b.PROJECT_STATE as projectState,b.PROJECT_NAME as projectName FROM portal_project_subscribe a JOIN portal_project b ON a.project_id=b.project_id " +
				" #if(${projectState}!='') AND b.project_state=$projectState #end #if(${projectName}!='') AND b.project_name like ${projectName} #end  ORDER BY a.SUBSCRIBE_TIME desc", null, ProjectSubscribe.class, params, new ProjectSubscribe(), page);
		

	}

	public ProjectSubscribe getSubscribe(String userId, Long projectId) {
		ProjectSubscribe p=(ProjectSubscribe)this.em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_SUBSCRIBE WHERE USER_ID=? AND PROJECT_ID=?",ProjectSubscribe.class).setParameter(1, userId).setParameter(2, projectId).getSingleResult();
		return p;
	}


}
