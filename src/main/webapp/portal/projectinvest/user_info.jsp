<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>用户信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form action="" name="progressForm" method="post">
			<table class="content">
				<input type="hidden" name="orderId" value="${order.orderId }" />
				<tbody>
					<tr>
						<td class="title" width="150px;">
							用户名
						</td>
						<td>
							<span id="username"></span>
						</td>
						<td class="title" width="150px;">
							手机号码
						</td>
						<td>
							<span id="mobileno"></span>
						</td>						
					</tr>
																	
					<tr>
						<td class="title" width="150px;">
							真实姓名
						</td>
						<td>
							<span id="realname"></span>
						</td>
						<td class="title" width="150px;">
							身份证号码
						</td>
						<td>
							<span id="idcard"></span>
						</td>						
					</tr>	
	
					<tr>
						<td class="title" width="150px;">
							联系地址
						</td>
						<td colspan="3">
							<span id="address"></span>
						</td>
					</tr>	
					<tr>
						<td class="title" width="150px;">
							邮箱地址
						</td>
						<td colspan="3">
							<span id="email"></span>
						</td>
					</tr>																
				</tbody>

			</table>
		</form>
	</body>
</html>
