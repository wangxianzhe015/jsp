<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>审核意见</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form action="<%=servletPath %>/console/function/addFuncs.action" method="post" name="addFuncsForm">
			<!-- ajax获得action中的方法 -->
			<input type="hidden" name="hasSelectedResc" value="绑定已选则的资源">
			<input type="hidden" name="moduleId" value="" />
			<input type="hidden" name="modulePath" value="" />
			<div id="hiddenArea" style="display: none;"></div>
			<table class="content">
				<thead>
					<tr>
						<th width="50px" align="center">
							<input type="checkbox" name="checkAll" id="checkAllMethods"
								title="select all" />
						</th>

						<th>
							<label title="功能名称">
								功能名称
							</label>
						</th>
						<th class="">
							<label title="功能路径">
								功能路径
							</label>
						</th>						
						<th class="">
							<label title="功能描述">
								功能描述
							</label>
						</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" align="left"">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</body>
</html>
