<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>新增栏目</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<link rel="stylesheet" type="text/css" href="<%=contextPath %>/common/plugins/multiselect/jquery.multiselect.css">
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/multiselect/src/jquery.multiselect.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/common/plugins/multiselect/i18n/jquery.multiselect.zh-cn.js"></script>
		<script type="text/javascript" src="<%=contextPath %>/console/portal/addPortal.js"></script>
	</head>

	<body>
		<div class="grid_body">
			<form
				action="<%=servletPath %>/console/portal/update.action"
				method="post" name="data_form" id="data_form">
				<input type="hidden" name="portal.catalogId"
					value="${requestScope.portal.catalogId}" />
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								修改栏目
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;" class="title">
								栏目编码
							</td>
							<td>
								<input type="text" value="${requestScope.portal.catalogCode }"
									name="portal.catalogCode" />
							</td>

						</tr>
						<tr>
							<td width="150px;" class="title">
								标题
							</td>
							<td>
								<input type="text" value="${requestScope.portal.catalogTitle }"
									name="portal.catalogTitle" />
							</td>

						</tr>

						<tr>
							<td class="title">
								状态
							</td>
							<td>
								<c:choose>
									<c:when test="${requestScope.portal.catalogStaus=='1' }">
										<input type="radio" name="portal.catalogStaus" value="1"
											checked="checked" />
									</c:when>
									<c:otherwise>
										<input type="radio" name="portal.catalogStaus" value="1" />
									</c:otherwise>
								</c:choose>
								使用中
								<c:choose>
									<c:when test="${requestScope.portal.catalogStaus=='0' }">
										<input type="radio" name="portal.catalogStaus" value="0"
											checked="checked" />
									</c:when>
									<c:otherwise>
										<input type="radio" name="portal.catalogStaus" value="0" />
									</c:otherwise>
								</c:choose>
								关闭
							</td>

						</tr>
						<tr>
							<td valign="top" class="title">
								显示内容
							</td>
							<td>
								<textarea rows="5" cols="50" name="portal.catalogContent">${requestScope.portal.catalogContent }</textarea>
							</td>
						</tr>

						<tr>
							<td width="150px;" class="title" valign="top">
								链接URL
							</td>
							<td>
								<textarea rows="5" cols="50" name="portal.catalogUrl">${requestScope.portal.catalogUrl }</textarea>
							</td>

						</tr>
						<tr>
							<td width="150px;" class="title">
								额定高度
							</td>
							<td>
								<input type="text" value="${requestScope.portal.catalogHeight }"
									name="portal.catalogHeight" />
							</td>

						</tr>
						<tr>
							<td valign="top" class="title">
								备注
							</td>
							<td>
								<textarea rows="5" cols="50" name="portal.catalogMemo">${requestScope.portal.catalogMemo }</textarea>
							</td>
						</tr>
						<tr>
							<td class="title">
								访问权限
							</td>
							<td>
								<select multiple="multiple" id="accessPermission"
									name="accessPermission">
									<optgroup label="不需要权限" data-label="不需要权限"
										id="needNoAccess_optionGroup">
										<c:choose>
											<c:when test="${requestScope.portal.catalogAccess=='0' }">
												<option id="needNoAccess_option" selected="selected"
													value="no">
											</c:when>
											<c:otherwise>
												<option id="needNoAccess_option" value="no">
											</c:otherwise>
										</c:choose>
										不需要访问权限
										</option>
									</optgroup>
									<optgroup label="需要权限" id="needAccess_optionGroup">
										<c:forEach items="${requestScope.pRoles}" var="pr"
											varStatus="index">

											<c:choose>
												<c:when
													test="${pr.selected&&requestScope.portal.catalogAccess=='1'}">
													<option value="${pr.role.roleId }" selected="selected">
												</c:when>
												<c:otherwise>
													<option value="${pr.role.roleId }">
												</c:otherwise>
											</c:choose>
											<c:out value="${pr.role.roleName}"></c:out>
											</option>
										</c:forEach>
									</optgroup>
								</select>
								<input type="hidden" name="portal.catalogAccess"
									value="${requestScope.portal.catalogAccess }" />
								<input type="hidden" name="portal.roleIds"
									value="${requestScope.portal.roleIds }" />
								<input type="hidden" name="portal.roleNames"
									value="${requestScope.portal.roleNames}" />
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
