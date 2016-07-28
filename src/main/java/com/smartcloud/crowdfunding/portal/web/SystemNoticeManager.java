package com.smartcloud.crowdfunding.portal.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.SystemNotice;
import com.smartcloud.crowdfunding.portal.service.SystemNoticeService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 系统公告管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="系统公告管理",path="/portal/sysnotice/*",portal=true)
public class SystemNoticeManager extends WebAction{
	
	@Reference
	private SystemNoticeService noticeService;
	
	@Action(description = "系统公告列表", responses = { @Response(name = SUCCESS,forward=@Forward(url="/portal/sysnotice/sysnotice_list.jsp")) })
	public String index(SystemNotice notice,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		
		if(notice==null){
			notice=new SystemNotice();
		}
		page.setCount(true);
		page.setPageSize(10);
		
		List<SystemNotice> notices=noticeService.findSystemNotices(notice, page);
		response.addToRequest("notices", notices);
		return SUCCESS;
		
	}
	
	@Action(description = "进入添加公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/sysnotice/sysnotice_add.jsp")) })
	public String entryAdd(){
		return SUCCESS;
	}
	
	@Action(description = "添加系统公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/sysnotice/index.action")) })
	public String addNotice(SystemNotice notice){
		noticeService.addSystemNotice(notice);
		return SUCCESS;
	}
	
	@Action(description = "进入更新公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/sysnotice/sysnotice_update.jsp")) })
	public String entryUpdate(SystemNotice notice){
		response.addToRequest("notice",noticeService.getSystemNotice(notice.getNoticeId()));
		return SUCCESS;
	}
	
	@Action(description = "更新系统公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/sysnotice/index.action")) })
	public String updateNotice(SystemNotice notice){
		this.noticeService.updateSystemNotice(notice);
		return SUCCESS;
	}
	
	@Action(description = "删除系统公示", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/sysnotice/index.action")) })
	public String remove(SystemNotice[] notice){
		if(notice!=null){
			for(SystemNotice n:notice){
				noticeService.removeSystemNotice(n.getNoticeId());
			}
		}
		return SUCCESS;
	}

}
