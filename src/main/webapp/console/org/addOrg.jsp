<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>新增机构</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>	
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script>
	(function($){
		$( function() {
			//定义校验规则
			var validateFormRule = {
				ignore : "",
				rules : {
					"org.orgName" : {
						required : true
					},
					"org.orgManager" : {
						required : false
					},
					"org.orgNo":{
					   required : true,
					   number:true
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
			$("#backBtn").click( function() {
				window.location.href = servletPath+"/console/org/index.action";
			});
			//各种方式调出弹出窗

			$("#selectOrg").click(
					function(event) {
						showPopWindow(event, "组织机构", servletPath+"/console/org/entryOrgTree.action", $("[name='org.parentOrgName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']", "[name='org.parentOrgId']",
								"[name='org.parentOrgName']", "[name='org.parentOrgPath']", "[id='selectOrg']");
					});
			$("#selectUser").click(
					function(event) {
						showPopWindow(event, "系统用户", servletPath+"/console/user/entryUserTree.action", $("[name='org.orgManagerName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']", "[name='org.orgManager']",
								"[name='org.orgManagerName']", "[name='managerPath']", "[id='selectUser']");
					});

			//showPopWindowBySelf("测试focus弹出:","gas/org.venus.iplatform.gas.web.OrgManager.entryOrgTree.action","[name='employee.address']", "[id='_PopCloseBtn']","[id='_PopSubBtn']");

		})
		})(jQuery)
</script>
	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/console/org/add.action"
				method="post" name="data_form" id="data_form">

				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								新增机构
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;" class="title">
								机构名称
							</td>
							<td>
								<input type="text" value="" name="org.orgName" />
							</td>

						</tr>
						<tr>
							<td class="title">
								上级机构
							</td>
							<td>
								<input type="text"  name="org.parentOrgId" class="initOrgTree"  style="display: none;"/>
								<input type="text"  name="org.parentOrgPath"  style="display: none;"/>
								<input type="text"  name="org.parentOrgName" readonly="readonly" />
								<a href="javascript:void(0);" id="selectOrg" class="button" data-method="singleNoCheck">选择</a>
							</td>

						</tr>
						<tr>
							<td class="title">
								机构负责人
							</td>
							<td>
								<input type="text" name="org.orgManager" class="initUserTree"  style="display: none;"/>
								<input type="text" name="managerPath" value=""  style="display: none;"/>
								<input type="text" name="org.orgManagerName" readonly="readonly" />
								<a href="javascript:void(0);" id="selectUser" class="button" data-method="multiWithChild">选择</a>
							</td>

						</tr>
						<tr>
							<td valign="top" class="title">
								机构顺序
							</td>
							<td>
								<input type="text" name="org.orgNo" value="1"/>

							</td>

						</tr>						
						<tr>
							<td valign="top" class="title">
								机构描述
							</td>
							<td>
								<textarea rows="5" cols="50" name="org.orgDesc"></textarea>

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
