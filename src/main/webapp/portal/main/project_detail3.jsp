<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="${project.projectName }"></c:set>
<%@include file="../common/meta.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/ali-detail-min.css" />

<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index.css" />
<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/user.css" />
<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/project-detail.css" />

<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/project-detail.js"></script>
<style>
body.page-header {background: none repeat scroll 0 0 #F3F3F3;}
.schedule-box .sponsor {
    position: relative;
    z-index: 1;
    padding: 0 15px 0 45px;
    color: #333;
    height: 200px;
}
.schedule-box .shop-link {
    display: inline-block;
    width: 66px;
    height: 66px;
    float: left;
    margin-right: 13px;
}
.schedule-box .sponsor-pic {
    float: left;
    margin-right: 13px;
    margin-top:20px;
    width: 90px;
    height:90px;
    -webkit-border-radius: 33px;
    -moz-border-radius: 33px;
    border-radius: 33px;
}
.schedule-box .sponsor .sponsor-tmall {
    float: left;
    position: relative;
    top: 5px;
    margin-right: 4px;
}
.schedule-box .ww-light {
    margin-top: 2px;
    margin-right: 10px;
    display: block;
    float: left;
}
.schedule-box .sponsor-name {
    display: block;
    float: left;
    height: 30px;
    line-height: 30px;
    width: 135px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-break: break-all;
    word-wrap: break-word;
    font-size: 15px;
    font-weight: 700;
}
.schedule-box .sponsor-intro {
    float: left;
    width: 200px;
    display: block;
    height: 36px;
    word-break: break-all;
    word-wrap: break-word;
    overflow: hidden;
}
</style>
<script>
var projectId = "${project.projectId}";
var isAttention = "${isAttention}";
var sign = "";
var shareId = parseInt("0");
var position = "";
var caches = [];
var totalNum = parseInt("${project.subscribeCount}");
var lestFinance = "${project.minInvestAmount}";
var pretotalpeople = parseInt("${subscribedInverstorCount}");
var pretotalnum = parseInt("${subscribedTotalCopies}");

function showShareTab(tabId){
    for (var i = 1; i <= 7; i++) {
        $("#ShowContent" + i).hide();
    }	
    $("#ShowContent" + tabId).show();
}

//关注
function attention(){
    $("#attention").unbind("click");
    var op = Math.abs(isAttention - 1);
    $.ajax({
        type: "get",
        url: "<%=servletPath%>/portal/uc/attention.action",
        dataType: "json",
        data: {"op": op, "projectId": projectId},
        success: function(data){
            if (data.code == 1) {
                isAttention = op;
                if (op) {
                    $("#focusCount").html(parseInt($("#focusCount").html()) + 1);
                    $("#attentionText").html("已关注");
                } else {
                    $("#focusCount").html(parseInt($("#focusCount").html()) - 1);
                    $("#attentionText").html("关注");
                }
                popBox(data.message, 'success', 3);
            } else {
                popBox(data.message, 'info', 3, function(){
                    if (data.nologin != undefined) {
                        common_show_user();
                    }
                });
            }
            $("#attention").bind("click", attention);
        }
    });
}
$(document).ready(function(){
    $("li[data-eventname=menu],span[data-eventname=menu]").bind("click", function(){
        var tabId = $(this).attr("data-id");
        showShareTab(tabId);
        // 评论选项卡 TODO :待实现
        if (tabId == 5) {
            //pager("http://www.renrentou.com/comment/comment/project_id/8630/p/1", 0);
        }
    });	
    
    // 关注项目
    $("#attention").bind("click", attention);    
});

</script>
</head>

<body class="page-header">
<%@include file="../common/header.jsp" %>
<div id="main" class=" tmall- page-not-market  w1190">
		<div class="layout">
			<div id="J_Detail">
			
				<div class="project-title">
					<h1>${project.projectName }</h1>
					<a class="interest"  data-focus="" data-unfocus="">
						<i style="cursor: pointer;font-size: 28px" class='<c:if test="${empty sessionUser }">ajax_login</c:if>' id="attention" class="int-status" ></i>
						<i>
						<span id="attentionText">
							<c:choose>
									<c:when test="${isAttention=='1'}">
									 已关注
									</c:when>
									<c:otherwise>
									关注
									</c:otherwise>
							</c:choose>
						</span></i> <i>(<span class="J_LikeNum" id="focusCount">${project.focusCount}</span>)</i>					
				
					</a>

				</div>
				
				<div class="project-content">
						<div class="col-left J_ProjectContent">
							<div class="cover">
								<img width="794px" height="405px" src="${project.projectImage }" class="cover-img">
							</div>
							<div class="content">
							    <h2 class="title">项目简介 <span class="position-span5" title="${project.provinceName }${project.cityName}">${project.provinceName }${project.cityName}</span></h2>
							    <div style="padding: 10px 20px;  min-height: 10px;">
							    	<div>${project.projectProfile }</div>
							    </div>
							    <div  style="padding: 10px 20px;">地址:${project.address }</div>
								<div class="details-content2">
									<div class="details-center">
										<div class="details-center-l">
											<ul class="shop-list" id="shopList">
												<li class="on" data-id="1" data-eventname="menu"><a href="javascript:;">项目介绍</a></li>
												<li class="<c:if test="${empty sessionUser }">ajax_login </c:if>" 
													data-id="2" data-eventname="menu"><a
													href="javascript:;">融资情况</a></li>
												<li
													class="<c:if test="${empty sessionUser }">ajax_login </c:if>"
													data-id="3" data-eventname="menu"><a
													href="javascript:;">股东回报</a></li>
												<li
													class="<c:if test="${empty sessionUser }">ajax_login </c:if>"
													data-id="5" data-eventname="menu"><a
													href="javascript:;">项目评论</a></li>
												<div class="clear-both"></div>
											</ul>
											
											<!--项目简介-->
											<div class="process-list" id="ShowContent1">
												<%@include file="./details/project_introduce.jsp" %>
											</div>
											
											<!--融资情况-->
											<div class="process-list" style=" display:none;" id="ShowContent2">
											    <%@include file="./details/project_plan.jsp" %>
											</div>
											
											<!--风控点评-->
											<div class="process-list" style=" display:none;" id="ShowContent3">
												<%@include file="./details/project_risk.jsp" %>
											</div>
											
											<!--项目评论-->
											<div class="process-list" style=" display:none;" id="ShowContent5">
												<div class="risk-tips risk-tips2">
													<h4>项目评论</h4>
													<div class="space-10"></div>
													<div class="textarea-box textarea-box2">
														<textarea id="comment_content"></textarea>
														<span id="comment_contentTip"></span>
													</div>
													<div class="space-20"></div>
													<div class="submit-btn">
														<a href="javascript:;" id="commentBtn" class="<c:if test="${empty sessionUser }">ajax_login </c:if>">提 交</a>
													</div>
												</div>
												<div class="comment-box">
													<span id="comment-list-top"></span>
												</div>
												<div class="space-50"></div>
												<div class="pages" id="pagerHtml"></div>
												<div class="clear-both space-50"></div>
											</div>	
																			
										</div>
									</div>
								</div>

						</div>
						</div>
						<div class="col-right">
							<div class="box schedule-box">
								<div class="attention-div">
									<c:if test="${project.projectState=='prepared' }">
										<%@include file="./prebuy_info.jsp" %>
									</c:if>
									<c:if test="${project.projectState=='financing' }">
										<%@include file="./financing_info.jsp" %>
									</c:if>	
									<c:if test="${project.projectState=='successed'||project.projectState=='operating' ||project.projectState=='dividends' }">
										<%@include file="./success_info.jsp" %>
									</c:if>	
									
								</div>

							 <div class="sponsor">
							                <div class="avatar">
							                    <a class="shop-link">
							                        <c:choose>
								                        <c:when test="${empty user.userImage }">
								                        	<img class="sponsor-pic" src="<%=resourcePath %>/images/default-avatar-2.png" />
								                        </c:when>
								                        <c:otherwise>
								                        	<img class="sponsor-pic" src="${user.userImage }" />
								                        </c:otherwise>
							                        </c:choose>
							                    </a>
							                </div>
							                <div class="sponsor-info">
												<div class="attention-dl">
													<dd>
														<b>发起人：${user.userName }</b>
														<div class="space-10"></div>
														
														<i data-toggle="modal" data-target="#myModal1" style="cursor: pointer">私信</i>
														
													</dd>								     
									              
									            </div>
									            
			
							                   
							                </div>
							  </div>
								 
							</div>
							<div class="repays">
								<div class="repay-box">
									<div class="repay">
										<div class="content-con">
											<div class="contact-me contact-review">
												<h4>股东回报</h4>
												<ul class="review_sh" style="font-size:16px">
												
												${project.stockholderRepayHtml }
												</ul>
											</div>
										</div>
									</div>

								</div>

							</div>							
							<div class="repays">
								<div class="repay-box">
									<div class="repay">
										<div class="content-con">
											<!--资质审核-->
											<div class="contact-me contact-review">
												<%@include file="./details/project_audit.jsp" %>
											</div>
										</div>
									</div>

								</div>

							</div>
							<div class="explain">
								<h2>项目提示</h2>
								<p class="explain-p" style="font-size:14px">1.&nbsp;在项目投资之前，请认真阅读《众投客投资风险提示书》。</p>
								<p class="explain-p" style="font-size:14px">2.&nbsp;请勿相信任何非众投客官方对外公布的承诺或非官方发布的协议。对此，众投客将不承担任何法律责任。</p>
								<p class="explain-p" style="font-size:14px">3.&nbsp;如需核实信息请拨打官方 客服电话：400-079-961。
								</p>
								<b></b>
							</div>
						</div>
					</div>

			</div>
		</div>

</div>

<div class="recommend">
    <div class="layout">
        <h3><span>你可能感兴趣的项目</span></h3>
        <ul class="projects" id="J_Recommend">
        	
        	<c:forEach items="${hotProjects}" var="hotProject" varStatus="index">
			<li class="project-item">
			    <a href="<%=servletPath %>/portal/main/showProject.action?projectId=${hotProject.projectId}" target="_blank">
			        <span class="project-area">
			            <img src="${hotProject.projectImage }" alt="${hotProject.projectName }" class="project-pic">
			            
			            <span class="project-step project-prepub">${hotProject.projectStateName }</span>
			            
			            <b class="shadow"></b>
			        </span>
			        <span class="project-intro">${hotProject.projectName }</span>
			        <span class="schedule-bar">
			            <i class="schedule-current project-success " style="width:${hotProject.progress}%;"></i>
			        </span>
			        <span class="project-schedule">
			            <span class="other-info">
			                <span class="every-info">
			                <em>${hotProject.progress }%</em>
			                <em class="info-name">完成率</em>
			                </span>
			                <span class="every-info info-dollar">
			                    <em>${hotProject.raisedTotalAmount}</em>
			                    <em class="info-name">已筹金额</em>
			                </span>
			                <span class="every-info info-left">
			                    <em>${hotProject.financeAmount }</em>
			                    
			                    <em class="info-name">融资金额</em>
			                    
			                </span>
			            </span>
			        </span>
			    </a>
			</li>
			</c:forEach>
		</ul>
    </div>
</div>
<%@include file="./modal_prebuy.jsp" %>
<%@include file="./modal_message.jsp" %>
<%@include file="../common/footer.jsp" %>
</body>

</html>