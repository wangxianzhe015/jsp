<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title> 修改项目公告</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.config.js"></script> 
		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.all.min.js" ></script> 
		
		<script>
	( function($) {
		$( function() {

			var contentEditorUE = UE.getEditor('contentEditor');
				contentEditorUE.options.initialFrameHeight=400;
								
			var validateFormRule = {
				rules : {
					"notice.project.projectId" : {
						required : true
					}
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				if (vo.form()){
					$("[name='notice.content']").val(UE.getEditor("contentEditor").getContent());
					$("#data_form").submit();
				}
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/projectnotice/index.action";
			});
			


		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/projectnotice/updateNotice.action" method="post" name="data_form" id="data_form">
			    <input type="hidden" name="notice.noticeId" value="${notice.noticeId }"/>
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								新增项目公告
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;" class="title">
								选择项目
							</td>
							<td>
								<select name="notice.project.projectId" style="width: 400px" >
								   <option value=''>---------请选择--------</option>
								   <c:forEach items="${projects }" var="project">
								   		<option value="${project.projectId }" <c:if test="${notice.project.projectId==project.projectId }">selected </c:if> >${project.projectName }(${project.projectStateName })</option>
								   </c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">
								公告简介
							</td>
							<td>
								<textarea type="text" id="notice.profile" name="notice.profile" style="margin: 0px; width: 70%; height: 65px;">${notice.profile }</textarea>
							</td>
						</tr>
						<tr>
							<td class="title">
								公告详情
							</td>
							<td> 
							     <input type="hidden" name="notice.content" id="notice.content" value=""/>
								 <script type="text/plain" id="contentEditor" name="contentEditor" style="height:250px;width:95%">
								 ${notice.contentHtml}
								</script>							
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
