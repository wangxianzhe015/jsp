package com.smartcloud.crowdfunding.portal.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PayUtils {


	/**
	 * 绑定银行卡订单类型
	 */
	public static final String ORDER_TYPE_BINDCARD="ZTKBINDBANKCARD";
	/**
	 * 充值订单类型
	 */
	public static final String ORDER_TYPE_RECHARGE="ZTKRECHARGE";
	/**
	 * 提现订单类型
	 */
	public static final String ORDER_TYPE_WITHDRAW="ZTKWITHDRAW";
	/**
	 * 下单订单类型
	 */
	public static final String ORDER_TYPE_INVEST="ZTKORDER";
	/**
	 * 退款订单类型
	 */
	public static final String ORDER_TYPE_REFUND="ZTKREFUND";
	
	
	public static String createRequestId(String flag){
		SimpleDateFormat dateFormat= new SimpleDateFormat("yyMMddHHmmssSSS");
		String requestid= flag + dateFormat.format(new Date());
		return requestid;
	}

}
