package com.smartcloud.crowdfunding.portal.web;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.crowdfunding.portal.model.BankCard;
import com.smartcloud.crowdfunding.portal.model.MessageTips;
import com.smartcloud.crowdfunding.portal.model.OrderRecord;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.ProjectDoc;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
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
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectService;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.crowdfunding.portal.service.YeePayService;
import com.smartcloud.crowdfunding.portal.utils.Html2Pdf;
import com.smartcloud.crowdfunding.portal.utils.PayUtils;
import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.common.utils.AmountUtils;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.common.utils.FileUtils;
import com.smartcloud.platform.component.common.utils.StringUtils;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.Framework;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;


@URI(description="订单支付管理",path="/portal/order/*")
public class OrderPayManager extends WebAction{

	@Reference
	private PortalUserService userService;
	
	@Reference
	private ProjectService projectService;
	
	@Reference
	private ProjectTradeService tradeService; 
	
	@Reference
	private SystemMessageService messageService;
	
	@Reference
	private BankCardService bankcardServcie;
	
	@Reference
	private AccountInfoService accountService;
	
	@Reference
	private YeePayService payService;
	
	@Reference
	private BankCardService bankcardService;
	
	private Integer code;
	
	private String message;
	
	//用户中心菜单ID,左侧菜单导航
	private String ucmenuId;

	
	@Action(description = "重新生成订单", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/portal/user/order/order_agreement.jsp")),
			@Response(name = FAILURE,forward=@Forward(url="/portal/common/message_tips.jsp"))
			})
	public String repay(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		if(order.getOrderState()==OrderState.CONFIRM_FAILURE){
			order.setValid("0");
			tradeService.updateTradeOrder(order);
			//重新生成订单
			order.setValid("1");
			order.setOrderId(PayUtils.createRequestId(PayUtils.ORDER_TYPE_INVEST));
			order.setOrderState(OrderState.WAITING_PAY);
			tradeService.addTradeOrder(order);
		}

		PortalUser user=userService.getUserById(order.getUserId());
		if(StringUtils.isNullOrBlank(user.getRealName()) || StringUtils.isNullOrBlank(user.getIdentityCard())){
			code=-1;
			message=ResourceMessages.getI18nMessage("ProjectOrderManager_not_realname");
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/safeSetting.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			
			return FAILURE;
					
		}
		
		String htmlFile=createAgreementHtml(order, user, orderId);
		
		response.addToRequest("order", order);
		response.addToRequest("htmlFile", htmlFile);
		
		return SUCCESS;
	}
	
	private String replaceVars(TradeOrder order,PortalUser user,String html){
		if(html==null)
			return "";
		else {
			if(user.getRealName()!=null)
				html=html.replace("[投资人姓名]", user.getRealName());
			if(user.getIdentityCard()!=null)
				html=html.replace("[投资人身份证]", user.getIdentityCard());
			if(user.getMobileNo()!=null)
				html=html.replace("[投资人手机号码]",user.getMobileNo());
			if(order.getTotalAmount()!=null)
				html=html.replace("[投资金额]", order.getTotalAmount()+"");
			if(order.getIncomeRate()!=null)
				html=html.replace("[持股比例]", order.getIncomeRate()+"");
			if(order.getProject().getProjectName()!=null)
				html=html.replace("[项目名称]", order.getProject().getProjectName());
			
			String address=order.getProject().getProvinceName()+order.getProject().getCityName()+order.getProject().getAddress();
			if(address!=null)
				html=html.replace("[项目地址]", address);
			if(order.getProject().getCompanyName()!=null)
				html=html.replace("[项目方管理公司]",order.getProject().getCompanyName());
			
			return html;
		}

	}
	
	@Action(description = "进入合作协议确认", responses = { 
			@Response(name = SUCCESS,forward=@Forward(url="/portal/user/order/order_agreement.jsp")),
			@Response(name = FAILURE,forward=@Forward(url="/portal/common/message_tips.jsp"))
			})
	public String entryAgreement(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		PortalUser user=userService.getUserById(order.getUserId());
		
		if(StringUtils.isNullOrBlank(user.getRealName()) || StringUtils.isNullOrBlank(user.getIdentityCard())){
			code=-1;
			message=ResourceMessages.getI18nMessage("ProjectOrderManager_not_realname");
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/safeSetting.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			
			return FAILURE;
					
		}
		String htmlFile=createAgreementHtml(order, user, orderId);
		
		response.addToRequest("order", order);
		response.addToRequest("htmlFile", htmlFile);
		
		return SUCCESS;
	}
	
	@Action(description = "导出PDF", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/portal/user/order/export_pdf.jsp")),
			@Response(name = FAILURE, forward=@Forward(url="/portal/common/message_tips.jsp"))})
	public String exportPdf(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		PortalUser user=userService.getUserById(order.getUserId());
		
		if(StringUtils.isNullOrBlank(user.getRealName()) || StringUtils.isNullOrBlank(user.getIdentityCard())){
			code=-1;
			message=ResourceMessages.getI18nMessage("ProjectOrderManager_not_realname");
			MessageTips tips=new MessageTips();
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/safeSetting.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			
			return FAILURE;
					
		}
		
		String htmlFile=createAgreementHtml(order, user, orderId);
        String pdfFile=Framework.getInstance().getAppConfiguration().getWarRealPath()+"/downloads/"+order.getOrderId()+".pdf";
		Html2Pdf.createPdf(htmlFile, pdfFile, true);

	    response.addToRequest("path", pdfFile);
	    response.addToRequest("name", order.getProject().getProjectName()+"_合作协议.pdf");
		return SUCCESS;
	}
	
	
	/**
	 * 生成协议HTML文件
	 * @param order
	 * @param user
	 * @param orderId
	 * @return
	 */
	private String createAgreementHtml(TradeOrder order,PortalUser user,String orderId){
		
		ProjectDoc projectDoc=projectService.getProjectDoc(order.getProject().getProjectId());
		String content="";
		if(projectDoc!=null){
			String projectAgreement=projectDoc.getProjectAgreementHtml();
			content=replaceVars(order, user, projectAgreement);
		}
		if(StringUtils.isNullOrBlank(content)){
			content="<p>The agreement content is empty! </p>";
		}

		File root=new File(Framework.getInstance().getAppConfiguration().getWarRealPath()+"/downloads");
        if(!root.exists()){
        	FileUtils.mkdir(root, true);
        }
        String htmlFile=Framework.getInstance().getAppConfiguration().getWarRealPath()+"/downloads/"+order.getOrderId()+".html";
        
        String header="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"+
	        "<html xmlns=\"http://www.w3.org/1999/xhtml\">" +
	        "<head>"+
	        "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />" +
	        "</head>"+
	        //"<body style=\"font-family:SimSun;\">";
	        "<body>";
	    String footer="</body></html>";
	    String html=header+content+footer;
	    try {
			org.apache.commons.io.FileUtils.writeStringToFile(new File(htmlFile), html, "UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
	    return htmlFile;
	}


	@Action(description = "进入支付确认", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/user/order/order_confirm.jsp")) })
	public String entryPayConfirm(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		PortalUser orderUser=userService.getUserById(order.getUserId());

		response.addToRequest("order", order);
		response.addToRequest("orderUser", orderUser);
		return SUCCESS;
	}
	
	@Action(description = "进入支付确认", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/user/order/order_pay.jsp")) })
	public String entryPay(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		order.setCheckAgreement("1");
		tradeService.updateTradeOrder(order);
		
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<BankCard> bankcards=bankcardServcie.getBankCards(sessionUser.getUserId());
		PortalUser user=userService.getUserById(sessionUser.getUserId());
		
		response.addToRequest("bankcards", bankcards);
		response.addToRequest("order", order);
		response.addToRequest("user", user);
		return SUCCESS;
	}
	
	@Action(description = "列出银行卡", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String listBankcards(){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		List<BankCard> bankcards=bankcardServcie.getBankCards(sessionUser.getUserId());
		
		response.addToRequest("bankcards", bankcards);
		return SUCCESS;
	}
	
	
	@Action(description = "发送手机验证码", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String sendMobileCode(String orderId,Long cardId){
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
	
	@Action(description = "银行卡支付", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/common/message_tips.jsp"))})
	public String bankcardPay(String orderId,String mobilecode){

		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		TradeOrder order=tradeService.getTradeOrder(orderId);
		//判断重复支付,如果订单有效，并且订单状态为”支付成功“”交易确认“”交易完成“，表示已经支付过了。
		if("1".equals(order.getValid()) && 
				(order.getOrderState()==OrderState.PAY_SUCCESS || 
				order.getOrderState()==OrderState.CONFIRM_SUCCESS || 
				order.getOrderState()==OrderState.DEAL_FINISH)){
			
			MessageTips tips=new MessageTips();
			message=ResourceMessages.getI18nMessage("YeePayManager_repeat_pay");
			tips.setMessage(message);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			
			return SUCCESS;
		}
		
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
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/findSubscribeProject.action");
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
		tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/findSubscribeProject.action");
		tips.setWaitSecond(3);
		response.addToRequest("tips", tips);
		return SUCCESS;
	}
	
	@Action(description = "账户划款支付", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/common/message_tips.jsp")) })
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
			tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/findSubscribeProject.action");
			tips.setWaitSecond(3);
			response.addToRequest("tips", tips);
			return SUCCESS;
		}
		
		//更新订单状态"支付成功"
		order.setPayTime(DateUtils.getCurrentTime());
		order.setOrderState(OrderState.DEAL_FINISH);
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
		tips.setBackUrl(request.getContextPath()+"/platform/portal/uc/findSubscribeProject.action");
		tips.setWaitSecond(3);
		response.addToRequest("tips", tips);
		
		return SUCCESS;
	}
	
	public EntityTransaction getTransactionManager(){
		EntityTransaction t= Persistence.createEntityManagerFactory("default").createEntityManager().getTransaction();
		return t;
	}
	
	//获取支付回调URL
	private String getPayCallbackUrl(){
		return PropertyResourceConfigurer.getInstance().getProperty("callbackUrl");
	}

	public Integer getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
	
	
	
}
