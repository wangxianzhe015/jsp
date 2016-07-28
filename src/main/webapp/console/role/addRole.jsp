<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>新增角色</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/dynaTreeDiyOptions.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/role/addRole.js"></script>
	</head>
	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/console/role/addRole.action" method="post" name="data_form" id="data_form">
				<div class="a_container">
					<div class="a_container_top">
						新增角色
					</div>
					<div class="a_container_left" style="width: 400px;">
						<table style="margin: 2px;" class="content">
							<tbody>
								<tr>
									<td width="100px;" nowrap="nowrap" class="title">
										角色名称
									</td>
									<td>
										<input type="text" value="" name="role.roleName" />
									</td>

								</tr>
								<tr>
									<td class="title">
										所属机构
									</td>
									<td>
										<input type="text" value="" name="initOrgId" class="initOrgTree" style="display: none;">
										<input type="text" value="" name="initOrgName">

										<a href="javascript:void(0);" id="selectOrg" class="button"	data-method="multiNoChild">选择</a>
										<!-- 将某角色给上级机构，其子机构不一定拥有该角色 -->
										<div id="addOrgRoleDiv" class="orgRoleSelectedDiv"></div>
									</td>
								</tr>
							
								<tr>
									<td class="title">
										角色启用状态
									</td>
									<td>
										<input type="radio" name="role.roleState" value="1"
											checked="checked" />
										使用
										<input type="radio" name="role.roleState" value="0" />
										关闭
									</td>
								</tr>
								<tr>
									<td class="title">
										角色类型
									</td>
									<td>
										<select name="role.roleType">
											<option value="">
												--请选择角色类型--
											</option>
											<option value="sysadmin" selected="selected">
												系统管理员
											</option>
											<option value="orgadmin">
												机构管理员
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td valign="top" class="title">
										角色备注
									</td>
									<td>
										<textarea rows="5" style="width: 98%" name="role.roleMemo"></textarea>
									</td>
								</tr>
									<tr>
									<td valign="top" class="title">
										功能说明
									</td>
									<td>
										<span class="memo">1、将角色分配给机构(可以为空,可以多选)||和机构是many-to-many的关系</span>
										<br />
										2、不需要权限的模块都已默认选中
										<br/>3、对模块的配置，权限控制到菜单上显示
										<br/>4、对资源(叶子节点)的筛选控制应当控制到各个action中对应的btn(带有action操作的按钮上)或者模块具有权限的
										视图(div)上，当前未完成此功能
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="a_container_right">
						<!-- 初始化角色的资源树的隐藏域值 -->
						<input type="hidden" value="${requestScope.funcsStr }"
							name="functionIds" id="initFuncTree">
						<div class="memo_head">
							<span class="memo"> 选择模块资源 </span>
							<span id="showdselectInfo"></span><span class="memo"> [公共资源已默认选中] </span>
						</div>
						<div id="addRoleFuncDiv" class="roleFuncSelectedDiv"></div>
						<div id="selectFuncTree" style="width: 100%; overflow-x: auto;">
						</div>
					</div>
					<div class="clearfloat"></div>
					<div class="ac_foot">
						<a id="submitBtn" class="button" href="javascript:void(0);"
							data-operate="add">新增</a>
						<a id="resetBtn" class="button" href="javascript:void(0);">重置</a>
						<a id="backBtn" class="button" href="javascript:void(0);">返回</a>
					</div>
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
