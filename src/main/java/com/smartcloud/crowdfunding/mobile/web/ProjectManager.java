package com.smartcloud.crowdfunding.mobile.web;

import java.text.MessageFormat;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.dict.ProjectCategoryDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectBonus;
import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.crowdfunding.portal.model.ProjectCert;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.crowdfunding.portal.model.ProjectDoc;
import com.smartcloud.crowdfunding.portal.model.ProjectProgress;
import com.smartcloud.crowdfunding.portal.model.ProjectState;
import com.smartcloud.crowdfunding.portal.model.SMSType;
import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectBonusService;
import com.smartcloud.crowdfunding.portal.service.ProjectCertService;
import com.smartcloud.crowdfunding.portal.service.ProjectProgressService;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.crowdfunding.portal.service.SmsService;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.common.utils.StringUtils;
import com.smartcloud.platform.component.mail.MailSender;
import com.smartcloud.platform.component.mail.internal.SimpleMailMessage;
import com.smartcloud.platform.component.mail.support.MailSenderService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.mvc.web.dict.DictEntry;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="项目管理",path="/mobile/project/*",portal=true)
public class ProjectManager extends WebAction{

	private static Logger logger=LoggerFactory.getLogger(ProjectManager.class);
	@Reference
	private ProjectService projectService;
	
	@Reference
	private ProjectProgressService progressService;
	
	@Reference
	private PortalUserService userService;
	
	@Reference 
	private ProjectCertService certService;
	
	@Reference 
	private ProjectBonusService bonusService;
	
	@Reference
	private SmsService smsService;
	
	@Reference
	private ProjectTradeService tradeService;
	
	@Reference
	private SystemMessageService messageService;
	
	@Action(description = "进入项目列表", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/project_list.jsp")) })
	public String index(Project project){
		if (project==null)
			project=new Project();
		Page page=new Page();
		page.setCount(true);
		page.setBeginPage(1);
		page.setPageSize(10);
		List<DictEntry> projectStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		List<DictEntry> projectTypes=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_TYPE);

		
		List<Project> projects=projectService.findAllProjects(project, page);
		
		response.addToRequest("projects", projects);
		response.addToRequest("projectStates", projectStates);
		response.addToRequest("projectTypes", projectTypes);
		response.addToRequest("page", page);
		return SUCCESS;
	}
	
	@Action(description = "分页查询", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/project_list.jsp")) })
	public String pageQuery(Project project,Page page){
		List<Project> projects=projectService.findAllProjects(project, page);
		response.addToRequest("projects", projects);
		response.addToRequest("page", page);
		
		return SUCCESS;
	}
	
	@Action(description = "进入发布项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/publish_project.jsp")) })
	public String entryPublish(){
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		List<DictEntry> projectStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		List<DictEntry> projectTypes=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_TYPE);
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();
		
		response.addToRequest("projectStates", projectStates);
		response.addToRequest("projectTypes", projectTypes);
		response.addToRequest("projectCategories", projectCategories);
		
		response.addToRequest("provinces", provinces);
		return SUCCESS;
	}
	
	@Action(description = "进入修改项目", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/project/update_project.jsp")) })
	public String entryUpdate(Project project){
		project=projectService.getProject(project.getProjectId());
		List<DictEntry> projectStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		List<DictEntry> projectTypes=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_TYPE);
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();
		
		PortalUser publisher=userService.getUserById(project.getUserId());
		
		ProjectCert projectCert=certService.getProjectCert(project.getProjectId());
		ProjectDoc projectDoc=projectService.getProjectDoc(project.getProjectId());
		
		response.addToRequest("publisher", publisher);
		response.addToRequest("projectCategories", projectCategories);
		response.addToRequest("projectStates", projectStates);
		response.addToRequest("projectTypes", projectTypes);
		
		response.addToRequest("provinces", provinces);
		response.addToRequest("project", project);
		response.addToRequest("projectCert", projectCert);
		response.addToRequest("projectDoc", projectDoc);
		
		return SUCCESS;
	}
	
	@Action(description = "进入修改项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/index.action")) })
	public String update(Project project,ProjectCert projectCert,ProjectBonus bonus,ProjectDoc projectDoc){
		projectService.updateProject(project);
		projectCert.setProjectId(project.getProjectId());
		certService.saveProjectCert(projectCert);
		bonus.setProjectId(project.getProjectId());
		
		projectService.saveProjectDoc(projectDoc);
		
		bonusService.saveProjectBonus(bonus);
		
		return SUCCESS;
	}
	
	
	@Action(description = "删除项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/index.action")) })
	public String remove(Project project){
		certService.deleteProjectCert(project.getProjectId());
		bonusService.removeProjectBonus(project.getProjectId());
		projectService.removeProjectDoc(project.getProjectId());
		
		projectService.removeProject(project);
		return SUCCESS;
	}

	
	@Action(description = "发布项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/project/project_list.jsp")) })
	public String publish(Project project){
		project.setCreateTime(DateUtils.getCurrentTime());
		
		Long projectId=projectService.publishProject(project);
		
		ProjectProgress progress=new ProjectProgress();
		progress.setProjectId(projectId);
		progress.setFinishDate(DateUtils.getCurrentTime());
		progress.setProjectState(Constants.PROJECT_STATE_PUBLISHED);
		progress.setProgressNo(1);
		
		progressService.addProjectProgress(progress);
		
		return SUCCESS;
	}
	
	@Action(description = "更新项目进度", responses = { @Response(name = SUCCESS, json = @JSON) })
	public String updateProjectProgress(String sms,String email,String sysmsg,String currentState,ProjectProgress progress){
		
		Long projectId=progress.getProjectId();
		
		Project project=projectService.getProject(projectId);
		
		//修改当前进度审批信息
		ProjectProgress preProgress=progressService.getProgress(projectId, currentState);
		preProgress.setDealOpion(progress.getDealOpion());
		preProgress.setDealResult(progress.getDealResult());
		preProgress.setFinishDate(DateUtils.getCurrentTime());
		progressService.updateProjectProgress(preProgress);
		
		PortalUser publishUser=userService.getUserById(project.getUserId());
		
		//通过
		if("Y".equals(progress.getDealResult())){
			//修改项目状态
			Project updateProject=new Project();
			updateProject.setProjectId(projectId);
			updateProject.setProjectState(progress.getProjectState());
			//项目审核通过，更新项目上线时间、项目预购开始时间
			if(Constants.PROJECT_STATE_AUDITING.equals(preProgress.getProjectState())){
				//updateProject.setOnlineDate(DateUtils.getCurrentTime());
				updateProject.setPrebuyBeginDate(DateUtils.getCurrentTime());
			}
			//预热审核通过后，更新项目的融资上线时间
			if(Constants.PROJECT_STATE_PREPARED.equals(preProgress.getProjectState())){
				updateProject.setRaiseBeginDate(DateUtils.getCurrentTime());
				//updateProject.setOnlineDate(DateUtils.getCurrentTime());
			}
			//融资成功通过后，更新融资结束时间
			if(Constants.PROJECT_STATE_FINANCING.equals(preProgress.getProjectState())){
				updateProject.setRaiseEndDate(DateUtils.getCurrentTime());
			}
			
			projectService.updateProject(updateProject);

			//添加下一步进度信息
			progress.setFinishDate(DateUtils.getCurrentTime());
			progress.setProgressNo(ProjectState.getStateNo(progress.getProjectState()));
			progressService.addProjectProgress(progress);
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append("亲爱的众投客用户:您当前的项目【").append(project.getProjectName()).append("】");
		sb.append(DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PROJECT_STATE, progress.getProjectState()));
		if("Y".equals(progress.getDealResult())){
			sb.append("通过!");
		}else{
			sb.append("不通过!");
		}
		if(StringUtils.isNotNullAndBlank(progress.getDealOpion())){
			sb.append(progress.getDealOpion());
		}
		
		
		if("1".equals(email)){
			if(StringUtils.isNotNullAndBlank(publishUser.getEmail())){
				MailSender mailSender=new MailSenderService();
				SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
				simpleMailMessage.setSubject("众投客项目进展通知");
				simpleMailMessage.setText(sb.toString());
				simpleMailMessage.setTo(publishUser.getEmail());
				mailSender.sendMail(simpleMailMessage);
			}else{
				logger.info("用户"+publishUser.getUserName()+"未设置邮箱，无法发送!");
			}
		}
		if("1".equals(sysmsg)){
			SystemMessage message=new SystemMessage();
			message.setTitle("项目进展通知");
			message.setFromId("system");
			message.setFromName("系统通知");
			message.setSendTime(DateUtils.getCurrentTime());
			message.setToId(project.getUserId());
			message.setToName(project.getUserName());
			message.setMessageType("SYS");
			message.setContent(sb.toString());
			
			messageService.sendMessage(message);
		}
		
		if("1".equals(sms)){
			StringBuilder smsMessage=new StringBuilder("亲爱的众投客用户您好！您投资的项目{0},已经{1},感谢您对众投客的支持！");
			String projectName=project.getProjectName();
			StringBuilder progressDesc=new StringBuilder();
			
			String projectStateName=DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PROJECT_STATE, currentState);
			progressDesc.append(projectStateName+("Y".equals(progress.getDealResult())?"通过":"不通过"));
			String message=MessageFormat.format(smsMessage.toString(), new String[]{projectName,progressDesc.toString()});
			
			PortalUser founder=userService.getUserById(project.getUserId());
			//项目受理，项目审核，预约认购通过发短信给项目方
			if(Constants.PROJECT_STATE_ACCEPTED.equals(progress.getProjectState())||
					Constants.PROJECT_STATE_AUDITING.equals(progress.getProjectState())||
					Constants.PROJECT_STATE_PREPARED.equals(progress.getProjectState())){

				smsService.sendMessage(founder.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
			}
			
			//项目融资上线:发短信给项目方以及所有预约的投资者
			if(Constants.PROJECT_STATE_FINANCING.equals(progress.getProjectState())){
				smsService.sendMessage(founder.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
				List<TradeOrder> orders=tradeService.findTradeOrdersByProject(project.getProjectId());
				for(TradeOrder order:orders){
					if(order.getOrderState()==OrderState.WAITING_PAY){//订单状态:等待支付
						PortalUser investor=userService.getUserById(order.getUserId());
						smsService.sendMessage(investor.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
					}
				}
			}
			
			//融资成功/经营中:发送短信给项目方以及所有认购的投资者
			if(Constants.PROJECT_STATE_SUCCESSED.equals(progress.getProjectState())||
					Constants.PROJECT_STATE_OPERATING.equals(progress.getProjectState())){
				smsService.sendMessage(founder.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
				List<TradeOrder> orders=tradeService.findTradeOrdersByProject(project.getProjectId());
				for(TradeOrder order:orders){
					if(order.getOrderState()==OrderState.PAY_SUCCESS ||
							order.getOrderState()==OrderState.CONFIRM_SUCCESS ||
							order.getOrderState()==OrderState.DEAL_FINISH){//订单状态:支付成功/支付确认/交易完成
						PortalUser investor=userService.getUserById(order.getUserId());
						smsService.sendMessage(investor.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
					}
				}
			}
			
			//System.out.println(message);
		}
		return SUCCESS;
		
	}

}
