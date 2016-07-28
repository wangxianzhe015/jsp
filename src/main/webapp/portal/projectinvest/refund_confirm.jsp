<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>订单回退确认</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form
			action="<%=servletPath %>/portal/projectinvest/refundOrder.action" name="progressForm" method="post">
			<table class="content">
				<input type="hidden" name="orderIds" id="orderIds" value="" />
				<tbody>
																
					<tr>
						<td class="title" width="150px;">
							退款原因
						</td>
						<td>
							<textarea type="text" name="cause" value=""  cols="30" rows="5">未达目标融资金额</textarea>
						</td>
					</tr>
					<tr>
						<td class="title" width="150px;">
							通知订单所有者：
						</td>
						<td>
							手机短信<input type="checkbox" name="sms" value="1" checked="checked"/>
							电子邮件<input type="checkbox" name="email" value="1" checked="checked"/>
							站内消息<input type="checkbox" name="sysmsg" value="1" checked="checked"/>
						</td>
					</tr>
					<tr>
						<td class="title" width="150px;">
							提醒：
						</td>
						<td>
							<li>1、退款只针对有效的订单，并且订单状态为“支付成功”或“付款确认”或“交易完成”</li>
							<li>2、对于银行卡在线支付，是通过易宝与银行之间的退款操作，到账时间一般5~10个工作日</li>
							<li>3、对于账户划款支付，是通过直接将订单金额返还到用户的账户可用余额</li>
							<li>4、退款成功后，系统将相应的订单置为"无效"，并且订单状态改为”交易取消“</li>
							
						</td>						
					</tr>					
				</tbody>

			</table>
		</form>
	</body>
</html>
