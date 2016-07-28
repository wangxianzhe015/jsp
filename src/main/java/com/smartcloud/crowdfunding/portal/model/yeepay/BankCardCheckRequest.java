package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 银行卡有效性检查请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class BankCardCheckRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String cardno;
	

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}
	

}
