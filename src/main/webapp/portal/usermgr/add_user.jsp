<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>新增用户</title>
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
					"user.mobileNO" : {
						required : true
					},
					"user.password" : {
						required : true,
						minlength : 6,
						equalTo : "[id='password2']"//此处是为了jquery获得对象
					}
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				if (vo.form())
					$("#data_form").submit();
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/usermgr/index.action";
			});

		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/usermgr/addUser.action" method="post" name="data_form" id="data_form">
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								新增用户
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="title">
								登录手机号码
							</td>
							<td>
								<input type="text" name="user.mobileNo" value="" class="line_input" />
							</td>
						</tr>					
						<tr>
							<td width="150px;" class="title">
								用户名称
							</td>
							<td>
								<input type="text" name="user.userName" value="" class="line_input" />
							</td>
						</tr>
						<tr>
							<td class="title">
								用户密码
							</td>
							<td>
								<input type="password" name="user.password" id="password1" value="" class="line_input" />
							</td>
						</tr>
						<tr>
							<td class="title">
								请再次确认密码
							</td>
							<td>
								<input type="password"  id="password2" value="" class="line_input" />
							</td>
						</tr>
							<tr>
								<td class="title">
									真实姓名
								</td>
								<td>
									<input type="text" name="user.realName" value="" class="line_input" />
								</td>
							</tr>

							<tr>
								<td class="title" >
									身份证号码
								</td>
								<td>
									<input type="text" name="user.identityCard" value=""  class="line_input"/>
								</td>
							</tr>
							<tr>
								<td class="title" >
									是否实名认证
								</td>
								<td>
									<input type="checkbox" name="user.realNameAuth" value="1" />是
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
			</form>
		</div>
	</body>
</html>
