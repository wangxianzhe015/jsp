package com.smartcloud.crowdfunding.portal.model.yeepay;

public class SMSConfirmPayResponse {

	private String merchantaccount;
	
	private String orderid;
	
	private String yborderid;
	
	private Integer amount;
	
	private String errorcode;
	
	private String errormsg;

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

	public String getYborderid() {
		return yborderid;
	}

	public void setYborderid(String yborderid) {
		this.yborderid = yborderid;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getErrorcode() {
		return errorcode;
	}

	public void setErrorcode(String errorcode) {
		this.errorcode = errorcode;
	}

	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}
	
	

}
