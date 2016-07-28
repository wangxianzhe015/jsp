package com.smartcloud.crowdfunding.portal.model;

/**
 * 消息提示对象
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class MessageTips {

	//提示信息
	private String message;
	
	//跳转URL
	private String backUrl;
	
	//等待(秒)
	private Integer waitSecond;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getBackUrl() {
		return backUrl;
	}

	public void setBackUrl(String backUrl) {
		this.backUrl = backUrl;
	}

	public Integer getWaitSecond() {
		return waitSecond;
	}

	public void setWaitSecond(Integer waitSecond) {
		this.waitSecond = waitSecond;
	}
	
	
}
