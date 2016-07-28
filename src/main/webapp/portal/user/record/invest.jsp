<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="投资记录"></c:set>
	<%@include file="../../common/meta.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<style>
		 .paybutton {
		    width: 100px;
		    height: 30px;
		    display: inline-block;
		    line-height: 30px;
		    text-align: center;
		    color: #fff;
		    text-decoration: none;
		    background: #ff8758;
		    margin-right: 10px;
		    border: none;
		    cursor: pointer;
		}		
	</style>
	<script type="text/javascript">
	var selected_projectname="";
	var selected_totalamount="";
	var selected_nums="";
	var selected_recordid="";
	
	$(document).ready(
			function() {
				// 排序按钮绑定事件

				$("button[name=payBtn]").bind(
						"click",
						function() {
							
							$("#online_pay_form input[id='projectName']").val($(this).attr("data-projectName"));
							$("#online_pay_form input[id='totalAmount']").val($(this).attr("data-totalAmount"));
							$("#online_pay_form input[id='nums']").val($(this).attr("data-nums"));
							$("#online_pay_form input[id='recordId']").val($(this).attr("data-recordId"));
							
							$("#account_pay_form input[id='projectName']").val($(this).attr("data-projectName"));
							$("#account_pay_form input[id='totalAmount']").val($(this).attr("data-totalAmount"));
							$("#account_pay_form input[id='nums']").val($(this).attr("data-nums"));
							$("#account_pay_form input[id='recordId']").val($(this).attr("data-recordId"));
							
							$("#modal_pay").modal("show");
						});				
				
			}	
	);
	</script>
</head>
<body>
	<%@include file="../../common/uc_header.jsp"%>
	<div class="wrap clear">
		<div class="row mt-20">
			<div class="col-7 mr-10">
				<!--左侧栏-->
				<%@include file="../uc_menu.jsp"%>
			</div>
			<div class="col-23 bg_white">
				<div class="clear user_tit_box">
					<div class="fl user_tit font-wet">最近更新的动态</div>
					<div class="fr more_box">
					    <a href="<%=servletPath %>/portal/uc/investRecord.action" class="now">投资记录</a>
						<a href="<%=servletPath %>/portal/uc/rechargeRecord.action" >充值记录</a> 
						<a href="<%=servletPath %>/portal/uc/withdrawRecord.action">提现记录</a> 
						
					</div>
				</div>
				<div class="buylist_cont" style="margin-top: 10px">
					<div class="buylist_cont_01">
						<div class="border-c buylist_cont_01div">
							<div class="buylist_title">
								<h3>投资记录</h3>
								<form action="<%=servletPath %>/portal/uc/investRecord.action"
									method="post">
									<label for="">日期选择 : </label>
									<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/js/calendar/jscal2.css" />
									<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/js/calendar/win2k.css" />
									<script type="text/javascript" src="<%=resourcePath %>/js/calendar/calendar.js"></script>
									<script type="text/javascript" src="<%=resourcePath %>/js/calendar/cn.js"></script>
									<input type="text" name="search[start_time]" id="start_time" value="" size="10" class="input-text date">&nbsp;
									<script type="text/javascript">
										Calendar.setup({
										weekNumbers: true,
									    inputField : "start_time",
									    trigger    : "start_time",
									    dateFormat: "%Y-%m-%d",
									    showTime: false,
										minuteStep: 1,
									    onSelect   : function() {this.hide();}
										});
							        </script>
									<span> -- </span> <input type="text" name="search[end_time]" id="end_time" value="" size="10" class="input-text date">&nbsp;
									<script type="text/javascript">
										Calendar.setup({
										weekNumbers: true,
									    inputField : "end_time",
									    trigger    : "end_time",
									    dateFormat: "%Y-%m-%d",
									    showTime: false,
										minuteStep: 1,
									    onSelect   : function() {this.hide();}
										});
							        </script>
									
									<select name="search[status]">
									    <option value='' selected>全部</option>
									    <c:forEach items="${payStates}" var="payState">
									       <option value='${payState.dictId }'>${payState.dictName }</option>
									    </c:forEach>
									</select>
									<button>查询</button>
								</form>
							</div>
							<div class="buylist_table">
								<table>
									<tr class="weight_tr" style="border-bottom: solid 1px #d2d2d2;">
										<td>交易流水</td>
										<td>认购项目</td>
										<td>认购份数</td>
										<td>总金额(元)</td>
										<td>协议确认</td>
										<td>支付时间</td>
										<td>支付方式</td>
										<td>状态</td>
									</tr>
									<c:if test="${empty investRecords }">
										<tr>
											<td colspan="6"><img src="<%=resourcePath %>/images/i-warning.png">
												您当前没有投资记录。<a href="<%=servletPath %>/portal/main/projectlist.action"
												target="_blank">去看看最新项目吧>></td>
										</tr>
									</c:if>
									<c:if test="${!empty investRecords }">
										<c:forEach items="${investRecords}" var="record" varStatus="index">
											<tr>
												<td>
												   <c:out value="${record.orderId }"/>
												</td>
												<td>
													<c:out value="${record.project.projectName}"></c:out>
												</td>	
												<td>
													<c:out value="${record.nums}"></c:out>
												</td>																									
												<td>
													<c:out value="${record.totalAmount}"></c:out>
												</td>
												<td>
													<c:out value="${record.checkAgreement}"></c:out>
												</td>												
												<td>
													<c:out value="${record.payTime}"></c:out>
												</td>
												<td>
													<c:out value="${record.payTypeName}"></c:out>
												</td>													
												<td>
													<c:choose>
														<c:when test="${record.payState=='unpay'}">
												    		<button name="payBtn" class="paybutton " 
												    		data-recordId="${record.recordId }"
												    		data-projectName="${record.project.projectName }"
												    		data-totalAmount="${record.totalAmount }"
												    		data-nums="${record.nums }">立即支付</button>
														</c:when>
														<c:otherwise>
															<c:out value="${record.payStateName}"></c:out>
														</c:otherwise>
													</c:choose> 		
												</td>
																																																																						
											</tr>									
										</c:forEach>
									</c:if>									
								</table>
								<!--分页-->
								<div class="pages">
								  <%@include file="./page.jsp" %>
								</div>
								<div class="bk3"></div>
							</div>
						</div>
					</div>
					<!-- buylist_cont_01结束 -->
				</div>
			</div>
			<!-- col-23结束 -->
		</div>
	</div>
	
	<%@include file="./modal_pay.jsp" %>
	<%@include file="../../common/footer.jsp"%>
</body>
</html>