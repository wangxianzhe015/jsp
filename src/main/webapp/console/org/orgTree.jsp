<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>机构树</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/dynaTreeDiyOptions.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/org/selectOrgTree.js"></script>
	</head>

	<body>

		
			<div id="orgTree"  class="tree"></div>
		
	</body>
</html>
