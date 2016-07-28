<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>银行卡绑定查询</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/module_gridTable.js"></script>
<script>
(function($){
	$( function() {
		$("#queryBtn").click( function() {
			$("#query_form").submit();
		});

		$("#unbindBtn").click( function() {
			var unbindBtn = $(this);

			var bindid = $("[name='bindid']:checked");
			if (bindid.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('确定将选中的银行卡进行解除绑定?', {
					buttons : {
						"确定" : true,
						"取消" : false
					},
					focus : 1,
					submit : function(v) {
						if (v) {
							var action = unbindBtn.data("url");
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
			<form action="<%=servletPath %>/portal/pay/queryBindCard.action" method="post" name="query_form" id="query_form">
				<div class="grid_body">
					<table>
						<thead>
							<tr>
								<th colspan="4" align="left">
									银行卡绑定查询
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>
									输入身份证号码:
								</td>
								<td colspan="3">
									<input type="text" name="identityid" value="" style="width:400px" />
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
						查询结果
					</div>
					<div class="head_right">
						<a href="javascript:void(0);" id="unbindBtn"
							data-url="<%=servletPath %>/portal/pay/unbind.action">解除绑定</a>
							
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
								    身份证号码
								</th>
								<th>
									绑定银行卡ID
								</th>
								<th>
									银行卡号
								</th>
								<th>
									银行卡名称
								</th> 
								<th>
									预留电话
								</th>
								<th>
									绑定有效期
								</th>

							</tr>
						</thead>

						<tbody>
					
						    <c:if test="${not empty result.errorcode}">
						    	<tr>
						    	    <td colspan="7">错误代码：${result.errorcode } &nbsp;&nbsp; 错误信息: ${result.errormsg }</td>
						    	</tr>
						    </c:if>
						    
							<c:forEach items="${result.cardinfos}" var="card" varStatus="index">
								<tr>
									<td class="center">
										<input type="checkbox" name="bindid" id='checkthis${index.count}' title="select ${index.count}"
											value="${card.bindid}_${result.identityid}" />

									</td>								
									<td>
										<c:out value="${result.identityid}"></c:out>
									</td>
									<td>
										<c:out value="${card.bindid }"/>
									</td>
									<td>
										<c:out value="${card.card_top }">******<c:out value="${card.card_last }"/></c:out>
									</td>

									<td>
										<c:out value="${card.cardname}"></c:out>
									</td>
									<td>
								          <c:out value="${card.phone }"></c:out>
									</td>
									<td>
										
										<c:out value="${card.bindvalidthru }"/>
									</td>									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</form>
		</div>

	</body>
</html>
