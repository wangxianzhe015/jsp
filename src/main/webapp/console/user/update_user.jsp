<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改用户</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script>
	( function($) {
		$( function() {
			var validateFormRule = {
				rules : {
					"user.userName" : {
						required : true
					},
					"password" : {
						required : true
					},
					"user.nickName" : {
						required : true
					},
					"user.password" : {
						required : true,
						minlength : 6,
						equalTo : "[name='password']"//此处是为了jquery获得对象
					}
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				$("#data_form").submit();
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/console/user/index.action";
			});

			$("#selectOrg").click(
					function(event) {
						showPopWindow(event, "组织树", servletPath+"/console/org/entryOrgTree.action", $("[name='user.org.orgName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']", "[name='user.org.orgId']",
								"[name='user.org.orgName']", null, "[id='selectOrg']");//打开弹出窗

					});

			$("#selectEmployee").click(
					function(event) {
						showPopWindow(event, "机构职员", servletPath+"/console/employee/entryEmployeeTree.action", $("[name='user.employee.employeeName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']",
								"[name='user.employee.employeeId']", "[name='user.employee.employeeName']", null, "[id='selectEmployee']", {
									"beforeClose" : employeeCallbacks
								});
					});

			//选择employee的时候的回调
			var employeeCallbacks = function(selectedEmployee) {
				$("[name='user.nickName']").val(selectedEmployee["name"]);
				$("[name='user.org.orgName']").val(selectedEmployee["orgName"]);
				$("[name='user.org.orgId']").val(selectedEmployee["orgId"]);
			}
		});
	})(jQuery)
</script>

	</head>

	<body>

		<div class="grid_body">

			<form action="<%= servletPath%>/console/user/updateUser.action" method="post" name="data_form" id="data_form">
				<input type="hidden" name="user.userId" value="${user.userId}" />
				<div class="grid_body">
					<table class="content">
						<thead>
							<tr>
								<th colspan="2">
									修改系统用户
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="title" title="和员工基本信息关联，若不是机构职员，则不需要选择">
									选择员工信息
								</td>
								<td>
									<input type="text" style="display: none;"
										name="user.employee.employeeId" class="initEmployeeTree"
										value="${user.employee.employeeId}" />
									<input type="text" name="user.employee.employeeName"
										readonly="readonly" value="${user.employee.employeeName}" />
									<a href="javascript:void(0);" id="selectEmployee"
										class="button" data-method="singleWithCheck">选择</a>
								</td>
							</tr>
							<tr>
								<td width="150px;" class="title">
									用户名称
								</td>
								<td>
									<input type="text" name="user.userName"
										value="${user.userName }" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title">
									用户昵称
								</td>
								<td>
									<input type="text" name="user.nickName"
										value="${user.nickName }" class="line_input" />
								</td>
							</tr>

							<tr>
								<td class="title">
									用户密码
								</td>
								<td>
									<input type="password" name="password"
										value="${user.password }" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title">
									请再次确认密码
								</td>
								<td>
									<input type="password" name="user.password"
										value="${user.password }" class="line_input" />
								</td>
							</tr>


							<tr>
								<td class="title" title="确定角色的范围">
									选择部门
								</td>
								<td>
									<input type="text" name="user.org.orgId" class="initOrgTree"
										style="display: none;" value="${user.org.orgId}" />
									<input type="text" name="user.org.orgName" readonly="readonly"
										value="${user.org.orgName }" />
									<a href="javascript:void(0);" id="selectOrg" class="button"
										data-method="singleWithCheck">选择</a>
								</td>
							</tr>
							<tr>
								<td class="title">
									是否有效
								</td>
								<td>
									<c:choose>
										<c:when test="${user.valid.value=='1'}">
											<input type="checkbox" name="user.valid" value="1"
												checked="checked" />
										</c:when>
										<c:otherwise>
											<input type="checkbox" name="user.valid" value="1" />
										</c:otherwise>
									</c:choose>

								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<a id="submitBtn" class="sub" href="javascript:void(0);">提交</a>
									<a id="resetBtn" class="reset" href="javascript:void(0);">重置</a>
									<a id="backBtn" class="return" href="javascript:void(0);">返回</a>
								</td>
							</tr>

						</tfoot>
					</table>
				</div>
			</form>
		</div>

		<div class="pop_tree">
			<div class="pop_head">
			</div>
			<div class="pop_body">
			</div>
			<div class="pop_foot">
				<a href="javascript:void(0);" id="_PopSubBtn" class="button"
					data-popel="" data-vel="">确定</a>
				<a href="javascript:void(0);" id="_PopCloseBtn" class="button">关闭</a>
			</div>
		</div>
	</body>
</html>
