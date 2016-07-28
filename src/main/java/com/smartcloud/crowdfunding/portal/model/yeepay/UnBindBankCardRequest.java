package com.smartcloud.crowdfunding.portal.model.yeepay;

import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;

/**
 * 解除银行卡绑定请求
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class UnBindBankCardRequest {

	private String merchantaccount=PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	
	private String bindid;
	
	private String identityid;
	
	private Integer identitytype;
	

	public String getMerchantaccount() {
		return merchantaccount;
	}

	public void setMerchantaccount(String merchantaccount) {
		this.merchantaccount = merchantaccount;
	}

	public String getBindid() {
		return bindid;
	}

	public void setBindid(String bindid) {
		this.bindid = bindid;
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
