package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 短信确认支付
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SMSConfirmPayRequest {
	
	//商户账户
	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//客户订单号
	private String orderid;
	//短信验证码,测试环境下不会真实发送短信验证码，默认为“123456”
	private String validatecode;
	
	public String getMerchantaccount() {
		return merchantaccount;
	}
	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public String getValidatecode() {
		return validatecode;
	}
	public void setValidatecode(String validatecode) {
		this.validatecode = validatecode;
	}
	
	
}
