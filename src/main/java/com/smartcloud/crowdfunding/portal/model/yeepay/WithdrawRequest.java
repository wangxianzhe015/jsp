package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 提现请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class WithdrawRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String requestid;
	
	private String identityid;
	
	private Integer identitytype;
	
	private String card_top;
	
	private String card_last;
	
	//提现金额(分)
	private int amount;
	//提现类型
	//(NATRALDAY_NORMAL( 自然日 t+1);
	//NATRALDAY_URGENT（自然日t+0）
	private String drawtype;
	
	private String userip;
	

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getRequestid() {
		return requestid;
	}

	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}

	public String getIdentityid() {
		return identityid;
	}

	public void setIdentityid(String identityid) {
		this.identityid = identityid;
	}

	public Integer getIdentitytype() {
		return identitytype;
	}

	public void setIdentitytype(Integer identitytype) {
		this.identitytype = identitytype;
	}

	public String getCard_top() {
		return card_top;
	}

	public void setCard_top(String card_top) {
		this.card_top = card_top;
	}

	public String getCard_last() {
		return card_last;
	}

	public void setCard_last(String card_last) {
		this.card_last = card_last;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getDrawtype() {
		return drawtype;
	}

	public void setDrawtype(String drawtype) {
		this.drawtype = drawtype;
	}

	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}

	
}
