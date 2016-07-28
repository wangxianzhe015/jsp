package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;

/**
 * 提现记录
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_WITHDRAW_RECORD")
public class WithdrawRecord implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="RECORD_ID")
	private Long recordId;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="DRAW_TIME")
	private Timestamp drawTime;
	
	@Column(name="AMOUNT")
	private Float amount;
	
	//交易流水号
	@Column(name="ORDER_ID")
	private String orderId;
	
	//易宝交易流水号
	@Column(name="YB_ORDER_ID")
	private String ybOrderId;
	
	//支付状态
	@Column(name="PAY_STATE")
	private String payState;
	
	//支付时间
	@Column(name="PAY_TIME")
	private Timestamp payTime;
	
	//支付错误码
	@Column(name="PAY_ERRCODE")
	private String errorCode;
	//支付错误信息
	@Column(name="PAY_ERRMSG")
	private String errorMsg;
	
	//交易状态
	@Column(name="DEAL_STATE")
	private String dealState;
	
	//交易完成时间
	@Column(name="DEAL_TIME")
	private Timestamp dealTime;

	//交易状态名称
	private String dealStateName;
	
	//支付状态名称
	private String payStateName;

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Timestamp getDrawTime() {
		return drawTime;
	}

	public void setDrawTime(Timestamp drawTime) {
		this.drawTime = drawTime;
	}

	public Float getAmount() {
		return amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}


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

	public String getPayState() {
		return payState;
	}

	public void setPayState(String payState) {
		this.payState = payState;
	}

	public Timestamp getPayTime() {
		return payTime;
	}

	public void setPayTime(Timestamp payTime) {
		this.payTime = payTime;
	}

	public String getDealState() {
		return dealState;
	}

	public void setDealState(String dealState) {
		this.dealState = dealState;
	}

	public Timestamp getDealTime() {
		return dealTime;
	}

	public void setDealTime(Timestamp dealTime) {
		this.dealTime = dealTime;
	}

	public String getDealStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_DEAL_STATE, dealState);
	}

	public void setDealStateName(String dealStateName) {
		this.dealStateName = dealStateName;
	}

	public String getPayStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PAY_STATE, payState);
	}

	public void setPayStateName(String payStateName) {
		this.payStateName = payStateName;
	}

	
	
}
