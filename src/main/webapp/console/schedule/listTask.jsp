<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<%@include file="/common/common.jsp"%>
<%@include file="/common/jqueryUI.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/schedule/sortTable.js"></script>
</head>
<body style="margin:0px">

	<form id="quartzs" action="" method="post">
		<div class="grid_head">
			<div class="head_left">任务列表</div>
		</div>
		<table border="0" class="EOS_TABLE" width="100%">
			<tr>
				<td width="100%">
				<input type="hidden" name="ip" value="${ip}" /> 
				<input type="hidden" name="port" value="${port}" /> 
				<input type="hidden" name="appName" value="${appName}" /> 
				<input type="hidden" name="schedulerName" value="${schedulerName}" />
				<input type="hidden" name="taskName" id="taskName" value=""/>

					<div class="grid_body">
						<table width="100%" class="EOS_TABLE" id="sortTable">
							<thead class="EOS_TABLE_HEAD">
								<tr>
									<td><h:checkbox name="check" id="checkall" onclick="checkAll();" />选择</td>
									<td nowrap onclick="sort()">任务名称</td>
									<td nowrap onclick="sort()">状态</td>
									<td nowrap onclick="sort()">类型</td>
									<td nowrap onclick="sort()">是否有状态</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${taskList}" var="task" varStatus="index">
									<tr>
										<td width="100"><input type="checkbox" name="selectedItem" value='<c:out value="${task.taskName}"/>,<c:out value="${task.taskState}"/>' /></td>
										<td width="200"><c:out value="${task.taskName}" /></td>
										<td width="150"><c:choose>
												<c:when test="${task.taskState==0}">
										              正常
										       </c:when>
												<c:when test="${task.taskState==1}">
										              暂停
										       </c:when>
												<c:when test="${task.taskState==2}">
										              完成
										       </c:when>
												<c:otherwise>
										              错误
										       </c:otherwise>
											</c:choose></td>
										<td width="200">
										   <c:choose>
											<c:when test="${task.taskType==3}">
										        Java方法
										       </c:when>
												<c:otherwise>
										              其他
										       </c:otherwise>
											</c:choose>
										</td>
										<td width="200"><c:choose>
												<c:when test="${task.isStateful==true}">
										              有状态
										       </c:when>
												<c:otherwise>
										              无状态
										       </c:otherwise>
											</c:choose></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div></td>
			</tr>

			<tr class="command_sort_area">
				<td><input type="button" class="sub" value="新增" onclick="userCommand('add');"> <input type="button" id="updatebtn" class="sub" value="修改"
					onclick="userCommand('update');"> <input type="button" id="deletebtn" class="sub" value="删除" onclick="userCommand('remove');"> <input type="button"
					id="pausebtn" class="sub" value="暂停" onclick="userCommand('pause');"> <input type="button" id="goonbtn" class="sub" value="继续" onclick="userCommand('resume');">
				</td>

			</tr>

		</table>
	</form>

	<script language="javascript">
		function userCommand(action) {
			var frm=document.getElementById("quartzs");
			if(!checkState(action)) return;
			var box = getSelectRow();
			if(box!=null){
				var values=box.value.split(",");
				var taskName = values[0];
				var state = values[1];	
				document.getElementById("taskName").value=taskName;
			}
			
			switch(action) {
			case "add":
				frm.action=servletPath+"/console/schedule/entryAddTask.action";
				frm.submit();
				break;
			case "update":
				frm.action=servletPath+"/console/schedule/entryUpdateTask.action";
				frm.submit();
				break;
			case "remove":
				if(confirm("要删除该任务，确认吗?")){
					frm.action=servletPath+"/console/schedule/deleteTask.action";
					frm.submit();
				}
				break;
			case "resume":
				frm.action=servletPath+"/console/schedule/resumeTask.action";
				frm.submit();
				break;
			case "pause":
				frm.action=servletPath+"/console/schedule/pauseTask.action";
				frm.submit();
				break;
					
			}
		}
		
		var STATE_NORMAL = "0";
		var STATE_PAUSED = "1";
		var STATE_COMPLETE = "2";
		var STATE_ERROR = "3";
		
		
		function getSelectRow(){
			var checkboxes=document.getElementsByName("selectedItem");
			for(var i=0;i<checkboxes.length;i++){
				if(checkboxes[i].checked){
					return checkboxes[i];
				}
			}
			return null;
		}
		
		function checkState(command) {
			if(command=="add" )
				return true;
			
			var box = getSelectRow();
			if(box==null){
				alert("未选中编辑的任务!");
				return false;
			}
			var values=box.value.split(",");
			var taskName = values[0];
			var state = values[1];
			switch(command) {
				case "add": return true;
				case "update": return true;
				case "remove": return true;
				case "resume":
						if(state == STATE_COMPLETE) {
							alert("任务[" + taskName + "]已经完成,不能继续执行");
							return false;
						}
						if(state == STATE_NORMAL) {
							alert("任务[" + taskName + "]状态正常，不能继续执行!");
							return false;
						}
						if(state == STATE_ERROR) {
							alert("任务[" + taskName + "]状态异常，无法继续执行!");
							return false;
						}
					
					break;
				case "pause":
						if(state == STATE_COMPLETE) {
							alert("任务[" + taskName + "]已完成,不能暂停!");
							return false;
						}
						if(state == STATE_PAUSED) {
							alert("任务[" + taskName + "]已经暂停");
							return false;
						}
						if(state == STATE_ERROR) {
							alert("任务[" + taskName + "]状态异常，不能暂停!");
							return false;
						}
					
					break;
			}
			return true;
		}
	</script>
</body>
