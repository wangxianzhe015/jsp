<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp"%>
<html>
	<head>
		<title>用户修改portlet</title>
		<script type="text/javascript" src="<%=contextPath %>/console/userportal/manageUserPortal.js"></script>
	</head>
	<body>
		<form
			action="<%=servletPath %>/console/userportal/updateUserPortal.action" name="updateUserPortalForm" id="updateUserPortalForm" method="post">
			<input type="hidden" name="userPortal.userPortalId" />
			<table class="content">
				<tbody>
					<tr>
						<td class="title" width="100px;">
							标题
						</td>
						<td>
							<input type="text" id="" name="userPortal.portalTitleSelf" />
						</td>
					</tr>
					<tr>
						<td class="title">
							原标题
						</td>
						<td data-po="userPortal.portal.catalogTitle">
							<span></span>
							<input type="hidden" name="userPortal.portal.catalogId" />
						</td>
					</tr>
					<tr>
						<td class="title">
							高度
						</td>
						<td>
							<input type="text" id="" name="userPortal.portalHeight" />
						</td>
					</tr>
				</tbody>
			</table>
			<div id="_wait_add_up_div" style="display: none;"></div>
		</form>

	</body>
</html>
