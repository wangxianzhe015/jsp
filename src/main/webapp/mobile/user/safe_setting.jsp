<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="安全设置"></c:set>
	<c:set var="topPage" value="/mobile/uc/index.action"></c:set>
	<%@include file="../common/meta.jsp" %>
    <!-- Bootstrap core CSS -->
    <link href="<%=resourcePathM %>/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/style.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<%@include file="../common/header.jsp" %>
	<div class="security-items">
	<ul>
		<li class="row">
			<div class="col-xs-8">
				<span>
					登录密码
				</span>
			</div>
			<div class="col-xs-4">
				<a href="<%=servletPath %>/mobile/uc/updatePassword.action">
					<span class="btn btn-custom">
					重置密码
					</span>
				</a>
			</div>
		</li>
		<li class="row">
			<div class="col-xs-8">
				<span>
					实名认证
				</span>
			</div>
			<div class="col-xs-4">
				<span class="btn btn-custom">
					<a href="<%=servletPath %>/mobile/uc/verifyRealName.action">
					立即认证
					</a>
				</span>
			</div>
		</li>
		<li class="row">
			<div class="col-xs-8">
				<span>
					手机认证
				</span>
			</div>
			<div class="col-xs-4">
				<span class="btn confirmed">
					已认证
				</span>
			</div>
		</li>
		<li class="row">
			<div class="col-xs-8">
				<span>
					邮箱验证
				</span>
			</div>
			<div class="col-xs-4">
				<span class="btn btn-custom">
					<a href="<%=servletPath %>/mobile/uc/verifyEmail.action">
					立即认证
					</a>
				</span>
			</div>
		</li>
	</ul>
	</div>
	
	<!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>
	
</body>
</html>
