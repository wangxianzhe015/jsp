package com.smartcloud.crowdfunding.mobile.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.dict.ProjectCategoryDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.Banner;
import com.smartcloud.crowdfunding.portal.model.PortalNews;
import com.smartcloud.crowdfunding.portal.model.PortalPattern;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.crowdfunding.portal.model.ProjectCert;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.crowdfunding.portal.model.ProjectDoc;
import com.smartcloud.crowdfunding.portal.model.ProjectNotice;
import com.smartcloud.crowdfunding.portal.model.SystemNotice;
import com.smartcloud.crowdfunding.portal.service.BannerService;
import com.smartcloud.crowdfunding.portal.service.PortalNewsService;
import com.smartcloud.crowdfunding.portal.service.PortalPatternService;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectCertService;
import com.smartcloud.crowdfunding.portal.service.ProjectCityService;
import com.smartcloud.crowdfunding.portal.service.ProjectNoticeService;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.crowdfunding.portal.service.SystemNoticeService;
import com.smartcloud.platform.component.common.utils.StringUtils;
import com.smartcloud.platform.component.mvc.User;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.mvc.web.dict.DictEntry;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.condition.CriteriaQuery;
import com.smartcloud.platform.component.persistence.query.condition.Orderby;
import com.smartcloud.platform.component.persistence.query.condition.WhereExpression;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="首页管理",path="/mobile/main/*",portal=true)
public class MainManager extends WebAction{

	@Reference
	private BannerService bannerService;
	
	@Reference
	private ProjectService projectService;
	
	@Reference
	private ProjectNoticeService projectNoticeService;
	
	@Reference
	private ProjectCityService cityService; 
	
	@Reference
	private ProjectCertService certService;
	
	@Reference
	private PortalUserService userService;
	
	@Reference
	private SystemNoticeService noticeService;
	
	@Reference
	private PortalPatternService patternService;
	
	@Reference
	private PortalNewsService newsService;
	
	private String menuId;
	
	//是否登录
	private String logon;
	
	@Action(description = "首页", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/index.jsp")) })
	public String index(){
		//获取所有广告横幅
		List<Banner> banners=bannerService.getAllBanners();
		
		List<Project> topProjects=projectService.getTopProjects();
		
		List<SystemNotice> systemNotices=noticeService.queryLastestNotices(2);
		
		//获取最新10条公告
		List<ProjectNotice> projectNotices=projectNoticeService.getProjectNotices(6);
		List<PortalNews> portalNewss=newsService.queryLastestNews(4);
		List<PortalPattern> portalPatterns=patternService.getAllPortalPatterns();
		
		//Integer preparedCount=projectService.statProjectsByState(Constants.PROJECT_STATE_PREPARED);
		//Integer financingCount=projectService.statProjectsByState(Constants.PROJECT_STATE_FINANCING);
		//Integer successedCount=projectService.statProjectsByState(Constants.PROJECT_STATE_SUCCESSED);
		//Integer projectNoticeCount=projectNoticeService.getNoticeTotalCount();
		
		//response.addToRequest("preparedCount", preparedCount);
		//response.addToRequest("financingCount", financingCount);
		//response.addToRequest("successedCount", successedCount);
		//response.addToRequest("projectNoticeCount", projectNoticeCount);
		response.addToRequest("topProjects", topProjects);
		response.addToRequest("banners", banners);
		response.addToRequest("projectNotices", projectNotices);
		response.addToRequest("systemNotices", systemNotices);
		response.addToRequest("portalNewss", portalNewss);
		response.addToRequest("portalPatterns", portalPatterns);
		
		menuId=Constants.MENU_ITEMS[0];
		

		return SUCCESS;
	}
	
	
	@Action(description = "查看项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/main/project_detail3.jsp")) })
	public String showProject(Long projectId){
		
		Project project=projectService.getProject(projectId);
		ProjectDoc projectDoc=projectService.getProjectDoc(projectId);
		ProjectCert projectCert=certService.getProjectCert(projectId);
		List<Project> hotProjects=projectService.getProjectsByType(Constants.PROJECT_TYPE_HOT, 5);
		
		//获取项目发起人信息
		PortalUser user=userService.getUserById(project.getUserId());

		User sessionUser=request.getSessionContext().getUser();
		boolean isAttention=false;
		if(sessionUser!=null)
			isAttention=projectService.isAttention(sessionUser.getUserId(), projectId);
		
		response.addToRequest("user", user);
		response.addToRequest("isAttention", isAttention==true?"1":"0");
		
		response.addToRequest("hotProjects",hotProjects);
		response.addToRequest("projectCert", projectCert);
		response.addToRequest("project", project);
		response.addToRequest("projectDoc", projectDoc);
		
		menuId=Constants.MENU_ITEMS[1];
		return SUCCESS;
	}
	
	
	@Action(description = "查看项目公示信息", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/main/project_notice_info.jsp")) })
	public String showProjectNotice(Long noticeId){
		return SUCCESS;
	}
	
	
	@Action(description = "获取项目列表", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String getProject(String projectState,String sort,String orderby){
		int num=4;
		//预热显示最新3条记录
		if(Constants.PROJECT_STATE_PREPARED.equals(projectState)){
			num=3;
		}
		List<Project> projects=projectService.getProjectsByState(projectState,sort,orderby, num);
		response.addToRequest("projects", projects);
		return SUCCESS;
	}
	
	@Action(description = "根据项目状态获取所有项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/main/project_list.jsp")) })
	public String query(Project project, String sort,Page page){
		projectlist(project, sort,page);
		return SUCCESS;
	}
	
	@Action(description = "关于我们", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/intro/index.jsp")) })
	public String aboutus(Project project, String sort,Page page){
		menuId=Constants.MENU_ITEMS[3];
		return SUCCESS;
	}
	
	
	
	@Action(description = "根据项目状态获取所有项目", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/main/project_list.jsp")) })
	public String projectlist(Project project, String sort,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		if(project==null)
			project=new Project();
		
		page.setCount(true);
		page.setPageSize(8);
		
		CriteriaQuery criteria=new CriteriaQuery();
		criteria.setEntityClass(Project.class.getName());
		if(StringUtils.isNotNullAndBlank(project.getProjectState()))
			criteria.appendExpr(new WhereExpression("projectState", "=", project.getProjectState()));
		if(StringUtils.isNotNullAndBlank(project.getIndustryCategory()))
			criteria.appendExpr(new WhereExpression("industryCategory", "=", project.getIndustryCategory()));
		if(StringUtils.isNotNullAndBlank(project.getCity()))
			criteria.appendExpr(new WhereExpression("city", "=", project.getCity()));
		if(StringUtils.isNotNullAndBlank(project.getProjectName()))
			criteria.appendExpr(new WhereExpression("projectName", "like", project.getProjectName()));
		
		if(StringUtils.isNotNullAndBlank(sort))
			criteria.appendOrder(new Orderby(sort,"ASC"));
		else{
			//默认按项目顺序排序
			criteria.appendOrder(new Orderby("projectNo","DESC"));
			criteria.appendOrder(new Orderby("createTime","DESC"));
		}
		
		if(StringUtils.isNullOrBlank(project.getProjectState()))
			criteria.appendExpr(new WhereExpression("projectState", "in", "('prepared','financing','successed')"));
		
		List<Project> projects=projectService.queryProjects(criteria, page);
		
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();
		
		List<DictEntry> projectStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		//有效状态
		List<DictEntry> validProjectStates=new ArrayList<DictEntry>();
		Iterator<DictEntry> it=projectStates.iterator();
		while(it.hasNext()){
			DictEntry entry=it.next();
			if(StringUtils.contains(Constants.NORMAL_PROJECT_STATES, entry.getDictId())){
				validProjectStates.add(entry);
			}
		}
		
		List<Project> recommendProjects=projectService.getRecommendProjects();
		
		List<ProjectCity> provinces=this.cityService.getProvinces();
		response.addToRequest("recommendProjects", recommendProjects);
		response.addToRequest("provinces",provinces);
		response.addToRequest("projectStates", validProjectStates);
		response.addToRequest("projectCategories", projectCategories);
		response.addToRequest("projects", projects);
		response.addToRequest("page", page);
		response.addToRequest("project", project);
		response.addToRequest("sort", sort);
		
		menuId=Constants.MENU_ITEMS[1];
		
		return SUCCESS;
	}

	
	@Action(description = "查看系统公告内容", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/main/system_notice.jsp")) })
	public String detailSysNotice(Long noticeId){
		SystemNotice notice=noticeService.getSystemNotice(noticeId);
		response.addToRequest("systemNotice", notice);
		return SUCCESS;
	}
	
	@Action(description = "查看新闻资讯", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/main/news_detail.jsp")) })
	public String detailNews(Long newsId){
		PortalNews news=newsService.getNews(newsId);
		newsService.addReadCount(newsId);
		response.addToRequest("news", news);
		return SUCCESS;
	}
	
	@Action(description = "显示所有新闻资讯", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/infor/news_list.jsp")) })
	public String listNews(Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		List<PortalNews> newss=newsService.findNews(new PortalNews(), page);
		response.addToRequest("newss", newss);
		response.addToRequest("page", page);
		return SUCCESS;
	}
	
	@Action(description = "显示所有平台公告", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/infor/notice_list.jsp")) })
	public String listNotices(Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		List<SystemNotice> notices=noticeService.findSystemNotices(new SystemNotice(), page);
		response.addToRequest("notices", notices);
		response.addToRequest("page", page);
		return SUCCESS;
	}
	

	public String getMenuId() {
		return menuId;
	}


	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}


	public String getLogon() {
		User user=request.getSessionContext().getUser();
		if(user!=null){
			logon="true";
		}else{
			logon="false";
		}
		return logon;
	}


	
	

}
