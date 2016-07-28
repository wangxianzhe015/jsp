package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 账户信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_USER_ACCOUNT")
public class AccountInfo implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="TOTAL_AMOUNT")
	private Float totalAmount;
	
	@Column(name="AVAILABLE_AMOUNT")
	private Float availableAmount;
	
	@Column(name="FREEZE_AMOUNT")
	private Float freezeAmount;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Float getAvailableAmount() {
		return availableAmount;
	}

	public void setAvailableAmount(Float avaliableAmount) {
		this.availableAmount = avaliableAmount;
	}

	public Float getFreezeAmount() {
		return freezeAmount;
	}

	public void setFreezeAmount(Float freezeAmount) {
		this.freezeAmount = freezeAmount;
	}

	
}
