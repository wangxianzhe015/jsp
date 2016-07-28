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
@URI(description="用户中心管理",path="/mobile/help/*")
public class HelpCenterManager extends WebAction{

	@Action(description = "帮助中心首页", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/index.jsp")) })
	public String index(){
		return SUCCESS;
	}
	
	@Action(description = "注册及认证", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/regist.jsp")) })
	public String regist(){
		return SUCCESS;
	}
	
	@Action(description = "充值指引", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/charge.jsp")) })
	public String charge(){
		return SUCCESS;
	}
	
	@Action(description = "我要投资", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/invest.jsp")) })
	public String invest(){
		return SUCCESS;
	}
	
	@Action(description = "疑难解答", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/qa.jsp")) })
	public String qa(){
		return SUCCESS;
	}
	
	@Action(description = "新手指南", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/guide.jsp")) })
	public String guide(){
		return SUCCESS;
	}
	
	@Action(description = "联系我们", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/help/contactus.jsp")) })
	public String contactus(){
		return SUCCESS;
	}
	
}
