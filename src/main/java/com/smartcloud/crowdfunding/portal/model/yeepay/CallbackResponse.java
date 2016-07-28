package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 支付回调应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class CallbackResponse {

	private String merchantaccount;
	
	private String orderid;
	
	//易宝交易流水号
	private String yborderid;
	
	//交易金额(分)
	private Integer amount;
	
	//，商户生成的用户唯一标识
	private String identityid;
	
	private String cardtop;
	
	private String cardlast;
	//1:表示成功；0:表示失败 
	private int status;
	
	private String errorcode;
	
	private String errormsg;
	
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
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getIdentityid() {
		return identityid;
	}
	public void setIdentityid(String identityid) {
		this.identityid = identityid;
	}
	public String getCardtop() {
		return cardtop;
	}
	public void setCardtop(String cardtop) {
		this.cardtop = cardtop;
	}
	public String getCardlast() {
		return cardlast;
	}
	public void setCardlast(String cardlast) {
		this.cardlast = cardlast;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
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
