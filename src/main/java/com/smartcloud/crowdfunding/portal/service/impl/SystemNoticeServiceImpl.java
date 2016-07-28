package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.SystemNotice;
import com.smartcloud.crowdfunding.portal.service.SystemNoticeService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class SystemNoticeServiceImpl extends DAOSupport<SystemNotice> implements SystemNoticeService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	public List<SystemNotice> findSystemNotices(SystemNotice notice, Page page) {
		return this.executeEntitiesPageQuery(notice, page);
	}

	public void addSystemNotice(SystemNotice notice) {
		insert(notice);
	}

	public void updateSystemNotice(SystemNotice notice) {
		update(notice);
	}

	public void removeSystemNotice(Long noticeId) {
		SystemNotice notice=new SystemNotice();
		notice.setNoticeId(noticeId);
		delete(notice);
		
	}

	public SystemNotice getSystemNotice(Long noticeId) {
		SystemNotice notice=new SystemNotice();
		notice.setNoticeId(noticeId);
		return find(notice);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public List<SystemNotice> queryLastestNotices(int top) {
		
		return em.createNativeQuery("select notice_id,notice_time,title from portal_system_notice order by notice_time desc " ,SystemNotice.class).setMaxResults(top).getResultList();
		
	}

}
