package com.smartcloud.crowdfunding.portal.model.yeepay;

/**
 * 查询订单应答
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryOrderResponse {

	private String merchantaccount;
	
	private String orderid;
	
	private String yborderid;
	
	private Integer amount; 
	
	//绑卡ID
	private String bindid;
	
	//绑卡有效期
	private String bindvalidthru;
	
	//银行名称
	private String bank;
	
	//银行代码缩写
	private String bankcode;
	
	//支付时间
	private String closetime;
	
	//银行卡类型(1:储蓄卡,2:信用卡)
	private String bankcardtype;
	
	//卡号后4 位
	private String lastno;
	
	//用户标识
	private String identityid;
	
	//用户标识类型
	private String identitytype;
	
	//0：失败
	//1：成功
	//2：未处理
	//3：处理中
	private String status;
	
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

	public String getBindid() {
		return bindid;
	}

	public void setBindid(String bindid) {
		this.bindid = bindid;
	}

	public String getBindvalidthru() {
		return bindvalidthru;
	}

	public void setBindvalidthru(String bindvalidthru) {
		this.bindvalidthru = bindvalidthru;
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

	public String getClosetime() {
		return closetime;
	}

	public void setClosetime(String closetime) {
		this.closetime = closetime;
	}

	public String getBankcardtype() {
		return bankcardtype;
	}

	public void setBankcardtype(String bankcardtype) {
		this.bankcardtype = bankcardtype;
	}

	public String getLastno() {
		return lastno;
	}

	public void setLastno(String lastno) {
		this.lastno = lastno;
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
