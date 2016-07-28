package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 获取消费清算对账单记录
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class PayClearDataRequest {
	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//获取消费清算对账记录开始时间，格式如：2014-03-07
	private String startdate;
	//获取消费清算对账记录结束时间，格式如：2014-03-07
	private String enddate;


	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	
	
}
