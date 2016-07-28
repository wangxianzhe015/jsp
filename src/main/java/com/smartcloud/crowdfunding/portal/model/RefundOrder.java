package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 * 订单退款记录
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_ORDER_REFUND")
public class RefundOrder implements java.io.Serializable{
	private static final long serialVersionUID = 1L;

	//订单ID
	@Id
	@Column(name="ORDER_ID")
	private String orderId;
	
	//易宝订单流水号
	@Column(name="YBORDER_ID")
	private String ybOrderId;
	
	//订单用户ID
	@Column(name="USER_ID")
	private String userId;
	
	//订单用户名
	@Column(name="USER_NAME")
	private String userName;
	
	//原订单ID
	@Column(name="ORIG_ORDER_ID")
	private String origOrderId;
	
	//原易宝订单流水号
	@Column(name="ORIG_YBORDER_ID")
	private String origYbOrderId;
	
	//项目ID
	@JoinColumn(name="PROJECT_ID")
	private Project project;
	
	//退款方式(BANKCARD/ACCOUNT)
	@Column(name="REFUND_TYPE")
	private String refundType;
	
	//退款金额
	@Column(name="AMOUNT")
	private Float amount;
	
	//退款手续费
	@Column(name="FEE")
	private Float fee;
	//剩余可退款金额
	@Column(name="REMAIN")
	private Float remain;
	
	//创建时间
	@Column(name="CREATE_TIME")
	private Timestamp createTime;
	
	//退款原因
	@Column(name="CAUSE")
	private String cause;
	
	@Column(name="ERR_CODE")
	private String errorCode;
	
	@Column(name="ERR_MSG")
	private String errorMsg;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getYbOrderId() {
		return ybOrderId;
	}

	public void setYbOrderId(String ybOrderId) {
		this.ybOrderId = ybOrderId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOrigOrderId() {
		return origOrderId;
	}

	public void setOrigOrderId(String origOrderId) {
		this.origOrderId = origOrderId;
	}

	public String getOrigYbOrderId() {
		return origYbOrderId;
	}

	public void setOrigYbOrderId(String origYbOrderId) {
		this.origYbOrderId = origYbOrderId;
	}

	public Float getAmount() {
		return amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	public Float getFee() {
		return fee;
	}

	public void setFee(Float fee) {
		this.fee = fee;
	}

	public Float getRemain() {
		return remain;
	}

	public void setRemain(Float remain) {
		this.remain = remain;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getCause() {
		return cause;
	}

	public void setCause(String cause) {
		this.cause = cause;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public String getRefundType() {
		return refundType;
	}

	public void setRefundType(String refundType) {
		this.refundType = refundType;
	}
	
	
}
