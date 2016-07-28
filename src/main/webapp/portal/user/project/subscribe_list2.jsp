<%@page import="com.smartcloud.platform.component.common.utils.DateUtils"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<c:set var="pageTitle" value="我认购的项目"></c:set>
<%@include file="../../common/meta.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=resourcePath%>/css/common.css" />
<link rel="stylesheet" rev="stylesheet" href="<%=resourcePath%>/css/subscribe2.css" type="text/css">
<script type="text/javascript" src="<%=resourcePath%>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath%>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath%>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath%>/js/index/png.js"></script>
<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index.css" />
<style>
		 .unpaybtn { width: 100px; height: 30px;display: inline-block;line-height: 30px; text-align: center; color: #fff; text-decoration: none; background: #ff8758; margin-right: 10px;  border: none; cursor: pointer;}
		 .paidbtn { width: 100px; height: 30px;display: inline-block;line-height: 30px; text-align: center; color: #fff; text-decoration: none; background: #7B7777; margin-right: 10px;  border: none; cursor: pointer;}
		 		
</style>

<script>

function closeProgress(orderId){
	$("#detail_"+orderId).hide();
}
$(document).ready(function(){
	$("[id=viewOrderProgress]").click(function(){
		$("#detail_"+$(this).attr("data-orderId")).toggle();
	});
	
	$("[id=payBtn]").click(function(){
		var projectId=$(this).attr("data-projectId");
		var orderId=$(this).attr("data-orderId");
		var nums=$(this).attr("data-nums");
		$.post("<%=servletPath%>/portal/uc/checkBuyNum.action",{'projectId':projectId,'nums':nums},function(data){  
 			if(data.code==-1)
 			{
 				popBox(data.message,'error');
 				return ;
 			}else{
 				window.location.href="<%=servletPath%>/portal/order/entryAgreement.action?orderId="+orderId;
 			}
	    },"json");
		
	});
	$("[id=repayBtn]").click(function(){
		var projectId=$(this).attr("data-projectId");
		var orderId=$(this).attr("data-orderId");
		var nums=$(this).attr("data-nums");
		$.post("<%=servletPath%>/portal/uc/checkBuyNum.action",{'projectId':projectId,'nums':nums},function(data){  
 			if(data.code==-1)
 			{
 				popBox(data.message,'error');
 				return ;
 			}else{
 				window.location.href="<%=servletPath%>/portal/order/repay.action?orderId="+orderId;
 			}
	    },"json");
		
	});	
	
	
	$("[id=exportPdf]").click(function(){
		window.location.href="<%=servletPath%>/portal/order/exportPdf.action?orderId="+$(this).attr("data-orderId");
	});
});
</script>
</head>
<body>
	<%@include file="../../common/uc_header.jsp"%>

	<div class="wrap clear">
		<div class="row mt-20">
			<div class="col-7 mr-10">
				<!-- 左侧菜单 -->
				<%@include file="../uc_menu.jsp"%>
			</div>
			
			
			<div class="col-23 bg_white">
		
				<div class="clear user_tit_box">
					<div class="fl user_tit font-wet">我认购的项目</div>
				</div>

				<div class="gray_tit_box mt-10">
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action" <c:if test="${empty flag || flag=='' }">class="now" </c:if>>全部</a> 
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action?flag=0" <c:if test="${flag=='0' }">class="now" </c:if> >待付款项目</a>
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action?flag=1" <c:if test="${flag=='1' }">class="now" </c:if>>已付款项目</a>
				</div>


				<div class="rightMain">
					<div class="my_list">
						<div id="placeContent" style="color:#e8eff6">
						
						<c:if test="${!empty orders }">
							<c:forEach items="${orders}" var="order" varStatus="index">
								<c:set var="last" value=""/>
								<c:set var="createTime" value="${order.createTime }"/>
								<c:if test="${index.count==orders.size() }">
									<c:set var="last" value="last"/>
								</c:if>
								
								<%
								  java.util.Date createTime=(java.util.Date)pageContext.getAttribute("createTime");
								  String mm=DateUtils.formatDate(createTime, "MM"); 
								  String dd=DateUtils.formatDate(createTime,"dd");
								  String week=DateUtils.formatDate(createTime,"EEEE");
								  week=week.replace("星期", "周");
								%>
								<div class="my_list_detail ${last }">
									<!--日期开始-->
									<div class="date left">
										<div class="date_week right"><%=week %></div>
										<div class="month left"><%=mm %>月</div>
										<div class="day left">
											<h1 class="font_wryh zh_font"><%=dd %></h1>
										</div>
										<div class="clear"></div>
									</div>
									<!--日期结束-->
									<div class="detail_box right">
										<!--单条内容开始-->
										<div class="detail_one">
											<div class="detail_info" method="detail_info">
				
												<div class="detail_nmdt">
				
													<a href="" class="del_curr right"></a> <span>订单号：<b>${order.orderId }</b></span>
				
													<span>订单时间：<b>${order.createTime }</b></span>
				
												</div>
				
												<ul>
													<li class="info_icon">
														<a href="<%=servletPath%>/portal/main/showProject.action?projectId=${order.project.projectId}">
														<img src="${order.project.projectImage }" alt="${order.project.projectName }" width="100px" height="100px">
														</a>
													</li>
													<li class="info_txt" style="padding-left:30px;">
														<h1>
															<a class="font_wryh font_for_en" href="<%=servletPath%>/portal/main/showProject.action?projectId=${order.project.projectId}">${order.project.projectName }</a>
														</h1>
														<p>
															<span class="price" isrmb="true" cur="RMB" curprice="${order.totalAmount }">认购金额:&nbsp; ${order.totalAmount }</span>元 &nbsp;&nbsp;&nbsp;&nbsp;
															<span class="price" isrmb="true" cur="RMB" curprice="${order.totalAmount }">认购份数:&nbsp; ${order.nums }</span>份 &nbsp;&nbsp;
															<c:choose>
																<c:when test="${order.project.projectState=='prepared' }">
																</c:when>
																<c:otherwise>
																	<span class="price" isrmb="true" cur="RMB" curprice="${order.totalAmount }">剩余:&nbsp;${order.project.remainingCopies }</span>份 
																</c:otherwise>
															</c:choose>
														</p>
														<p>	
														    <em>融资进度:&nbsp; ${order.project.progress}%</em> &nbsp;&nbsp; &nbsp;&nbsp;状态：${order.project.projectStateName }
															<div class="progress-s progress-s2 hotMargin">
																<p>
																	<b style="width: ${order.project.progress}%"></b>
																</p>
																
															</div>
															<span class="cbbb"></span>
														</p>
														<p method="addressphone">地址：${order.project.provinceName }${order.project.cityName }${order.project.address }</p>
				

				
													</li>
													<li class="info_price trace_done" style="padding-right:10px;">
														<h2>
															<span class="icon_trace"></span> ${order.orderStateName }
															<p class="t_w"></p>
				
														</h2> 
														<a id="viewOrderProgress" data-orderId="${order.orderId }" class="check" style="margin-left:30px"> 查看订单进度 <span class="icon"></span></a>
				
													</li>
													<li class="info_trace">
														<p>
																   <c:if test="${order.project.projectState=='prepared' }">
																        <button class="paidbtn">等待付款</button>
																   </c:if>
																   <c:if test="${order.project.projectState=='financing' }">
																	<c:choose>
																		<c:when test="${order.orderState.value=='00'}">
																    		<button id="payBtn" class="unpaybtn" data-orderId="${order.orderId }" data-projectId="${order.project.projectId}" data-nums="${order.nums }">立即支付</button>
																		</c:when>
																		<c:when test="${order.orderState.value=='10' || order.orderState.value=='20' ||order.orderState.value=='30'}">
																    		<button class="paidbtn" data-orderId="${order.orderId }" style="background: #2ca9e3">付款成功</button>
																		</c:when>
																		<c:when test="${order.orderState.value=='11' || order.orderState.value=='21'}">
																    		<button id="repayBtn" class="unpaybtn" data-orderId="${order.orderId }" data-projectId="${order.project.projectId}" data-nums="${order.nums }">重新支付</button>
																		</c:when>
																		
																		<c:otherwise>
																    		
																		</c:otherwise>
																	</c:choose> 									   
																   </c:if>
																   <c:if test="${order.project.projectState=='successed' }">
																   		<button class="paidbtn">融资完成</button>
																   </c:if>
																   
	
														</p>
														<p>
															<br/>
															<span id="exportPdf" style="color:#2891d7;" data-orderId="${order.orderId }">下载协议</span>
														</p>
													</li>
												</ul>
											</div>
											<div class="clear"></div>
											<div class="detail_ems" id="detail_${order.orderId}"style="display: none;">
												<div class="progressBar">
													<ul class="progressBar_txt">
														<li class="first">
															<p>提交订单</p>
														</li>
				
														<li>
															<p>订单支付</p>
														</li>
				
														<li>
															<p>平台确认</p>
														</li>
				
														<li>
															<p>订购完成</p>
														</li>
				
													</ul>
													<div class="bar_off over4">
														<div class="bar_on step${order.step}">
															<div></div>
														</div>
													</div>
												</div>
				
				
												<ul class="order_detail">
													<c:forEach items="${order.records }" var="record">
														
														<li><label><fmt:formatDate value="${record.operTime}" pattern="yyyy-MM-dd HH:mm"/></label>
															<p>${record.operDesc }</p>
														</li>
													</c:forEach>
												</ul>
				
												<div class="clear"></div>
												<a class="ems_close" href="javascript:closeProgress('${order.orderId}')"></a>
											</div>
										</div>
										<!--单条内容结束-->
									</div>
									<div class="clear"></div>
								</div>


			
								</c:forEach>
							</c:if>





							<c:if test="${empty orders }">
								<div class="no_result none" style="color: Black;">您目前还没有订单哦~</div>
							</c:if>
							
						</div>
					</div>
				</div>

			</div>

		</div>
		<div class="pages">
			<%@include file="./page.jsp" %>
		</div>
	</div>
		

	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>
</body>
</html>
