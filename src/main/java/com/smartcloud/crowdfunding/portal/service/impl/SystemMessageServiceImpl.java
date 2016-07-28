package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.condition.CriteriaQuery;
import com.smartcloud.platform.component.persistence.query.condition.Orderby;
import com.smartcloud.platform.component.persistence.query.condition.WhereExpression;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class SystemMessageServiceImpl extends DAOSupport<SystemMessage> implements SystemMessageService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	public void sendMessage(SystemMessage message) {
		message.setSendTime(DateUtils.getCurrentTime());
		
		this.insert(message);
	}

	public List<SystemMessage> findReceiveMessages(String userId, Integer lastestNum) {
		return this.em.createNativeQuery("SELECT * FROM PORTAL_SYSTEM_MESSAGE WHERE TO_ID=? ORDER BY SEND_TIME DESC", SystemMessage.class).setParameter(1, userId).setMaxResults(lastestNum).getResultList();
		
	}

	public List<SystemMessage> findReceiveMessages(String userId, Page page) {
		CriteriaQuery criteria=new CriteriaQuery();
		criteria.setEntityClass(SystemMessage.class.getName());
		criteria.appendExpr(new WhereExpression("toId", "=", userId));
		criteria.appendOrder(new Orderby("sendTime","desc"));

		return this.executeCriteriaPageQuery(criteria, page);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public List<SystemMessage> findSendMessages(String userId, Page page) {
		CriteriaQuery criteria=new CriteriaQuery();
		criteria.setEntityClass(SystemMessage.class.getName());
		criteria.appendExpr(new WhereExpression("fromId", "=", userId));
		criteria.appendOrder(new Orderby("sendTime","desc"));
		
		return this.executeCriteriaPageQuery(criteria, page);
	}

	


}
