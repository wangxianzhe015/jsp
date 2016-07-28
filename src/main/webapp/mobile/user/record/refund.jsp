<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<c:set var="pageTitle" value="退款记录"></c:set>
<c:set var="topPage" value="/mobile/uc/accountInfo.action"></c:set>
<%@include file="../../common/meta.jsp" %>
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

<%@include file="../../common/header.jsp" %>
<div>
	<ul class="log-ul">
		<li class="log-header">
		<div class="row">
			<div class="col-xs-5">退款时间</div>
			<div class="col-xs-4">退款金额（元）</div>
			<div class="col-xs-3">订单状态</div>
		</div>
		</li>
		<c:forEach items="${rechargeRecords}" var="record" varStatus="index">
			<li class="log-item">
				<div class="row">
					<div class="col-xs-5">
						<fmt:formatDate value="${record.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
					</div>
					<div class="col-xs-4">${record.amount }</div>
					<div class="col-xs-3">${record.errorCode }</div>
				</div>
			</li>
		</c:forEach>
		<li class="log-item">
		<div class="row">
			<div class="col-xs-5">2015-12-07  14:49:12</div>
			<div class="col-xs-4">3000</div>
			<div class="col-xs-3">退款成功</div>
		</div>
		</li>
		<li class="log-item">
		<div class="row">
			<div class="col-xs-5">2015-12-07  14:49:12</div>
			<div class="col-xs-4">2000</div>
			<div class="col-xs-3">退款成功</div>
		</div>
		</li>
	</ul>
</div>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

</body>
</html>
