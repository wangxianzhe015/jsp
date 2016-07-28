<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>新增员工</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script type="text/javascript" >
		( function($) {
			$( function() {
				// 定义校验规则
				var validateFormRule = {
					rules : {
						"employee.employeeName" : {
							required : true
						},
						"employee.address" : {
							required : false

						},
						"employee.email" : {
							required : false,
							email : true
						},
						"employee.telephoneNo" : {
							required : false,
							minlength : 6
						},
						"employee.mobileNo" : {
							required : false,
							minlength : 6,
							equalTo : "[name='employee.telephoneNo']"// 此处是为了jquery获得对象
						},
						"employee.gender" : {
							required : false
						},
						"employee.org.orgName" : {
							required : true
						},
						"employee.birthday" : {
							required : false,
							dateISO : true
						}
					},
					messages : {
						"employee.employeeName" : {
							required : "请输入用户名"
						},
						"employee.address" : {
							required : "请输入地址"

						},
						"employee.mobileNo" : {
							required : "手机号码必填",
							minlength : "长度和电话一样长",
							equalTo : "和电话要写的一样"// 此处是为了jquery获得对象
						}

					}
				};
				var vo = validateForm("#data_form", validateFormRule);
				// 提交按钮
				$("#submitBtn").click( function() {
					if (vo.form())
						$("#data_form").submit();
				});

				// 重置按钮
				$("#resetBtn").click( function() {
					vo.resetForm();
				})

				// 返回按钮
				$("#backBtn").click( function() {
					window.location.href = servletPath+"/console/employee/index.action";
				});
				// 各种方式调出弹出窗

				$("#selectOrg").click(
						function(event) {
							showPopWindow(event, "组织树", servletPath+"/console/org/entryOrgTree.action", $("[name='employee.org.orgName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']", "[name='employee.org.orgId']",
									"[name='employee.org.orgName']", null, "[id='selectOrg']");// 打开弹出窗
						});
				// showPopWindowBySelf("测试focus弹出:","gas/org.venus.iplatform.gas.web.OrgManager.entryOrgTree.action","[name='employee.address']",
				// "[id='_PopCloseBtn']","[id='_PopSubBtn']");

				// 调用日期控件
				$("[name='employee.birthday']").datepicker({
					changeMonth : true,
					changeYear : true,
					dateFormat:"yy/mm/dd",
					regional:"zh-CN"
						});	
			});
		})(jQuery)
		</script>
	</head>

	<body>
		<div class="grid_body">
			<form
				action="<%=servletPath %>/console/employee/add.action"
				method="post" name="data_form" id="data_form">

				<table class="content">
					<thead>
						<tr>
							<th colspan="4">
								新增员工
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="100px;" class="title">
								用户名
							</td>
							<td width="300px;">
								<input type="text" value="" name="employee.employeeName" />
							</td>
							<td width="100px;" class="title">
								性别
							</td>
							<td>

								<input type="radio" name="employee.gender" value="M" />
								男

								<input type="radio" name="employee.gender" value="F" />
								女
							</td>
						</tr>
						<tr>
							<td class="title">
								地址
							</td>
							<td>
								<input type="text" name="employee.address" />
							</td>
							<td class="title">
								部门
							</td>
							<td>
								<input id="employee.org.orgId" type="text"
									name="employee.org.orgId" class="initOrgTree"  style="display: none;"/>
								<input id="employee.org.orgName" type="text"
									name="employee.org.orgName" readonly="readonly" />
								<a href="javascript:void(0);" id="selectOrg" class="button"
									data-method="singleNoCheck">选择</a>
							</td>
						</tr>
						<tr>
							<td class="title">
								邮箱
							</td>
							<td>
								<input type="text" name="employee.email" />
							</td>
							<td class="title">
								电话
							</td>
							<td>
								<input type="text" value="" name="employee.telephoneNo" />
							</td>
						</tr>


						<tr>
							<td class="title">
								手机
							</td>
							<td>
								<input type="text" name="employee.mobileNo" />
							</td>
							<td class="title">
								生日
							</td>
							<td>
								<input type="text" name="employee.birthday" readonly="readonly" />
							</td>
						</tr>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="4">
								<a id="submitBtn" class="sub" href="javascript:void(0);">提交</a>
								<a id="resetBtn" class="reset" href="javascript:void(0);">重置</a>
								<a id="backBtn" class="return" href="javascript:void(0);">返回</a>
							</td>
						</tr>

					</tfoot>
				</table>
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
