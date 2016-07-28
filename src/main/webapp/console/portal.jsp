<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>portal</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<link type="text/css" href="<%=contextPath %>/common/skins/css/base.css" rel="stylesheet" />
		<link type="text/css" href="<%=contextPath %>/common/skins/css/portal.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath %>/common/plugins/multiselect/jquery.multiselect.css">
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/store.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/multiselect/src/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/multiselect/i18n/jquery.multiselect.zh-cn.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/userportal/manageUserPortal.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/userportal/initUserPortal.js"></script>
	</head>

	<body>
		<div class="catalog">
			<div class="catalog_head">
				<div class="catalog_bar">
					<div class="bar_left">
						<label>
							布局设置：
						</label>
						<ul id="portal_layout_setting">
							<c:forEach items="${requestScope.dictlist}" var="dict"
								varStatus="index">
								<li>
									<c:choose>
										<c:when test="${dict.inUse}">
											<a href="javascript:void(0);"
												data-val="${dict.dictEntry.dictId }" class="current">${dict.dictEntry.dictName}</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:void(0);"
												data-val="${dict.dictEntry.dictId }">${dict.dictEntry.dictName}</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="bar_right">
						<ul>
							<!-- <li>
								<a href="javascript:void(0);" class="" id="_cache_reload"
									title="从本地缓存重新加载">缓存加载</a>
							</li>-->
							<li>
								<a href="javascript:void(0);" class="" id="_server_reload"
									title="重新读取服务端保存的布局和配置">刷新</a>
							</li> 
							<li>
								<a href="javascript:void(0);" class="" id="_addUserPortal">添加模块</a>
							</li>
							<li>
								<a href="javascript:void(0);" class="" id="_savePortalSettings"
									title="将数据和布局配置上传到服务器">保存配置</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="catalog_content">
			</div>
		</div>
		<div style="display: none;">
			<form action="" method="post" name="upform_temp" id="upform_temp"><!-- 此表单用于存放动态生成的表单元素,action地址不定 --></form>
		</div>
		<!-- 用户portal的添加窗口 -->
		<div id="addUserPortalDialog" style="display: none;">
			<jsp:include page="/console/userportal/addUserPortal.jsp"></jsp:include>
		</div>
		<!-- 用户portal的修改窗口 -->
		<div id="updateUserPortalDialog" style="display: none;">
			<jsp:include page="/console/userportal/updateUserPortal.jsp"></jsp:include>
		</div>
		<!-- <div class="test">111</div> -->
	</body>
</html>
