<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="联系我们"></c:set>
	<c:set var="topPage" value="/mobile/uc/index.action?menuId=main"></c:set>
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
    <div class="content mrgt0"> 
    	<div class="baidu-map">
    		<img src="<%=resourcePathM %>/images/baidu_map.jpg" class="img-responsive"/>
    	</div>
    	<div class="map-info">
    		<p>客户服务热线：400-079-9617</p>
			<p>客服QQ ：3259349313</p>
			<p>客服微信号：zhongtouke01</p>
			<p>客户在线咨询：周一至周五 9:30—18:00</p>
			<p>客服邮箱： zhongtouke06@163.com</p>
			<p>商务合作邮箱：zhongtoke01@163.com</p>
			<p>媒体合作邮箱：zhongtoke02@163.com</p>
			<p>微信公众号：zhongtouke</p>
			<p>地址：福建省福州市晋安区连江北路东二环泰禾广场  7#1002</p>
			<p>邮编：350000</p>
			<p>公交指引：</p>
			<p>二化[公交车站]： 153路  317路  322路  70路</p>
			<p>保利香槟国际[公交车站]：64路  118路  125路  28路  305路  318路  508路  72路  贵安桂湖旅游专线(华为城乡客运站线) 178路</p>
			<p>岳峰[公交车站]：313路  317路  28路  317支路  68路  322路  70路  46路  153路  178路</p>
    	</div>
    </div>

    <!-- FOOTER -->
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