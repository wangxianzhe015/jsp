<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<%@page import="com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>项目订单管理</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
		<script>
(function($){
	$( function() {
		// 此div必须存在height=一个值
		$("div.a_container_left").resizable({
			minHeight : 200,
			minWidth : 300,
			maxWidth : 400,
			maxHeight : 550
		});

		/**
		 * 初始化弹出窗口
		 */
		$(".refundConfirmDialog").dialog({
			draggable : false,
			resizable : false,
			autoOpen : false,
			modal : true
		});
		$(".userinfoDialog").dialog({
			draggable : false,
			resizable : false,
			autoOpen : false,
			modal : true
		});		
		
		$("#queryBtn").click( function() {
			$("#query_form").submit();
		});

		$("[id=userinfo]").click(function(){
			var userId=$(this).attr("data-userid");
			$.ajax({
				url : servletPath+"/portal/projectinvest/getUserInfo.action?userId="+userId,
				type : 'POST',
				global : false,
				dataType : 'json',
				async: false,
				success : function(data) {
					$("#userinfoDialog #username").html("");
					$("#userinfoDialog #mobileno").html("");
					$("#userinfoDialog #realname").html("");
					$("#userinfoDialog #idcard").html("");
					$("#userinfoDialog #address").html("");
					$("#userinfoDialog #email").html("");
					
					var user=data.user;
					if(user!=null){
						$("#userinfoDialog #username").html(user.userName);
						$("#userinfoDialog #mobileno").html(user.mobileNo);
						$("#userinfoDialog #realname").html(user.realName);
						$("#userinfoDialog #idcard").html(user.identityCard);
						$("#userinfoDialog #address").html(data.address);
						$("#userinfoDialog #email").html(user.email);
					}
				}
			});

			$("#userinfoDialog").dialog({
				title : "查看用户信息",
				height:$.browser.msie?500:"auto",
				width : 750,
				minWidth : 750,
				buttons : {
					"关闭" : function() {
						$(this).dialog("close");
					}
				}
			}).dialog("open");
		});
		
		$("#updateBtn").click( function() {
				var projectId_checked = $("[name='orderId']:checked");
				if (projectId_checked.length > 1) {
					$.prompt("只能选择一个订单!")
				} else if (projectId_checked.length == 0) {
					$.prompt("请选择一个订单!")

				} else {
					var action = $(this).data("url");
					
					$("#result_form").attr("action", action).submit();
				}

			});
		
		$("[id=batchBtn]").click(function(){
			var checked = $("[name='orderId']:checked");
			if (checked.length <= 0) {
				$.prompt("请选择退款的订单!")
			} else {
				var orderIds="";
				for(var i=0;i<checked.length;i++){
					if(i==checked.length-1){
						orderIds+=checked[i].value;
					}else{
						orderIds+=checked[i].value+",";
					}
					
				}
				
				$("#refundConfirmDialog #orderIds").val(orderIds);
				
				$("#refundConfirmDialog").dialog({
					title : "订单退款确认",
					height:$.browser.msie?500:"auto",
					width : 750,
					minWidth : 750,
					buttons : {
						"确定" : function() {
							var validateFormRule = {
								rules : {
									"cause" : {
										required : true,
										maxlength: 20
									}							
								}
							};
							
							var vo = validateForm("form[name='progressForm']", validateFormRule);
							if (vo.form()) {
								var options = {
									dataType : "json",
									error : function() {
										$.prompt('订单退款出错!');
									},
									success : function(data) {
										$.prompt('订单退款信息:<br/>选择记录数:'+data.selectedCount+",退款成功记录:"+data.successCount,{
											submit: function(e,v,m,f){
												window.location.href=servletPath+"/portal/projectinvest/index.action";
											}
										});
										
									}
								};
								$("[name='progressForm']").ajaxSubmit(options);
								$(this).dialog("close");
							}
						},
						"关闭" : function() {
							$(this).dialog("close");
						}
					}
				}).dialog("open");
			}
		});
	});
	
})(jQuery)
</script>
	</head>

	<body>
		<div class="grid">
			<form action="<%=servletPath %>/portal/projectinvest/index.action" method="post" name="query_form" id="query_form">
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
									<input type="text" name="order.project.projectName" value="${order.project.projectName }" size="40px"/>
								</td>
								<td>
									订单号:
								</td>
								<td>
									<input type="text" name="order.orderId" value="${order.orderId }" size="40px"/>
								</td>
							</tr>
							<tr>
								<td>
									项目状态:
								</td>
								<td>
									<select name="order.project.projectState" id="projectState" >
									    <option value="">---全部---</option>
										<c:forEach items="${projectStates}" var="projectState" varStatus="index">
										<option value="${projectState.dictId }" <c:if test="${order.project.projectState==projectState.dictId  }" >selected</c:if> >${projectState.dictName }</option>
										</c:forEach>
									</select>
								</td>
								<td>
									订单状态:
								</td>
								<td>
									<select name="order.orderState" id="orderState" >
									    <option value="">---全部---</option>
										<c:forEach items="${orderStates}" var="orderState" varStatus="index">
										<option value="${orderState.dictId }" <c:if test="${order.orderState.value==orderState.dictId  }" >selected</c:if>>${orderState.dictName }</option>
										</c:forEach>
									</select>
								</td>								
							</tr>
							
							<tr>
							   <td>
									订单是否有效:
								</td>
								<td>
									<input type="radio" name="order.valid" value="1" <c:if test="${order.valid=='1' }">checked</c:if> />有效 
									<input type="radio" name="order.valid" value="0" <c:if test="${order.valid=='0' }">checked</c:if> />无效
									
								</td>
								<td>
								  每页显示：
								</td>
								<td>
								   <input type="text" name="page.pageSize" value="${page.pageSize}" size="10px"/>条
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
						认购订单列表
					</div>

					<div class="head_right">
						<a href="javascript:void(0);" id="updateBtn"
							data-url="<%=servletPath %>/portal/projectinvest/entryUpdate.action">审核订单</a>
						
						<a href="javascript:void(0);" id="batchBtn"
							data-url="<%=servletPath %>/portal/projectinvest/entryUpdate.action">批量选择订单退款</a>
							
							
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
									订单号
								</th>
								<th>
									项目名称
								</th>
								<th>
									项目状态
								</th> 
								<th>
									订购人
								</th>
								<th>
									总金额
								</th>
								 <th>
									份数
								</th>
								<th>
									订单状态
								</th>
								<th>
									支付方式
								</th>
								<th>
									订单时间
								</th>
								<th>
									付款时间
								</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${orders}" var="order" varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="orderId"
											id='checkthis${index.count}' title="select ${index.count}"
											value="${order.orderId}" />

									</td>
									<td>
										<c:out value="${order.orderId}"/>
									</td>
									<td>
										<c:out value="${order.project.projectName}"></c:out>
									</td>
									<td>
										<c:out value="${order.project.projectStateName}"></c:out>
									</td>
									<td>
										<a id="userinfo" data-userid="${order.userId }"><c:out value="${order.userName }"/> </a>
									</td>	
									<td>
									    <c:out value="${order.totalAmount }"/>
									</td>
									<td>
									    <c:out value="${order.nums }"/>

									</td>
									<td>
									    <c:out value="${order.orderStateName }"/>

									</td>
									<td>
									    <c:out value="${order.payTypeName }"/>

									</td>
								
									<td>
										<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>																		
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
			<form action="<%=servletPath %>/portal/projectinvest/pageQuery.action" method="post" name="page_form" id="page_form">
				<input type="hidden" name="order.project.projectName" value="${order.project.projectName}" />
				<input type="hidden" name="order.project.projectState" value="${order.project.projectState}" />
				<input type="hidden" name="order.valid" value="${order.valid }"/>
				<input type="hidden" name="order.orderId" value="${order.orderId }"/>
				
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
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/projectinvest/pageQuery.action" data-formId="page_form">

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
									href="javascript:firstPage('<%=servletPath %>/portal/projectinvest/pageQuery.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/portal/projectinvest/pageQuery.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/portal/projectinvest/pageQuery.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/portal/projectinvest/pageQuery.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>

		</div>

		<div class="refundConfirmDialog" title="订单退款确认" id="refundConfirmDialog">
				<jsp:include page="refund_confirm.jsp"></jsp:include>
		</div>
		<div class="userinfoDialog" title="查看用户信息" id="userinfoDialog">
				<jsp:include page="user_info.jsp"></jsp:include>
		</div>		
	</body>
</html>
