<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/order-confirm.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script>
$(document).ready(function(){
   $("[id=backBtn]").click(function(){
	   window.location.href="<%=servletPath%>/portal/uc/findSubscribeProject.action";
   })

});
</script>
</head>
<%@include file="../../common/uc_header.jsp"%>
<body class="page-header">
	<div class="clearfix mt20">
		<div class="z_container">
			<div class="order_process">
				<ul>
					<li>协议确认 <span class="order_behind_arrow order_arrow"></span>
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
					<li class="active">订单确认 
						<span class="order_behind_arrow order_arrow"></span> 
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>支付 
					    <span class="order_behind_arrow order_arrow"></span> 
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>完成 
						<span class="order_behind_arrow order_arrow"></span> 
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
				</ul>
			</div>
			<div class="module_wrap mt20">
				<div class="common_tit">
					<h1 class="common_tit_name icon_ok">订单提交成功：${order.project.projectName }</h1>
				</div>
				<div class="module_con">
					<div class="module_item">
						<dl>
							<dt>订单号：</dt>
							<dd>${order.orderId }</dd>
						</dl>
						<dl>
							<dt>联系人：</dt>
							<dd>${orderUser.userName }</dd>
						</dl>
						<dl>
							<dt>联系方式：</dt>
							<dd>${orderUser.mobileNo}</dd>
						</dl>
						<dl>
							<dt>备注：</dt>
							<dd>&nbsp;</dd>
						</dl>
					</div>
					<div class="module_item">
						<dl>
							<dt>收货人信息：</dt>
							<dd>
								<div class="clearfix">
									<p>联系人:${orderUser.userName }  联系电话:${orderUser.mobileNo } </p>
									<p>${orderUser.contactProvinceName}${orderUser.contactCityName}${orderUser.contactAddress }(邮编:${orderUser.contactZip })</p>
								</div>
							</dd>

						</dl>
					</div>
					<table border="0" cellspacing="0" cellpadding="0"
						class="table01 mt20">
						<thead>
							<tr>
								<th>项目名称</th>
								<th>发起人</th>
								<th>投资回报</th>
								<th>份数</th>
								<th>持股比例</th>
								<th>总金额</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><a target="_blank"
									href="<%=servletPath%>/portal/main/showProject.action?projectId=${order.project.projectId}">${order.project.projectName }</a></td>
								<td>${order.project.userName }</td>
								<td>
									<div class="default_txt pr">
										<div style="width:455px;">
											${order.project.stockholderRepay }
										</div>
										<div class="hover_div" style="display:none;">
											<i class="icon_upb"></i>
											${order.project.stockholderRepay }
										</div>
									</div>
								</td>
								<td><span class="f_red">${order.nums}</span></td>
								<td><span class="f_red">${order.incomeRate}%</span></td>
								<td>￥${order.totalAmount}元</td>
							</tr>
						</tbody>
					</table>
					<div class="total930" style="margin: 3px 35px 0 35px;">
						<strong class="f_gery14">应付金额&nbsp;&nbsp;</strong><span
							class="f_red28">￥${order.totalAmount }</span>
					</div>
					<div class="common_button">
						<form action="<%=servletPath %>/portal/order/entryPay.action" method="POST">
							<button type="submit" id="paynow" style="cursor: hand;">立即付款</button>
							<button type="button" id="backBtn" class="btn_grey"  style="cursor: hand;">返回</button>
							<input type="hidden" id="orderId" name="orderId" value="${order.orderId }"/> 
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>

<%@include file="../../common/footer.jsp"%>	
</body>

</html>