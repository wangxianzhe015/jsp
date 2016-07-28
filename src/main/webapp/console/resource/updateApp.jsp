<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>资源管理-修改应用</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	</head>
	<body>
		<form action="<%=servletPath %>/console/application/updateApp.action" name="updateAppForm" method="post">
			<table class="content">
				<input type="hidden" name="app.appId" value="" />
				<tbody>
					<tr>
						<td width="150px;" class="title">
							应用名称
						</td>
						<td>
							<input type="text" value="" name="app.appName" />
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							应用描述
						</td>
						<td>
							<input type="text" value="" name="app.appD" />
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							应用上下文
						</td>
						<td>
							<input type="text" value="" name="app.appContext" />
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							应用协议
						</td>
						<td>
							<select name="app.protocol">
								<option value="http">
									HTTP
								</option>
								<option value="https">
									HTTPS
								</option>
							</select>
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							应用IP
						</td>
						<td>
							<input type="text" value="" name="app.appIp" />
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							应用端口
						</td>
						<td>
							<input type="text" value="" name="app.appPort" />
						</td>

					</tr>
				</tbody>

			</table>
		</form>
	</body>
</html>
