package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 查询交易记录<BR>
 * https://ok.yeepay.com/merchant/query_server/pay_single
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryTradeRecordRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//客户订单号
	private String orderid;
	
	//易宝交易流水号
	private String yborderid;

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getYborderid() {
		return yborderid;
	}

	public void setYborderid(String yborderid) {
		this.yborderid = yborderid;
	}
	
	
	
}
