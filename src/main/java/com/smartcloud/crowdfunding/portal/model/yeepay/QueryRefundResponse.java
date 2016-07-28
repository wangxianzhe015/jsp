package com.smartcloud.crowdfunding.portal.model.yeepay;

public class QueryRefundResponse {

	private String merchantaccount;
	
	//客户退货订单号
	private String orderid;
	
	//易宝退货流水号
	private String yborderid;
	
	//原易宝交易流水号
	private String origyborderid;
	
	//退款金额
	private Integer amount;

	//货币类型156人民币
	private Integer currency;
	
	//退货手续费
	private Integer fee;
	
	//下单时间,易宝收到交易请求时间
	private Integer ordertime;
	//交易时间 交易变成当前状态的时间
	private Integer closetime;
	
	//退款原因
	private String cause;
	
	//4、处理中
	//5、退款成功
	private Integer status;
	
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

	public String getOrigyborderid() {
		return origyborderid;
	}

	public void setOrigyborderid(String origyborderid) {
		this.origyborderid = origyborderid;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Integer getFee() {
		return fee;
	}

	public void setFee(Integer fee) {
		this.fee = fee;
	}

	public Integer getOrdertime() {
		return ordertime;
	}

	public void setOrdertime(Integer ordertime) {
		this.ordertime = ordertime;
	}

	public Integer getClosetime() {
		return closetime;
	}

	public void setClosetime(Integer closetime) {
		this.closetime = closetime;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
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
