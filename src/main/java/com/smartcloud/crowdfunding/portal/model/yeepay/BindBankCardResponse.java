package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 返回的绑定结果信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class BindBankCardResponse {

	//绑卡请求号
	private String requestid;
	
	//商户编号
	private String merchantaccount;
	
	//短信验证码发送方
	private String codesender;
	
	//短信验证码
	private String smscode;

	//返回码
	private String errorcode;
	
	//返回信息
	private String errormsg;

	public String getRequestid() {
		return requestid;
	}

	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getCodesender() {
		return codesender;
	}

	public void setCodesender(String codesender) {
		this.codesender = codesender;
	}

	public String getSmscode() {
		return smscode;
	}

	public void setSmscode(String smscode) {
		this.smscode = smscode;
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
