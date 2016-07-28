package com.smartcloud.crowdfunding.portal.model.enums;

/**
 * 认购方式
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public enum SubscribeType {
	/**
	 * 预购
	 */
	PREBUY("prebuy"),
	/**
	 * 认购
	 */
	BUY("buy");
	
	private String value;
	
	SubscribeType(String value){
		this.value=value;
	}
	
	public String getValue(){
		return value;
	}

}
