<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>易宝交易查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/common/css/tabpanel.css">		
		<script>
		(function($){
			$( function() {
				$("#queryBtn").click( function() {
					$("#query_form").submit();
				});

				$("[id=tab]").click(function(){
					window.location.href=$(this).attr("data-url");
				})
			});
			
		})(jQuery)
		</script>

	</head>

	<body>
		<div class="grid_body">
				<table class="content">
					<tbody>
					
						<tr>
						<td>
							<div id="Tab1">
								<div class="Menubox">
									<ul>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryOrder.action" >订单查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryTrade.action" class="hover">交易查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryWithdraw.action">提现查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryRefund.action">退款查询</li>
									</ul>
								</div>
								<div class="Contentbox">
										<form action="<%=servletPath %>/portal/pay/queryTrade.action" method="post" name="query_form" id="query_form">
											<div class="grid_body">
												<table>
													<thead>
														<tr>
															<th colspan="4" align="left">
																查询交易记录
															</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td>
																输入订单流水号:
															</td>
															<td colspan="3">
																<input type="text" name="orderid" value="" style="width:400px" />
															</td>
														</tr>
													</tbody>
													<tfoot>
														<tr>
															<td colspan="4">
																<a id="queryBtn" class="sub" href="javascript:void(0);">查询</a>
							
															</td>
														</tr>
							
													</tfoot>
												</table>
											</div>
							
										</form>
										<form action="" method="post" name="result_form" id="result_form">
											<div class="grid_head">
												<div class="head_left">
													查询结果
												</div>
							
											</div>
											<input type="hidden" name="hasSelected" value="" />
											<div class="grid_body">
											<table class="content">
											
											     <c:if test="${not empty result }">
													<tr>
														<td width="150px;" class="title">
															订单流水号
														</td>
														<td>
															${result.orderid }
														</td>
													</tr>
													<tr>
														<td width="150px;" class="title">
															易宝流水号
														</td>
														<td>
															${result.yborderid }
														</td>
													</tr>
													<tr>
														<td class="title">
															订单金额(分)
														</td>
														<td>
															${result.amount }
														</td>
													</tr>
													<tr>
														<td width="150px;" class="title">
															商品名称
														</td>
														<td>
															${result.productname }
														</td>
													</tr>	
													<tr>
														<td width="150px;" class="title">
															银行卡
														</td>
														<td>
															${result.card_top }******${result.card_last }
														</td>
													</tr>	
													<tr>
														<td width="150px;" class="title">
															银行卡类型
														</td>
														<td>
															<c:if test="${result.bankcardtype==1}">储蓄卡</c:if>
															<c:if test="${result.bankcardtype==2}">信用卡</c:if>
														</td>
													</tr>							
													<tr>
														<td width="150px;" class="title">
															银行名称
														</td>
														<td>
															${result.bank}
														</td>
													</tr>		
																																		
													<tr>
														<td class="title">
															付款方手续费
														</td>
														<td>
															${result.sourcefee }
														</td>
													</tr>
													<tr>
														<td class="title">
															收款方手续费(分)
														</td>
														<td>
														    ${result.targetfee }
														</td>
													</tr>						
													<tr>
														<td class="title">
															付款方实付金额(分)
														</td>
														<td>
															${result.sourceamount }
							
														</td>
													</tr>												
													<tr>
														<td class="title">
															收款方实收金额(分)
														</td>
														<td>
															${result.targetamount }
														</td>
													</tr>
							
													<tr>
														<td class="title">
															下单时间
														</td>
														<td>
														   ${result.ordertime }							
														</td>
													</tr>	
													<tr>
														<td class="title">
															交易时间
														</td>
														<td>
														   ${result.closetime }							
														</td>
													</tr>	
													<tr>
														<td class="title">
															交易状态
														</td>
														<td>
														   <font color="red">
														   <c:if test="${result.status==0}">待付款</c:if>
														   <c:if test="${result.status==1}">已付款</c:if>
														   <c:if test="${result.status==2}">已撤销</c:if>
														   <c:if test="${result.status==3}">阻断交易</c:if>
														   	
														   </font>					
														</td>
													</tr>	
													</c:if>																
											</table>
											</div>
										</form>
								
								</div>
							</div>
						</td>
					</tr>

					</tbody>
				</table>
		</div>
	</body>
</html>
