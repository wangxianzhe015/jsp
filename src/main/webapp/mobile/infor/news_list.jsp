<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="资讯中心"></c:set>
	<c:set var="topPage" value="/mobile/main/index.action"></c:set>
	<%@include file="../common/meta.jsp"%>
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
    <div class="content">
    	<div class="container">
    		<ul class="news_list">
	    		<c:forEach items="${newss }" var="news">
	    			<li>
	    				<div class="row">
				    		<div class="col-xs-3">
					            <a href="<%=servletPath%>/mobile/main/detailNews.action?newsId=${news.newsId}" target="_blank">
					    			<img src="${news.newsImage }" class="img-responsive"/>
				    			</a>
				    		</div>
				    		<div class="col-xs-9">
				    			<p>
				    				<a href="<%=servletPath%>/portal/main/detailNews.action?newsId=${news.newsId}" target="_blank">${news.title }</a>
				    			</p>
				    			<span>
									<fmt:formatDate value="${news.newsTime}" pattern="yyyy-MM-dd"/>
								</span>
				    		</div>
				    	</div>
	    			</li>
	   			</c:forEach>
    			<li>
    				<div class="row">
			    		<div class="col-xs-3">
			    			<img src="<%=resourcePathM %>/images/news02.png" class="img-responsive"/>
			    		</div>
			    		<div class="col-xs-9">
			    			<p>姚余东： 股权众筹有望成为“新五板市场”</p>
			    			<span>2015-12-03</span>
			    		</div>
			    	</div>
    			</li>
    		</ul>	    	
	    </div><!-- /.container -->	    
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