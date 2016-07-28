package com.smartcloud.crowdfunding.portal.model.yeepay;

public class QueryTradeRecordResponse {

	private String merchantaccount;
	
	private String orderid;
	
	private String yborderid;
	
	//订单金额
	private Integer amount; 
	
	//当前货币(156-人民币)
	private Integer currency;
	
	//付款方手续费
	private Integer sourcefee;
	
	//收款方手续费
	private Integer targetfee;
	
	//付款方实付金额
	private Integer sourceamount;
	
	//收款方实收金额
	private Integer targetamount;
	
	//下单时间
	private Integer ordertime;
	//交易时间
	private Integer closetime;
	//商品分类
	private Integer productcatalog;
	//商品名称
	private String productname;
	//商品描述
	private String productdesc;
	//支付类型(1、银行卡2、非银行卡)
	private Integer type;
	//银行名称
	private String bank;
	//银行缩写
	private String bankcode;
	//银行卡类型(1：储蓄卡 2：信用卡)
	private Integer bankcardtype;
	//状态0：待付（创建的订单未支付成功）
	//1：已付（订单已经支付成功）
	//2：已撤销（待支付订单有效期为1 天，过期后自动撤销）
	//3：阻断交易（订单因为高风险而被阻断）
	private Integer status;
	//累计退款
	private Integer refundtotal;
	
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

	public Integer getCurrency() {
		return currency;
	}

	public void setCurrency(Integer currency) {
		this.currency = currency;
	}

	public Integer getSourcefee() {
		return sourcefee;
	}

	public void setSourcefee(Integer sourcefee) {
		this.sourcefee = sourcefee;
	}

	public Integer getTargetfee() {
		return targetfee;
	}

	public void setTargetfee(Integer targetfee) {
		this.targetfee = targetfee;
	}

	public Integer getSourceamount() {
		return sourceamount;
	}

	public void setSourceamount(Integer sourceamount) {
		this.sourceamount = sourceamount;
	}

	public Integer getTargetamount() {
		return targetamount;
	}

	public void setTargetamount(Integer targetamount) {
		this.targetamount = targetamount;
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

	public Integer getProductcatalog() {
		return productcatalog;
	}

	public void setProductcatalog(Integer productcatalog) {
		this.productcatalog = productcatalog;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProductdesc() {
		return productdesc;
	}

	public void setProductdesc(String productdesc) {
		this.productdesc = productdesc;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBankcode() {
		return bankcode;
	}

	public void setBankcode(String bankcode) {
		this.bankcode = bankcode;
	}

	public Integer getBankcardtype() {
		return bankcardtype;
	}

	public void setBankcardtype(Integer bankcardtype) {
		this.bankcardtype = bankcardtype;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getRefundtotal() {
		return refundtotal;
	}

	public void setRefundtotal(Integer refundtotal) {
		this.refundtotal = refundtotal;
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
