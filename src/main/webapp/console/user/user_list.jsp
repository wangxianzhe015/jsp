<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>用户管理</title>
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
		$("[id='_allotPermissionToUser']").on("click", function() {
			var action = $(this).data("url");

			$("#result_form").attr("action", action).submit();
		})
		$("#addBtn").click( function() {
			$("#page_form").attr("action", servletPath+"/console/user/entryAdd.action");
			$("#page_form").submit();
		})

		$("#updateBtn").click( function() {
			//检测有没有选择员工
				var employeeId_checked = $("[name='user.userId']:checked");
				if (employeeId_checked.length > 1) {
					$.prompt("只能选择一位职员!")
				} else if (employeeId_checked.length == 0) {
					$.prompt("请选择一位职员!")

				} else {
					var action = $(this).data("url");

					$("#result_form").attr("action", action).submit();
				}

			})
		$("#deleteBtn").click( function() {
			var delBtn = $(this);

			var employeeId_checked = $("[name='user.userId']:checked");
			if (employeeId_checked.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('确定删除?', {
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
		
		$("#computeBtn").click( function() {
			var employeeId_checked = $("[name='user.userId']:checked");
			if (employeeId_checked.length <= 0) {
				$.prompt('请选择用户!');
			} else {
				var action = $(this).data("url");
				$("#result_form").attr("action", action).submit();
			}
		})		
	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="<%=servletPath %>/console/user/index.action" method="post" name="query_form" id="query_form">
				<div class="grid_body">
					<table>
						<thead>
							<tr>
								<th colspan="4" align="left">
									输入查询条件:
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									用户名:
								</td>
								<td>
									<input type="text" name="user.userName" value="" />
								</td>
								<td>
									用户昵称:
								</td>
								<td>
									<input type="text" name="user.nickName" value="" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="4">
									<a id="queryBtn" class="sub" href="javascript:void(0);">查询</a>

								</td>
							</tr>

						</tfoot>
					</table>
				</div>

			</form>
			<form action="" method="post" name="result_form" id="result_form">
				<div class="grid_head">
					<div class="head_left">
						用户列表
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="_allotPermissionToUser"
							data-url="<%=servletPath %>/console/permission/entryAPToUser.action"><label
								title="分配角色给用户">
								分配角色
							</label> </a>
						<a href="javascript:void(0);" id="addBtn"
							data-url="<%=servletPath %>/console/user/entryAdd.action">新增</a>
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/console/user/entryUpdate.action">修改</a>
						<a href="javascript:void(0);" id="deleteBtn"
							data-url="<%=servletPath %>/console/user/deleteUser.action">删除</a>
							
						<a href="javascript:void(0);" id="computeBtn"
							data-url="<%=servletPath %>/console/function/showPermissionGraphic.action">计算用户权限</a>	
					</div>
				</div>
				<input type="hidden" name="hasSelected" value="" />
				<div class="grid_body">

					<table>
						<thead>
							<tr>
								<th width="50px;">
									<input type="checkbox" name="checkAll" id="checkAll"
										title="select all" />
								</th>
								<th>
									用户名称
								</th>
								<th>
									用户昵称
								</th>
								<!-- <th>
									用户角色
								</th> -->

								<th>
									所属部门
								</th>
								<th>
									是否有效
								</th>

							</tr>
						</thead>

						<tbody>
							<c:forEach items="${users}" var="user" varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="user.userId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${user.userId}" />

									</td>
									<td>
										<c:out value="${user.userName}"></c:out>
									</td>
									<td>
										<c:out value="${user.nickName}"></c:out>
									</td>
									<!-- <td>
										<c:out value="用户角色"></c:out>
									</td> -->

									<td>
										<c:out value="${user.org.orgName}"></c:out>
									</td>
									<td>
									<c:choose>
										<c:when test="${user.valid.value=='1'}">
											<c:out value="启用"></c:out>
										</c:when>
										<c:otherwise>
											关闭
										</c:otherwise>
									</c:choose>
										
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/console/user/pageQuery.action" method="post" name="page_form" id="page_form">
				<input type="hidden" value="${user.userName}" />
				<input type="hidden" value="${user.nickName}" />
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
						<select class="gotoPage" data-formAction="<%=servletPath %>/console/user/pageQuery.action" data-formId="page_form">

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
									href="javascript:firstPage('<%=servletPath %>/console/user/pageQuery.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/console/user/pageQuery.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/console/user/pageQuery.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/console/user/pageQuery.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

	</body>
</html>
