package com.smartcloud.crowdfunding.portal.model.enums;
/**
 * 支付方式
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public enum PayType {

	/**
	 * 银行卡支付
	 */
	BANKCARD("bankcard"),
	/**
	 * 账户划款
	 */
	ACCOUNT("account");
	
	private String value;
	
	PayType(String value){
		this.value=value;
	}
	
	public String getValue(){
		return value;
	}
}
