<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="资讯中心"></c:set>
	<%@include file="../common/meta.jsp"%>
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/infocenter.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/jquery.slideBox.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/odometer-theme-car.css" />

	
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.slideBox.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/odometer.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.SuperSlide.2.1.1.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/index.js"></script>	

	<script>
	$(document).ready(function(){

	});
		
	</script>
  </head>
  
<body>
<%@include file="../common/header.jsp" %>
<div class="layout help_box">
    <div class="help_menu_box">
    <div class="help_menu_head"><img src="<%=resourcePath %>/images/help_bj.png" width="190" height="58"></div>
    <ul class="help_menu">
        <li id="tariff" class="current"><a href="<%=servletPath%>/portal/main/listNotices.action">平台公告</a></li>
        <li id="service"><a href="<%=servletPath%>/portal/main/listNews.action">行业新闻</a></li>

    </ul>
</div>
<script>
    $('#tariff').addClass('current');
    $(function(){
       $('body').css('background-color','#FFF');
    });
</script>
        <div class="help_cont_box">
            <div class="help_cont_titl"><h3>平台公告</h3></div>
            <div class="notice_cont">
				<ul>
				   <c:forEach var="notice" items="${notices }">
					<li><a href="<%=servletPath %>/portal/main/detailSysNotice.action?noticeId=${notice.noticeId}" title="${notice.title }" target="_blank">${notice.title }</a><span><fmt:formatDate value="${notice.noticeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></li>
				 </c:forEach>
						
				</ul>
			<div class="pagination-wrap">
			<script type="text/javascript" src="<%=contextPath%>/common/javascripts/page.js"></script>
			<form action="<%=servletPath%>/portal/main/listNotices.action" method="post" name="page_form" id="page_form">
				<div class="grid_foot">
					<div class="foot_left">
						当前第
						<c:out value="${page.currentPage}"></c:out>
						页/共
						<c:out value="${page.totalPage}"></c:out>
						, 每页显示
						<c:out value="${page.pageSize}"></c:out>
						条记录/共
						<c:out value="${page.totalCount}"></c:out>
						条
					</div>
					<div class="foot_right">
						<input type="hidden" name="page.pageSize" value="${page.pageSize }">
						<input type="hidden" name="page.count" value="${page.count }">
						<input type="hidden" name="page.currentPage" value="${page.currentPage }" /> 
						<input type="hidden" name="page.beginPage" value="${page.beginPage }"> 
						<input type="hidden" name="page.totalCount" value="${page.totalCount }">
						<input type="hidden" name="page.totalPage" value="${page.totalPage}">
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">首页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:firstPage('<%=servletPath %>/portal/main/listNotices.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:prevPage('<%=servletPath %>/portal/main/listNotices.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:nextPage('<%=servletPath %>/portal/main/listNotices.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>
			
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:lastPage('<%=servletPath %>/portal/main/listNotices.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

			        </div>				
			</div>
        </div>
</div>

<%@include file="../common/footer.jsp" %>
</body>
    
</html>
