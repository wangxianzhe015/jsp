package com.smartcloud.crowdfunding.portal.model.yeepay;

public class PayClearDataResponse {

	/**
	 * 商户账户编号,清算日期,下单时间,交易时间,客户消费订单号,消费交易流水号,消费金额,实收金额,收费方式,收款方手续费,支付产品,商品类别,商品名称,支付卡类型。
	 */

	private String merchantaccount;
	
	//清算日期
	private String cleardate;
	
	//下单时间
	private String ordertime;
	
	//交易时间
	private String transtime;
	
	//消费订单号
	private String orderid;
	
	//交易流水号
	private String transid;
	
	//消费金额
	private String amount;
	
	//实收金额
	private String realamount;
	//收费方式
	private String feetype;
	//手续费
	private String fee;
	
	private String paytype;
	
	private String productname; 
	
	private String cardtype;

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getCleardate() {
		return cleardate;
	}

	public void setCleardate(String cleardate) {
		this.cleardate = cleardate;
	}

	public String getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(String ordertime) {
		this.ordertime = ordertime;
	}

	public String getTranstime() {
		return transtime;
	}

	public void setTranstime(String transtime) {
		this.transtime = transtime;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getTransid() {
		return transid;
	}

	public void setTransid(String transid) {
		this.transid = transid;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getRealamount() {
		return realamount;
	}

	public void setRealamount(String realamount) {
		this.realamount = realamount;
	}

	public String getFeetype() {
		return feetype;
	}

	public void setFeetype(String feetype) {
		this.feetype = feetype;
	}

	public String getFee() {
		return fee;
	}

	public void setFee(String fee) {
		this.fee = fee;
	}

	public String getPaytype() {
		return paytype;
	}

	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getCardtype() {
		return cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

	
}
