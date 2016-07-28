package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 退款应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class RefundResponse {

	private String merchantaccount;
	
	private String orderid;
	
	private String yborderid;
	
	//退款金额
	private Integer amount;
	
	//退款手续费
	private Integer fee; 

	//原易宝交易流水号
	private String origyborderid;
	
	private Integer currency;
	
	//时间戳(秒)
	private Integer timestamp;
	
	//剩余可退款金额
	private Integer remain;
	

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

	public Integer getFee() {
		return fee;
	}

	public void setFee(Integer fee) {
		this.fee = fee;
	}

	public String getOrigyborderid() {
		return origyborderid;
	}

	public void setOrigyborderid(String origyborderid) {
		this.origyborderid = origyborderid;
	}

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Integer getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Integer timestamp) {
		this.timestamp = timestamp;
	}

	public Integer getRemain() {
		return remain;
	}

	public void setRemain(Integer remain) {
		this.remain = remain;
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
