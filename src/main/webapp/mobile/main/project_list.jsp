<%@page import="com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<title>项目管理</title>
	<%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp" %>
	<c:set var="pageTitle" value="项目管理"></c:set>
	<c:set var="topPage" value="/mobile/main/index.action?menuId=main"></c:set>
    <!-- Bootstrap core CSS -->
    <link href="<%=resourcePathM %>/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/style.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/project/list.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->    
</head>

<body>
<%@include file="../common/header.jsp" %>
    <div class="content mrgt0">    	
    	<div class="top-menu">
    		<ul>
    			<li id="menu1" class="project-category active">
    				<a>全部项目</a>
    			</li>
    			<li id="menu2" class="project-category">
    				<a>众筹中项目</a>
    			</li>
    			<li id="menu3" class="project-category">
    				<a>预热项目</a>
    			</li>
    			<li id="menu4" class="project-category">
    				<a>成功项目</a>
    			</li>
    		</ul>
    	</div>
    	<div class="content">
    	<c:forEach items="${projects }" var="project">
	    	<div class="box ${project.projectState}">
	    		<div class="h2-title"><span>${project.projectName}</span></div>
	    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
	    		<img class="img-responsive box-img" src="${project.projectImage}"/>
	    		<p class="description">${project.projectProfile }</p>
	    		<div class="box-bar-container">
	    			<div class="box-bar">
	    				<div class="inner-box-bar" style="width:${project.progress}%;"></div>
	    			</div>	    			
	    		</div>
	    		<div class="location">
	    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>${project.provinceName}${project.cityName}</span>
	    		</div>
	    		<hr class="divider">
	    		<div class="data">
	    			<div class="row">
		    			<div class="col-xs-3">
		    				<span>项目总额</span>
		    				<span>${project.financeAmount}</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>单笔投资</span>
		    				<span>${project.minInvestAmount}元</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>项目进度</span>
		    				<span>${project.progress}%</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>剩余天数</span>
		    				<span>${project.remainingDays }天</span>
		    			</div>
	    			</div>
	    		</div>
	    		<c:choose>
					<c:when test="${project.projectState=='prepared' }">
		    			<div class="box-mark box-mark-prepare">预热中</div>
		    		</c:when>
					<c:when test="${project.projectState=='successed' }">
			    		<div class="box-mark box-mark-done">已成功</div>	    		
		    		</c:when>
		    		<c:otherwise>
		    			<div class="box-mark box-mark-going">众筹中</div>
		    		</c:otherwise>
	    		</c:choose>
	    	</div>
    	</c:forEach>
	    	<div class="box prepared">
	    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
	    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
	    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box01.jpg"/>
	    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
	    		<div class="box-bar-container">
	    			<div class="box-bar">
	    				<div class="inner-box-bar w100"></div>
	    			</div>	    			
	    		</div>
	    		<div class="location">
	    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
	    		</div>
	    		<hr class="divider">
	    		<div class="data">
	    			<div class="row">
		    			<div class="col-xs-3">
		    				<span>项目总额</span>
		    				<span>100万</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>单笔投资</span>
		    				<span>1000元</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>项目进度</span>
		    				<span>50%</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>剩余天数</span>
		    				<span>2天</span>
		    			</div>
	    			</div>
	    		</div>
	    		<div class="box-mark box-mark-prepare">预热中</div>	    		
	    	</div>

	    	<div class="box successed">
	    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
	    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
	    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box01.jpg"/>
	    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
	    		<div class="box-bar-container">
	    			<div class="box-bar">
	    				<div class="inner-box-bar w100"></div>
	    			</div>	    			
	    		</div>
	    		<div class="location">
	    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
	    		</div>
	    		<hr class="divider">
	    		<div class="data">
	    			<div class="row">
		    			<div class="col-xs-3">
		    				<span>项目总额</span>
		    				<span>100万</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>单笔投资</span>
		    				<span>1000元</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>项目进度</span>
		    				<span>50%</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>剩余天数</span>
		    				<span>2天</span>
		    			</div>
	    			</div>
	    		</div>
	    		<div class="box-mark box-mark-done">已成功</div>	    		
	    	</div>

	    	<div class="box financing">
	    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
	    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
	    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box01.jpg"/>
	    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
	    		<div class="box-bar-container">
	    			<div class="box-bar">
	    				<div class="inner-box-bar w100"></div>
	    			</div>	    			
	    		</div>
	    		<div class="location">
	    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
	    		</div>
	    		<hr class="divider">
	    		<div class="data">
	    			<div class="row">
		    			<div class="col-xs-3">
		    				<span>项目总额</span>
		    				<span>100万</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>单笔投资</span>
		    				<span>1000元</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>项目进度</span>
		    				<span>50%</span>
		    			</div>
		    			<div class="col-xs-3">
		    				<span>剩余天数</span>
		    				<span>2天</span>
		    			</div>
	    			</div>
	    		</div>
	    		<div class="box-mark box-mark-going">众筹中</div>		
	    	</div>

    	</div>
    </div><!-- /.content -->
    <!-- FOOTER -->
	<%@include file="../common/footer.jsp" %>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM%>/js/common/main.js"></script>
    <script src="<%=resourcePathM%>/js/project/list.js"></script>
    
</body>
</html>