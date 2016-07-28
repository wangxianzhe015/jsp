package com.smartcloud.crowdfunding.mobile.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.PortalNews;
import com.smartcloud.crowdfunding.portal.service.PortalNewsService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 网站新闻管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="网站新闻管理",path="/mobile/news/*",portal=true)
public class PortalNewsManager extends WebAction{
	
	@Reference
	private PortalNewsService newsService;
	
	@Action(description = "系统公告列表", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/news/news_list.jsp")) })
	public String index(PortalNews news,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		
		if(news==null){
			news=new PortalNews();
		}
		page.setCount(true);
		page.setPageSize(10);
		
		List<PortalNews> newss=newsService.findNews(news, page);
		response.addToRequest("newss", newss);
		return SUCCESS;
		
	}
	
	@Action(description = "进入添加公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/news/news_add.jsp")) })
	public String entryAdd(){
		return SUCCESS;
	}
	
	@Action(description = "添加系统公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/news/index.action")) })
	public String addNews(PortalNews news){
		newsService.addNews(news);
		return SUCCESS;
	}
	
	@Action(description = "进入更新公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/news/news_update.jsp")) })
	public String entryUpdate(PortalNews news){
		response.addToRequest("news",newsService.getNews(news.getNewsId()));
		return SUCCESS;
	}
	
	@Action(description = "更新新闻", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/news/index.action")) })
	public String updateNews(PortalNews news){
		this.newsService.updateNews(news);
		return SUCCESS;
	}
	
	@Action(description = "删除新闻", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/news/index.action")) })
	public String remove(PortalNews[] news){
		if(news!=null){
			for(PortalNews n:news){
				newsService.removeNews(n.getNewsId());
			}
		}
		return SUCCESS;
	}

}
