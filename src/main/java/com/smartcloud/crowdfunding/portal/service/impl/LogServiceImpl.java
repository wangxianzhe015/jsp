package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.LogonLog;
import com.smartcloud.crowdfunding.portal.service.LogService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class LogServiceImpl extends DAOSupport<LogonLog> implements LogService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	public Long addLogonLog(LogonLog log) {
		this.insert(log);
		return log.getLogId();
	}

	public void updateLogonLog(LogonLog log) {
		// TODO Auto-generated method stub
		this.update(log);
	}

	public void removeLogonLog(LogonLog log) {
		// TODO Auto-generated method stub
		this.delete(log);
	}

	public List<LogonLog> getLogonLogs(LogonLog log, Page page) {
		return this.executeEntitiesPageQuery(log, page);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public LogonLog getLastestLogon(String userId) {
		return (LogonLog)this.em.createNativeQuery("SELECT * FROM PORTAL_LOGON_LOG WHERE USER_ID=? ORDER BY LOGON_TIME DESC", LogonLog.class).setParameter(1, userId).setMaxResults(1).getSingleResult();

	}
}
