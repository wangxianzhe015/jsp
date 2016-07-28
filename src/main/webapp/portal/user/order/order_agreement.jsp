<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta name="copyright" content="众投客">
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="众投客电子协议预览"></c:set>
	<%@include file="../../common/meta.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/order-confirm.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>

	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/font-awesome.css">
	
	<script>
    $(document).ready(function(){	
		$("#exportPdf").click(function(){
			$("#form1").attr("action","<%=servletPath%>/portal/order/exportPdf.action");
			$("#form1").submit();
		});
		
		$("#confirmBtn").click(function(){
			$("#form1").attr("action","<%=servletPath%>/portal/order/entryPayConfirm.action");
			$("#form1").submit();
		})		
    })
	</script>
<style>
body {
	margin: 0;
	padding: 0;
	font-family: "Microsoft Yahei";
	background: #fff;
}

.wap_contract {
	overflow-y: scroll;
	height: 500px;
	width: 1024px;
	margin: 0 auto;
	margin-top: 50px;
}

.contract_html {
	width: 900px;
	margin: 0 auto;
	min-height: 600px;
}

.contract_html h4 {
	text-align: center;
}

table {
	border-collapse: collapse;
	font-size: 14px;
	font-family: Microsoft Yahei;
}

table td {
	border: solid #000 1px;
	padding: 8px;
}

</style>
</head>
<%@include file="../../common/uc_header.jsp"%>

<body class="page-header">
	<div class="clearfix mt20">
		<div class="z_container">
			<div class="order_process">
				<ul>
					<li class="active">协议确认 <span class="order_behind_arrow order_arrow"></span>
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
					<li >订单确认 <span
						class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>支付 <span class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>完成 <span class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
				</ul>
			</div>


	<form class="form" id="form1" method="post" action="<%=servletPath%>/portal/order/entryPayConfirm.action">
		<input type="hidden" name="orderId" value="${order.orderId }"/>
		<div class="wap_contract">
			<div class="contract_html">
			<jsp:include page="/downloads/${order.orderId}.html"></jsp:include>
			</div>
		</div>
		<div
			style="margin: 0 auto;width:900px;text-align:center;padding:20px;">
			<button id="confirmBtn" type="button" style="background:#ea544a !important;color:#fff;border:none;cursor:pointer; font-family:Microsoft Yahei;width:200px;height:36px;">我已阅读并同意该协议内容</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button id="exportPdf" type="button" style="background:#3498DB !important;color:#fff;border:none;cursor:pointer; font-family:Microsoft Yahei;width:200px;height:36px;">下载该协议</button>
		</div>
	</form>
	
	</div>
	</div>
</div>
<%@include file="../../common/footer.jsp"%>
</body>
</html>