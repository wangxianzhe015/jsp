<%@page import="com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>项目管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
<style>
body { font-size: 12px; } 
#n { margin:10px auto; width:920px; border:1px solid #CCC;font-size:14px; line-height:30px; } 
#n a { padding:0 4px; color:#333 } 
.Bar ,.Bars { position: relative; width: 200px; /* 宽度 */ border: 1px solid #EFB519; padding: 1px; } 
.Bar div,.Bars div { display: block; position: relative; background:#FD8E13;/* 进度条背景颜色 */ color: #333333; height: 20px; /* 高度 */ line-height: 20px;  /* 必须和高度一致，文本才能垂直居中 */ } 
.Bars div{ background:#090} 
.Bar div span,.Bars div span { position: absolute; width: 200px;/* 宽度 */ text-align: center; font-weight: bold; } 
.cent{ margin:0 auto; width:300px; overflow:hidden} 
</style>
<script>
(function($){
	$( function() {
		$("#queryBtn").click( function() {
			$("#query_form").submit();
		});

		$("#addBtn").click( function() {
			var action = $(this).data("url");
			$("#page_form").attr("action", action);
			$("#page_form").submit();
		})

		$("#updateBtn").click( function() {
			//检测有没有选择员工
				var projectId_checked = $("[name='project.projectId']:checked");
				if (projectId_checked.length > 1) {
					$.prompt("只能选择一个项目!")
				} else if (projectId_checked.length == 0) {
					$.prompt("请选择一个项目!")

				} else {
					var action = $(this).data("url");
					
					$("#result_form").attr("action", action).submit();
				}

			})
		$("#deleteBtn").click( function() {
			var delBtn = $(this);

			var employeeId_checked = $("[name='project.projectId']:checked");
			if (employeeId_checked.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('确定删除选中的项目?', {
					buttons : {
						"确定" : true,
						"取消" : false
					},
					focus : 1,
					submit : function(v) {
						if (v) {
							var action = delBtn.data("url");
							$("#result_form").attr("action", action).submit();
						}
					}
				});

			}
		})	
	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="<%=servletPath %>/portal/project/index.action" method="post" name="query_form" id="query_form">
				<div class="grid_body">
					<table>
						<thead>
							<tr>
								<th colspan="4" align="left">
									输入查询条件:
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									项目名称:
								</td>
								<td>
									<input type="text" name="project.projectName" value="" />
								</td>
								<td>
									项目状态:
								</td>
								<td>
									<select name="project.projectState" id="project.projectState" >
									    <option value="">--全部--</option>
										<c:forEach items="${projectStates}" var="projectState" varStatus="index">
										<option value="${projectState.dictId }">${projectState.dictName }</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="4">
									<a id="queryBtn" class="sub" href="javascript:void(0);">查询</a>

								</td>
							</tr>

						</tfoot>
					</table>
				</div>

			</form>
			<form action="" method="post" name="result_form" id="result_form">
				<div class="grid_head">
					<div class="head_left">
						项目列表
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="addBtn"
							data-url="<%=servletPath %>/portal/project/entryPublish.action">发布项目</a>
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/portal/project/entryUpdate.action">编辑项目</a>
						<a href="javascript:void(0);" id="deleteBtn"
							data-url="<%=servletPath %>/portal/project/remove.action">删除项目</a>
							
					</div>
				</div>
				<input type="hidden" name="hasSelected" value="" />
				<div class="grid_body">

					<table>
						<thead>
							<tr>
								<th width="50px;">
									<input type="checkbox" name="checkAll" id="checkAll"
										title="select all" />
								</th>
								<th>
									项目名称
								</th>
								<th>
									融资进度
								</th>
								<th>
									剩余天数
								</th>
								<th>
									项目状态
								</th> 

								<th>
									项目类型
								</th>
								 <th>
									所属地区
								</th>
								<th>
									发布时间
								</th>

							</tr>
						</thead>

						<tbody>
							<c:forEach items="${projects}" var="project" varStatus="index">
								<c:set var="progress" value="${project.progress }"/>
								<%
									String progress=(String)pageContext.getAttribute("progress");
									Float f=0F;	
									if(progress!=""&&progress!=null){
										f=Float.parseFloat(progress);
									}
									pageContext.setAttribute("f", f);
								%>
								<tr <c:if test="${project.remainingDays<0 && f<100 }"> style="color:#FF0000" </c:if> >
									<td class="center">
										<input type="checkbox" name="project.projectId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${project.projectId}" />

									</td>
									<td>
										<c:out value="${project.projectName}"></c:out>
									</td>
									<td>
										<div class="Bar"> 
										    <div style="width: ${project.progress}%;"> 
										        <span>${project.progress }%</span> 
										    </div> 
										</div>
									</td>
									<td>
									    
										<c:choose>
											<c:when test="${project.remainingDays<0 && f<100}">
												<font color="#FF0000">已逾期</font>
											</c:when>
											<c:otherwise>
												<c:out value="${project.remainingDays }"/>
											</c:otherwise>
										</c:choose>
									</td>									
									<td>
										<c:out value="${project.projectStateName }"></c:out>
									</td>

									<td>
									    <c:set var="projectType" value="${project.projectType }"/>
									   	<%
									      String projectType=(String)pageContext.getAttribute("projectType");
									   	  String projectTypeName=DictionaryFactory.getInstance().getDictName("PORTAL_PROJECT_TYPE",projectType);
									      pageContext.setAttribute("projectTypeName", projectTypeName);
									   %>
										<c:out value="${projectTypeName}"></c:out>
									</td>
									<td>
								          <c:out value="${project.cityName }"></c:out>
									</td>
									<td>
										
										<fmt:formatDate value="${project.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/portal/project/pageQuery.action" method="post" name="page_form" id="page_form">
				<input type="hidden" value="${project.projectName}" />
				<input type="hidden" value="${project.projectState}" />
				<div class="grid_foot">
					<div class="foot_left">
						当前第
						<c:out value="${page.currentPage}"></c:out>
						页/共
						<c:out value="${page.totalPage}"></c:out>
						, 每页显示
						<c:out value="${page.pageSize}"></c:out>
						条记录/共
						<c:out value="${page.totalCount}"></c:out>
						条,跳转到
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/project/pageQuery.action" data-formId="page_form">

						</select>
						页
					</div>
					<div class="foot_right">
						<input type="hidden" name="page.pageSize"
							value="${page.pageSize }">
						<input type="hidden" name="page.count" value="${page.count }">
						<input type="hidden" name="page.currentPage"
							value="${page.currentPage }" />
						<input type="hidden" name="page.beginPage"
							value="${page.beginPage }">
						<input type="hidden" name="page.totalCount"
							value="${page.totalCount }">
						<input type="hidden" name="page.totalPage"
							value="${page.totalPage}">
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">首页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:firstPage('<%=servletPath %>/portal/project/pageQuery.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/portal/project/pageQuery.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/portal/project/pageQuery.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/portal/project/pageQuery.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

	</body>
</html>
