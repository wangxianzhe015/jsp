package com.smartcloud.crowdfunding.portal.service;

import java.util.Map;

import com.smartcloud.crowdfunding.portal.model.yeepay.BankCardCheckRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.BankCardCheckResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayClearDataRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayClearDataResponse;
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
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawResponse;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 易宝支付服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface YeePayService {


	/**
	 * 绑定银行卡
	 * @param request
	 * @return
	 */
	public BindBankCardResponse bindBankcard(BindBankCardRequest request);
	
	/**
	 * 确认绑定银行卡
	 * @param request
	 * @return
	 */
	public ConfirmBindResponse confirmBindBankcard(ConfirmBindRequest request);
	
	/**
	 * 发送短信验证码
	 * @param request
	 * @return
	 */
	public SMSCodeResponse sendSmsCode(SMSCodeRequest request);
	/**
	 * 查询银行卡绑定信息
	 * @param request
	 * @return
	 */
	public QueryBindBankCardResponse queryBindBankcard(QueryBindBankCardRequest request);

	/**
	 * 解除银行卡绑定
	 * @param request
	 * @return
	 */
	public UnBindBankCardResponse unbindBankcard(UnBindBankCardRequest request);
	
	
	/**
	 * 短信确认支付
	 * @param request
	 * @return
	 */
	public SMSConfirmPayResponse smsConfirmPay(SMSConfirmPayRequest request);
	/**
	 * 付款,需要短信验证
	 * @param request
	 * @return
	 */
	public PayOrderResponse payOrder(PayOrderRequest request);
	
	/**
	 * 付款，不需要短信验证
	 * @param request
	 * @return
	 */
	public PayOrderResponse directPay(PayOrderRequest request);
	
	
	/**
	 * 提现
	 * @param request
	 * @return
	 */
	public WithdrawResponse withdraw(WithdrawRequest request);
	
	
	/**
	 * 退款
	 * @param request
	 * @return
	 */
	public RefundResponse refund(RefundRequest request);
	
	/**
	 * 查询提现记录
	 * @param request
	 * @return
	 */
	public QueryDrawResponse queryWithdraw(QueryDrawRequest request);
	
	
	/**
	 * 查询退款记录
	 * @param request
	 * @return
	 */
	public QueryRefundResponse queryRefund(QueryRefundRequest request);
	
	
	/**
	 * 查询支付结果
	 * @param request
	 * @return
	 */
	public QueryOrderResponse queryOrder(QueryOrderRequest request);
	
	/**
	 * 查询交易记录
	 * @param request
	 * @return
	 */
	public QueryTradeRecordResponse queryTradeRecord(QueryTradeRecordRequest request);
	
	/**
	 * 检查银行卡信息
	 * @param request
	 * @return
	 */
	public BankCardCheckResponse checkBankcard(BankCardCheckRequest request);
	
	
	/**
	 * 下载清算对账单数据
	 * @param request
	 * @return
	 */
	public PayClearDataResponse downloadClearData(PayClearDataRequest request);

	/**
	 * 解密回调数据
	 * @param data
	 * @param encryptkey
	 * @return
	 */
	public Map<String, String> decryptCallbackData(String data, String encryptkey);
}
