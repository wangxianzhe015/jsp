package com.smartcloud.crowdfunding.portal.model.enums;

/**
 * 订单状态
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public enum OrderState {

	/**
	 * 待付款
	 */
	WAITING_PAY("00"),
	/**
	 * 付款成功
	 */
	PAY_SUCCESS("10"),
	/**
	 * 付款失败
	 */
	PAY_FAILURE("11"),
	/**
	 * 交易确认
	 */
	CONFIRM_SUCCESS("20"),
	/**
	 * 确认失败
	 */
	CONFIRM_FAILURE("21"),
	/**
	 * 交易完成
	 */
	DEAL_FINISH("30"),
	/**
	 * 交易取消
	 */
	DEAL_FAILURE("31");
	
	private String value;
	
	OrderState(String value){
		this.value=value;
	}
	
	public String getValue(){
		return value;
	}
}
