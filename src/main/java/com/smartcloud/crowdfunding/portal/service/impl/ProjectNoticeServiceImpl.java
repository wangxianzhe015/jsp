package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.ProjectNotice;
import com.smartcloud.crowdfunding.portal.service.ProjectNoticeService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.SQLQuery;
import com.smartcloud.platform.component.persistence.query.condition.CriteriaQuery;
import com.smartcloud.platform.component.persistence.query.condition.Orderby;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class ProjectNoticeServiceImpl extends DAOSupport<ProjectNotice> implements ProjectNoticeService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	@SuppressWarnings("unchecked")
	public List<ProjectNotice> getProjectNotices(Integer lastestNum) {
		SQLQuery query=(SQLQuery)this.createUnnamedNativeQuery("select * from portal_project_notice order by notice_time desc", ProjectNotice.class).setMaxResults(lastestNum);
		return (List<ProjectNotice>)query.getResultList();
	}

	public List<ProjectNotice> findProjectNotices(ProjectNotice notice, Page page) {
		return this.executeEntitiesPageQuery(notice, page);
	}
	
	
	public List<ProjectNotice> findAllProjectNotices(Page page){
		CriteriaQuery criteria=new CriteriaQuery();
		criteria.setEntityClass(ProjectNotice.class.getName());
		criteria.appendOrder(new Orderby("noticeTime","desc"));
		
		return this.executeCriteriaPageQuery(criteria, page);
	}

	public void addProjectNotice(ProjectNotice notice) {
		this.insert(notice);
		
	}

	public void updateProjectNotice(ProjectNotice notice) {
		this.update(notice);
		
	}

	public void removeProjectNotice(Long noticeId) {
		ProjectNotice notice=new ProjectNotice();
		notice.setNoticeId(noticeId);
		this.delete(notice);
		
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public Integer getNoticeTotalCount() {
		return (Integer)this.createUnnamedNativeQuery("select count(*) from portal_project_notice", Integer.class).getSingleResult();
	}

	public ProjectNotice getProjectNotice(Long noticeId) {
		ProjectNotice notice=new ProjectNotice();
		notice.setNoticeId(noticeId);
		return find(notice);
	}

}
