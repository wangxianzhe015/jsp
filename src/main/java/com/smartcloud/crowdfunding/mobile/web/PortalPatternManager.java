package com.smartcloud.crowdfunding.mobile.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.PortalPattern;
import com.smartcloud.crowdfunding.portal.service.PortalPatternService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="合作伙伴管理",path="/mobile/pattern/*")
public class PortalPatternManager extends WebAction{

	@Reference
	private PortalPatternService patternService;
	
	@Action(description = "获取所有合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/pattern_list.jsp")) })
	public String index(PortalPattern pattern,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		if(pattern==null){
			pattern=new PortalPattern();
		}
		page.setCount(true);
		page.setPageSize(10);
		List<PortalPattern> patterns=patternService.findAllPortalPatterns(pattern, page);
		response.addToRequest("patterns", patterns);
		response.addToRequest("page",page);
		return SUCCESS;
	}
	
	@Action(description = "进入新增合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/pattern_add.jsp")) })
	public String entryAdd(){
		
		return SUCCESS;
	}
	
	@Action(description = "添加合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/index.action")) })
	public String addPattern(PortalPattern pattern){
		patternService.addPortalPattern(pattern);
		return SUCCESS;
	}
	
	@Action(description = "进入更新合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/pattern_update.jsp")) })
	public String entryUpdate(PortalPattern pattern){
		response.addToRequest("pattern",patternService.getPortalPattern(pattern.getPatternId()));
		return SUCCESS;
	}
	
	
	@Action(description = "进入更新合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/index.action")) })
	public String updatePattern(PortalPattern pattern){
		this.patternService.updatePortalPattern(pattern);
		return SUCCESS;
	}
	
	@Action(description = "删除合作伙伴", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/pattern/index.action")) })
	public String remove(PortalPattern[] pattern){
		if(pattern!=null){
			for(PortalPattern b:pattern){
				patternService.removePortalPattern(b.getPatternId());
			}
		}
		return SUCCESS;
	}
}
