<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>职员管理</title>
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
			$("[id='_GridUpdateBtn']")
					.click( function() {
						//检测有没有选择员工
							var employeeId_checked = $("[name='employee.employeeId']:checked");
							if (employeeId_checked.length > 1) {
								$.prompt("只能选择一位职员!");
								//art.alert("只能选择一位职员!");
							} else if (employeeId_checked.length == 0) {
								$.prompt("请选择一位职员!")

							} else {
								var action = $(this).data("url");

								$("#operate_form").attr("action", action).submit();
							}

						});

			$("[id='_GridDeleteBtn']")
					.click( function() {
						var delBtn=$(this);
						//原先ajax检测有没有选择员工
							/*var hasSelected = $("[name='hasSelected']").val();
								if (hasSelected) {
									var action = $(this).data("url");
									$("#operate_form").attr("action", action).submit();

								} else {
									alert('尚未选择');
								}*/
							var employeeId_checked = $("[name='employee.employeeId']:checked");
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
											var action =delBtn.data("url");
											$("#operate_form").attr("action",action).submit();
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
					action="<%=servletPath %>/console/employee/index.action"
					method="post" name="query_form">
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
									姓名:
								</td>
								<td>
									<input type="text" value="${employee.employeeName}"
										name="employee.employeeName" />
								</td>
								<td>
									部门:
								</td>
								<td>
									<input type="text" value="${employee.org.orgName}"
										name="employee.org.orgName" />

								</td>
							</tr>


						</tbody>
						<tfoot>
							<tr>
								<td colspan="4">
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
						所有职员信息:
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="_GridAddBtn"
							data-url="<%=servletPath %>/console/employee/entryAdd.action">新增</a><a
							href="javascript:void(0);" id="_GridUpdateBtn"
							data-url="<%=servletPath %>/console/employee/entryUpdate.action">修改</a><a
							href="javascript:void(0);" id="_GridDeleteBtn"
							data-url="<%=servletPath %>/console/employee/delete.action">删除</a>
					</div>
				</div>

				<input type="hidden" name="hasSelected" />
				<div class="grid_body">

					<table>
						<thead>
							<tr>
								<th width="50px;">
									<input type="checkbox" name="checkAll" id="checkAll"
										title="select all" />
								</th>
								
								<th>
									姓名
								</th>
								<th>
									部门
								</th>
								<th>
									电话
								</th>
								<th>
									手机
								</th>
								<th>
									邮箱
								</th>

							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.elist}" var="emp"
								varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="employee.employeeId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${emp.employeeId}" />

									</td>
								<td>
										<c:out value="${emp.employeeName}"></c:out>
									</td>
									<td>
										<c:out value="${emp.org.orgName}"></c:out>
									</td>
									<td>
										<c:out value="${emp.telephoneNo}"></c:out>
									</td>
									<td>
										<c:out value="${emp.mobileNo}"></c:out>
									</td>
									<td>
										<c:out value="${emp.email}"></c:out>
									</td>
									
								</tr>
							</c:forEach>
						</tbody>
						<tfoot></tfoot>
					</table>

				</div>
			</form>

			<form
				action="<%=servletPath %>/console/employee/pageQuery.action"
				method="post" name="page_form" id="page_form">
				<input type="hidden" value="${employee.employeeName}"
					name="employee.employeeName" />
				<input type="hidden" value="${employee.org.orgName}"
					name="employee.org.orgName" />
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
							data-formAction="<%=servletPath %>/console/employee/pageQuery.action"
							data-formId="page_form">

						</select>
						页
					</div>
					<div class="foot_right">

						<input type="hidden" name="page.pageSize"
							value="${page.pageSize }"/>
						<input type="hidden" name="page.count" value="${page.count }"/>
						<input type="hidden" name="page.currentPage"
							value="${page.currentPage }" />
						<input type="hidden" name="page.beginPage"
							value="${page.beginPage }"/>
						<input type="hidden" name="page.totalCount"
							value="${page.totalCount }"/>
						<input type="hidden" name="page.totalPage"
							value="${page.totalPage}"/>

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
								<a
									href="javascript:prevPage();">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage();">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage();">末页</a>
							</c:otherwise>
						</c:choose>




					</div>
				</div>
			</form>

		</div>

	</body>
</html>
