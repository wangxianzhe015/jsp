package com.smartcloud.crowdfunding.portal.model;

/**
 * 短信发送结果
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SMSResult {
	
	private String mobileNo;

	private String returnCode;
	
	private String returnMsg;

	private String smsId;


	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}


	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getReturnMsg() {
		return returnMsg;
	}

	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}

	public String getSmsId() {
		return smsId;
	}

	public void setSmsId(String smsId) {
		this.smsId = smsId;
	}
	
	
}
