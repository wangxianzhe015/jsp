package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 提现应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class WithdrawResponse {

	private String merchantaccount;
	
	private String requestid;
	
	private String ybdrawflowid;
	
	private int amount;
	
	private String card_top;
	
	private String card_last;
	
	//提现请求状态
	//FAILURE：请求失败
	//SUCCESS：请求成功
	//UNKNOW:未知
	private String status;
	
	private String errorcode;
	
	private String errormsg;

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

	public String getYbdrawflowid() {
		return ybdrawflowid;
	}

	public void setYbdrawflowid(String ybdrawflowid) {
		this.ybdrawflowid = ybdrawflowid;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getErrorcode() {
		return errorcode;
	}

	public void setErrorcode(String errorcode) {
		this.errorcode = errorcode;
	}

	public String getErrormsg() {
		return errormsg;
	}

	public void setErrormsg(String errormsg) {
		this.errormsg = errormsg;
	}
	
	

}
