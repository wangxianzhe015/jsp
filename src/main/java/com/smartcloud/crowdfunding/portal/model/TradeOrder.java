package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.model.enums.PayType;
import com.smartcloud.crowdfunding.portal.model.enums.SubscribeType;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.persistence.annotation.Order;

/**
 * 项目订单
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_ORDER")
public class TradeOrder implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	//交易流水号
	@Id
	@Column(name="ORDER_ID")
	private String orderId;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@JoinColumn(name="PROJECT_ID")
	private Project project;
	
	//份数
	@Column(name="NUMS")
	private Integer nums;
	
	//单份金额
	@Column(name="AMOUNT")
	private Float amount;
	
	//订单总金额
	@Column(name="TOTAL_AMOUNT")
	private Float totalAmount;

	//收益比例
	@Column(name="INCOME_RATE")
	private Float incomeRate;
	
	
	//认购方式(prebuy/buy)
	@Column(name="SUBSCRIBE_TYPE")
	private SubscribeType subscribeType;
	
	//是否有效(有效1/无效0);
	@Column(name="IS_VALID")
	private String valid;
	
	//易宝交易流水号
	@Column(name="YB_ORDER_ID")
	private String ybOrderId;
	
	//是否确认合作协议
	@Column(name="CHECK_AGREEMENT")
	private String checkAgreement;
	
	//支付方式
	@Column(name="PAY_TYPE")
	private PayType payType;
	
	//订单状态
	@Column(name="ORDER_STATE")
	private OrderState orderState;
	
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
	@Order(sort="DESC")
	private Timestamp payTime;
	
	//交易确认时间
	@Column(name="CONFIRM_TIME")
	private Timestamp confirmTime;
	
	//交易完成时间
	@Column(name="FINISH_TIME")
	private Timestamp finishTime;
	
	//备注
	@Column(name="REMARK")
	private String remark;
	//操作记录
	@JoinColumn(name="records",columnDefinition="select * from portal_order_record where order_id=$ORDER_ID order by oper_time desc")
	private List<OrderRecord> records;

	//订单状态名称
	private String orderStateName;
	//认购类型名称
	private String subscribeTypeName;
	//有效名称
	private String validName;
	//订单支付方式名称
	private String payTypeName;
	//订单步骤
	private int step;
	

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
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

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public Integer getNums() {
		return nums;
	}

	public void setNums(Integer nums) {
		this.nums = nums;
	}

	public Float getAmount() {
		return amount;
	}

	public void setAmount(Float amount) {
		this.amount = amount;
	}

	public Float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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

	public Timestamp getPayTime() {
		return payTime;
	}

	public void setPayTime(Timestamp payTime) {
		this.payTime = payTime;
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


	public String getSubscribeTypeName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_SUBSCRIBE_TYPE, subscribeType.getValue());
	}

	public String getOrderStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_ORDER_STATE, orderState.getValue());
	}

	
	public String getCheckAgreement() {
		return checkAgreement;
	}

	public void setCheckAgreement(String checkAgreement) {
		this.checkAgreement = checkAgreement;
	}
	
	public PayType getPayType() {
		return payType;
	}

	public void setPayType(PayType payType) {
		this.payType = payType;
	}

	public String getPayTypeName() {
		if(payType!=null){
			return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PAY_TYPE, payType.getValue());
		}else{
			return "";
		}
	}

	public List<OrderRecord> getRecords() {
		return records;
	}

	public void setRecords(List<OrderRecord> records) {
		this.records = records;
	}

	
	public SubscribeType getSubscribeType() {
		return subscribeType;
	}

	public void setSubscribeType(SubscribeType subscribeType) {
		this.subscribeType = subscribeType;
	}

	public String getValid() {
		return valid;
	}

	public void setValid(String valid) {
		this.valid = valid;
	}

	public OrderState getOrderState() {
		return orderState;
	}

	public void setOrderState(OrderState orderState) {
		this.orderState = orderState;
	}

	public Timestamp getConfirmTime() {
		return confirmTime;
	}

	public void setConfirmTime(Timestamp confirmTime) {
		this.confirmTime = confirmTime;
	}

	public Timestamp getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(Timestamp finishTime) {
		this.finishTime = finishTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getStep() {
		if(orderState!=null){
			if(orderState.getValue().startsWith("3")){//订购完成
				return 4;
			}
			if(orderState.getValue().startsWith("2")){//订单确认
				return 3;
			}
			
			if(orderState.getValue().startsWith("1")){//支付成功
				return 2;
			}
			
			return 2;
		}

		return 1;
	}

	public Float getIncomeRate() {
		return incomeRate;
	}

	public void setIncomeRate(Float incomeRate) {
		this.incomeRate = incomeRate;
	}

	public String getValidName() {
		return validName;
	}

	public void setValidName(String validName) {
		this.validName = validName;
	}

	public void setOrderStateName(String orderStateName) {
		this.orderStateName = orderStateName;
	}

	public void setSubscribeTypeName(String subscribeTypeName) {
		this.subscribeTypeName = subscribeTypeName;
	}

	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	public void setStep(int step) {
		this.step = step;
	}
	
	
}
