package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 支付应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class PayOrderResponse {

	private String merchantaccount;
	
	private String orderid;
	
	private String phone;
	
	private String smsconfirm;
	
	private String codesender;
	
	private String sign;
	
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSmsconfirm() {
		return smsconfirm;
	}

	public void setSmsconfirm(String smsconfirm) {
		this.smsconfirm = smsconfirm;
	}

	public String getCodesender() {
		return codesender;
	}

	public void setCodesender(String codesender) {
		this.codesender = codesender;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
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
