<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="充值记录"></c:set>
	<%@include file="../../common/meta.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
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
					<div class="fl user_tit font-wet">交易记录</div>
					<div class="fr more_box">
						<a href="<%=servletPath %>/portal/uc/rechargeRecord.action" class="now">充值记录</a>
						<a href="<%=servletPath %>/portal/uc/withdrawRecord.action">提现记录</a> 
						<a href="<%=servletPath %>/portal/uc/refundRecord.action">退款记录</a>
						
					</div>
				</div>
				<div class="buylist_cont">
					<div class="buylist_cont_01">
						<div class="border-c buylist_cont_01div">
							<div class="buylist_title">
								<h3>充值明细</h3>
								<form action="<%=servletPath %>/portal/uc/rechargeRecord.action" method="post">
									<label for="">日期选择 : </label>
									<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/js/calendar/jscal2.css" />
									<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/js/calendar/win2k.css" />
									<script type="text/javascript" src="<%=resourcePath %>/js/calendar/calendar.js"></script>
									<script type="text/javascript" src="<%=resourcePath %>/js/calendar/lang/cn.js"></script>
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
									<span> -- </span> 
									<input type="text" name="search[end_time]" id="end_time" value="" size="10" class="input-text date">&nbsp;
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
									<button>查询</button>
								</form>
							</div>
							<div class="buylist_table">
								<table>
									<tr class="weight_tr" style="border-bottom: solid 1px #d2d2d2;">
										<td>交易流水</td>
										<td>充值时间</td>
										<td>充值金额</td>
										<td>支付状态</td>
										<td>错误描述</td>
									</tr>
									<c:if test="${empty rechargeRecords }">
										<tr>										   
											<td colspan="5">
												<img src="<%=resourcePath %>/images/i-warning.png">你当前没有充值记录
											</td>
										</tr>
									</c:if>
									<c:if test="${!empty rechargeRecords }">
										<c:forEach items="${rechargeRecords}" var="record" varStatus="index">
											<tr>
												<td>
													<c:out value="${record.orderId}"></c:out>
												</td>
												<td>
												   <c:out value="${record.rechargeTime}"></c:out>
												</td>
												<td>
													<c:out value="${record.amount}"></c:out>
												</td>	
												<td>
												     <c:choose>
												        <c:when test="${record.payState=='Y' }">成功</c:when>
												        <c:when test="${record.payState=='N' }">失败</c:when>
												        <c:otherwise>
												            	未知
												        </c:otherwise>
												     </c:choose>
												</td>	
												<td>
												    <c:out value="${record.errorMsg}"></c:out>
												</td>																				
											</tr>									
										</c:forEach>
									</c:if>
								</table>
								<!-- 分页 -->
								<div class="pages">
								  <%@include file="./page.jsp" %>
								</div>
								<div class="bk3"></div>
							</div>
						</div>
						<!-- buylist_cont_01结束 -->
					</div>
				</div>
				<!-- col-23结束 -->
			</div>
		</div>
		<!--首页底部-->
		<%@include file="../../common/footer.jsp"%>
</body>
</html>