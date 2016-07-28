<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=contextPath%>/common/javascripts/page.js"></script>
<form action="<%=servletPath%>${pageAction}" method="post" name="page_form" id="page_form">
	<input type="hidden" name="project.projectState" value="${projectState}" /> 
	<input type="hidden" name="flag" value="${flag}" /> 
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
					<a href="javascript:firstPage('<%=servletPath %>${pageAction}', null, null);">首页</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${page.first==true}">
					<a href="javascript:void(0);">上一页</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:prevPage('<%=servletPath %>${pageAction}', null, 'page_form');">上一页</a>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${page.last==true}">
					<a href="javascript:void(0);">下一页</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:nextPage('<%=servletPath %>${pageAction}', null, 'page_form');">下一页</a>
				</c:otherwise>
			</c:choose>

			<c:choose>
				<c:when test="${page.last==true}">
					<a href="javascript:void(0);">末页</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:lastPage('<%=servletPath %>${pageAction}', null, 'page_form');">末页</a>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</form>
