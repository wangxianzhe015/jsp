package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 查询提现记录请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryDrawRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//商户请求流水号
	//商户生成的唯一提现订单号，最长50位；商户订单号和易宝交易流水号不可同时为空，都不为空时以易宝交易流水号为准。
	private String requestid;
	
	//易宝流水号
	private String ybdrawflowid;
	

	public String getMerchantaccount() {
		merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getRequestid() {
		return requestid;
	}

	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}

	public String getYbdrawflowid() {
		return ybdrawflowid;
	}

	public void setYbdrawflowid(String ybdrawflowid) {
		this.ybdrawflowid = ybdrawflowid;
	}

	
	
	

}
