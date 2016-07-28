<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>订单查询</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
<script>
(function($){
	$( function() {
		$("#queryBtn").click( function() {
			var options = {
					dataType : "json",
					error : function() {
						$.prop('查询订单错误');
					},
					success : function(data) {
						var order=data.order;
						if(order.errorCode!=null && order.errorCode!=""){
							$.prop("错误代码:"+order.errorCode+",错误信息:"+order.errorMsg);
							return ;
						}
						$("#orderId").html(order.orderid);
						$("#yborderid").html(order.yborderid);
						$("#amount").html(order.amount);
						$("#lastno").html("*******"+order.lastno);
						$("#bankcardtype").html(order.bankcardtype);
						$("#bank").html(order.bank);
						$("#closetime").html(order.closetime);
						var status="";
						if(order.status==0){
							status="失败";
						}
						if(order.status==1){
							status="成功";
						}
						if(order.status==2){
							status="未处理";
						}
						if(order.status==3){
							status="已处理";
						}
						
						$("#status").html(status);
						
						
					}
				};
				$("form[id='query_form']").ajaxSubmit(options);			
			
		});

	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="<%=servletPath %>/portal/pay/queryOrderAjax.action" method="post" name="query_form" id="query_form">
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
									<input type="text"  name="orderid" value="" style="width:400px" />
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
								<tr>
									<td id="orderId">
										
									</td>
									<td id="yborderid">
									
									</td>
									<td id="amount">
								
									</td>
									<td id="lastno">
										
									</td>

									<td id="bankcardtype">
										
									</td>
									<td id="bank">
								         
									</td>
									<td id="closetime">
										
									</td>
									<td>
									   <font color="red" id="status">

									   </font>
									</td>																			
								</tr>
					
						</tbody>
					</table>
				</div>
			</form>
		</div>

	</body>
</html>
