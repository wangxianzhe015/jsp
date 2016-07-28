package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.model.enums.PayType;

/**
 * 投资记录
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_INVEST_RECORD")
public class InvestRecord implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	//交易流水号
	@Id
	@Column(name="RECORD_ID")
	private Long recordId;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//份数
	@Column(name="NUMS")
	private Integer nums;
	
	//单份金额
	@Column(name="AMOUNT")
	private Float amount;
	
	//订单总金额
	@Column(name="TOTAL_AMOUNT")
	private Float totalAmount;
	
	//易宝交易流水号
	@Column(name="YB_ORDER_ID")
	private String ybOrderId;
	
	//支付方式
	@Column(name="PAY_TYPE")
	private PayType payType;
	
	//订单状态
	@Column(name="ORDER_STATE")
	private String pay;
	
	//支付错误码
	@Column(name="ERRCODE")
	private String errorCode;
	
	//支付错误信息
	@Column(name="ERRMSG")
	private String errorMsg;
	
	//订单创建时间
	@Column(name="CREATE_TIME")
	private Timestamp createTime;
	
	//订单支付时间
	@Column(name="PAY_TIME")
	private Timestamp payTime;
	
	//交易确认时间
	@Column(name="CONFIRM_TIME")
	private Timestamp confirmTime;
	
	//交易完成时间
	@Column(name="FINISH_TIME")
	private Timestamp finishTime;


	
}
