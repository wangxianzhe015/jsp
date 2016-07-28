package com.smartcloud.crowdfunding.mobile.web;

import java.text.MessageFormat;
import java.util.List;

import javax.transaction.TransactionManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.Project;
import com.smartcloud.crowdfunding.portal.model.RefundOrder;
import com.smartcloud.crowdfunding.portal.model.SMSType;
import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.model.enums.PayType;
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundResponse;
import com.smartcloud.crowdfunding.portal.service.AccountInfoService;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.crowdfunding.portal.service.SmsService;
import com.smartcloud.crowdfunding.portal.service.SystemMessageService;
import com.smartcloud.crowdfunding.portal.service.YeePayService;
import com.smartcloud.crowdfunding.portal.utils.PayUtils;
import com.smartcloud.platform.component.common.extension.ExtensionLoader;
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
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.mvc.web.dict.DictEntry;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;
import com.smartcloud.platform.component.transaction.TransactionManagerFactory;

/**
 * 项目投资管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="项目管理",path="/mobile/projectinvest/*",portal=true)
public class ProjectOrderManager extends WebAction{
	private static Logger logger=LoggerFactory.getLogger(ProjectOrderManager.class);
	
	@Reference
	private ProjectTradeService tradeService;
	
	@Reference
	private PortalUserService userService;
	
	@Reference
	private SystemMessageService messageService;
	
	@Reference
	private YeePayService payService;
	
	@Reference
	private AccountInfoService accountService;
	
	@Reference
	private SmsService smsService;
	
	@Action(description = "进入订单列表", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/projectinvest/order_list.jsp")) })
	public String index(TradeOrder order,String projectName,Page page){
		if(page==null){
			page=new Page();
			page.setBeginPage(1);	
			page.setPageSize(10);
		}
		page.setCount(true);
		
		if(order==null){
			order=new TradeOrder();
		}
		if(StringUtils.isNullOrBlank(order.getValid())){
			order.setValid("1");
		}
		
		List<DictEntry> projectStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_STATE);
		List<DictEntry> projectTypes=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_PROJECT_TYPE);
		List<DictEntry> orderStates=DictionaryFactory.getInstance().getDictType(Constants.DICT_TYPE_ORDER_STATE);

		
		List<TradeOrder> orders=tradeService.queryAllTradeOrder(order, page);
		
		response.addToRequest("orders", orders);
		response.addToRequest("projectStates", projectStates);
		response.addToRequest("projectTypes", projectTypes);
		response.addToRequest("orderStates", orderStates);
		response.addToRequest("order", order);
		response.addToRequest("page", page);
		return SUCCESS;
	}
	
	@Action(description = "翻页", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/projectinvest/order_list.jsp")) })
	public String pageQuery(TradeOrder order,String projectName,Page page){
		return index(order,projectName,page);
	}
	
	@Action(description = "进入修改订单", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/projectinvest/order_update.jsp")) })
	public String entryUpdate(String orderId){
		TradeOrder order=tradeService.getTradeOrder(orderId);
		PortalUser orderUser=userService.getUserById(order.getUserId());
		response.addToRequest("order", order);
		response.addToRequest("orderUser", orderUser);
		return SUCCESS;
	}
	
	@Action(description = "修改订单", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/projectinvest/index.action")) })
	public String updateOrder(TradeOrder order){
		tradeService.updateTradeOrder(order);
		return SUCCESS;
	}
	
	
	@Action(description = "订单退款", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String getUserInfo(String userId){
		PortalUser user=userService.getUserById(userId);
		if(user!=null){
			StringBuilder address=new StringBuilder();
			
			if(StringUtils.isNotNullAndBlank(user.getContactCity())){
				address.append(CityDictionaryFactory.getInstance().getProvinceAndCityName(user.getContactCity()));
			}
			else if (StringUtils.isNotNullAndBlank(user.getCity())){
				address.append(CityDictionaryFactory.getInstance().getProvinceAndCityName(user.getCity()));
			}
			address.append(" 邮编:"+user.getContactZip());
			
			response.addToRequest("user", user);
			response.addToRequest("address", address.toString());
		}
		return SUCCESS;
	}
	
	/**
	 * 订单退款
	 * @param orderId
	 * @return
	 */
	@Action(description = "订单退款", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String refundOrder(String orderIds,String cause,String sms,String sys,String email){
		if(StringUtils.isNullOrBlank(orderIds))
			return SUCCESS;
		
		String[] orderIdsArray=orderIds.split(",");
		int selectedCount=orderIdsArray.length;
	
		int successCount=0;
		for(String oid:orderIdsArray){
			TradeOrder order=tradeService.getTradeOrder(oid);
			
			//通过银行卡支付的，并且是有效订单，并且当前订单状态为处理完成的情况下，进行退款操作
			if(order.getPayType()==PayType.BANKCARD && "1".equals(order.getValid()) && StringUtils.isNotNullAndBlank(order.getYbOrderId())){
				RefundRequest refundRequest=new RefundRequest();
				refundRequest.setOrigyborderid(order.getYbOrderId());
				refundRequest.setCurrency(156);
				refundRequest.setAmount(Integer.valueOf(AmountUtils.changeY2F(String.valueOf(order.getTotalAmount()))));
				
				String refundOId=PayUtils.createRequestId(PayUtils.ORDER_TYPE_REFUND);
				refundRequest.setOrderid(refundOId);
				
				RefundResponse refundResponse=payService.refund(refundRequest);
				
				RefundOrder refundOrder=new RefundOrder();
				refundOrder.setAmount(order.getTotalAmount());
				refundOrder.setCause(cause);
				refundOrder.setCreateTime(DateUtils.getCurrentTime());
				refundOrder.setErrorCode(refundResponse.getErrorcode());
				refundOrder.setErrorMsg(refundResponse.getErrormsg());
			
				refundOrder.setOrderId(refundOId);
				refundOrder.setOrigOrderId(order.getOrderId());
				refundOrder.setOrigYbOrderId(order.getYbOrderId());
				
				Project project=new Project();
				project.setProjectId(order.getProject().getProjectId());
				refundOrder.setProject(project);
				refundOrder.setRefundType("BANKCARD");

				try{
					Float remain=Float.parseFloat(AmountUtils.changeF2Y(String.valueOf(refundResponse.getRemain())));
					refundOrder.setRemain(remain);
					
					Float fee=Float.parseFloat(AmountUtils.changeF2Y(String.valueOf(refundResponse.getFee())));
					refundOrder.setFee(fee);
				}catch(Exception e){
					
				}
				refundOrder.setUserId(order.getUserId());
				refundOrder.setUserName(order.getUserName());
				refundOrder.setYbOrderId(refundResponse.getYborderid());

				tradeService.addRefundOrder(refundOrder);
				if(StringUtils.isNullOrBlank(refundResponse.getErrorcode())){
					//设置订单无效
					order.setValid("0");
					order.setRemark("系统订单退款!");
					order.setOrderState(OrderState.DEAL_FAILURE);
					order.setFinishTime(DateUtils.getCurrentTime());
					tradeService.updateTradeOrder(order);
					
					PortalUser user=userService.getUserById(order.getUserId());
					
					StringBuilder smsMessage=new StringBuilder("很抱歉的通知您，您所订购的{0}由于{1},系统已退还您的资金{2}元,到账时间以银行转账为准");
					String message=MessageFormat.format(smsMessage.toString(), new String[]{order.getProject().getProjectName(),cause,String.valueOf(order.getTotalAmount())});
					smsService.sendMessage(user.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
					sendSystemNotice(user.getUserId(),user.getUserName(),message);
					
					successCount++;
				}
				
				
			}
			else if(order.getPayType()==PayType.ACCOUNT && "1".equals(order.getValid()) && 
					(order.getOrderState()==OrderState.PAY_SUCCESS || 
					order.getOrderState()==OrderState.CONFIRM_SUCCESS ||
					order.getOrderState()==OrderState.DEAL_FINISH)){
				
				RefundOrder refundOrder=new RefundOrder();
				refundOrder.setAmount(order.getAmount());
				refundOrder.setCause(cause);
				refundOrder.setCreateTime(DateUtils.getCurrentTime());
			
				String refundOId=PayUtils.createRequestId(PayUtils.ORDER_TYPE_REFUND);
				refundOrder.setOrderId(refundOId);
				refundOrder.setOrigOrderId(order.getOrderId());
				refundOrder.setOrigYbOrderId(order.getYbOrderId());
				
				Project project=new Project();
				project.setProjectId(order.getProject().getProjectId());
				refundOrder.setProject(project);
				
				refundOrder.setRefundType("ACCOUNT");

				refundOrder.setUserId(order.getUserId());
				refundOrder.setUserName(order.getUserName());

				//更新账户可用金额
				AccountInfo accountInfo=accountService.getAccountInfo(order.getUserId());
				TransactionManager  tm=getTransactionManager();
				try{
					if(accountInfo!=null){
						accountInfo.setTotalAmount(accountInfo.getTotalAmount()+order.getTotalAmount());
						accountInfo.setAvailableAmount(accountInfo.getAvailableAmount()+order.getTotalAmount());
					}else{
						accountInfo=new AccountInfo();
						accountInfo.setUserId(order.getUserId());
						accountInfo.setTotalAmount(order.getTotalAmount());
						accountInfo.setAvailableAmount(order.getTotalAmount());
					}
					
					tm.begin();
					//添加回退记录
					tradeService.addRefundOrder(refundOrder);
					accountService.saveAccount(accountInfo);
					//设置订单无效
					order.setValid("0");
					order.setOrderState(OrderState.DEAL_FAILURE);
					order.setRemark("系统订单退款!");
					order.setFinishTime(DateUtils.getCurrentTime());
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
				
				PortalUser user=userService.getUserById(order.getUserId());
				
				StringBuilder smsMessage=new StringBuilder("很抱歉的通知您，您所订购的{0}由于{1},系统已退还{2}元到您的平台资金账户.");
				String message=MessageFormat.format(smsMessage.toString(), new String[]{order.getProject().getProjectName(),cause,String.valueOf(order.getTotalAmount())});
				smsService.sendMessage(user.getMobileNo(), message, "", SMSType.PROGRESS_SMS);
				sendSystemNotice(user.getUserId(),user.getUserName(),message);
				
				successCount++;
			}
			
		}
		response.addToRequest("selectedCount", selectedCount);
		response.addToRequest("successCount", successCount);
		return SUCCESS;
	}
	
	private void sendSystemNotice(String userId,String userName,String content){
		SystemMessage message=new SystemMessage();
		message.setTitle("众投客退订通知");
		message.setFromId("system");
		message.setFromName("系统通知");
		message.setSendTime(DateUtils.getCurrentTime());
		message.setToId(userId);
		message.setToName(userName);
		message.setMessageType("SYS");
		message.setContent(content);
			
		messageService.sendMessage(message);
	}
	@Action(description = "订单确认", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String confirmOrder(String email,String sysmsg,String sms,String orderId,String confirmResult,String remark){
		boolean successOrfailure="Y".equals(confirmResult)?true:false;
		tradeService.confirmTradeOrder(orderId, successOrfailure,remark);
		TradeOrder order=tradeService.getTradeOrder(orderId);
		PortalUser publishUser=userService.getUserById(order.getUserId());
		
		StringBuilder sb=new StringBuilder();
		sb.append("亲爱的众投客用户:您认购的项目【").append(order.getProject().getProjectName()).append("】");
		if("Y".equals(confirmResult)){
			sb.append("订单审核通过!");
		}else{
			sb.append("订单审核不通过!");
			
		}
		if(StringUtils.isNotNullAndBlank(remark)){
			sb.append(remark);
		}
		
		if("1".equals(email)){
			if(StringUtils.isNotNullAndBlank(publishUser.getEmail())){
				MailSender mailSender=new MailSenderService();
				SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
				simpleMailMessage.setSubject("众投客认购订单通知");
				simpleMailMessage.setText(sb.toString());
				simpleMailMessage.setTo(publishUser.getEmail());
				mailSender.sendMail(simpleMailMessage);
			}else{
				logger.info("用户"+publishUser.getUserName()+"未设置邮箱，无法发送!");
			}
		}
		if("1".equals(sysmsg)){
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
		
		if("1".equals(sms)){
			
		}
		return SUCCESS;
	}
	
	public TransactionManager getTransactionManager(){
		TransactionManagerFactory factory=ExtensionLoader.getExtensionLoader(TransactionManagerFactory.class).getDefaultExtension();
		return factory.getTransactionManager();
	}

}
