package com.smartcloud.crowdfunding.console.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "GAS_APPLICATION")
public class Application implements java.io.Serializable {


	public static final String GET_APP_BY_MODULE="GET_APP_BY_MODULE";
	
	public static final String GET_APP_BY_PERMISSION="GET_APP_BY_PERMISSION";
	
	public static final String QUERY_APP_BY_FUNC = "QUERY_APP_BY_FUNC";

	@Id
	@Column(name = "APP_ID")
	private Long appId;

	@Column(name = "APP_NAME")
	private String appName;

	@Column(name = "APP_DESC")
	private String appDesc;

	@Column(name = "WEB_CONTEXT")
	private String appContext;

	@Column(name = "PROTOCOL")
	private String protocol;

	@Column(name = "IP")
	private String appIp;

	@Column(name = "PORT")
	private String appPort;

	public Long getAppId() {
		return appId;
	}

	public void setAppId(Long appId) {
		this.appId = appId;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAppDesc() {
		return appDesc;
	}

	public void setAppDesc(String appMemo) {
		this.appDesc = appMemo;
	}

	public String getAppContext() {
		return appContext;
	}

	public void setAppContext(String appContext) {
		this.appContext = appContext;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public String getAppIp() {
		return appIp;
	}

	public void setAppIp(String appIp) {
		this.appIp = appIp;
	}

	public String getAppPort() {
		return appPort;
	}

	public void setAppPort(String appPort) {
		this.appPort = appPort;
	}

}
