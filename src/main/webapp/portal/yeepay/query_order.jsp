<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>易宝订单查询</title>
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
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryOrder.action" class="hover">订单查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryTrade.action">交易查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryWithdraw.action">提现查询</li>
										<li id="tab" data-url="<%=servletPath %>/portal/pay/queryRefund.action">退款查询</li>
									</ul>
								</div>
								<div class="Contentbox">
											<form action="<%=servletPath %>/portal/pay/queryOrder.action" method="post" name="query_form" id="query_form">
												<div class="grid_body">
													<table>
														<thead>
															<tr>
																<th colspan="4" align="left">
																	查询支付订单
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
								
													<table>
														<thead>
															<tr>
																<th>
																         订单流水号
																</th>
																<th>
																	易宝流水号
																</th>
																<th>
																	订单金额(分)
																</th>
																<th>
																	银行卡号
																</th> 
																<th>
																	卡类型
																</th>
																<th>
																	银行名称
																</th>
																<th>
																	交易时间
																</th>
																<th>
																	交易状态
																</th>
								
															</tr>
														</thead>
								
														<tbody>
														
														    <c:if test="${not empty result.errorcode}">
														    	<tr>
														    	    <td colspan="8">错误代码：${result.errorcode } &nbsp;&nbsp; 错误信息: ${result.errormsg }</td>
														    	</tr>
														    </c:if>
														    
															<c:if test="${not empty result && empty result.errorcode}">
																<tr>
																	<td>
																		<c:out value="${result.orderid}"></c:out>
																	</td>
																	<td>
																		<c:out value="${result.yborderid }"/>
																	</td>
																	<td>
																	    <c:out value="${result.amount }"/>
																	</td>
																	<td>
																		**********<c:out value="${result.lastno }"/>
																	</td>
								
																	<td>
																		<c:out value="${result.bankcardtype}"></c:out>
																	</td>
																	<td>
																          <c:out value="${result.bank }"></c:out>
																	</td>
																	<td>
																		<c:out value="${result.closetime }"/>
																	</td>
																	<td>
																	   <font color="red">
																	   <c:if test="${result.status==0}">失败</c:if>
																	   <c:if test="${result.status==1}">成功</c:if>
																	   <c:if test="${result.status==2}">未处理</c:if>
																	   <c:if test="${result.status==3}">已处理</c:if>
																	   </font>
																	</td>																			
																</tr>
															</c:if>
															
														</tbody>
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
