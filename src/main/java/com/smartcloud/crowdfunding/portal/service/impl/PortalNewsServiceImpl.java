package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.PortalNews;
import com.smartcloud.crowdfunding.portal.service.PortalNewsService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class PortalNewsServiceImpl extends DAOSupport<PortalNews> implements PortalNewsService{
	
	@PersistenceUnit(name="default")
	private EntityManager em;


	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public List<PortalNews> queryLastestNews(int top) {
		
		return em.createNativeQuery("select news_id,news_time,title,news_image,profile,read_count from portal_news order by news_time desc " ,PortalNews.class).setMaxResults(top).getResultList();
		
	}
	
	public void addReadCount(Long newsId){
		em.createNativeQuery("update portal_news set read_count=read_count+1 where news_id=?").setParameter(1, newsId).executeUpdate();
	}

	public List<PortalNews> findNews(PortalNews news, Page page) {
		return this.executeEntitiesPageQuery(news, page);
	}

	public void addNews(PortalNews news) {
		news.setReadCount(0);
		news.setNewsTime(DateUtils.getCurrentTime());
		insert(news);
	}

	public void updateNews(PortalNews news) {
		update(news);
		
	}

	public void removeNews(Long newsId) {
		PortalNews news=new PortalNews();
		news.setNewsId(newsId);
		delete(news);
	}

	public PortalNews getNews(Long newsId) {
		PortalNews news=new PortalNews();
		news.setNewsId(newsId);
		return find(news);
	}

}
