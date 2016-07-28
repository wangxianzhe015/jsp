package com.smartcloud.crowdfunding.portal.model.yeepay;

public class CardBindInfo {
	
	private String merchantaccount;
	//绑卡ID
	private String bindid;
	
	private String card_top;
	//卡号后4位
	private String card_last;
	
	//卡名称
	private String cardname;
	
	//绑卡有效期
	private String bindvalidthru;
	
	private String phone;
	
	private String bankcode;

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getBindid() {
		return bindid;
	}

	public void setBindid(String bindid) {
		this.bindid = bindid;
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

	public String getCardname() {
		return cardname;
	}

	public void setCardname(String cardname) {
		this.cardname = cardname;
	}

	public String getBindvalidthru() {
		return bindvalidthru;
	}

	public void setBindvalidthru(String bindvalidthru) {
		this.bindvalidthru = bindvalidthru;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBankcode() {
		return bankcode;
	}

	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}

	

}
