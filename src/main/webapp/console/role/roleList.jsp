<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>角色管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>

		<script type="text/javascript">
	(function($){
		$( function() {
			$("[id='_GridQueryBtn']").click( function() {

				$(this).parents("form").submit();
			});

			$("[id='_GridAddBtn']").click( function() {
				var action = $(this).data("url");
				$("#operate_form").attr("action", action).submit();

			});
			$("[id='_GridUpdateBtn']").click( function() {
				//检测有没有选择员工
					var org_checked = $("[name='role.roleId']:checked");
					if (org_checked.length > 1) {
						$.prompt("只能选择一种角色!")
					} else if (org_checked.length == 0) {
						$.prompt("请选择一种角色!")

					} else {
						var action = $(this).data("url");

						$("#operate_form").attr("action", action).submit();
					}

				});

			$("[id='_GridDeleteBtn']").click( function() {
				var delBtn = $(this);
				var org_checked = $("[name='role.roleId']:checked");
				if (org_checked.length <= 0) {
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
								$("#operate_form").attr("action", action).submit();
							}
						}
					});

				}

			});
		});
		})(jQuery)
</script>

	</head>

	<body>

		<div class="grid">
			<div class="grid_body">
				<form
					action="<%=servletPath %>/console/role/index.action"
					method="post" name="query_form">
					<table>
						<thead>
							<tr>
								<th colspan="2" align="left">
									输入查询条件:
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									角色名称:
								</td>
								<td>
									<input type="text" value="${role.roleName}"
										name="role.roleName" />
								</td>
								<!-- 
								<td>
									角色状态:
								</td>
								<td>
									<input type="text" value="${role.orgName}" name="role.orgName" />
								</td> -->
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<a class="sub" href="javascript:void(0);" id="_GridQueryBtn">查询</a>

								</td>
							</tr>

						</tfoot>
					</table>
				</form>
			</div>
			<form method="post" name="operate_form" id="operate_form">


				<div class="grid_head">
					<div class="head_left">
						所有角色信息:
					</div>

					<div class="head_right">

						<a href="javascript:void(0);" id="_GridAddBtn"
							data-url="<%=servletPath %>/console/role/entryAdd.action">新增</a><a
							href="javascript:void(0);" id="_GridUpdateBtn"
							data-url="<%=servletPath %>/console/role/entryUpdate.action">修改</a><a
							href="javascript:void(0);" id="_GridDeleteBtn"
							data-url="<%=servletPath %>/console/role/delete.action">删除</a>
					</div>
				</div>

				<input type="hidden" name="hasSelected" />
				<div class="grid_body">

					<table id="cosplanTable">
						<thead>
							<tr>
								<th width="50px;">
									<input type="checkbox" name="checkAll" id="checkAll"
										title="select all" />
								</th>


								<!-- <th class="cosplan"> -->
								<th>
									角色名称
								</th>
								<th class="">
									说明
								</th>
								<th>
									状态
								</th>
								<th>
									创建人
								</th>
								

								<!-- <th width="150px;">
									操作
								</th> -->
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.rlist}" var="role"
								varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="role.roleId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${role.roleId}" />

									</td>


									<td width="150px;">
										<c:out value="${role.roleName}"></c:out>
									</td>
									<td>
										<c:out value="${role.roleMemo}"></c:out>
									</td>
									<td width="100px;">
										<c:choose>
											<c:when test="${role.roleState=='1'}">
												<!-- 已启用 -->
											</c:when>
											<c:otherwise>
												<c:out value="已关闭"></c:out>
											</c:otherwise>
										</c:choose>

									</td>
									<td width="150px;">
										<c:out value="${role.userName}"></c:out>
									</td>
									

									<!-- <td width="150px;">
										<a href="javascript:void(0);" class="button">所属机构</a>
										<a href="javascript:void(0);" class="button">查看权限</a>
									</td> -->
								</tr>
							</c:forEach>
						</tbody>
						<tfoot></tfoot>
					</table>

				</div>
			</form>

			<form
				action="<%=servletPath %>/console/role/pageQuery.action"
				method="post" name="page_form" id="page_form">
				<input type="hidden" value="${role.roleName}" name="role.roleName" />
				<input type="hidden" value="${role.orgName}" name="role.orgName" />
				<div class="grid_foot">
					<div class="foot_left">
						当前第
						<c:out value="${page.currentPage}"></c:out>
						页/共
						<c:out value="${page.totalPage}"></c:out>
						页, 每页显示
						<c:out value="${page.pageSize}"></c:out>
						条记录/共
						<c:out value="${page.totalCount}"></c:out>
						条,跳转到
						<select class="gotoPage"
							data-formAction="<%=servletPath %>/console/role/pageQuery.action"
							data-formId="page_form">
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
								<a href="javascript:firstPage();">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:prevPage();">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:nextPage();">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:lastPage();">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>