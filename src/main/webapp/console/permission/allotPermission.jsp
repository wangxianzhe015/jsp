<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>配置权限首页</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/dynaTreeDiyOptions.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/permission/allotPermission.js"></script>
	</head>

	<body>
		<form action="" name="data_form" id="data_form" method="post">
			<!-- 该显示哪一种树 org的或者user的 -->
			<input type="hidden"  name="showWhich" id="showWhich"
				value="${requestScope.showWhich }" />
				<input type="hidden" name="paramId" id="paramId"
				value="${requestScope.paramId }" />
				
			<div class="a_container">
				<div class="a_container_left">
					<div class="ac_head">
						选择机构/用户
						<input type="hidden" name="lorgId">
						<input type="hidden" name="luserId">
					</div>
					<div class="ac_body">
						<span class="memo"> 选择机构，给机构分配角色 </span>
						<div id="showTree"></div>
					</div>

				</div>
				<div class="a_container_right">
				<!-- ac_head是角色id隐藏域insert的地方 -->
					<div class="ac_head">
						勾选角色
						<input type="hidden" name="ouRoleId" /><!-- 代替id，当nodeType不为空的时候替换掉 -->
						
					</div>
					<div class="ac_body">
						<div class="memo">
							<label id="load">
								角色列表
							</label>
							<label id="selectInfo"></label>
						</div>
						<div id="showHasSelected">
							显示已经选择的角色
						</div>
						<div id="showRlist">
						</div>
					</div>
				</div>
				<div class="clearfloat"></div>
				<div class="ac_foot">
					<a href="javascript:void(0);" id="submitBtn" class="button">确定</a>
					<a href="javascript:void(0);" id="resetBtn" class="button"
						title="重新选择角色">重置</a>
				</div>
			</div>
			<div id="_formHiddenArea">
			<!-- 存放生成隐藏域的div -->
			</div>
		</form>
	
	</body>
</html>
