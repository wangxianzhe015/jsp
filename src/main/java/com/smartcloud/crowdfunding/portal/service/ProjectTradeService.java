package com.smartcloud.crowdfunding.portal.service;

import java.sql.Timestamp;
import java.util.List;

import com.smartcloud.crowdfunding.portal.model.OrderRecord;
import com.smartcloud.crowdfunding.portal.model.RechargeRecord;
import com.smartcloud.crowdfunding.portal.model.RefundOrder;
import com.smartcloud.crowdfunding.portal.model.TradeOrder;
import com.smartcloud.crowdfunding.portal.model.WithdrawRecord;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 资金交易记录服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectTradeService {
	
	
	/**
	 * 添加退款记录
	 * @param order
	 * @return
	 */
	public void addRefundOrder(RefundOrder order);
	
	/**
	 * 获取退款信息
	 * @param orderId
	 * @return
	 */
	public RefundOrder getRefundOrder(String orderId);
	
	/**
	 * 查询所有退款记录
	 * @param order
	 * @param page
	 * @return
	 */
	public List<RefundOrder> queryRefundOrders(RefundOrder order,Page page);
	
	/**
	 * 查询指定用户的退款记录
	 * @param userId
	 * @param page
	 * @return
	 */
	public List<RefundOrder> queryRefundOrders(String userId,Page page);
	
	/**
	 * 获取交易记录
	 * @param orderId
	 * @return
	 */
	public RechargeRecord getRechargeRecord(String orderId);
	
	/**
	 *获取提现记录 
	 */
	public WithdrawRecord getWithdrawRecord(String orderId);
	
	/**
	 * 获取订单信息
	 * @param orderId
	 * @return
	 */
	public TradeOrder getTradeOrder(String orderId);
	
	
	/**
	 * 获取该项目所有有效订单
	 * @param projectId
	 * @return
	 */
	public List<TradeOrder> findTradeOrdersByProject(Long projectId);
	
	/**
	 * 查询所有项目订单记录
	 * @param order
	 * @param page
	 * @return
	 */
	public List<TradeOrder> queryAllTradeOrder(TradeOrder order,Page page);
	
	/**
	 * 取消项目交易订单
	 * @param orderId
	 * @return
	 */
	public int cancelTradeOrder(String orderId);
	
	/**
	 * 确认项目交易订单
	 * @param orderId 订单ID
	 * @param successOrfailure 成功或失败
	 * @param remark 备注
	 */
	public void confirmTradeOrder(String orderId,boolean successOrfailure,String remark);
	
	
	/**
	 * 添加订单记录
	 * @param record
	 */
	public void addOrderRecord(OrderRecord record);
	/**
	 * 更新充值交易状态
	 * @param orderId
	 * @param tradeState
	 * @param tradeFinishTime
	 * @param errorCode
	 * @param errorMsg
	 */
	public int updateRechargeStatus(String orderId,String tradeState,Timestamp tradeFinishTime,String errorCode,String errorMsg);
	
	/**
	 * 更新提现交易状态
	 * @param orderId
	 * @param tradeState
	 * @param tradeFinishTime
	 * @param errorCode
	 * @param errorMsg
	 */
	public int updateWithdrawStatus(String orderId,String tradeState,Timestamp tradeFinishTime,String errorCode,String errorMsg);
	
	/**
	 * 判断充值订单ID是否存在
	 * @param orderId
	 * @return
	 */
	public boolean existRechargeOrderId(String orderId);
	
	/**
	 * 判断提现订单ID是否已经存在
	 * @param orderId
	 * @return
	 */
	public boolean existWithdrawOrderId(String orderId);
	/**
	 * 添加充值记录
	 * @param record
	 */
	public void addRechargeRecord(RechargeRecord record);
	
	/**
	 * 修改充值记录
	 * @param record
	 */
	public void updateRechargeRecord(RechargeRecord record);
	
	/**
	 * 获取充值记录
	 * @param userId 用户ID
	 * @param beginDate 开始日期
	 * @param endDate 结束日期
	 * @param page 分页对象
	 * @return
	 */
	public List<RechargeRecord> queryRechargeRecord(String userId,String beginDate,String endDate,Page page);
	
	
	/**
	 * 添加提现记录
	 * @param record
	 */
	public void addWithdrawRecord(WithdrawRecord record);
	

	/**
	 * 修改提现记录
	 * @param record
	 */
	public void updateWithdrawRecord(WithdrawRecord record);
	/**
	 * 获取提现记录
	 * @param userId 用户ID
	 * @param beginDate 开始日期
	 * @param endDate 结束日期
	 * @param page 分页对象
	 * @return
	 */
	public List<WithdrawRecord> queryWithdrawRecord(String userId,String beginDate,String endDate,Page page);
	
	/**
	 * 查询订单
	 * @param userId 用户ID
	 * @param orderState 订单状态
	 * @param page 分页对象
	 * @return
	 */
	public List<TradeOrder> queryTradeOrder(String userId,OrderState[] orderStates,Page page);
	
	/**
	 * 判断用户是否已经存在该项目的订单记录
	 * @param userId 用户ID
	 * @param projectId 项目ID
	 * @return
	 */
	public boolean existTradeOrder(String userId,Long projectId);
	
	/**
	 * 添加订单
	 * @param record
	 */
	public void addTradeOrder(TradeOrder record);
	
	/**
	 * 更新订单
	 * @param record
	 */
	public void updateTradeOrder(TradeOrder record);
	
	/**
	 * 删除订单
	 * @param record
	 */
	public void deleteTradeOrder(TradeOrder record);
	
	/**
	 * 累计充值金额
	 * @param userId
	 * @return
	 */
	public Float statTotalRechargeAmount(String userId);
	
	/**
	 * 累计取现金额
	 * @param userId
	 * @return
	 */
	public Float statTotalWithdrawAmount(String userId);
	
	/**
	 * 累计投资金额
	 * @param userId
	 * @return
	 */
	public Float statTotalInvestAmount(String userId);
	


}
