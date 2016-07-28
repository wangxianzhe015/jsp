package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 支付请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class PayOrderRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String orderid;
	
	//交易时间戳(精确到秒)
	private Integer transtime;
	
	//交易金额(单位分)
	private Integer amount;
	
	//商品名称(最长50位)
	private String productname;
	
	//用户标识(商户生成的用户唯一标识，最长50位 )
	private String identityid;
	
	//用户类型
	private Integer identitytype;
	
	//卡号前6位
	private String card_top;
	
	//卡号后4位
	private String card_last;
	
	//用来通知商户支付结果
	private String callbackurl;
	
	//用户终端地址
	private String userip;
	

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

	public Integer getTranstime() {
		return transtime;
	}

	public void setTranstime(Integer transtime) {
		this.transtime = transtime;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getIdentityid() {
		return identityid;
	}

	public void setIdentityid(String identityid) {
		this.identityid = identityid;
	}

	public Integer getIdentitytype() {
		return identitytype;
	}

	public void setIdentitytype(Integer identitytype) {
		this.identitytype = identitytype;
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

	public String getCallbackurl() {
		return callbackurl;
	}

	public void setCallbackurl(String callbackurl) {
		this.callbackurl = callbackurl;
	}

	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}

	
	
	
}
