<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>资源管理-修改函数</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form
			action="<%=servletPath %>/console/function/updateFunc.action"
			name="updateFuncForm" method="post">
			<table class="content">
				<input type="hidden" name="function.module.moduleId" value="" />
				<tbody>
					<tr>
						<td class="title" width="150px;">
							功能名称
							<input type="hidden" name="function.functionId" value="" />
						</td>
						<td>

						</td>
					</tr>
					<tr>
						<td class="title" width="150px;">
							功能路径
							
						</td>
						<td>
							<input type="text" name="function.functionUrl" value="" width="120"/>
						</td>
					</tr>
										
					<tr>
						<td class="title" width="150px;">
							功能描述
						</td>
						<td>
							<textarea type="text" name="function.description" value=""  cols="30" rows="5"></textarea>
						</td>
					</tr>
				</tbody>

			</table>
		</form>
	</body>
</html>
