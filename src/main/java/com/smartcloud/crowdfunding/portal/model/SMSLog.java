package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 短信日志
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_SMS_LOG")
public class SMSLog implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="SMS_ID")
	private Long smsId;
	
	@Column(name="MOBILE_NO")
	private String mobileNo;
	
	@Column(name="SEND_TIME")
	private Timestamp sendTime;
	
	@Column(name="SEND_MSG")
	private String sendMessage;
	
	@Column(name="SMS_TYPE")
	private String smsType;
	
	@Column(name="VERIFY_CODE")
	private String verifyCode;
	
	@Column(name="RETURN_CODE")
	private String returnCode;
	
	@Column(name="RETURN_MSG")
	private String returnMsg;

	public Long getSmsId() {
		return smsId;
	}

	public void setSmsId(Long smsId) {
		this.smsId = smsId;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public String getSendMessage() {
		return sendMessage;
	}

	public void setSendMessage(String sendMessage) {
		this.sendMessage = sendMessage;
	}

	public String getSmsType() {
		return smsType;
	}

	public void setSmsType(String smsType) {
		this.smsType = smsType;
	}

	public String getVerifyCode() {
		return verifyCode;
	}

	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
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
	
	
}
