<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>订单确认</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form
			action="<%=servletPath %>/portal/projectinvest/confirmOrder.action" name="progressForm" method="post">
			<table class="content">
				<input type="hidden" name="orderId" value="${order.orderId }" />
				<tbody>
					<tr>
						<td class="title" width="150px;">
							确认结果
						</td>
						<td>
							<select name="confirmResult" id=""confirmResult"" >
							    <option value="">请选择</option>
								<option value="Y">确认成功</option>
								<option value="N">确认失败</option>
							</select>
						</td>
					</tr>
																
					<tr>
						<td class="title" width="150px;">
							备注
						</td>
						<td>
							<textarea type="text" name="remark" value=""  cols="30" rows="5"></textarea>
						</td>
					</tr>
					<tr>
						<td class="title" width="150px;">
							通知项目发起人：
						</td>
						<td>
							手机短信<input type="checkbox" name="sms" value="1" checked="checked"/>
							电子邮件<input type="checkbox" name="email" value="1" checked="checked"/>
							站内消息<input type="checkbox" name="sysmsg" value="1" checked="checked"/>
						</td>
					</tr>					
				</tbody>

			</table>
		</form>
	</body>
</html>
