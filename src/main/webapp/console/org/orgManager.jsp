<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>机构管理</title>

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

			$("[id='_allotPermissionToOrg']").on("click", function(event) {
				var action = $(this).data("url");
				$("#operate_form").attr("action", action).submit();
			});

			$("[id='_GridAddBtn']").click( function() {
				var action = $(this).data("url");
				$("#operate_form").attr("action", action).submit();

			});
			$("[id='_GridUpdateBtn']").click( function() {
				//检测有没有选择员工
					var org_checked = $("[name='org.orgId']:checked");
					if (org_checked.length > 1) {
						$.prompt("只能选择一个机构!")
					} else if (org_checked.length == 0) {
						$.prompt("请选择一个机构!")

					} else {
						var action = $(this).data("url");

						$("#operate_form").attr("action", action).submit();
					}

				});

			$("[id='_GridDeleteBtn']").click( function() {
				var delBtn = $(this);
				var org_checked = $("[name='org.orgId']:checked");
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
					action="<%=servletPath %>/console/org/index.action"
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
									机构名称:
								</td>
								<td>
									<input type="text" value="${org.orgName}" name="org.orgName" />
								</td>
								<td>
									机构负责人:
								</td>
								<td>
									<input type="text" value="${org.orgManager}"
										name="org.orgManager" />
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
						机构信息:
					</div>
					<div class="head_right">
						<a href="javascript:void(0);" id="_allotPermissionToOrg"
							data-url="<%=servletPath %>/console/permission/entryAPToOrg.action"><label
								title="分配角色给机构">
								配置角色
							</label> </a>
						<a href="javascript:void(0);" id="_GridAddBtn"
							data-url="<%=servletPath %>/console/org/entryAdd.action">新增</a><a
							href="javascript:void(0);" id="_GridUpdateBtn"
							data-url="<%=servletPath %>/console/org/entryUpdate.action">修改</a><a
							href="javascript:void(0);" id="_GridDeleteBtn"
							data-url="<%=servletPath %>/console/org/deleteOrg.action">删除</a>
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
								<th nowrap="nowrap">
									机构编码
								</th>
								<th nowrap="nowrap">
									机构名称
								</th>
								<th class="cosplan" nowrap="nowrap">
									上级机构
								</th>
								<th nowrap="nowrap">
									机构负责人
								</th>
								<!-- <th nowrap="nowrap">
									机构角色
								</th> -->
								<th nowrap="nowrap">
									备注
								</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.olist}" var="org"
								varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="org.orgId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${org.orgId}" />
									</td>
									<td>
										${org.orgId}
									</td>
									<td>
										${org.orgName}
									</td>
									<td>
										${org.parentOrgName}
									</td>
									<td>
										${org.orgManagerName}
									</td>
									<td>
										${org.orgDesc }
									</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot></tfoot>
					</table>
				</div>
			</form>
			<form
				action="<%=servletPath %>/console/org/pageQuery.action"
				method="post" name="page_form" id="page_form">
				<input type="hidden" value="${org.orgName}" name="org.orgName" />
				<input type="hidden" value="${org.orgManager}" name="org.orgManager" />
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
							data-formAction="<%=servletPath %>/console/org/pageQuery.action"
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