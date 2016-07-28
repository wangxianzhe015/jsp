package com.smartcloud.crowdfunding.mobile.web;

import java.text.DecimalFormat;
import java.util.List;

import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.dict.ProjectCategoryDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.crowdfunding.portal.model.BankCard;
import com.smartcloud.crowdfunding.portal.model.LogonLog;
import com.smartcloud.crowdfunding.portal.model.MessageTips;
import com.smartcloud.crowdfunding.portal.model.OrderRecord;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.crowdfunding.portal.model.ProjectCert;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.crowdfunding.portal.model.ProjectExistingProfile;
import com.smartcloud.crowdfunding.portal.model.ProjectPlan;
import com.smartcloud.crowdfunding.portal.model.ProjectProgress;
import com.smartcloud.crowdfunding.portal.model.ProjectQuit;
import com.smartcloud.crowdfunding.portal.model.RechargeRecord;
import com.smartcloud.crowdfunding.portal.model.RefundOrder;
import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.WithdrawRecord;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.model.enums.PayType;
import com.smartcloud.crowdfunding.portal.model.enums.SubscribeType;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayResponse;
import com.smartcloud.crowdfunding.portal.service.AccountInfoService;
import com.smartcloud.crowdfunding.portal.service.BankCardService;
import com.smartcloud.crowdfunding.portal.service.LogService;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectCertService;
import com.smartcloud.crowdfunding.portal.service.ProjectExistingService;
import com.smartcloud.crowdfunding.portal.service.ProjectPlanService;
import com.smartcloud.crowdfunding.portal.service.ProjectProgressService;
import com.smartcloud.crowdfunding.portal.service.ProjectQuitService;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.crowdfunding.portal.service.YeePayService;
import com.smartcloud.crowdfunding.portal.utils.PayUtils;
import com.smartcloud.crowdfunding.portal.utils.SMSSender;
import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.common.utils.AmountUtils;
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

/**
 * 用户中心管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="用户中心管理",path="/mobile/uc/*")
public class UserCenterManager extends WebAction{

	@Reference
	private PortalUserService userService;
	
	@Reference
	private ProjectService projectService;
	
	@Reference
	private ProjectTradeService tradeService; 
	
	@Reference
	private ProjectProgressService progressService;
	
	@Reference
	private SystemMessageService messageService;
	
	@Reference
	private LogService logService;
	
	@Reference
	private ProjectCertService certService;
	
	@Reference
	private ProjectPlanService planService;
	
	@Reference
	private ProjectExistingService existingService;
	
	@Reference
	private ProjectQuitService quitService;
	

	
	@Reference
	private BankCardService bankcardServcie;
	
	@Reference
	private AccountInfoService accountService;
	
	@Reference
	private YeePayService payService;
	
	@Reference
	private BankCardService bankcardService;
	
	
	private PortalUser user;
	
	private Integer code;
	
	private String message;
	
	private String status;
	
	//用户中心菜单ID,左侧菜单导航
	private String ucmenuId;
	
	@Action(description = "用户中心首页", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/index.jsp")) })
	public String index(){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<SystemMessage> messages=messageService.findReceiveMessages(sessionUser.getUserId(), 5);
		LogonLog logonLog=logService.getLastestLogon(sessionUser.getUserId());
		response.addToRequest("messages", messages);
		response.addToRequest("logonLog", logonLog);
		
		ucmenuId=Constants.UC_MENU_USER_INDEX;
		return SUCCESS;
	}
	
	@Action(description = "我的账户-安全设置", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/safe_setting.jsp")) })
	public String safeSetting(){
		
		ucmenuId=Constants.UC_MENU_SAFE_SETTING;
		return SUCCESS;
	}
	

	@Action(description = "发布项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/publish_project.jsp")) })
	public String publishProject(){
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();

		response.addToRequest("projectCategories", projectCategories);
		response.addToRequest("provinces", provinces);
		ucmenuId=Constants.UC_MENU_PUBLISH_PROJECT;
		return SUCCESS;
	}
	
	@Action(description = "提交项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/common/message_tips.jsp")) })
	public String submitProject(Project project){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		
		if(project.getProjectId()==null){
		
			project.setProjectState(Constants.PROJECT_STATE_PUBLISHED);
			project.setUserId(sessionUser.getUserId());
			project.setUserName(sessionUser.getUserName());
			project.setCreateTime(DateUtils.getCurrentTime());
			
			Long projectId=projectService.publishProject(project);
			
			ProjectProgress progress=new ProjectProgress();
			progress.setProjectId(projectId);
			progress.setFinishDate(DateUtils.getCurrentTime());
			progress.setProjectState(Constants.PROJECT_STATE_PUBLISHED);
			progress.setDealResult("Y");
			//progress.set("等待审核...");
			progress.setProgressNo(1);
			
			progressService.addProjectProgress(progress);
		}else{
			projectService.updateProject(project);
		}
		
		MessageTips tips=new MessageTips();
		tips.setMessage("项目提交成功,等待审核...");
		tips.setWaitSecond(3);
		tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findMyProject.action");
		
		response.addToRequest("tips", tips);
		
		return SUCCESS;
	}
	

	@Action(description = "发送邮件", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxSendEmail(String email){
		MailSender mailSender=new MailSenderService();
		SimpleMailMessage message=new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("众投客邮箱注册验证码");
		String emailCode=SMSSender.smsRandom(6);
		message.setText("尊敬的众投客用户您好!您的验证码是:"+emailCode+"，工作人员不会向您索取，请勿泄漏。如非本人操作，请忽略本消息欢迎您邮箱注册");
		mailSender.sendMail(message);
		this.request.getSessionContext().add("_email", email);
		this.request.getSessionContext().add("_emailcode", emailCode);
		this.code=1;
		this.message=ResourceMessages.getI18nMessage("UserCenterManager_email_sendsuccess");
		return SUCCESS;
	}
	
	@Action(description = "邮件确认", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxEmailConfirm(String email,String code){
		if(StringUtils.equal((String)this.request.getSessionContext().get("_email"),email)&&
				StringUtils.equal((String)this.request.getSessionContext().get("_emailcode"),code)){
			PortalUser sessionUser=getUser();
			int result=userService.updateEmail(sessionUser.getUserId(), email, "1");
			if(result>0){
				user.setEmailAuth("1");
				
				this.code=1;
				this.message=ResourceMessages.getI18nMessage("UserCenterManager_email_verfiysuccess");
				this.request.getSessionContext().remove("_email");
				this.request.getSessionContext().remove("_emailcode");
			}else{
				this.code=-1;
				this.message=ResourceMessages.getI18nMessage("UserCenterManager_email_updatefail");
			}
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("UserCenterManager_email_verifyfail");
		}
		return SUCCESS;
	}
	
	@Action(description = "实名认证", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxSaveRealName(String realName,String identityCode){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		int result=userService.updateRealName(sessionUser.getUserId(), realName, identityCode);
		if(result>0){
			this.code=1;
			this.message=ResourceMessages.getI18nMessage("UserCenterManager_realname_verfiysuccess");
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("UserCenterManager_realname_updatefail");
		}
		return SUCCESS;
	}
	
	
	@Action(description = "密码重置", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxResetPassword(String newPassword){
		PortalUser sessionUser=getUser();
		int result=userService.updatePassword(sessionUser.getUserId(), newPassword);
		if(result>0){
			code=1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_password_reset_success");
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_password_reset_fail");
		}
		return SUCCESS;
	}
	
	
	@Action(description = "发送短信", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxSendSms(){
		return SUCCESS;
	}

	
	@Action(description = "手机确认", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxMobileConfirm(){
		return SUCCESS;
	}

	@Action(description = "个人设置", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/personal_setting.jsp")) })
	public String personalSetting(){
		ucmenuId=Constants.UC_MENU_PERSONAL_SETTING;
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		response.addToRequest("provinces", provinces);
		return SUCCESS;
	}
	
	
	@Action(description = "保存用户名", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxUsernameSave(String username){
		
		PortalUser user=getUser();
		if("1".equals(user.getNameChanged())){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_username_changed");
		}else{
			userService.updateUsername(user.getUserId(),username);
			code=1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_username_reset_success");
		}
		return SUCCESS;
	}
	
	@Action(description = "保存个人设置", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/common/message_tips.jsp")) })
	public String savePersonalSetting(PortalUser user){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		user.setUserId(sessionUser.getUserId());
		
		userService.updateUser(user);
		MessageTips tips=new MessageTips();
		tips.setMessage(ResourceMessages.getI18nMessage("UserCenterManager_personalsetting_success"));
		tips.setWaitSecond(3);
		tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/personalSetting.action");
		
		response.addToRequest("tips", tips);
		
		return SUCCESS;
	}
	
	@Action(description = "充值记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/record/recharge.jsp")) })
	public String rechargeRecord(String beginDate,String endDate,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<RechargeRecord> rechargeRecords=tradeService.queryRechargeRecord(sessionUser.getUserId(), beginDate, endDate, page);
		this.ucmenuId=Constants.UC_MENU_FINANCE_DEAL;
		response.addToRequest("rechargeRecords", rechargeRecords);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		return SUCCESS;
	}
	
	@Action(description = "退款记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/record/refund.jsp")) })
	public String refundRecord(String beginDate,String endDate,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<RefundOrder> rechargeRecords=tradeService.queryRefundOrders(sessionUser.getUserId(), page);
		this.ucmenuId=Constants.UC_MENU_FINANCE_DEAL;
		response.addToRequest("refundRecords", rechargeRecords);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		return SUCCESS;
	}
	
	@Action(description = "提现记录", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/user/record/withdraw.jsp")) })
	public String withdrawRecord(String beginDate,String endDate,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<WithdrawRecord> drawRecords=tradeService.queryWithdrawRecord(sessionUser.getUserId(), beginDate, endDate, page);
		
		this.ucmenuId=Constants.UC_MENU_FINANCE_DEAL;
		response.addToRequest("withdrawRecords", drawRecords);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		return SUCCESS;
	}
	
	@Action(description = "账户信息", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/account_info.jsp")) })
	public String accountInfo(){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		Float totalRechargeAmount=tradeService.statTotalRechargeAmount(sessionUser.getUserId());
		Float totalDrawAmount=tradeService.statTotalWithdrawAmount(sessionUser.getUserId());
		Float totalInvestAmount=tradeService.statTotalInvestAmount(sessionUser.getUserId());
		
		List<DictEntry> banks=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_BANK_LIST);
		List<BankCard> bankcards=bankcardServcie.getBankCards(sessionUser.getUserId());
		
		this.ucmenuId=Constants.UC_MENU_FINANCE_ACCOUNT;

		response.addToRequest("totalRechargeAmount", totalRechargeAmount);
		response.addToRequest("totalDrawAmount", totalDrawAmount);
		response.addToRequest("totalInvestAmount", totalInvestAmount);
		response.addToRequest("bankcards", bankcards);
		response.addToRequest("banks", banks);
		return SUCCESS;
	}
	
	
	
	@Action(description = "查询关注的项目", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/user/project/focus_list.jsp")) })
	public String findFocusProject(String projectState,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(4);
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<Project> focusProjects=projectService.findFocusProjects(sessionUser.getUserId(), projectState, page);
		
		this.ucmenuId=Constants.UC_MENU_FOCUS_RPOJECTS;
		
		response.addToRequest("projectState", projectState);
		response.addToRequest("projects", focusProjects);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		List<DictEntry> definitionStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		response.addToRequest("definitionStates", definitionStates);
		return SUCCESS;
	}
	
	@Action(description = "查询我发布的项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/project/myproject_list.jsp")) })
	public String findMyProject(String projectState,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(4);
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<Project> projects=projectService.findPublishProjects(sessionUser.getUserId(), projectState, page);
		
		this.ucmenuId=Constants.UC_MENU_MY_RPOJECTS;
		
		response.addToRequest("projectState", projectState);
		response.addToRequest("projects", projects);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		List<DictEntry> definitionStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		response.addToRequest("definitionStates", definitionStates);
		return SUCCESS;
	}


	@Action(description = "查询我认购的项目", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/project/subscribe_list2.jsp")) })
	public String findSubscribeProject(String projectState,String flag,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(8);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		//获取当前用户的所有投资记录
		OrderState[] orderStates=new OrderState[0];
		if("0".equals(flag)){//等待支付
			orderStates=new OrderState[1];
			orderStates[0]=OrderState.WAITING_PAY;
		}else if("1".equals(flag)){
			orderStates=new OrderState[3];
			orderStates[0]=OrderState.PAY_SUCCESS;
			orderStates[1]=OrderState.CONFIRM_SUCCESS;
			orderStates[2]=OrderState.DEAL_FINISH;
		}
		
		List<TradeOrder> orders=tradeService.queryTradeOrder(sessionUser.getUserId(), orderStates, page);
		List<DictEntry> payStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PAY_STATE);
		
		this.ucmenuId=Constants.UC_MENU_SUBSCRIBE_RPOJECTS;
		
		response.addToRequest("projectState", projectState);
		response.addToRequest("orders", orders);
		response.addToRequest("payStates", payStates);
		response.addToRequest("flag", flag);
		response.addToRequest("page", page);
		response.addToRequest("pageAction", request.getRequestMappingURI()+".action");
		
		List<DictEntry> definitionStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		response.addToRequest("definitionStates", definitionStates);
		
		return SUCCESS;
	}

	
	@Action(description = "关注项目", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String attention(Integer op, Long projectId){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		if(sessionUser!=null){
			if(op==0){
				//取消关注
				projectService.removeFocusProject(sessionUser.getUserId(), projectId);
				projectService.updateFocusCount(projectId, -1);
				
				code=1;
				message="已取关注";
			}else{
				//关注项目
				projectService.addFocusProject(sessionUser.getUserId(), projectId);
				projectService.updateFocusCount(projectId, 1);
				code=1;
				message="已关注";
			}
		}else{
			code=-1;
			message="请先登录!";
		}

		return SUCCESS;
	}
	

	@Action(description = "接收消息列表", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/message/receive_list.jsp")) })
	public String receiveMessages(Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<SystemMessage> messages=messageService.findReceiveMessages(sessionUser.getUserId(), page);
		response.addToRequest("messages", messages);
		response.addToRequest("page", page);
		ucmenuId=Constants.UC_MENU_MESSAGE_LIST;
		return SUCCESS;
	}
	
	@Action(description = "发送消息列表", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/message/send_list.jsp")) })
	public String sendMessages(Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);
		}
		page.setCount(true);
		page.setPageSize(10);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<SystemMessage> messages=messageService.findSendMessages(sessionUser.getUserId(), page);
		response.addToRequest("messages", messages);
		response.addToRequest("page", page);
		ucmenuId=Constants.UC_MENU_MESSAGE_LIST;
		return SUCCESS;
	}
	
	@Action(description = "发布项目(基本信息)", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/user/publish/first.jsp")),
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String publishFirst(Project project){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		if(StringUtils.isNullOrBlank(project.getContactPhone())){
			project.setContactPhone(sessionUser.getMobileNo());
		}
		
		if(project!=null && project.getProjectId()!=null){
			Long projectId=project.getProjectId();
			project=projectService.getProject(projectId);
			response.addToRequest("project", project);
		}

		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();

		response.addToRequest("projectCategories", projectCategories);
		response.addToRequest("provinces", provinces);
		ucmenuId=Constants.UC_MENU_PUBLISH_PROJECT;
		return SUCCESS;
	}
	
	@Action(description = "发布项目(股权设置)", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/mobile/user/publish/second.jsp")), 
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String publishSecond(Project project){
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		if(project!=null){
			project.setUserId(sessionUser.getUserId());
			project.setUserName(sessionUser.getUserName());
			project.setFocusCount(0);
			project.setCreateTime(DateUtils.getCurrentTime());
			
			projectService.publishProject(project);

		}
		
		if(project!=null && project.getProjectId()!=null ){
			Long projectId=project.getProjectId();
			project=projectService.getProject(projectId);
		}
		
		response.addToRequest("project", project);
		ucmenuId=Constants.UC_MENU_PUBLISH_PROJECT;
		return SUCCESS;
	}
	
	@Action(description = "发布项目(项目编辑)", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/user/publish/third.jsp")), 
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String publishThird(Project project){
		
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		if(project!=null ){
			projectService.publishProject(project);
		}
		
		Long projectId=project.getProjectId();
		project=projectService.getProject(projectId);
		
		ProjectCert projectCert=certService.getProjectCert(projectId);
		ProjectPlan projectPlan=planService.getProjectPlan(projectId);
		ProjectExistingProfile existingProfile=existingService.getExistingProfile(projectId);
		ProjectQuit projectQuit=quitService.getProjectQuitSolution(projectId);
		
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		List<ProjectCategory> projectCategories=ProjectCategoryDictionaryFactory.getInstance().getProjectCategories();

		response.addToRequest("projectCategories", projectCategories);
		response.addToRequest("provinces", provinces);
		
		response.addToRequest("projectQuit", projectQuit);
		response.addToRequest("existingProfile", existingProfile);
		response.addToRequest("projectPlan", projectPlan);
		response.addToRequest("projectCert", projectCert);
		response.addToRequest("project", project);
		ucmenuId=Constants.UC_MENU_PUBLISH_PROJECT;
		return SUCCESS;
	}
	
	@Action(description = "保存项目图片", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String saveImage(Long projectId,String imagePath,String imageName){
		
		String key=imageName.substring("img_".length());
		Project project=new Project();
		project.setProjectId(projectId);
		if("background".equals(key)){
			project.setBackgroundImage(imagePath);
			projectService.updateProject(project);
		}else if("cover".equals(key)){
			project.setProjectImage(imagePath);
			projectService.updateProject(project);
		}
		code=1;
		
		return SUCCESS;
	}
	
	@Action(description = "保存编辑项目数据", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String saveData(Project project,
			ProjectCert projectCert,
			ProjectExistingProfile existingProfile,
			ProjectPlan projectPlan,
			ProjectQuit projectQuit){
		
		if(projectCert!=null){
			if(projectCert.getProjectId()==null)
				projectCert.setProjectId(project.getProjectId());
			certService.saveProjectCert(projectCert);
		}
		
		if(projectPlan!=null){
			if(projectPlan.getProjectId()==null)
				projectPlan.setProjectId(project.getProjectId());
			
			planService.saveProjectPlan(projectPlan);
		}
		
		if(existingProfile!=null){
			if(existingProfile.getProjectId()==null)
				existingProfile.setProjectId(project.getProjectId());
			
			existingService.saveExistingProfile(existingProfile);
		}
		
		if(projectQuit!=null){
			if(projectQuit.getProjectId()==null)
				projectQuit.setProjectId(project.getProjectId());
			quitService.saveProjectQuitSolution(projectQuit);
		}
		
		projectService.updateProject(project);
		code=1;
		
		return SUCCESS;
	}
	
	
	@Action(description = "发布项目(确认合作协议)", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/user/publish/fourth.jsp")) ,
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String publishFourth(Project project){
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		Long projectId=project.getProjectId();
		project=projectService.getProject(projectId);
		response.addToRequest("project", project);
		return SUCCESS;
	}
	
	@Action(description = "发布项目(平台审核)", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/common/message_tips.jsp")), 
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String publishFifth(Project project){
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		if(project!=null){
			//更改项目状态为“发布”
			project.setProjectState(Constants.PROJECT_STATE_PUBLISHED);
			projectService.updateProject(project);
			
			//project=projectService.getProject(project.getProjectId());
			
			//默认初始发布进度
			ProjectProgress progress=new ProjectProgress();
			progress.setProjectId(project.getProjectId());
			progress.setFinishDate(DateUtils.getCurrentTime());
			progress.setProjectState(Constants.PROJECT_STATE_PUBLISHED);
			progress.setDealResult("Y");
			//progress.set("等待审核...");
			progress.setProgressNo(1);
			
			progressService.addProjectProgress(progress);
			
			tips=new MessageTips();
			tips.setMessage("项目【"+project.getProjectName()+"】已提交成功，等待审核...");
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findMyProject.action");
			tips.setWaitSecond(2);
			
			response.addToRequest("tips", tips);
		}else{
			tips=new MessageTips();
			tips.setMessage("未正确填写项目信息，请重新发布");
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/publishFirst.action");
			tips.setWaitSecond(2);
			
			response.addToRequest("tips", tips);
		}
		
		return SUCCESS;
	}
	
	@Action(description = "发布项目(平台审核)", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/mobile/common/message_tips.jsp")) ,
			@Response(name=FAILURE,forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String removeProject(Project project){
		MessageTips tips=this.checkProjectAccessPermission(project!=null?project.getProjectId():null);
		if(tips!=null){
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		certService.deleteProjectCert(project.getProjectId());
		planService.deleteProjectPlan(project.getProjectId());
		existingService.deleteExistingProfile(project.getProjectId());
		quitService.deleteProjectQuitSolution(project.getProjectId());
		progressService.deleteProjectProgress(project.getProjectId());
		
		projectService.removeProject(project);
		
		tips=new MessageTips();
		tips.setMessage("项目已成功删除!");
		tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findMyProject.action");
		tips.setWaitSecond(2);
		
		response.addToRequest("tips", tips);
		
		return SUCCESS;
	}
	
	@Action(description = "保存项目介绍", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String saveProjectIntroduce(Project project){
		projectService.updateProject(project);
		code=1;
		
		return SUCCESS;
	}
	
	@Action(description = "私信交谈", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String talk(Long projectId,String content){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		if(sessionUser==null){
			code=-2;
			message=ResourceMessages.getI18nMessage("UserCenterManager_user_nologin");
		}else{
			Project project=projectService.getProject(projectId);
			if(project!=null){
				PortalUser founder=userService.getUserById(project.getUserId());
				
				SystemMessage sysMessage=new SystemMessage();
				sysMessage.setMessageType(SystemMessage.MSG_TYPE_TALK);
				sysMessage.setContent(content);
				sysMessage.setFromId(sessionUser.getUserId());
				sysMessage.setSendTime(DateUtils.getCurrentTime());
				sysMessage.setTitle("来自"+sessionUser.getUserName()+"的消息");
				sysMessage.setToId(founder.getUserId());
				sysMessage.setToName(founder.getUserName());
				
				messageService.sendMessage(sysMessage);
				
				code=1;
				message=ResourceMessages.getI18nMessage("UserCenterManager_messsage_send_success");
				
			}else{
				code=-1;
				message=ResourceMessages.getI18nMessage("UserCenterManager_messsage_send_fail");
			}
		}
		
		return SUCCESS;
	}
	
	@Action(description = "预约认购(预热项目)", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String prebuy(Long projectId,Integer prebuyNum){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		//判断是否重复认购
		boolean existOrder=tradeService.existTradeOrder(sessionUser.getUserId(), projectId);
		if(existOrder){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_repeat_subscribe");
			return SUCCESS;
		}
		
		Project project=projectService.getProject(projectId);
		if(project!=null){
			//判断预约的总份数(包括已支付的)大于设定得份数
//			boolean b=project.getSubscribedTotalCopies()+prebuyNum>project.getSubscribeCount();
//			if(b){
//				code=-1;
//				message=ResourceMessages.getI18nMessage("UserCenterManager_more_then_subscribe_copies");
//				return SUCCESS;
//			}
			
			TradeOrder order=new TradeOrder();
			order.setProject(project);
			order.setNums(prebuyNum);
			order.setCreateTime(DateUtils.getCurrentTime());
			order.setOrderId(PayUtils.createRequestId(PayUtils.ORDER_TYPE_INVEST));
			order.setSubscribeType(SubscribeType.PREBUY);
			order.setUserId(sessionUser.getUserId());
			order.setUserName(sessionUser.getUserName());
			order.setValid("1");

			Float totalAmount=project.getMinInvestAmount()*prebuyNum;
			order.setAmount(project.getMinInvestAmount());
			order.setTotalAmount(totalAmount);
			order.setOrderState(OrderState.WAITING_PAY);
			order.setRemark(SubscribeType.PREBUY.getValue());
			
			float incomeRate=totalAmount*project.getInvestorIncomeRate()/project.getInvestorAmount();
			DecimalFormat format=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
			String p=format.format(incomeRate);
			order.setIncomeRate(Float.parseFloat(p));
			
			OrderRecord record=new OrderRecord();
			record.setOperDesc("生成预购订单");
			record.setOperTime(DateUtils.getCurrentTime());
			record.setOrderId(order.getOrderId());
			record.setUserId(sessionUser.getUserId());
			
			tradeService.addOrderRecord(record);
			tradeService.addTradeOrder(order);
			
			code=1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_subscribe_success");
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_subscribe_fail");
		}
		
		return SUCCESS;
	}
	
	@Action(description = "认购", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/main/buyinfo.jsp")),
			 @Response(name = FAILURE, forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String buy(Long projectId){
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		//判断是否重复认购,如果当前项目已经被购买了，则不能重复认购
		boolean existOrder=tradeService.existTradeOrder(sessionUser.getUserId(), projectId);
		if(existOrder){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_exist_unpay_order");
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			return FAILURE;
			
		}
		
		Project project=projectService.getProject(projectId);
		response.addToRequest("project", project);
		return SUCCESS;
	}
	
	
	/**
	 * 检测项目认购的份数是否超出了预设的份数。
	 * @param project
	 * @param nums
	 * @return
	 */
	@Action(description = "检测项目认购的份数是否超出了预设的份数", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String checkBuyNum(Long projectId,Integer nums){
		Project project=projectService.getProject(projectId);
		boolean b=project.getSubscribedTotalCopies()+nums>project.getSubscribeCount();
		if(b){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_more_then_subscribe_copies");
		}else{
			code=1;
		}
		return SUCCESS;
	}
	
	@Action(description = "提交订单", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/platform/mobile/uc/findSubscribeProject.action")),
			@Response(name = FAILURE, forward=@Forward(url="/mobile/common/message_tips.jsp")) })
	public String submitOrder(Long projectId,Float amounts,Integer nums){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		
		//判断用户是否重复投资
		Boolean exist=tradeService.existTradeOrder(sessionUser.getUserId(), projectId);
		if(exist){
			MessageTips tips=new MessageTips();
			tips.setMessage(ResourceMessages.getI18nMessage("UserCenterManager_exist_unpay_order"));
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			
			response.addToRequest("tips", tips);
			return FAILURE;
			
		}

		Project project=projectService.getProject(projectId);
		//判断订单份数是否超出总份数
		boolean b=project.getSubscribedTotalCopies()+nums>project.getSubscribeCount();
		if(b){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_more_then_subscribe_copies");
			
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/buy.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			return FAILURE;
		}
		
		//生成订单投资记录
		TradeOrder order=new TradeOrder();
		order.setCreateTime(DateUtils.getCurrentTime());
		order.setProject(project);

		float incomeRate=amounts*project.getInvestorIncomeRate()/project.getInvestorAmount();
		DecimalFormat format=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String p=format.format(incomeRate);
		order.setIncomeRate(Float.parseFloat(p));
		
		order.setAmount(project.getMinInvestAmount());
		order.setTotalAmount(amounts);
		order.setNums(nums);
		order.setUserId(sessionUser.getUserId());
		order.setUserName(sessionUser.getUserName());
		order.setOrderId(PayUtils.createRequestId(PayUtils.ORDER_TYPE_INVEST));
		order.setSubscribeType(SubscribeType.BUY);
		order.setOrderState(OrderState.WAITING_PAY);
		order.setValid("1");

		tradeService.addTradeOrder(order);
		OrderRecord record=new OrderRecord();
		record.setOperDesc("提交订单");
		record.setOperTime(DateUtils.getCurrentTime());
		record.setOrderId(order.getOrderId());
		record.setUserId(sessionUser.getUserId());
		tradeService.addOrderRecord(record);
		
		return SUCCESS;
	}
	
	@Action(description = "进入合作协议确认", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/user/project/cooperation_agreement.jsp"))})
	public String entryAgreement(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		response.addToRequest("order", order);
		
		return SUCCESS;
	}
	
	@Action(description = "进入支付", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/user/project/order_pay.jsp")) })
	public String entryPay(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		order.setCheckAgreement("1");
		tradeService.updateTradeOrder(order);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<BankCard> bankcards=bankcardServcie.getBankCards(sessionUser.getUserId());
		response.addToRequest("bankcards", bankcards);
		response.addToRequest("order", order);
		return SUCCESS;
	}
	
	@Action(description = "在线支付", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String onlinePay(String orderId,Long cardId){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		//判断用户是否绑定银行卡
		List<BankCard> bankcards=bankcardService.getBankCards(sessionUser.getUserId());
		if(bankcards==null || bankcards.size()==0){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_pls_bind_bankcard");
			return SUCCESS;
		}
	
		BankCard bankcard=bankcardService.getBankCard(cardId);
		TradeOrder order=tradeService.getTradeOrder(orderId);
		
		PayOrderRequest payRequest=new PayOrderRequest();
		payRequest.setAmount(Integer.valueOf(AmountUtils.changeY2F(order.getTotalAmount().toString())));
		payRequest.setCard_last(bankcard.getCardLast());
		payRequest.setCard_top(bankcard.getCardTop());
		payRequest.setIdentityid(bankcard.getIdentityid());
		payRequest.setIdentitytype(5);
		
		payRequest.setOrderid(orderId);
		payRequest.setTranstime((int)(System.currentTimeMillis()/1000));
		payRequest.setUserip(this.request.getRemoteAddress());
		payRequest.setCallbackurl(getPayCallbackUrl());
		payRequest.setProductname("[众投客]认购"+order.getProject().getProjectName());
		
		
		PayOrderResponse payOrderResponse=payService.payOrder(payRequest);
		if(payOrderResponse!=null){
			//输出交易订单ID
			response.addToRequest("orderid", payOrderResponse.getOrderid());
		
			if(StringUtils.isNotNullAndBlank(payOrderResponse.getErrorcode())){
				code=-1;
				message=payOrderResponse.getErrormsg();
				return SUCCESS;
				
			}
			//发送短信验证码
			SMSCodeRequest smsRequest=new SMSCodeRequest();
			smsRequest.setOrderid(payOrderResponse.getOrderid());
			SMSCodeResponse smsResponse=payService.sendSmsCode(smsRequest);
			if(smsResponse==null || StringUtils.isNotNullAndBlank(smsResponse.getErrorcode())){
				code=-1;
				message=ResourceMessages.getI18nMessage("YeePayManager_smscode_send_fail");
				if(smsResponse!=null)
					message=message+"("+smsResponse.getErrormsg()+")";
			}
			else{
				code=1;
				message=ResourceMessages.getI18nMessage("YeePayManager_smscode_send_success");
			}
			
			
		}
		return SUCCESS;
	}
	
	@Action(description = "确认支付", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/common/message_tips.jsp"))})
	public String confirmPay(String orderId,String mobilecode){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		TradeOrder order=tradeService.getTradeOrder(orderId);
		
		SMSConfirmPayRequest smsPayRequest=new SMSConfirmPayRequest();
		smsPayRequest.setOrderid(order.getOrderId());
		smsPayRequest.setValidatecode(mobilecode);

		//订单操作记录
		OrderRecord record=new OrderRecord();
		record.setOrderId(orderId);
		record.setOperTime(DateUtils.getCurrentTime());
		record.setUserId(sessionUser.getUserId());
		
		SMSConfirmPayResponse smsPayResponse=payService.smsConfirmPay(smsPayRequest);
		if(smsPayResponse==null || StringUtils.isNotNullAndBlank(smsPayResponse.getErrorcode())){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_pay_fail");
			if(smsPayResponse!=null){
				message=message+"("+smsPayResponse.getErrormsg()+")";
				order.setErrorCode(smsPayResponse.getErrorcode());
				order.setErrorMsg(smsPayResponse.getErrormsg());
			}

			record.setOperDesc("银行卡在线支付失败!");
			order.setPayTime(DateUtils.getCurrentTime());
			order.setOrderState(OrderState.PAY_FAILURE);
			
			EntityTransaction  tm=getTransactionManager();
			try{
				tm.begin();
				tradeService.addOrderRecord(record);
				tradeService.updateTradeOrder(order);
				tm.commit();
			}catch(Exception e){
				e.printStackTrace();
				try {
					tm.rollback();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			return SUCCESS;
		}
		
		//更新订单状态"支付成功"

		order.setOrderId(order.getOrderId());
		order.setYbOrderId(smsPayResponse.getYborderid());
		order.setPayTime(DateUtils.getCurrentTime());
		order.setOrderState(OrderState.PAY_SUCCESS);
		order.setPayType(PayType.BANKCARD);
		order.setSubscribeType(SubscribeType.BUY);
		
		record.setOperDesc("银行卡在线支付成功!");
		
		EntityTransaction  tm=getTransactionManager();
		try{
			tm.begin();
			tradeService.updateTradeOrder(order);
			tradeService.addOrderRecord(record);
			tm.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}

		code=1;
		message=ResourceMessages.getI18nMessage("UserCenterManager_pay_success");
		MessageTips tips=new MessageTips();
		tips.setMessage(message);
		tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
		tips.setWaitSecond(3);
		response.addToRequest("tips", tips);
		return SUCCESS;
	}
	
	@Action(description = "账户划款支付", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/mobile/common/message_tips.jsp")) })
	public String accountPay(String orderId,String verifycode){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		TradeOrder order=tradeService.getTradeOrder(orderId);
		Float totalAmount=order.getTotalAmount();
		
		AccountInfo accountInfo=accountService.getAccountInfo(sessionUser.getUserId());
		//判断余额是否足够
		if(accountInfo==null || totalAmount>accountInfo.getAvailableAmount()){
			code=-1;
			message=ResourceMessages.getI18nMessage("UserCenterManager_account_balance_noenough");
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			return SUCCESS;
		}
		
		//更新订单状态"支付成功"
		order.setPayTime(DateUtils.getCurrentTime());
		order.setOrderState(OrderState.PAY_SUCCESS);
		order.setPayType(PayType.ACCOUNT);
		order.setSubscribeType(SubscribeType.BUY);
		
		OrderRecord record=new OrderRecord();
		record.setOrderId(orderId);
		record.setOperTime(DateUtils.getCurrentTime());
		record.setOperDesc("账户划款成功");
		record.setUserId(sessionUser.getUserId());

		accountInfo.setAvailableAmount(accountInfo.getAvailableAmount()-totalAmount);
		accountInfo.setTotalAmount(accountInfo.getTotalAmount()-totalAmount);
		accountInfo.setUserId(sessionUser.getUserId());
		
		EntityTransaction  tm=getTransactionManager();
		try{
			tm.begin();
			//更新账户余额
			accountService.saveAccount(accountInfo);
			tradeService.updateTradeOrder(order);
			tradeService.addOrderRecord(record);
			tm.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}
		
		code=1;
		message=ResourceMessages.getI18nMessage("UserCenterManager_pay_success");
		MessageTips tips=new MessageTips();
		tips.setMessage(message);
		tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findSubscribeProject.action");
		tips.setWaitSecond(3);
		response.addToRequest("tips", tips);
		
		return SUCCESS;
	}
	
	public EntityTransaction getTransactionManager(){
		EntityTransaction t= Persistence.createEntityManagerFactory("default").createEntityManager().getTransaction();
		return t;
	}
	
	public PortalUser getUser() {
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		if(sessionUser!=null)
			user=userService.getUserById(sessionUser.getUserId());
		
		return user;
	}
	

	public Integer getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}

	public String getUcmenuId() {
		return ucmenuId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	//获取支付回调URL
	private String getPayCallbackUrl(){
		return PropertyResourceConfigurer.getInstance().getProperty("callbackUrl");
	}
	/**
	 * 检查项目访问权限，防止直接通过浏览器地址直接访问项目
	 * @param userId
	 * @param projectId
	 * @return
	 */
	private MessageTips checkProjectAccessPermission(Long projectId){
		if(projectId==null)
			return null;
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		int result=projectService.checkProjectAccessPermission(sessionUser.getUserId(), projectId);
		if(result>0){
			return null;
		}else{
			MessageTips tips=new MessageTips();
			if(result==0){
				tips.setMessage("项目已被受理,访问拒绝!");
				tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findMyProject.action");
				tips.setWaitSecond(2);
			}else{
				tips.setMessage("非法访问!");
				tips.setBackUrl(request.getContextPath()+"/platform/mobile/uc/findMyProject.action");
				tips.setWaitSecond(2);
			}
			return tips;
		}
	}
	
	@Action(description = "邮箱验证", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/safesetting/auth_email.jsp")) })
	public String verifyEmail(Page page){
		return SUCCESS;
	}

	@Action(description = "实名认证", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/safesetting/auth_realname.jsp")) })
	public String verifyRealName(Page page){
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		response.addToRequest("provinces", provinces);
		return SUCCESS;
	}

	@Action(description = "登录密码", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/safesetting/auth_password.jsp")) })
	public String updatePassword(Page page){
		return SUCCESS;
	}

	@Action(description = "项目分红", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/account/divide_end.jsp")) })
	public String logde(Page page){
		return SUCCESS;
	}

	@Action(description = "支付记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/account/log_pay.jsp")) })
	public String logPay(Page page){
		return SUCCESS;
	}

	@Action(description = "支付记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/charge.jsp")) })
	public String charge(Page page){
		return SUCCESS;
	}

	@Action(description = "支付记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/withdraw.jsp")) })
	public String withdraw(Page page){
		return SUCCESS;
	}

	@Action(description = "支付记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/user/verifycard.jsp")) })
	public String verifyCard(Page page){
		return SUCCESS;
	}

}
