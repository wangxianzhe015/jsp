<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="我认购的项目"></c:set>
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
				<!-- 左侧菜单 -->
				<%@include file="../uc_menu.jsp"%>
			</div>
			
			
			<div class="col-23 bg_white">
		
				<div class="clear user_tit_box">
					<div class="fl user_tit font-wet">我认购的项目</div>
				</div>

				<div class="gray_tit_box mt-10">
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action" <c:if test="${empty projectState || projectState=='' }">class="now" </c:if>>全部</a> 
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action?projectState=prepared" <c:if test="${projectState=='prepared' }">class="now" </c:if> >预约认购</a>
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action?projectState=financing" <c:if test="${projectState=='financing' }">class="now" </c:if>>上线融资</a>
					<a href="<%=servletPath %>/portal/uc/findSubscribeProject.action?projectState=successed" <c:if test="${projectState=='successed' }">class="now" </c:if>>融资成功</a>
				</div>


				<c:forEach items="${projects}" var="project" varStatus="index">
					<div class="clear gray_bg mt-10" id="project_${project.projectId }">
						<div class="col-6 mr-10">
							<div class="user_pic text-c">
								<a href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
									title="${project.projectName }" target="_blank"> 
									<img src="${project.projectImage }" />
								</a>
							</div>
							<div class="text-c mt-5">
								<a href="javascript: void(0)" data-eventname="message"
									data-project-id="${project.projectId }" data-guide="${project.userName}tKakPM">+发私信</a>
							</div>
						</div>
						<div class="col-16 mr-10">
							<div class="blue user_bt">
								<a href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
									title="${project.projectName }" target="_blank">${project.projectName }</a>
							</div>
							<div style="margin: 10px 0px 0px 0px">
                                     <p class="lh24">
 									 <c:if test="${project.subscribeType=='prebuy' &&project.projectState=='financing' }">
										 <a href="<%=servletPath %>/portal/uc/buy.action?projectId=${project.projectId}">去认购</a>
                                     </c:if>
                                     <c:if test="${project.subscribeType=='prebuy' && project.projectState=='prepared' }">
										 已预购
                                     </c:if>
                                     <c:if test="${project.subscribeType=='buy' }">
                                     	已认购
                                     </c:if>
							</div>
							<div class="clear">
								<div class="col-6 mr-10 index_cont_div">
									<p class="lh24 index_cont_text">地区：${project.provinceName }${project.cityName }${project.address }</p>
									<p class="lh24 index_cont_text">行业：${project.industryCategoryName}</p>
									<p class="lh24 index_cont_text">状态：${project.projectStateName }</p>
								</div>
								<div class="col-5 mr-10 index_cont_div">
									<p class="lh24 index_cont_text">融资金额:￥${project.financeAmount}元</p>
									<p class="lh24 index_cont_text">融资完成率:${project.progress}%</p>
								</div>
								<div class="col-5 index_cont_div">
									<p class="lh24 index_cont_text" style="margin-top: 25px;">最低投资金额:￥${project.minInvestAmount }元</p>
								</div>
							</div>
							<div class="">
							</div>
						</div>
					</div>
	
	
					<div class="user_ico_box " id="project_status_${project.projectId }">
						<ul>
						   <%
						     /*
						     	<li>
									<p>发布</p>
									<p class="mt-8">2015/06/11</p>
								</li>
								<li>
									<p>预约认购</p>
									<p class="mt-8">2015/07/15</p>
								</li>
								<li>
									<p>上线融资</p>
									<p class="mt-8">2015/08/10</p>
								</li>
								<li>
									<p>融资完成</p>
									<p class="mt-8">2015/08/10</p>
								</li>
								<li class="gray_ico">
									<p>放款完成</p>
								</li>
								<li class="gray_ico">
									<p>选址</p>
								</li>
								<li class="gray_ico">
									<p>装修</p>
								</li>
								<li class="gray_ico">
									<p>采购</p>
								</li>
								<li class="gray_ico">
									<p>开业</p>
								</li>
								<li class="gray_ico">
									<p>项目分红</p>
								</li>
						     */
						   %>
						   <c:forEach items="${definitionStates}" var="definitionState">
						            <c:set var="finishDate" value=""/>
						            <c:set var="isPass" value=""/>
						            <c:set var="comment" value=""/>
									<c:forEach items="${project.projectProgresses}" var="projectProgress" >
									   <c:if test="${projectProgress.projectState==definitionState.dictId }">
									   		<c:set var="finishDate" value="${projectProgress.finishDate }"/>
									   		<c:set var="isPass" value="${projectProgress.dealResult }"/>
									   		<c:set var="comment" value="${projectProgress.dealOpion }"/>
									   </c:if>
									</c:forEach>
								   
									<c:choose>
										<c:when test="${isPass=='Y'}">
									     <li>
											<p>${definitionState.dictName }</p>
											<p class="mt-8"><fmt:formatDate value="${finishDate}" pattern="yyyy-MM-dd"/></p>
										 </li>
										</c:when>
										<c:otherwise>
									      <li class="gray_ico">
											<p>${definitionState.dictName }</p>
										  </li>
										</c:otherwise>
									</c:choose>
							</c:forEach>
						</ul>
					</div>
					<div class="clear bk3" id="project_clear_${project.projectId }"></div>
				
				</c:forEach>
			</div>

		</div>
		<div class="pages">
			<%@include file="./page.jsp" %>
		</div>
	</div>

	<%@include file="./modal_message.jsp" %>
	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>
</body>
</html>