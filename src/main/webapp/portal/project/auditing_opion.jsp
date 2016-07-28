<%@page import="com.smartcloud.crowdfunding.portal.model.ProjectState"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/common/header.jsp" %>
<html>
	<head>
		<title>项目审核意见</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

	</head>
	<body>
		<form
			action="<%=servletPath %>/portal/project/updateProjectProgress.action" name="progressForm" method="post">
			<table class="content">
				<input type="hidden" name="progress.projectId" value="${project.projectId }" />
				<tbody>
					<tr>
						<td class="title" width="150px;">
							处理结果
						</td>
						<td>
							<select name="progress.dealResult" id="progress.dealResult" >
							    <option value="">请选择</option>
								<option value="Y">通过</option>
								<option value="N">不通过</option>
							</select>
						</td>
					</tr>
						<tr>
							<td class="title">
							当前阶段
							</td>
							<td>
							<input type="hidden" name="currentState" value="${project.projectState }"/>
							${project.projectStateName }
							</td>
						</tr>	
						<tr>
							<td class="title">
							下一阶段
							</td>
							<td>
							<c:set var="currentState" value="${project.projectState }"/>
							<%
								
							   String nextState=ProjectState.nextState((String)pageContext.getAttribute("currentState"));
							   String nextStateName=DictionaryFactory.getInstance().getDictName("PORTAL_PROJECT_STATE",nextState );
							   pageContext.setAttribute("nextState", nextState);
							%>
							<select name="progress.projectState" id="progress.projectState">
								<c:forEach items="${projectStates}" var="projectState" varStatus="index">
								<option value="${projectState.dictId }" <c:if test="${projectState.dictId==nextState }">selected</c:if> >${projectState.dictName }</option>
								</c:forEach>
							</select>

							</td>
						</tr>																
					<tr>
						<td class="title" width="150px;">
							意见描述
						</td>
						<td>
							<textarea type="text" name="progress.dealOpion" value=""  cols="30" rows="5"></textarea>
						</td>
					</tr>
					<tr>
						<td class="title" width="150px;">
							通知项目发起人：
						</td>
						<td>
							手机短信<input type="checkbox" name="sms" value="1" checked="checked"/>
							电子邮件<input type="checkbox" name="email" value="1" checked="checked"/>
							站内消息<input type="checkbox" name="sysmsg" value="1" checked="checked"/>
						</td>
					</tr>					
				</tbody>

			</table>
		</form>
	</body>
</html>
