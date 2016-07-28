package com.smartcloud.crowdfunding.portal.model.yeepay;

import java.util.List;

/**
 * 银行卡绑定查询应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryBindBankCardResponse {

	private String merchantaccount;
	
	//用户标识
	private String identityid;
	
	//用户标识类型
	private String identitytype;
	
	//绑卡列表(JSON)
	private String cardlist;
	
	private List<CardBindInfo> cardinfos;
	
	private String errorcode;
	
	private String errormsg;

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getIdentityid() {
		return identityid;
	}

	public void setIdentityid(String identityid) {
		this.identityid = identityid;
	}

	public String getIdentitytype() {
		return identitytype;
	}

	public void setIdentitytype(String identitytype) {
		this.identitytype = identitytype;
	}

	public String getCardlist() {
		return cardlist;
	}

	public void setCardlist(String cardlist) {
		this.cardlist = cardlist;
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

	public List<CardBindInfo> getCardinfos() {
		return cardinfos;
	}

	public void setCardinfos(List<CardBindInfo> cardinfos) {
		this.cardinfos = cardinfos;
	}


	
	
  
}
