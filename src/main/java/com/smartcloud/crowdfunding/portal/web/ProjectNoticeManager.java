package com.smartcloud.crowdfunding.portal.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectNotice;
import com.smartcloud.crowdfunding.portal.service.ProjectNoticeService;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 项目公示管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="项目公示管理",path="/portal/projectnotice/*",portal=true)
public class ProjectNoticeManager extends WebAction{

	@Reference
	private ProjectNoticeService projectNoticeService;
	
	@Reference
	ProjectService projectService;
	
	@Action(description = "项目公示列表", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/projectnotice/projectnotice_list.jsp")) })
	public String index(ProjectNotice notice,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		
		if(notice==null){
			notice=new ProjectNotice();
		}
		page.setCount(true);
		page.setPageSize(10);
		
		List<ProjectNotice> notices=projectNoticeService.findProjectNotices(notice, page);
		response.addToRequest("notices", notices);
		return SUCCESS;
		
	}
	
	@Action(description = "进入添加项目公示", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/projectnotice/projectnotice_add.jsp")) })
	public String entryAdd(){
		List<Project> projects=projectService.findProjectIdAndNames();
		response.addToRequest("projects", projects);
		return SUCCESS;
	}
	
	@Action(description = "添加项目公示", responses = { @Response(name = SUCCESS,forward=@Forward(url="/portal/projectnotice/index.action")) })
	public String addNotice(ProjectNotice notice){
		projectNoticeService.addProjectNotice(notice);
		return SUCCESS;
	}
	
	@Action(description = "进入更新项目公示", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/projectnotice/projectnotice_update.jsp")) })
	public String entryUpdate(ProjectNotice notice){
		List<Project> projects=projectService.findProjectIdAndNames();
		response.addToRequest("projects", projects);
		response.addToRequest("notice",projectNoticeService.getProjectNotice(notice.getNoticeId()));
		return SUCCESS;
	}
	
	
	@Action(description = "更新项目公示", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/projectnotice/index.action")) })
	public String updateNotice(ProjectNotice notice){
		this.projectNoticeService.updateProjectNotice(notice);
		return SUCCESS;
	}
	
	@Action(description = "删除项目公示", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/projectnotice/index.action")) })
	public String remove(ProjectNotice[] notice){
		if(notice!=null){
			for(ProjectNotice n:notice){
				projectNoticeService.removeProjectNotice(n.getNoticeId());
			}
		}
		return SUCCESS;
	}

}
