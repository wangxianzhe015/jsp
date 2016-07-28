<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>新增角色</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="resource/js/pop_select.js"></script>
		<script>
	$( function() {
		//定义校验规则
		var validateFormRule = {
			rules : {
				"role.roleName" : {
					required : true
				},
				"role.state" : {
					required : true

				},
				"role.roleType" : {
					required : true

				}
			}
		};
		var vo = validateForm("#data_form", validateFormRule);

		//提交按钮
		$("#submitBtn").click( function() {
			if (vo.form())
				$("#data_form").submit();
		});

		//重置按钮
		$("#resetBtn").click( function() {
			vo.resetForm();
		})

		//返回按钮
		$("#backBtn")
				.click(
						function() {
							window.location.href = servletPath+"/org/index.action";
						});
		//各种方式调出弹出窗

		$("#selectOrg")
				.click(
						function(event) {
							showPopWindow(
									event,
									"组织树",
									servletPath+"/org/entryOrgTree.action",
									$("[name='org.parentOrgName']"),
									$("[id='_PopCloseBtn']"),
									"[id='_PopSubBtn']",
									"[name='org.parentOrgId']",
									"[name='org.parentOrgName']", null);
						});
		$("#selectFunc")
				.click(
						function(event) {
							showPopWindow(
									event,
									"选择功能",
									servletPath+"/function/entryFuncTree.action",
									$("[name='functionNames']"),
									$("[id='_PopCloseBtn']"),
									"[id='_PopSubBtn']",
									"[name='functionIds']",
									"[name='functionNames']", null);
						});

		//showPopWindowBySelf("测试focus弹出:","gas/org.venus.iplatform.gas.web.OrgManager.entryOrgTree.action","[name='employee.address']", "[id='_PopCloseBtn']","[id='_PopSubBtn']");

	})
</script>
	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/role/add.action"
				method="post" name="data_form" id="data_form">

				<table>
					<thead>
						<tr>
							<th colspan="2">
								新增角色
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;">
								角色名称:
							</td>
							<td>
								<input type="text" value="" name="role.roleName" />
							</td>

						</tr>
						<tr>
							<td>
								所属机构:
							</td>
							<td>
								<input type="hidden" value="" name="org.parentOrgId"
									class="initOrgTree">
								<input type="text" value="" name="org.parentOrgName">

								<a href="javascript:void(0);" id="selectOrg" class="button"
									data-method="singleNoCheck">选择</a><span class="memo">将角色分配给机构(可以为空,可以多选)||和机构是many-to-many的关系</span>
							</td>

						</tr>
						<tr>
							<td>
								角色启用状态:
							</td>
							<td>

								<input type="radio" name="role.state" value="Y">
								使用


								<input type="radio" name="role.state" value="N">
								关闭

							</td>

						</tr>
						<tr>
							<td>
								角色类型:
							</td>
							<td>
								<select name="role.roleType">
									<option value="">
										--请选择角色类型--
									</option>
									<option value="test">
										from数据字典
									</option>
									<option value="sysadmin">
										SYSADMIN
									</option>
									<option value="orgadmin">
										ORGADMIN
									</option>
								</select>
							</td>

						</tr>
						<tr>
							<td valign="top">
								角色备注:
							</td>
							<td>
								<textarea rows="5" cols="50"></textarea>

							</td>

						</tr>
						<tr>
							<td valign="top">
								权限设置:
							</td>
							<td>
								<input type="hidden" value="" name="functionIds"
									class="initFuncTree">
								<input type="text" value="" name="functionNames">

								<a href="javascript:void(0);" id="selectFunc" class="button"
									data-method="multiWithChild">选择</a>
								<span class="memo"> 调出权限树（功能树），分配给角色 </span>

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
