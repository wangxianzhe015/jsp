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

		$("#addBtn").click( function() {
			$("#page_form").attr("action", servletPath+"/portal/usermgr/entryAdd.action");
			$("#page_form").submit();
		})

		$("#updateBtn").click( function() {
			//检测有没有选择员工
				var employeeId_checked = $("[name='user.userId']:checked");
				if (employeeId_checked.length > 1) {
					$.prompt("只能选择一位用户!")
				} else if (employeeId_checked.length == 0) {
					$.prompt("请选择一位用户!")

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
			
	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="<%=servletPath %>/portal/usermgr/index.action" method="post" name="query_form" id="query_form">
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
									手机号码:
								</td>
								<td>
									<input type="text" name="user.mobileNo" value="" />
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
						<a href="javascript:void(0);" id="addBtn"
							data-url="<%=servletPath %>/portal/usermgr/entryAdd.action">新增</a>
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/portal/usermgr/entryUpdate.action">修改</a>
						<a href="javascript:void(0);" id="deleteBtn"
							data-url="<%=servletPath %>/portal/usermgr/deleteUser.action">删除</a>
							
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
									手机号码
								</th>
								<th>
									邮箱地址
								</th>
								<th>
									真实姓名
								</th>
								<th>
									身份证号码
								</th>
								<th>
									注册时间
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
										<c:out value="${user.mobileNo}"></c:out>
									</td>
									<td>
										<c:out value="${user.email }"></c:out>
									</td>
									<td>
										<c:out value="${user.realName}"></c:out>
									</td>
									<td>
										<c:out value="${user.identityCard}"></c:out>
									</td>
									<td>
										<c:out value="${user.createTime}"></c:out>
									</td>									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/portal/usermgr/pageQuery.action" method="post" name="page_form" id="page_form">
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
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/usermgr/pageQuery.action" data-formId="page_form">

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
								<a href="javascript:firstPage('<%=servletPath %>/portal/usermgr/pageQuery.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:prevPage('<%=servletPath %>/portal/usermgr/pageQuery.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:nextPage('<%=servletPath %>/portal/usermgr/pageQuery.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:lastPage('<%=servletPath %>/portal/usermgr/pageQuery.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

	</body>
</html>
