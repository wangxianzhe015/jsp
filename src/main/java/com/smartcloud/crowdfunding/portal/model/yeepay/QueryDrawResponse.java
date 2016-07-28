package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 查询提现记录应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryDrawResponse {

	private String merchantaccount;
	
	private String requestid;
	
	private String ybdrawflowid;
	
	private Integer amount;
	
	private String card_top;
	
	private String card_last;
	
	//DOING：处理中
	//FAILURE：提现失败
	//REFUND：提现退回
	//SUCCESS：提现成功
	//UNKNOW：未知
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

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
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
