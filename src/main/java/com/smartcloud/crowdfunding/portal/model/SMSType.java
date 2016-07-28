package com.smartcloud.crowdfunding.portal.model;
/**
 * 短信类型
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public enum SMSType {

	/**
	 * 注册短信
	 */
	REGISTRY("REG"),
	/**
	 * 进度通知短信
	 */
	PROGRESS_SMS("PROGRESS"),
	/**
	 * 密码重置短信
	 */
	RESET_PASSWORD("RESETPWD");
	
	private String type;
	
	SMSType(String type){
		this.type=type;
	}
	
	public String getValue(){
		return type;
	}
	
	public String toString(){
		return type;
	}
}
