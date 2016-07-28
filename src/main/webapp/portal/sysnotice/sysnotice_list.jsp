<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>系统公告</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
		<script>
(function($){
	$( function() {
		$("#addBtn").click( function() {
			var action = $(this).data("url");
			$("#page_form").attr("action", action);
			$("#page_form").submit();
		})

		$("#updateBtn").click( function() {
			//检测有没有选择员工
				var projectId_checked = $("[name='notice.noticeId']:checked");
				if (projectId_checked.length > 1) {
					$.prompt("只能选择一个公告!")
				} else if (projectId_checked.length == 0) {
					$.prompt("请选择一个公告!")

				} else {
					var action = $(this).data("url");
					
					$("#result_form").attr("action", action).submit();
				}

			})
		$("#deleteBtn").click( function() {
			var delBtn = $(this);

			var employeeId_checked = $("[name='notice.noticeId']:checked");
			if (employeeId_checked.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('确定删除选中的公告?', {
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
						项目公告列表
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="addBtn"
							data-url="<%=servletPath %>/portal/sysnotice/entryAdd.action">新增公告</a>
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/portal/sysnotice/entryUpdate.action">编辑公告</a>
						<a href="javascript:void(0);" id="deleteBtn"
							data-url="<%=servletPath %>/portal/sysnotice/remove.action">删除公告</a>
							
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
									公告标题
								</th>
								<th>
									公告时间
								</th> 
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${notices}" var="notice" varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="notice.noticeId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${notice.noticeId}" />

									</td>
									<td>
										<c:out value="${notice.title}"></c:out>
									</td>
									<td>
									   
										<fmt:formatDate value="${notice.noticeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>																	
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/portal/sysnotice/index.action" method="post" name="page_form" id="page_form">
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
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/sysnotice/index.action" data-formId="page_form">

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
									href="javascript:firstPage('<%=servletPath %>/portal/sysnotice/index.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/portal/sysnotice/index.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/portal/sysnotice/index.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/portal/sysnotice/index.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

	</body>
</html>
