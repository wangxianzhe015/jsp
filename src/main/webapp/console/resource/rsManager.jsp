<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>资源管理首页</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<link href="<%=contextPath %>/common/plugins/jeegoocontext/skins/cm_default/style.css" rel="Stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/jeegoocontext/jquery.jeegoocontext.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/dynaTreeDiyOptions.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/resource/addResource.js"></script>
	</head>

	<body>

		<form action="" name="data_form" id="data_form">

			<div class="a_container">
				<!-- -------------------------------左侧模块树 -------------------------------->
				<div class="a_container_left">
					<div class="ac_head">
						系统模块
						<input type="hidden" name="module.moduleId">
					</div>
					<div class="ac_body">
						<div class="memo"> 选择模块 </div>
						<div id="showMdTree" style="overflow: auto; "></div>
					</div>

				</div>
				<!-- ---------------------------功能函数列表 ------------------------------>
				<div class="a_container_right" >
					<div class="ac_head">
						模块功能
						<span class="memo" id="selectedNodeInfo"></span>
					</div>
					<div class="ac_body">
						<div class="grid_head">
							<div class="head_left">
								模块下的资源列表:
							</div>
							<div class="head_right">
								<a href="javascript:void(0);" id="_GridAddBtn"
									data-url="<%=servletPath %>/console/function/entryAdd.action">新增</a><a
									href="javascript:void(0);" id="_GridUpdateBtn"
									data-url="<%=servletPath %>/console/function/entryUpdate.action">修改</a><a
									href="javascript:void(0);" id="_GridDeleteBtn"
									data-url="<%=servletPath %>/console/function/delete.action">删除</a>
							</div>
						</div>
						<input type="hidden" name="hasSelected" />
						<input type="hidden" name="function.module.moduleId" value="" />
						<div class="grid_body">
							<table id="funclistTable">
								<thead>
									<tr>
										<th width="50px" align="center">
											<input type="checkbox" name="checkAll" id="checkAll"
												title="select all" />
										</th>
										<th nowrap="nowrap">
											功能名称
										</th>
										<th class="" nowrap="nowrap" >
											功能路径
										</th> 									
										<th class="" nowrap="nowrap" width="100px;">
											功能描述
										</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="3" align="left"">
											未选择模块
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div style="clear:both"></div>
			</div>

		</form>
		<!-- 新增函数的弹出窗 -->
		<div class="funcDialog" title="新增函数" id="addFuncDialog">
			<div class="dialog_s">
				<div class="content">
					<jsp:include page="addFuncs.jsp"></jsp:include>

				</div>
			</div>
		</div>
		<!-- 修改函数的弹出窗 -->
		<div class="funcDialog" title="修改函数窗口" id="updateFuncDialog">
				<jsp:include page="updateFunc.jsp"></jsp:include>
		</div>
		<!-- 更新模块的弹出窗 -->
		<div class="funcDialog" title="更新模块" id="updateModuleDialog" >
				<jsp:include page="updateModule.jsp"></jsp:include>
		</div>
		<!-- 新增模块的弹出窗 -->
		<div class="funcDialog" title="新增模块" id="addModuleDialog">
				<jsp:include page="addModule.jsp"></jsp:include>
		</div>

		<!-- 新增应用 -->
		<!-- 新增模块的弹出窗 -->
		<div class="funcDialog" title="新增应用" id="addAppDialog">
				<jsp:include page="addApp.jsp"></jsp:include>
		</div>


		<!-- 修改应用弹出窗 -->
		<div class="funcDialog" title="修改应用" id="updateAppDialog">
				<jsp:include page="updateApp.jsp"></jsp:include>
		</div>



		<!-- ------------------右键菜单-------------- -->
		<ul id="folderMenu" class="jeegoocontext cm_default">
			<li class="icon " id="delete">
				<span class="icon delete"></span> 删除应用
			</li>
			<li class="icon" id="add">
				<span class="icon copy"></span> 新增模块
			</li>
			<li class="separator"></li>
			<li class="icon" id="edit">
				<span class="icon edit"></span> 修改应用
			</li>
		</ul>
		<ul id="leafMenu" class="jeegoocontext cm_default">
			<li class="icon" id="delete">
				<span class="icon delete"></span> 删除模块
			</li>
			<li class="icon disabled" id="add">
				<span class="icon copy"></span> 新增模块
			</li>
			<li class="separator"></li>
			<li class="icon" id="edit">
				<span class="icon edit"></span> 修改模块
			</li>
		</ul>
		<ul id="treeMenu" class="jeegoocontext cm_default">
			<li class="icon" id="add">
				<span class="icon "></span> 新增应用
			</li>
			<li class="icon" id="refresh">
				<span class="icon "></span> 刷新资源树
			</li>
		</ul>
	</body>
</html>
