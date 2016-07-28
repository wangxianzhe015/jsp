<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/common/header.jsp"%>
<html>
	<head>
	    <base href="<%=basePath%>">
		<title>权限系统首页</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link type="text/css" href="<%=contextPath %>/common/skins/css/base.css" rel="stylesheet" />
		<link type="text/css" href="<%=contextPath %>/common/skins/css/style.css" rel="stylesheet" />
		<link rel="stylesheet" type="text/css" href="<%=contextPath %>/common/plugins/jqueryUI_bootstrapTheme/css/custom-theme/jquery-ui-1.8.16.custom.css" />
		
	</head>
	<body>
		<div id="wrapper">
			<div id="sidebar" class="sidebar">
				<h1>
					<span></span>
				</h1>
				<div class="userinfo mb10">
					<dl>
						<dt>
							<a href="javascript:void(0);"><img
									src="<%=contextPath%>/common/skins/images/user-icon.png" width="55" height="55"
									alt="${userInfo.nickName }" /> </a>
						</dt>
						<dd>
							<b>普通管理员</b>
							<br />
							<a href="javascript:void(0);">${userInfo.nickName }</a>
							<br />
							<span><a href="javascript:void(0);" title="设置快捷菜单"
								id="shortcutMenuSetting" data-method="multiNoChild"
								data-switch="close" data-user="${userInfo.nickName }" data-userid="${userInfo.userId}">设置</a> | <a href="javascript:void(0);" id="logout">退出</a> </span>
						</dd>
					</dl>
				</div>
				<div id="fMenu" class="fmenu fradius">
					<b class="b1"></b>
					<b class="b2"></b>
					<div class="fmain">
					</div>
					<b class="b3"></b>
					<b class="b4"></b>
				</div>
			</div>
			<div id="main" class="main">
				<div class="top">
					<a class="home" href="javascript:void(0);" data-url="<%=servletPath %>/console/login/index.action" data-title="当前位置:首页"></a>
					<div id="tMenu" class="tmenu">
					<!-- 快捷菜单 -->
					</div>
					<div class="rightbar">
						<a class="message" href="javascript:void(0);">消息<i>5</i> </a>
						<span class="skinbar"> 
							<a href="#1"></a> <a href="#2"></a>
							<a href="#3"></a> <a href="#4"></a> 
						</span>
					</div>
				</div>
				<div class="submain">
					<h3 class="title">
						<span id="currentLocation">当前位置:首页</span>
						<b></b>
					</h3>
					<div class="iframe_wrap">
						<div class="iframe_top"></div>
						<div class="iframe_box">
							<iframe frameborder="0"
								src="" name="contentIframe" id="contentIframe"></iframe>
						</div>
						<div class="iframe_bottom"></div>
					</div>
				</div>
				<div class="bottom">
					<i></i><span></span><b></b>
				</div>
			</div>
			<div id="foot"></div>
		</div>
		<!-- 快捷菜单设置窗口 -->
		<div id="shortcutDialog" class="dialogContainner">
			<div class="dialogExtra">
			</div>
			<div
				style="height: 5%; width100 %; border-bottom: 1px solid #ccc; min-height: 20px; max-height: 20px;"><form name="justForValidate" id="justForValidate" method="post" action="" style="display: none;">
				[
				<a href="javascript:void(0);" title="显示功能functions" id="funcSwitchOpen" class="funcSwitch">开</a>/
				<a href="javascript:void(0);" title="不显示functions功能，只显示模块" id="funcSwitchClose" class="funcSwitch">关</a>]权限树<span id="permissionTreeSelectInfo">[已选快捷菜单占<font color="red">0</font>栏位]</span>
					<input type="hidden" name="shortcutmenuError" id="shortcutmenuError" value="0"/>
			</form></div>
			<div class="dialogContent" style="height: 95%; width: 100%;"></div>
		</div>
	
		<!-- 加载js -->
		<script type="text/javascript" src="<%=request.getContextPath() %>/common/javascripts/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/common/plugins/jquery.cookies.2.2.0.js"></script>
		<!-- 设置皮肤 -->
		<script type="text/javascript" src="<%=request.getContextPath() %>/common/javascripts/skinsetting.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/common/plugins/foldmenu.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/console/initIndexMenus.js"></script>
		<!-- jqueryUI -->
		<script type="text/javascript" src="<%=request.getContextPath() %>/common/plugins/jqueryUI/js/jquery-ui-1.8.23.js" ></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/console/shortcutMenuSetting.js"></script>
		
		<!-- 引入jauqey.Validate支持 -->
		<script src="<%=request.getContextPath() %>/common/plugins/jquery.validate/jquery.validate.js"></script>
		<script src="<%=request.getContextPath() %>/common/plugins/jquery.validate/messages_cn.js"></script>
		<script src="<%=request.getContextPath() %>/common/plugins/jquery.validate/jquery.metadata.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/common/plugins/jquery.validate/jquery.validateSelf.css">
	</body>
</html>
