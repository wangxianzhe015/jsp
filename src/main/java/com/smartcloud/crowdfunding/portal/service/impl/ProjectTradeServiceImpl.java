package com.smartcloud.crowdfunding.portal.service.impl;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.OrderRecord;
import com.smartcloud.crowdfunding.portal.model.RechargeRecord;
import com.smartcloud.crowdfunding.portal.model.RefundOrder;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.WithdrawRecord;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.service.ProjectTradeService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class ProjectTradeServiceImpl extends DAOSupport implements ProjectTradeService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	/**
	 * 订单唯一性检查方式-可重复认购
	 */
	private static final String REBUYABLE="REBUYABLE";
	/**
	 * 订单唯一性检查方式-不可重复认购
	 */
	private static final String UNREBUY="UNREBUY";
	
	public List<RechargeRecord> queryRechargeRecord(String userId, String beginDate, String endDate, Page page) {
		StringBuilder sql=new StringBuilder();
		sql.append("select * from portal_recharge_record where user_id=$userId");
		if(beginDate!=null)
			sql.append(" and recharge_time >= $beginDate");
		if(endDate!=null)
			sql.append(" and recharge_time <= $endDate");
		Map<String,String> params=new HashMap<String,String>();
		params.put("userId", userId);
		params.put("beginDate",beginDate);
		params.put("endDate", endDate);
		
		return this.executeUnnamedNativePageQuery(sql.toString(),null,RechargeRecord.class,params,new RechargeRecord(),page);

	}

	public List<WithdrawRecord> queryWithdrawRecord(String userId, String beginDate, String endDate, Page page) {
		StringBuilder sql=new StringBuilder();
		sql.append("select * from portal_withdraw_record where user_id=$userId");
		if(beginDate!=null)
			sql.append(" and draw_time >= $beginDate");
		if(endDate!=null)
			sql.append(" and draw_time <= $endDate");
		Map<String,String> params=new HashMap<String,String>();
		params.put("userId", userId);
		params.put("beginDate",beginDate);
		params.put("endDate", endDate);
		
		return this.executeUnnamedNativePageQuery(sql.toString(),null,WithdrawRecord.class,params,new WithdrawRecord(),page);
	}

	public List<TradeOrder> queryTradeOrder(String userId, OrderState[] orderStates, Page page) {
		StringBuilder sql=new StringBuilder();
		sql.append("select * from portal_project_order where user_id=$userId and is_valid='1' ");
		
		if(orderStates!=null && orderStates.length >0){
			String values="";
			for(OrderState os:orderStates){
				values+="'"+os.getValue()+"',";
			}
			if(values.endsWith(","))
				values=values.substring(0,values.length()-1);
			
			sql.append(" and order_state in ("+values+")");
		}
		
		sql.append(" order by create_time desc");
		
		Map<String,String> params=new HashMap<String,String>();
		params.put("userId", userId);
		
		return this.executeUnnamedNativePageQuery(sql.toString(),null,TradeOrder.class,params,new TradeOrder(),page);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public Float statTotalRechargeAmount(String userId) {
		return (Float)this.createUnnamedNativeQuery("select sum(amount) from portal_recharge_record where user_id=? and pay_state ='Y' ", Float.class).setParameter(1, userId).getSingleResult();
	}

	public Float statTotalWithdrawAmount(String userId) {
		return (Float)this.createUnnamedNativeQuery("select sum(amount) from portal_withdraw_record where user_id=? and pay_state ='Y' ", Float.class).setParameter(1, userId).getSingleResult();
	}

	public Float statTotalInvestAmount(String userId) {

		return (Float)this.createUnnamedNativeQuery("select sum(total_amount) from portal_project_order where user_id=? and order_state not in ('00','11','21','31')", Float.class).setParameter(1, userId).getSingleResult();
	}

	public void addTradeOrder(TradeOrder record) {
		this.insert(record);
		
	}

	public void deleteTradeOrder(TradeOrder record) {
		this.delete(record);
		
	}

	/**
	 * 判断用户订单是否已经存在<BR>
	 * 判断条件：该订单有效，并且订单状态是待支付状态、支付失败、确认失败状态，表示存在未支付完成的订单
	 * @param userId
	 * @param projectId
	 */
	public boolean existTradeOrder(String userId, Long projectId) {
		String sql="select * from portal_project_order where user_id=? and project_id=? and is_valid='1' and order_state in ('00','11','21') ";
		String orderUnique=(String)em.createNativeQuery("select order_unique from portal_project where project_id=?", String.class).setParameter(1, projectId).getSingleResult();
		if(UNREBUY.equals(orderUnique)){
			sql="select * from portal_project_order where user_id=? and project_id=? and is_valid='1' ";
		}
		
		TradeOrder record=(TradeOrder)em.createNativeQuery(sql, TradeOrder.class).setParameter(1, userId).setParameter(2, projectId).getSingleResult();
		
		return record!=null?true:false;
	}

	public void addRechargeRecord(RechargeRecord record) {
		this.insert(record);
	}

	public void updateRechargeRecord(RechargeRecord record) {
		this.update(record);
		
	}

	public void addWithdrawRecord(WithdrawRecord record) {
		this.insert(record);
	}

	public void updateWithdrawRecord(WithdrawRecord record) {
		this.update(record);
		
	}

	public boolean existRechargeOrderId(String orderId) {
		RechargeRecord record=(RechargeRecord)em.createNativeQuery("SELECT * FROM PORTAL_RECHARGE_RECORD WHERE ORDER_ID=?",RechargeRecord.class).setParameter(1, orderId).getSingleResult();
		return record!=null?true:false;
	}

	public boolean existWithdrawOrderId(String orderId) {
		RechargeRecord record=(RechargeRecord)em.createNativeQuery("SELECT * FROM PORTAL_WITHDRAW_RECORD WHERE ORDER_ID=?",RechargeRecord.class).setParameter(1, orderId).getSingleResult();
		return record!=null?true:false;
	}

	public int updateRechargeStatus(String orderId, String payState, Timestamp payTime, String errorCode, String errorMsg) {
		return em.createNativeQuery("UPDATE PORTAL_RECHARGE_RECORD SET PAY_STATE=?,PAY_TIME=?,PAY_ERRCODE=?,PAY_ERRMSG=? WHERE ORDER_ID=?").
		setParameter(1, payState).
		setParameter(2, payTime).
		setParameter(3, errorCode).
		setParameter(4, errorMsg).
		setParameter(5, orderId).executeUpdate();
		
		
	}

	public int updateWithdrawStatus(String orderId, String payState, Timestamp payTime, String errorCode, String errorMsg) {
		return em.createNativeQuery("UPDATE PORTAL_WITHDRAW_RECORD SET PAY_STATE=?,PAY_TIME=?,PAY_ERRCODE=?,PAY_ERRMSG=? WHERE ORDER_ID=?").
		setParameter(1, payState).
		setParameter(2, payTime).
		setParameter(3, errorCode).
		setParameter(4, errorMsg).
		setParameter(5, orderId).executeUpdate();
	}

	public TradeOrder getTradeOrder(String orderId) {
		TradeOrder record=new TradeOrder();
		record.setOrderId(orderId);
		return (TradeOrder)find(record);
	}

	public void updateTradeOrder(TradeOrder record) {
		this.update(record);
	}

	public void addOrderRecord(OrderRecord record) {
		this.insert(record);
		
	}

	public List<TradeOrder> queryAllTradeOrder(TradeOrder order, Page page) {
		return this.executeEntitiesPageQuery(order, page);
	}

	public int cancelTradeOrder(String orderId) {
		TradeOrder order=new TradeOrder();
		order.setOrderId(orderId);
		order.setValid("0");
		this.update(order);
		return 1;
	}

	public void confirmTradeOrder(String orderId,boolean successOrfailure,String remark) {
		TradeOrder order=new TradeOrder();
		order.setOrderId(orderId);
		order.setConfirmTime(DateUtils.getCurrentTime());
		order.setRemark(remark);
		
		if(successOrfailure)
			order.setOrderState(OrderState.CONFIRM_SUCCESS);
		else
			order.setOrderState(OrderState.CONFIRM_FAILURE);
		
		this.update(order);
		
		OrderRecord record=new OrderRecord();
		record.setOperDesc("交易确认"+(successOrfailure?"成功":"失败,原因:"+remark));
		record.setOperTime(DateUtils.getCurrentTime());
		record.setOrderId(orderId);
		this.insert(record);
		
	}

	public List<TradeOrder> findTradeOrdersByProject(Long projectId) {
		List<TradeOrder> result=em.createNativeQuery("select * from portal_project_order where project_id=? and is_valid='1'",TradeOrder.class ).setParameter(1, projectId).getResultList();
 		return result;
	}

	public RechargeRecord getRechargeRecord(String orderId) {

		return (RechargeRecord)em.createNativeQuery("select * from portal_recharge_record where order_id=?",RechargeRecord.class ).setParameter(1, orderId).getSingleResult();
	}

	public WithdrawRecord getWithdrawRecord(String orderId) {
		return (WithdrawRecord)em.createNativeQuery("select * from portal_withdraw_record where order_id=?",WithdrawRecord.class ).setParameter(1, orderId).getSingleResult();

	}

	public void addRefundOrder(RefundOrder order) {
		this.insert(order);
	}

	public RefundOrder getRefundOrder(String orderId) {
		RefundOrder order=new RefundOrder();
		order.setOrderId(orderId);
		return (RefundOrder)find(order);
	}

	public List<RefundOrder> queryRefundOrders(RefundOrder order, Page page) {
		return this.executeEntitiesPageQuery(order, page);
	}

	public List<RefundOrder> queryRefundOrders(String userId, Page page) {
		RefundOrder order=new RefundOrder();
		order.setUserId(userId);
		return this.executeEntitiesPageQuery(order, page);
	}



}
