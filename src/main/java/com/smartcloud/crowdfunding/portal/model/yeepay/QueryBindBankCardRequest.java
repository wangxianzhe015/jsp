package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 查询银行卡绑定信息请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class QueryBindBankCardRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String identityid;
	
	private Integer identitytype;
	

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

	public Integer getIdentitytype() {
		return identitytype;
	}

	public void setIdentitytype(Integer identitytype) {
		this.identitytype = identitytype;
	}
	
	
}
