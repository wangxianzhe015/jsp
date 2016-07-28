<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp"%>
<html>
	<head>
		<title>用户新增portlet</title>
		<script type="text/javascript" src="<%=contextPath%>/console/userportal/manageUserPortal.js"></script>
	</head>
	<body>
		<form action="<%=servletPath %>/console/userportal/addUserPortal.action" name="addUserPortalForm" id="addUserPortalForm" method="post">
			<input type="hidden" value="" name="userPortal.portalLayout" />
			<table class="content">
				<tbody>
					<tr>
						<td width="100px;" class="title">
							选择portlet
						</td>
						<td>
							<select name="userPortal.portal.catalogId" multiple="multiple" ></select>
						</td>
					</tr>
					<tr>
						<td class="title">
							自定义标题
						</td>
						<td>
							<input type="text" value="" name="userPortal.portalTitleSelf" />
						</td>
					</tr>
					<tr>
						<td class="title">
							显示在列(X)
						</td>
						<td>
							<div id="portalLayoutSelect">
							</div>
						</td>

					</tr>
					<tr>
						<td class="title">
							显示在行(Y)
						</td>
						<td>
							<input type="text" value="" name="userPortal.portalY" />
						</td>

					</tr>
					<tr>
						<td class="title">
							给定高度
						</td>
						<td>
							<input type="text" value="" name="userPortal.portalHeight" />
						</td>

					</tr>

				</tbody>

			</table>
		</form>

	</body>
</html>
