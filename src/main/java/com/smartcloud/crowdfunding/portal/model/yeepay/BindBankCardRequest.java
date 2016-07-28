package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 绑定银行卡请求桉树
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class BindBankCardRequest {
	

	//商户编号
	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	//用户标识，商户生成的用户唯一标识
	private String identityid;
	
	//用户标识类型
	private Integer identitytype;
	
	//绑卡请求号(商户生成的唯一绑卡请求号，最长50位)
	private String requestid;
	
	//银行卡卡号
	private String cardno;
	
	//证件类型，固定值 01
	private String idcardtype;
	
	//证件号
	private String idcardno;
	
	//持卡人用户名
	private String username;
	
	//银行预留的手机号
	private String phone;
	
	//用户支付时使用的网络终端IP
	private String userip;
	


	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getIdentityid() {
		return identityid;
	}

	/**
	 * 用户标识,商户生成的用户唯一标识
	 * @param identityid
	 */
	public void setIdentityid(String identityid) {
		this.identityid = identityid;
	}


	public Integer getIdentitytype() {
		return identitytype;
	}
	/**
	 * 用户标识类型<br/>
	 * 0：IMEI <br/>
	 * 1：MAC 地址<br/>
	 * 2：用户ID<br/>
	 * 3：用户Email<br/>
	 * 4：用户手机号<br/>
	 * 5：用户身份证号<br/>
	 * 6：用户纸质订单协议号<br/>
	 * @return
	 */
	public void setIdentitytype(Integer identitytype) {
		this.identitytype = identitytype;
	}

	public String getRequestid() {
		return requestid;
	}

	/**
	 * 商户生成的唯一绑卡请求号，最长50 位
	 * @param requestid
	 */
	public void setRequestid(String requestid) {
		this.requestid = requestid;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public String getIdcardtype() {
		return idcardtype;
	}

	/**
	 * 证件类型 固定值:01
	 * @param idcardtype
	 */
	public void setIdcardtype(String idcardtype) {
		this.idcardtype = idcardtype;
	}

	public String getIdcardno() {
		return idcardno;
	}

	/**
	 * 设置证件号
	 * @param idcardno
	 */
	public void setIdcardno(String idcardno) {
		this.idcardno = idcardno;
	}

	public String getUsername() {
		return username;
	}

	/**
	 * 设置持卡人姓名
	 * @param username
	 */
	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return phone;
	}

	/**
	 * 设置银行预留手机号
	 * @param phone
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUserip() {
		return userip;
	}

	public void setUserip(String userip) {
		this.userip = userip;
	}

	
	
	
}
