<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="/common/header.jsp"%>
<html>
	<head>
		<title>资源管理-新增模块</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	</head>
	<body>
		<form action="<%=servletPath %>/console/resource/addModule.action"
			name="addModuleForm" method="post">
			<input type="hidden" name="module.parentModuleId" />
			<input type="hidden" name="module.app.appId" />
			<input type="hidden" name="module.modulePath" />
			<input type="hidden" name="module.iconPath" value="iconPath" />
			<table class="content">

				<tbody>
					<tr>
						<td width="150px;" class="title">
							模块名称
						</td>
						<td>
							<input type="text" value="" name="module.moduleName" />
						</td>

					</tr>
					<tr>
						<td width="150px;" class="title">
							模块描述
						</td>
						<td>
							<input type="text" value="" name="module.moduleDesc" />
							<span class="memo">模块的中文描述</span>
						</td>

					</tr>

					<tr>
						<td class="title">
							显示顺序
						</td>
						<td>
							<input type="text" value="" name="module.moduleNo" />
							<span class="memo">输入数字</span>
						</td>

					</tr>
					<tr>
						<td class="title" title="eg:/resource/update.action">
							模块链接URL
						</td>
						<td>
							<input type="text" value="" name="module.entryUrl" />
						</td>

					</tr>
					<tr>
						<td class="title">
							是否访问受限
						</td>
						<td>
							<select name="module.accessFlag">
								<option value="">
									--请选择--
								</option>
								<option value="N">
									公共资源
								</option>
								<option value="Y">
									需要权限
								</option>
							</select>
						</td>

					</tr>
					<tr>
						<td class="title">
							是否菜单
						</td>
						<td>
							<input type="radio" name="module.isMenu" value="Y" />
							是
							<input type="radio" name="module.isMenu" value="N" />
							否
						</td>

					</tr>
					<tr>
						<td class="title">
							是否叶子节点
						</td>
						<td>
							<input type="radio" name="module.isLeaf" value="Y" />
							是
							<input type="radio" name="module.isLeaf" value="N" />
							否
						</td>

					</tr>
				</tbody>

			</table>
		</form>
	</body>
</html>
