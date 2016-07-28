package com.smartcloud.crowdfunding.portal.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.Banner;
import com.smartcloud.crowdfunding.portal.service.BannerService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="横幅管理",path="/portal/banner/*")
public class BannerManager extends WebAction{

	@Reference
	private BannerService bannerService;
	
	@Action(description = "获取所有横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/banner_list.jsp")) })
	public String index(Banner banner,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		if(banner==null){
			banner=new Banner();
		}
		page.setCount(true);
		page.setPageSize(10);
		List<Banner> banners=bannerService.findAllBanners(banner, page);
		response.addToRequest("banners", banners);
		response.addToRequest("page",page);
		return SUCCESS;
	}
	@Action(description = "进入添加横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/banner_add.jsp")) })
	public String entryAdd(){
		
		return SUCCESS;
	}
	
	@Action(description = "添加横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/index.action")) })
	public String addBanner(Banner banner){
		bannerService.addBanner(banner);
		return SUCCESS;
	}
	
	@Action(description = "进入更新横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/banner_update.jsp")) })
	public String entryUpdate(Banner banner){
		response.addToRequest("banner",bannerService.getBanner(banner.getBannerId()));
		return SUCCESS;
	}
	
	
	@Action(description = "进入更新横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/index.action")) })
	public String updateBanner(Banner banner){
		this.bannerService.updateBanner(banner);
		return SUCCESS;
	}
	
	@Action(description = "删除横幅", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/banner/index.action")) })
	public String remove(Banner[] banner){
		if(banner!=null){
			for(Banner b:banner){
				bannerService.removeBanner(b.getBannerId());
			}
		}
		return SUCCESS;
	}
}
