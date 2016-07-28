package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 退款请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class RefundRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//退款金额
	private Integer amount;
	
	//货币类型(默认人民币156)
	private Integer currency;
	
	//退款说明
	private String cause;
	
	
	
	//客户退货订单号
	private String orderid;
	//原易宝交易流水号
	private String origyborderid;
	

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

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

	public String getOrigyborderid() {
		return origyborderid;
	}

	public void setOrigyborderid(String origyborderid) {
		this.origyborderid = origyborderid;
	}

	
	

}
