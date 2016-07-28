<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>项目订单审核</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script>
	( function($) {
		$( function() {
			// 此div必须存在height=一个值
			$("div.a_container_left").resizable({
				minHeight : 200,
				minWidth : 300,
				maxWidth : 400,
				maxHeight : 550
			});

			/**
			 * 初始化弹出窗口
			 */
			$(".orderConfirmDialog").dialog({
				draggable : false,
				resizable : false,
				autoOpen : false,
				modal : true
			});

			/**
			 * 初始化弹出窗口
			 */
			$(".orderQueryDialog").dialog({
				draggable : false,
				resizable : false,
				autoOpen : false,
				modal : true
			});
			
			$("[id='submitBtn']").click( function() {
						$("#orderConfirmDialog").dialog({
							title : "订单确认",
							height:$.browser.msie?500:"auto",
							width : 620,
							minWidth : 620,
							buttons : {
								"确定" : function() {
									var validateFormRule = {
										rules : {
											"confirmResult" : {
												required : true
											}							
										}
									};
									
									var vo = validateForm("form[name='progressForm']", validateFormRule);
									if (vo.form()) {
										var options = {
											dataType : "json",
											error : function() {
												$.prompt('订单审核出错!');
											},
											success : function(data) {
												$.prompt('审核成功!');
												window.location.href=servletPath+"/portal/projectinvest/index.action";
											}
										};
										$("[name='progressForm']").ajaxSubmit(options);
										$(this).dialog("close");
									}
								},
								"关闭" : function() {
									$(this).dialog("close");
								}
							}
						}).dialog("open");
					
				});			
			
			$("[id='queryOrderBtn']").click( function() {
				$("#orderQueryDialog").dialog({
					title : "订单确认",
					height:$.browser.msie?500:"auto",
					width : 780,
					minWidth : 780,
					buttons : {
						"关闭" : function() {
							$(this).dialog("close");
						}
					}
				}).dialog("open");
			
			});	

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/projectinvest/index.action";
			});
			
			$("[id=updateBtn]").click(function(){
				$("#data_form").attr("action","<%= servletPath%>/portal/projectinvest/updateOrder.action");
				$("#data_form").submit();
			});
			
			$("#nums").change( function () {
		           var sum = Number($(this).val());
		           var lestamount=Number($("#amount").val());
		           var investorIncomeRate=Number($("#investorIncomeRate").val());
		           var investorAmount=Number($("#investorAmount").val());
		           
		           if(sum < 1){
		               sum = 1;
		               $(this).val(1);
		           }
		           var totalAmount=(sum*lestamount).toFixed(2);
		           $('#totalAmount').val(totalAmount);
		           var incomeRate=totalAmount*investorIncomeRate/investorAmount;
		           $('#incomeRate').val(incomeRate.toFixed(2));
			});
			$("#nums").focus();
		});
	})(jQuery)
</script>

	</head>

	<body>

		<div class="grid_body">

			<form action="<%= servletPath%>/portal/projectinvest/confirmOrder.action" method="post" name="data_form" id="data_form">
			<input type="hidden" id="investorIncomeRate" value="${order.project.investorIncomeRate }"/>
			<input type="hidden" id="investorAmount" value="${order.project.investorAmount }"/>
			
				<div class="grid_body">
					<table class="content">
						<thead>
							<tr>
								<th colspan="2">
									项目订单信息
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="title">
									订单ID
								</td>
								<td>
									<input type="text" name="order.orderId" readonly="readonly" value="${order.orderId }" class="line_input" size="60px"/>
									<c:if test="${order.payType.value=='bankcard' }">
									<a id="queryOrderBtn" class="sub" href="javascript:void(0);">查询易宝订单</a>
									</c:if>
								</td>
							</tr>
							<tr>
								<td width="150px;" class="title">
									项目名称
								</td>
								<td>
									<input type="text"  value="${order.project.projectName }" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									份数
								</td>
								<td>
									<input type="text" value="${order.nums }" name="order.nums" id="nums" class="line_input" size="60px" style="color:red"/>
								</td>
							</tr>		
							<tr>
								<td class="title">
									单价
								</td>
								<td >
									<input type="text" value="${order.amount }" id="amount" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>												
							<tr>
								<td class="title">
									订单总金额
								</td>
								<td>
									<input type="text"  value="${order.totalAmount }" name="order.totalAmount" id="totalAmount" readonly="readonly" class="line_input" style="color:red"  size="60px"/>(元)
								</td>
							</tr>
							<tr>
								<td class="title">
									收益比例
								</td>
								<td>
									<input type="text"  value="${order.incomeRate }" name="order.incomeRate" id="incomeRate" readonly="readonly" class="line_input"  size="60px" style="color:red"/>
								</td>
							</tr>							
							<tr>
								<td class="title">
									认购方式
								</td>
								<td>
									<input type="text"  value="${order.subscribeTypeName }" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>
	
							<tr>
								<td class="title">
									易宝交易流水号
								</td>
								<td>
									<input type="text"  value="${order.ybOrderId }" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>													
							<tr>
								<td class="title">
									支付方式
								</td>
								<td>
									<input type="text" style="color:red" value="${order.payTypeName }" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									订单状态
								</td>
								<td>
									<input type="text"  value="${order.orderStateName }" readonly="readonly" class="line_input"  size="60px"/>
								</td>
							</tr>	
							<tr>
								<td class="title" >
									备注
								</td>
								<td>
								<input type="text"  value="${order.remark }" name="order.remark" class="line_input" size="60px" style="color:red"/>(修改订单请备注)
								</td>
							</tr>	
							<tr>
								<td class="title" >
									易宝信息
								</td>
								<td>
								<input type="text"  value="${order.errorMsg }" readonly="readonly" class="line_input" size="60px"/>
								</td>
							</tr>																			
							<tr>
								<td class="title">
									是否有效
								</td>
								<td>
									<select name="order.valid" style="color:red">
										<option value="1" <c:if test="${order.valid=='1'}">selected</c:if> >有效</option>
										<option value="0" <c:if test="${order.valid=='0'}">selected</c:if>>无效</option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="title" >
									订单用户
								</td>
								<td>
									<input type="text"  value="${orderUser.userName }" readonly="readonly" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title" >
									联系电话
								</td>
								<td>
									<input type="text"  value="${orderUser.mobileNo }" readonly="readonly" class="line_input" />
								</td>
							</tr>													
							<tr>
								<td class="title" >
									订单创建时间
								</td>
								<td>
									<input type="text"  value="${order.createTime }" readonly="readonly" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title" >
									订单支付时间
								</td>
								<td>
									<input type="text"  value="${order.payTime }" readonly="readonly" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title" >
									订单确认时间
								</td>
								<td>
								<input type="text"  value="${order.confirmTime }" readonly="readonly" class="line_input" />
								</td>
							</tr>	
																
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
								
									<a id="submitBtn" class="sub" href="javascript:void(0);">订单确认</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									
									<a id="updateBtn" class="sub" href="javascript:void(0);">订单修改</a>
									&nbsp;&nbsp;&nbsp;&nbsp;
									
									<a id="backBtn" class="return" href="javascript:void(0);">返回</a>
								</td>
							</tr>

						</tfoot>
					</table>
				</div>
			</form>
		</div>


		<div class="orderConfirmDialog" title="订单确认" id="orderConfirmDialog">
				<jsp:include page="order_confirm.jsp"></jsp:include>
		</div>
		<div class="orderQueryDialog" title="订单查询" id="orderQueryDialog">
				<jsp:include page="query_order.jsp"></jsp:include>
		</div>		
	</body>
</html>
