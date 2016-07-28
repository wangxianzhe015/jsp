<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<%@page import="com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>广告横幅</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
		<script>
(function($){
	$( function() {
		$("#queryBtn").click( function() {
			$("#query_form").submit();
		});

		$("#addBtn").click( function() {
			var action = $(this).data("url");
			$("#page_form").attr("action", action);
			$("#page_form").submit();
		})

		$("#updateBtn").click( function() {
			//检测有没有选择员工
				var projectId_checked = $("[name='banner.bannerId']:checked");
				if (projectId_checked.length > 1) {
					$.prompt("只能选择一个项目!")
				} else if (projectId_checked.length == 0) {
					$.prompt("请选择一个项目!")

				} else {
					var action = $(this).data("url");
					
					$("#result_form").attr("action", action).submit();
				}

			})
		$("#deleteBtn").click( function() {
			var delBtn = $(this);

			var employeeId_checked = $("[name='banner.bannerId']:checked");
			if (employeeId_checked.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('确定删除选中的项目?', {
					buttons : {
						"确定" : true,
						"取消" : false
					},
					focus : 1,
					submit : function(v) {
						if (v) {
							var action = delBtn.data("url");
							$("#result_form").attr("action", action).submit();
						}
					}
				});

			}
		})	
	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="" method="post" name="result_form" id="result_form">
				<div class="grid_head">
					<div class="head_left">
						广告横幅列表
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="addBtn"
							data-url="<%=servletPath %>/portal/banner/entryAdd.action">新增横幅</a>
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/portal/banner/entryUpdate.action">编辑横幅</a>
						<a href="javascript:void(0);" id="deleteBtn"
							data-url="<%=servletPath %>/portal/banner/remove.action">删除横幅</a>
							
					</div>
				</div>
				<input type="hidden" name="hasSelected" value="" />
				<div class="grid_body">

					<table>
						<thead>
							<tr>
								<th width="50px;">
									<input type="checkbox" name="checkAll" id="checkAll" title="select all" />
								</th>
								<th>
									标题
								</th>
								<th>
									顺序
								</th>
								<th>
									链接地址
								</th> 
								<th>
									查看
								</th> 
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${banners}" var="banner" varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="banner.bannerId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${banner.bannerId}" />

									</td>
									<td>
										<c:out value="${banner.title}"></c:out>
									</td>
									<td>
										<c:out value="${banner.orderNo}"></c:out>
									</td>
									<td>
									   
										<c:out value="${banner.href }"></c:out>
									</td>
									<td>
										<a href="<c:out value='${banner.image }'/>"	target="_blank">查看</a>
									</td>									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/portal/banner/index.action" method="post" name="page_form" id="page_form">
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
						条,跳转到
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/banner/index.action" data-formId="page_form">

						</select>
						页
					</div>
					<div class="foot_right">
						<input type="hidden" name="page.pageSize"
							value="${page.pageSize }">
						<input type="hidden" name="page.count" value="${page.count }">
						<input type="hidden" name="page.currentPage"
							value="${page.currentPage }" />
						<input type="hidden" name="page.beginPage"
							value="${page.beginPage }">
						<input type="hidden" name="page.totalCount"
							value="${page.totalCount }">
						<input type="hidden" name="page.totalPage"
							value="${page.totalPage}">
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">首页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:firstPage('<%=servletPath %>/portal/banner/index.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/portal/banner/index.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/portal/banner/index.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/portal/banner/index.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

	</body>
</html>
