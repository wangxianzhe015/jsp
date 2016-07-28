package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 订单记录
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_ORDER_RECORD")
public class OrderRecord implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="RECORD_ID")
	private Long recordId;
	
	//交易流水号
	@Column(name="ORDER_ID")
	private String orderId;
	
	//用户ID
	@Column(name="USER_ID")
	private String userId;
	
	//操作时间
	@Column(name="OPER_TIME")
	private Timestamp operTime;

	//操作描述
	@Column(name="OPER_DESC")
	private String operDesc;


	public Long getRecordId() {
		return recordId;
	}

	public void setRecordId(Long recordId) {
		this.recordId = recordId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public Timestamp getOperTime() {
		return operTime;
	}

	public void setOperTime(Timestamp operTime) {
		this.operTime = operTime;
	}

	public String getOperDesc() {
		return operDesc;
	}

	public void setOperDesc(String operDesc) {
		this.operDesc = operDesc;
	}



	
	
}
