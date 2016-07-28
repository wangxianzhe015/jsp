package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 用户登录日志
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_LOGON_LOG")
public class LogonLog implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="LOGON_ID")
	private Long logId;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="MOBILE_NO")
	private String mobileNo;
	
	@Column(name="REMOTE_IP")
	private String remoteIp;
	
	@Column(name="AREA")
	private String area;
	
	@Column(name="LOGON_TIME")
	private Timestamp logonTime;
	
	@Column(name="LOGOUT_TIME")
	private Timestamp logoutTime;

	public Long getLogId() {
		return logId;
	}

	public void setLogId(Long logId) {
		this.logId = logId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getRemoteIp() {
		return remoteIp;
	}

	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Timestamp getLogonTime() {
		return logonTime;
	}

	public void setLogonTime(Timestamp logonTime) {
		this.logonTime = logonTime;
	}

	public Timestamp getLogoutTime() {
		return logoutTime;
	}

	public void setLogoutTime(Timestamp logoutTime) {
		this.logoutTime = logoutTime;
	}
	
	
	

}
