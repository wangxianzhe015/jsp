<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="资讯"></c:set>
<c:set var="topPage" value="/mobile/main/listNews.action"></c:set>
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
    <div style="margin-top: 40px; width: 100%;margin: 0px auto;">
		<div class="leftGroup" style="background:#FFFFFF; padding:30px; ">
			<h2 style="padding-bottom:20px;">${news.title }</h2>
			<div style="border-top:1px #a9aaab dashed; border-bottom:1px #a9aaab dashed;height:40px;  text-align:right; padding-top:10px;">
				<span style="float:left;">作者：admin</span><span style="float:right;">发布日期：<fmt:formatDate value="${news.newsTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<span class="content" style=" font-size:14px; margin-top:20px;">
			</span>
			<div style="border-bottom:1px #a9aaab dashed; margin-top:20px; text-align: right; padding-bottom:10px;"> 文章来源:众投客</div>
	
		</div>
	</div>
	<!--首页底部-->
	<%@include file="../common/footer.jsp" %>	
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>
</body>
</html>
