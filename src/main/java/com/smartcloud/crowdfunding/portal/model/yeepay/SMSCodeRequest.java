package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 发送短信验证码请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SMSCodeRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String orderid;

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
	
	
}
