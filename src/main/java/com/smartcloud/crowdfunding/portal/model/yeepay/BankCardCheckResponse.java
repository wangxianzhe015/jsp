package com.smartcloud.crowdfunding.portal.model.yeepay;

public class BankCardCheckResponse {

	private String merchantaccount;
	
	private String cardno;
	
	//1：储蓄卡
	//2：信用卡
	//-1 未知银行卡
	private String cardtype;
	
	private String bankname;
	
	//0：无效卡号
	//1：有效的银行卡
	private int isvalid;

	private String errorcode;
	
	private String errormsg;
	
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

	public String getCardtype() {
		return cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

	public String getBankname() {
		return bankname;
	}

	public void setBankname(String bankname) {
		this.bankname = bankname;
	}

	public int getIsvalid() {
		return isvalid;
	}

	public void setIsvalid(int isvalid) {
		this.isvalid = isvalid;
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
