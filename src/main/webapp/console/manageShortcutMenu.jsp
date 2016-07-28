<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>主页-设置快捷菜单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/console/selectPermissionTree.js"></script>
	</head>
	<body>
		<form name="shortcutMenuForm" action="" method="post"
			id="shortcutMenuForm" data-olddata="${requestScope.mids }"> 
			<div id="formElArea" style="display: none;"><!-- 存放生成的表单元素 --></div>
		</form>
		<div id="permissionTree" class="tree"></div>
	</body>
</html>
