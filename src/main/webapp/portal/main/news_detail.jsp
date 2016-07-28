<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="新闻资讯"></c:set>
<%@include file="../common/meta.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/subscribe.css?" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
<style>
  h2{ font-size: 30px;font-weight: 500;}
  .content{ text-align: left; line-height: 2.2;}
  .leftGroup { width: 100%;}
</style>
</head>
<body>

	<%@include file="../common/header.jsp" %>
    <div style="margin-top: 40px; width: 1140px;margin: 0px auto;text-align: center;">
		<div class="leftGroup" style="background:#FFFFFF; padding:30px; ">
			<h2 style="padding-bottom:20px;">${news.title }</h2>
			<div style="border-top:1px #a9aaab dashed; border-bottom:1px #a9aaab dashed;height:40px;  text-align:right; padding-top:10px;">
				<span style="float:left;">作者：admin</span><span style="float:right;">发布日期：<fmt:formatDate value="${news.newsTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</div>
			<div class="content" style=" font-size:14px; margin-top:20px;">
				${news.contentHtml }
			</div>
			<div style="border-bottom:1px #a9aaab dashed; margin-top:20px; text-align: right; padding-bottom:10px;"> 文章来源:众投客</div>
	
		</div>
	</div>
	<!--首页底部-->
	<%@include file="../common/footer.jsp" %>	
</body>
</html>
