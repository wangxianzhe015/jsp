package com.smartcloud.crowdfunding.mobile.web;

import java.util.List;
import java.util.Map;

import javax.transaction.TransactionManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.crowdfunding.portal.model.BankCard;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.RechargeRecord;
import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.WithdrawRecord;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.CardBindInfo;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryBindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryBindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryDrawRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryDrawResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryOrderRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryOrderResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryRefundRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryRefundResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryTradeRecordRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryTradeRecordResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawResponse;
import com.smartcloud.crowdfunding.portal.service.AccountInfoService;
import com.smartcloud.crowdfunding.portal.service.BankCardService;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.crowdfunding.portal.service.YeePayService;
import com.smartcloud.crowdfunding.portal.utils.PayUtils;
import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;
import com.smartcloud.platform.component.common.extension.ExtensionLoader;
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
import com.smartcloud.platform.component.mvc.annotation.response.Alert;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.annotation.response.Text;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;
import com.smartcloud.platform.component.transaction.TransactionManagerFactory;

@URI(description="易宝支付管理",path="/mobile/pay/*")
public class YeePayManager extends WebAction{
	
	private static Logger logger=LoggerFactory.getLogger(YeePayManager.class);
	
	@Reference
	private YeePayService payService;
	
	@Reference
	private PortalUserService userService;

	@Reference
	private BankCardService bankcardService;
	
	@Reference
	private AccountInfoService accountService;
	
	@Reference
	private ProjectTradeService tradeService;
	
	@Reference
	private SystemMessageService messageService;
	
	private Integer code;
	
	private String message;
	

	
	
	private String getCallbackUrl(){
		return PropertyResourceConfigurer.getInstance().getProperty("callbackUrl");
	}
	



	@Action(description = "绑定银行卡", responses = { @Response(name = SUCCESS, json = @JSON) })
	public String bindBankcard(BankCard card){
		
		BindBankCardRequest bbcRequest=new BindBankCardRequest();
	
		String requestid=PayUtils.createRequestId(PayUtils.ORDER_TYPE_BINDCARD);
		bbcRequest.setUserip(request.getRemoteAddress());
		bbcRequest.setCardno(card.getCardNo());
		bbcRequest.setIdcardno(card.getIdentityid());
		bbcRequest.setIdcardtype("01");

		//身份证号识别
		bbcRequest.setIdentityid(card.getIdentityid());
		bbcRequest.setIdentitytype(5);
		
		bbcRequest.setPhone(card.getPhone());
		bbcRequest.setRequestid(requestid);
		bbcRequest.setUsername(card.getUserName());

		BindBankCardResponse bbcResponse=payService.bindBankcard(bbcRequest);
		if(bbcResponse!=null){
			if(StringUtils.isNullOrBlank(bbcResponse.getErrorcode())){
				code=1;
				message=ResourceMessages.getI18nMessage("YeePayManager_bindbank_smscode_send_scucess");
				
				response.addToRequest("requestid", bbcResponse.getRequestid());
			}else{
				code=-1;
				message=bbcResponse.getErrormsg()+"("+bbcResponse.getErrorcode()+")";
			}
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_bindbank_smscode_send_fail");
		}
		return SUCCESS;
	}

	@Action(description = "确认绑定银行卡", responses = { @Response(name = SUCCESS, json = @JSON) })
	public String confirmBindBankcard(String userName,String identityid,String cardNo,String requestid,String verifycode){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		
		ConfirmBindRequest cbRequest=new ConfirmBindRequest();
		cbRequest.setRequestid(requestid);
		cbRequest.setValidatecode(verifycode);
		
		ConfirmBindResponse cbResponse=payService.confirmBindBankcard(cbRequest);
		if(cbResponse!=null){
			if(StringUtils.isNullOrBlank(cbResponse.getErrorcode())){
				
				BankCard bankcard=new BankCard();
				bankcard.setCardTop(cbResponse.getCardtop());
				bankcard.setCardLast(cbResponse.getCardlast());
				bankcard.setBankCode(cbResponse.getBankcode());
				bankcard.setUserId(sessionUser.getUserId());
				bankcard.setIdentityid(identityid);
				bankcard.setUserName(userName);
				bankcard.setCardNo(cardNo);
				
				bankcardService.addBankCard(bankcard);
				code=1;
				message=ResourceMessages.getI18nMessage("YeePayManager_bindbank_success");
			}else{
				code=-1;
				message=ResourceMessages.getI18nMessage("YeePayManager_bindbank_fail")+"("+cbResponse.getErrormsg()+")";
			}
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_bindbank_fail");
		}
		
		return SUCCESS;
		
	}
	
	@Action(description = "解除银行卡绑定", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String unbindBankcard(Long cardId,String identityid){
		
		BankCard bankCard=bankcardService.getBankCard(cardId);
		QueryBindBankCardRequest qbbcRequest=new QueryBindBankCardRequest();
		qbbcRequest.setIdentityid(identityid);
		qbbcRequest.setIdentitytype(5);
		
		QueryBindBankCardResponse qbbcResponse=payService.queryBindBankcard(qbbcRequest);
		if(qbbcResponse==null || StringUtils.isNotNullAndBlank(qbbcResponse.getErrorcode())){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_fail");
			return SUCCESS;
		}
	
		CardBindInfo theBind=null;
		for(CardBindInfo cb:qbbcResponse.getCardinfos()){
			if(cb.getBankcode().equals(bankCard.getBankCode()) &&
					cb.getCard_top().equals(bankCard.getCardTop()) &&
					cb.getCard_last().equals(bankCard.getCardLast())){
				theBind=cb;
			}
		}
		
		if(theBind==null){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_not_found_bindcard");
			return SUCCESS;
		}
		
		UnBindBankCardRequest ubbcRequest=new UnBindBankCardRequest();
		ubbcRequest.setBindid(theBind.getBindid());
		ubbcRequest.setIdentityid(identityid);
		ubbcRequest.setIdentitytype(5);
	
		UnBindBankCardResponse result=payService.unbindBankcard(ubbcRequest);
		if(StringUtils.isNullOrBlank(result.getErrorcode())){
			bankcardService.removeBankCard(cardId);
			code=1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_success");
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_fail");
			if(result!=null)
				message=message+"("+result.getErrormsg()+")";
		}
		
		return SUCCESS;
	}
	
	@Action(description = "充值", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String recharge(Float amount,Long cardId){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		
		List<BankCard> bankcards=bankcardService.getBankCards(sessionUser.getUserId());
		if(bankcards==null || bankcards.size()==0){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_pls_bind_bankcard");
			return SUCCESS;
		}
		
		BankCard bankcard=bankcardService.getBankCard(cardId);
		
		String orderid=PayUtils.createRequestId(PayUtils.ORDER_TYPE_RECHARGE);
		PayOrderRequest poRequest=new PayOrderRequest();
		poRequest.setAmount(Integer.valueOf(AmountUtils.changeY2F(amount.toString())));
		poRequest.setCard_last(bankcard.getCardLast());
		poRequest.setCard_top(bankcard.getCardTop());
		poRequest.setIdentityid(bankcard.getIdentityid());
		poRequest.setIdentitytype(5);
		
		poRequest.setOrderid(orderid);
		poRequest.setTranstime((int)(System.currentTimeMillis()/1000));
		poRequest.setUserip(this.request.getRemoteAddress());
		poRequest.setCallbackurl(getCallbackUrl());
		poRequest.setProductname("充值");
		
		
		PayOrderResponse payOrderResponse=payService.payOrder(poRequest);
		if(payOrderResponse!=null){
			//输出交易订单ID
			response.addToRequest("orderid", payOrderResponse.getOrderid());
		
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
	
	@Action(description = "确认充值", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String confirmRecharge(Float amount,String orderid,String verifycode){
		SMSConfirmPayRequest smsPayRequest=new SMSConfirmPayRequest();
		smsPayRequest.setOrderid(orderid);
		smsPayRequest.setValidatecode(verifycode);
		
		SMSConfirmPayResponse smsPayResponse=payService.smsConfirmPay(smsPayRequest);
		if(smsPayResponse==null || StringUtils.isNotNullAndBlank(smsPayResponse.getErrorcode())){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_recharge_fail");
			if(smsPayResponse!=null)
				message=message+"("+smsPayResponse.getErrormsg()+")";
			return SUCCESS;
		}
		
		//保存交易记录
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		RechargeRecord record=new RechargeRecord();
		record.setAmount(amount);
		record.setOrderId(orderid);
		record.setRechargeTime(DateUtils.getCurrentTime());
		record.setPayState(Constants.PAY_STATE_CONFIRM);
		record.setUserId(sessionUser.getUserId());
		record.setUserName(sessionUser.getRealName());
		record.setYbOrderId(smsPayResponse.getYborderid());
		//默认设置交易未完成，只有收到回调信息后才修改为完成.
		record.setDealState(Constants.DEAL_STATE_CONFIRM);
	
		TransactionManager tm=getTransactionManager();
		try{
			tm.begin();
			tradeService.addRechargeRecord(record);
			code=1;
			message=ResourceMessages.getI18nMessage("YeePayManager_transaction_processing");
			tm.commit();
		}catch(Exception e){
			e.printStackTrace();
			try {
				tm.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_recharge_fail");
		}
		
		return SUCCESS;
	}
	
	@Action(description = "提现", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String withdraw(Float amount,Long cardId){
		PortalUser sessionUser=(PortalUser)this.request.getSessionContext().getUser();
		AccountInfo accountInfo=accountService.getAccountInfo(sessionUser.getUserId());
		//判断可用金额是否足够提现
		if(accountInfo==null||amount>accountInfo.getAvailableAmount()){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_withdraw_account_balance_noenough");
			return SUCCESS;
		}
	
		BankCard bankcard=bankcardService.getBankCard(cardId);
		String requestid=PayUtils.createRequestId(PayUtils.ORDER_TYPE_WITHDRAW);
		WithdrawRequest withdrawRequest=new WithdrawRequest();
		withdrawRequest.setAmount(Integer.valueOf(AmountUtils.changeY2F(amount.toString())));
		withdrawRequest.setCard_last(bankcard.getCardLast());
		withdrawRequest.setCard_top(bankcard.getCardTop());
		withdrawRequest.setIdentityid(bankcard.getIdentityid());
		withdrawRequest.setIdentitytype(5);
		withdrawRequest.setRequestid(requestid);
		withdrawRequest.setDrawtype("NATRALDAY_URGENT");//即时到账
		withdrawRequest.setUserip(request.getRemoteAddress());
		
		WithdrawResponse withdrawResponse= payService.withdraw(withdrawRequest);
		
		WithdrawRecord record=new WithdrawRecord();
		record.setAmount(amount);
		record.setDrawTime(DateUtils.getCurrentTime());
		record.setOrderId(requestid);
		record.setYbOrderId(withdrawResponse.getYbdrawflowid());
		record.setPayState("SUCCESS".equals(withdrawResponse.getStatus())?"Y":"N");
		record.setPayTime(DateUtils.getCurrentTime());
		record.setUserId(sessionUser.getUserId());
		record.setUserName(sessionUser.getRealName());
		
		if(StringUtils.isNotNullAndBlank(withdrawResponse.getErrorcode())){
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_withdraw_fail")+","+withdrawResponse.getErrormsg();
			
			record.setErrorCode(withdrawResponse.getErrorcode());
			record.setErrorMsg(withdrawResponse.getErrormsg());
			tradeService.addWithdrawRecord(record);
			
			return SUCCESS;
		}else{

			TransactionManager  tm=getTransactionManager();
			try{
				tm.begin();
				
				record.setDealState(Constants.DEAL_STATE_FINISH);
				tradeService.addWithdrawRecord(record);
				accountInfo.setAvailableAmount(accountInfo.getAvailableAmount()-amount);
				accountInfo.setTotalAmount(accountInfo.getTotalAmount()-amount);
				accountService.saveAccount(accountInfo);
				
				code=1;
				message=ResourceMessages.getI18nMessage("YeePayManager_withdraw_success");
				tm.commit();
			}catch(Exception e){
				try {
					tm.rollback();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				code=-1;
				message=ResourceMessages.getI18nMessage("YeePayManager_withdraw_fail");
			}
		}
		
	
		
		return SUCCESS;
	}
	
	@Action(description = "确认提现", responses = { @Response(name = SUCCESS, json =@JSON) })
	public String confirmWithdraw(String orderid,String smscode){
		SMSConfirmPayRequest req=new SMSConfirmPayRequest();
		req.setOrderid(orderid);
		req.setValidatecode(smscode);
		SMSConfirmPayResponse res=payService.smsConfirmPay(req);
		
		return SUCCESS;
	}
	
	@Action(description = "查询交易记录", responses = { @Response(name = SUCCESS, json = @JSON) })
	public String queryTradeRecord(String orderid){
		QueryTradeRecordRequest qt=new QueryTradeRecordRequest();
		qt.setOrderid(orderid);
		
		QueryTradeRecordResponse result=payService.queryTradeRecord(qt);
		response.addToRequest("tradeRecord", result);
		return SUCCESS;
	}
	
	@Action(description = "支付回调函数", responses = { @Response(name = SUCCESS, text=@Text(contentType="text/html;charset=UTF-8")) })
	public String callback(String data,String encryptkey){
		Map<String,String> result=payService.decryptCallbackData(data, encryptkey);
		String errorcode=result.get("errorcode");
		String errormsg=result.get("errormsg");
		String orderid=result.get("orderid");
		String status=result.get("status");
		String amount=result.get("amount");
		
		String remark=StringUtils.isNotNullAndBlank(errorcode)?(errormsg+","+errorcode):"";
		
		if(orderid.startsWith(PayUtils.ORDER_TYPE_RECHARGE)){
			RechargeRecord rechargeRecord=tradeService.getRechargeRecord(orderid);
			if(rechargeRecord!=null){
				tradeService.updateRechargeStatus(orderid, "0".equals(status)?"N":"Y", DateUtils.getCurrentTime(), errorcode, errormsg);
				if("1".equals(status)){//成功
					//更新账户可用金额
					AccountInfo accountInfo=accountService.getAccountInfo(rechargeRecord.getUserId());
					TransactionManager  tm=getTransactionManager();
					try{
						Float yuanAmount=Float.parseFloat(AmountUtils.changeF2Y(amount));
						if(accountInfo!=null){
							accountInfo.setTotalAmount(accountInfo.getTotalAmount()+yuanAmount);
							accountInfo.setAvailableAmount(accountInfo.getAvailableAmount()+yuanAmount);
						}else{
							accountInfo=new AccountInfo();
							accountInfo.setUserId(rechargeRecord.getUserId());
							accountInfo.setTotalAmount(yuanAmount);
							accountInfo.setAvailableAmount(yuanAmount);
						}
						
						tm.begin();
						accountService.saveAccount(accountInfo);
						tm.commit();
					}catch(Exception e){
						e.printStackTrace();
						try {
							tm.rollback();
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					}
					
				}
			}
			

			
		}else if(orderid.startsWith(PayUtils.ORDER_TYPE_WITHDRAW)){
			tradeService.updateWithdrawStatus(orderid, "0".equals(status)?"N":"Y", DateUtils.getCurrentTime(), errorcode, errormsg);
			
		}
		else if(orderid.startsWith(PayUtils.ORDER_TYPE_INVEST)){
			boolean successOrfailure="1".equals(status)?true:false;
			tradeService.confirmTradeOrder(orderid, successOrfailure,remark);
			TradeOrder order=tradeService.getTradeOrder(orderid);
			PortalUser publishUser=userService.getUserById(order.getUserId());
			
			StringBuilder sb=new StringBuilder();
			sb.append("亲爱的众投客用户:您认购的项目【").append(order.getProject().getProjectName()).append("】");
			if(successOrfailure){
				sb.append("订单审核通过!");
			}else{
				sb.append("订单审核不通过!");
			}
			
			if(StringUtils.isNotNullAndBlank(remark)){
				sb.append(remark);
			}
			
			
			if(StringUtils.isNotNullAndBlank(publishUser.getEmail())){
				MailSender mailSender=new MailSenderService();
				SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
				simpleMailMessage.setSubject("众投客认购订单通知");
				simpleMailMessage.setText(sb.toString());
				simpleMailMessage.setTo(publishUser.getEmail());
				mailSender.sendMail(simpleMailMessage);
			}else{
				logger.warn("用户"+publishUser.getUserName()+"未设置邮箱，无法发送!");
			}
			
			
				SystemMessage message=new SystemMessage();
				message.setTitle("众投客认购订单通知");
				message.setFromId("system");
				message.setFromName("系统通知");
				message.setSendTime(DateUtils.getCurrentTime());
				message.setToId(order.getUserId());
				message.setToName(order.getUserName());
				message.setMessageType("SYS");
				message.setContent(sb.toString());
				
				messageService.sendMessage(message);
					
		}
		response.addToRequest("SUCCESS", "SUCCESS");
		
		return SUCCESS;
	}

	@Action(description = "查询银行卡绑定信息", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/yeepay/query_card.jsp")) })
	public String queryBindCard(String identityid ){
		if(StringUtils.isNullOrBlank(identityid)){
			return SUCCESS;
		}
		QueryBindBankCardRequest queryRequest=new QueryBindBankCardRequest();
		queryRequest.setIdentityid(identityid);
		queryRequest.setIdentitytype(5);
		
		QueryBindBankCardResponse queryResponse=payService.queryBindBankcard(queryRequest);
		response.addToRequest("result", queryResponse);
		return SUCCESS;
	}
	
	@Action(description = "查询订单信息", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/yeepay/query_order.jsp")) })
	public String queryOrder(String orderid){
		if(StringUtils.isNullOrBlank(orderid)){
			return SUCCESS;
		}
		QueryOrderRequest  orderRequest=new QueryOrderRequest();
		orderRequest.setOrderid(orderid);
		
		QueryOrderResponse orderResponse=payService.queryOrder(orderRequest);
		response.addToRequest("result", orderResponse);
		return SUCCESS;
	}
	
	@Action(description = "查询订单信息", responses = { @Response(name = SUCCESS, json = @JSON) })
	public String queryOrderAjax(String orderid){
		if(StringUtils.isNullOrBlank(orderid)){
			return SUCCESS;
		}
		QueryOrderRequest  orderRequest=new QueryOrderRequest();
		orderRequest.setOrderid(orderid);
		
		QueryOrderResponse orderResponse=payService.queryOrder(orderRequest);
		response.addToRequest("order", orderResponse);
		return SUCCESS;
	}
	
	
	@Action(description = "查询交易记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/yeepay/query_trade.jsp")) })
	public String queryTrade(String orderid){
		if(StringUtils.isNullOrBlank(orderid)){
			return SUCCESS;
		}
		QueryTradeRecordRequest queryRequest=new QueryTradeRecordRequest();
		queryRequest.setOrderid(orderid);
		
		QueryTradeRecordResponse result=payService.queryTradeRecord(queryRequest);
		response.addToRequest("result", result);
		return SUCCESS;
	}
	
	@Action(description = "查询提现记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/yeepay/query_withdraw.jsp")) })
	public String queryWithdraw(String orderid){
		if(StringUtils.isNullOrBlank(orderid)){
			return SUCCESS;
		}
		QueryDrawRequest drawRequest=new QueryDrawRequest();
		drawRequest.setRequestid(orderid);
		QueryDrawResponse drawResponse=payService.queryWithdraw(drawRequest);
		response.addToRequest("result", drawResponse);
		return SUCCESS;
	}
	
	@Action(description = "查询退款记录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/yeepay/query_refund.jsp")) })
	public String queryRefund(String orderid){
		if(StringUtils.isNullOrBlank(orderid)){
			return SUCCESS;
		}
		
		QueryRefundRequest refundRequest=new QueryRefundRequest();
		refundRequest.setOrderid(orderid);
		QueryRefundResponse refundResponse=payService.queryRefund(refundRequest);
		response.addToRequest("result", refundResponse);
		return SUCCESS;
	}
	
	
	
	@Action(description = "查询交易记录", responses = { @Response(name = SUCCESS, alert=@Alert(message="$message", url="/mobile/yeepay/query_card.jsp")) })
	public String unbind(String bindid){
		String bid=bindid.split("_")[0];
		String identityid=bindid.split("_")[1];
		
		UnBindBankCardRequest ubbcRequest=new UnBindBankCardRequest();
		ubbcRequest.setBindid(bid);
		ubbcRequest.setIdentityid(identityid);
		ubbcRequest.setIdentitytype(5);
	
		UnBindBankCardResponse result=payService.unbindBankcard(ubbcRequest);
		if(StringUtils.isNullOrBlank(result.getErrorcode())){
			code=1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_success");
		}else{
			code=-1;
			message=ResourceMessages.getI18nMessage("YeePayManager_unbind_fail");
			if(result!=null)
				message=message+"("+result.getErrormsg()+")";
		}
		
		return SUCCESS;
	}
	
	public Integer getCode() {
		return code;
	}


	public String getMessage() {
		return message;
	}
	
	public TransactionManager getTransactionManager(){
		TransactionManagerFactory factory=ExtensionLoader.getExtensionLoader(TransactionManagerFactory.class).getDefaultExtension();
		return factory.getTransactionManager();
	}
}
