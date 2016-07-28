package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.PortalNews;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 网站新闻服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface PortalNewsService {
	
	/**
	 * 添加阅读次数
	 * @param newsId 新闻ID
	 */
	public void addReadCount(Long newsId);

	/**
	 * 获取最新的网站新闻
	 * @param top
	 * @return
	 */
	public List<PortalNews> queryLastestNews(int top);
	/**
	 * 分页查询网站新闻
	 * @param notice
	 * @param page
	 * @return
	 */
	public List<PortalNews> findNews(PortalNews news,Page page);
	
	
	/**
	 * 添加新闻
	 * @param PortalNews
	 */
	public void addNews(PortalNews news);
	
	
	/**
	 * 更新新闻
	 * @param notice
	 */
	public void updateNews(PortalNews news);
	
	/**
	 * 删除新闻
	 * @param noticeId
	 */
	public void removeNews(Long newsId);
	
	/**
	 * 获取新闻
	 * @param newsId
	 * @return
	 */
	public PortalNews getNews(Long newsId);
	
}
