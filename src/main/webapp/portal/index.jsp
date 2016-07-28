<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="./common/common.jsp"%>
    <base href="<%=basePath%>">
	<c:set var="pageTitle" value="众投客"/>
	<%@include file="./common/meta.jsp" %>	
	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/jquery.slideBox.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/odometer-theme-car.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index.css" />
	
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.slideBox.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/odometer.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.SuperSlide.2.1.1.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/index.js"></script>
	<style>
	.subscribe-btn a{display:block; float:left;width:150px; height: 40px; line-height: 40px; text-align: center; font-size: 20px; color: #fff;  background: #ff6666; margin-left:160px;}
	</style>
  </head>
  
  <body>
    <%@include file="./common/header.jsp" %>
<!--首页banner-->
<div class="index-news-banner">
     <div class="news-banner-box">
          <div class="news-banner-img" id="focus">
               <ul>
                 	<c:forEach items="${banners}" var="banner">
                      <li>
                        <a href="${banner.href}" title="${banner.title }" target="_blank">
                            <img src="${banner.image }" alt="${banner.title}">
                        </a>
                      </li>
                    </c:forEach>
               </ul>
               <div class="preNext-btn">
                    <div class="preNext" style="opacity: 0.2;">
                         <div class="pre"></div>
                         <div class="next"></div>
                    </div>
                    <div class="bg-btn-news">
                    <c:forEach items="${banners}" var="banner">
                           <span style="opacity: 0.2;"></span>
                    </c:forEach>
                   </div>
               </div>
          </div> 
     </div>
</div>  



<!-- 网站公告 -->
<div style="width: 1160px;margin: 0 auto;  padding:0 10px;">
		
			<a style="display:block;float:left;color:#505050;padding-bottom:0px; font-size:18px; background-image:url(<%=resourcePath%>/images/news.png); background-repeat:no-repeat; background-position:left center; padding-left:30px;" href="<%=servletPath%>/portal/main/listNotices.action" title="点击查看更多" target="_blank">最新公告 </a>
		
			<c:if test="${empty systemNotices }">
			   • 暂无公告
			</c:if>
			<c:forEach items="${systemNotices}" var="notice" varStatus="index">
				<c:choose>
					<c:when test="${index.count%2==0 }">
						<a style="width:505px;display:block;float:left;color:#505050; padding-left:30px; padding-bottom:0px;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" href="<%=servletPath %>/portal/main/detailSysNotice.action?noticeId=${notice.noticeId}" title="${notice.title }" target="_blank">• ${notice.title }&nbsp;&nbsp;<fmt:formatDate value="${notice.noticeTime}" pattern="yyyy-MM-dd"/></a>
					</c:when>
					<c:otherwise>
						<a style="width:505px;display:block;float:left;color:#505050; padding-left:10px; padding-bottom:0px;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" href="<%=servletPath %>/portal/main/detailSysNotice.action?noticeId=${notice.noticeId}" title="${notice.title }" target="_blank">• ${notice.title }&nbsp;&nbsp;<fmt:formatDate value="${notice.noticeTime}" pattern="yyyy-MM-dd"/></a>
						
					</c:otherwise>
				</c:choose>
			</c:forEach>		

		<div style="clear:both;">
		</div>
</div>


<!--精彩项目(置顶)-->
<div  class="recommendProject" style="overflow:hidden; margin:0 auto; width:1240px;">
<div class="blacklist-l"></div>
<div class="blacklist-r"></div>
<div class="layout-1190" data-eventname="content" data-index="5" >
     <div class="news-prefecture">
          <div class="prefecture-t">
               <div class="space-10"></div>
               <h4>精彩项目<a name="hot-7" id="hot-8"></a></h4>
               <ul class="online-time">

               </ul>
               <div class="all-more">
                    
               </div>
               <div class="clear-both"></div>
          </div>
          <div class="prefecture-c" style="display: block">
               <div class="blacklist-star">
                     <div class="financing-box">
                          <div class="blacklist-c">
                               <ul class="blacklist-ul" now="1">
                                  <c:forEach items="${topProjects}" var="topProject">
                                   <li>
                                        <div class="blacklist-ul-l" style="width:578px;">
                                           <a href="<%=servletPath %>/portal/main/showProject.action?projectId=${topProject.projectId}" target="_blank">
                                             <img src="${topProject.projectImage}" alt="${topProject.projectName}" width="650" height="400" >
                                               <c:choose>
	                                             	<c:when test="${topProject.projectState=='prepared' }">
	                                             	     <div class="yexm"></div>
                                              		</c:when>
                                              		<c:otherwise>
                                              			<div class="rzxm"></div>
                                              		</c:otherwise>
                                              	</c:choose>
                                           </a>
                                           <i class="gfx"></i>
                                        </div>
                                        
                                        <div class="blacklist-ul-r" style="width: 500px;height:400px">
                                             <div class="black-text">
                                             	<span>${topProject.projectName}</span>
                                             </div>
                                             <span class="position" title="${topProject.provinceName}${topProject.cityName}">${topProject.provinceName}${topProject.cityName}</span>
                                             <div class="desc">${topProject.projectProfile }</div>

                                             <div class="financing">
                                                <span class="money-title">目标融资</span>
                                                <span class="current-money"><span class="yen">¥</span>${topProject.financeAmount}<span>
                                             </div>
                                                                              
                                             <div class="currentMoney">
	                                             <c:choose>
	                                             	<c:when test="${topProject.projectState=='prepared' }">
	                                             		<span class="money-title">已预购金额</span>
	                                             		<span class="current-money"><span class="yen">¥</span>${topProject.raisedTotalAmount}</span>
	                                             	</c:when>
	                                             	<c:otherwise>
	                                             		<span class="money-title">已认购金额</span>
	                                            		 <span class="current-money"><span class="yen">¥</span>${topProject.raisedTotalAmount}</span>	                                             	
	                                             	</c:otherwise>
	                                             </c:choose>                                               

                                             </div>

                                             
                                             <div class="progress-s progress-s4" style="padding-left:40px;margin-top:20px; position:relative; display:block; float:left;"><p><b style="width: ${topProject.progress}%"></b></p><i style="padding-left:160px;">${topProject.progress}%</i></div>
                                             <br/>
                                             <span class="projects-schedule-data">
                                                <span>单笔最低金额：</span><span style="color:#ff6666;">${topProject.minInvestAmount}元&nbsp;&nbsp;</span>
                                                
                                                <c:choose>
                                                	<c:when test="${topProject.projectState=='prepared' }">
                                                		 <span>预购份数：</span><span style="color:#ff6666;">${topProject.subscribedTotalCopies} &nbsp;&nbsp;</span>
                                                	</c:when>
                                                	<c:otherwise>
                                                	    <span>剩余份数：</span><span style="color:#ff6666;">${topProject.remainingCopies} &nbsp;&nbsp;</span>
                                                	</c:otherwise>
                                                </c:choose>                                    
						                       
						                        <span class="time-left">剩余天数:</span><span class="data-number" style="color:#ff6666;">${topProject.remainingDays }天</span>
                    						</span>
                                            
											<div class="subscribe-btn <c:if test="${empty logon || logon=='false'}">ajax_login</c:if>">								
											
											 <a class="a-btn" href="<%=servletPath %>/portal/main/showProject.action?projectId=${topProject.projectId}" >
											  <c:if test="${topProject.projectState=='prepared' }"> 立即预约 </c:if>
											  <c:if test="${topProject.projectState=='financing' }"> 立即认购</c:if>
											  <c:if test="${topProject.projectState=='successed'||topProject.projectState=='operating' || topProject.projectState=='dividends' }"> 认筹结束</c:if>
											</a> 
											</div>	
                                             
                                        </div>
                                    </li>
                                   </c:forEach>

                                 </ul>
                          </div>
                          
                     </div>
               </div>
          </div>
     </div>
</div>
</div>

<!--预热项目-->
<div class="layout-1190" data-eventname="content" data-index="2">
     <div class="news-prefecture">
          <div class="prefecture-t prefecture-t-b">
               <div class="space-10"></div>
               <div class="all-more">
         		 <a href="<%=servletPath%>/portal/main/projectlist.action?project.projectState=prepared">more>></a>
    		   </div>  
               <h4>预热项目<a name="hot-3" id="hot-3"></a></h4>
               <ul class="online-time">

               </ul>

               <div class="clear-both"></div>
          </div>
          <div class="prefecture-c">
               <div class="financing-box"  id="list_prepared"></div>
          </div>
     </div>
   
</div>


<!--融资项目-->
<div class="layout-1190" data-eventname="content" data-index="1">
     <div class="news-prefecture">
          <div class="space-10"></div>
          <div class="prefecture-t">
		       <div class="all-more">
		         <a href="<%=servletPath%>/portal/main/projectlist.action?project.projectState=financing">more>></a>
		       </div>	          
               <h4>融资项目<a name="hot-2" id="hot-2"></a></h4>
               <ul class="online-time">
 
               </ul>
               <div class="clear-both"></div>
          </div>
			<div class="prefecture-c">
				<div class="financing-box" id="list_financing">
			  </div>
		</div>
	</div>

</div>



<!--成功项目-->
<div class="layout-1190" data-eventname="content" data-index="3">
     <div class="news-prefecture">
          <div class="prefecture-t">
               <div class="space-10"></div>
			   <div class="all-more">
			        <a href="<%=servletPath%>/portal/main/projectlist.action?project.projectState=success">more>></a>
			   </div>                   
               <h4>成功项目<a name="hot-6" id="hot-6"></a></h4>
               <ul class="online-time">
               </ul>
               <div class="clear-both"></div>
          </div>
          <div class="prefecture-c">
               <div class="financing-box" id="list_successed"></div>
          </div>
     </div> 
</div>

<div class="newsFr" style="width: 1160px;margin: 0 auto;  background: #FFFFFF; padding:0 10px;">
		<div style="width: 1160px;margin: 0 auto;">
			<span class="newsHeader">最新资讯	
	        <div class="all-more">
	           <a href="<%=servletPath%>/portal/main/listNews.action">					
	            <span>more>></span></a>
	          </div>				
	        </span>
		</div>

         <div class="space-10"></div>
         <div class="newsBox">
               		<c:forEach items="${portalNewss}" var="news" varStatus="index">
               			<div class='<c:choose><c:when test="${index.count%2==0 }">newsList-2</c:when><c:otherwise>newsList-1</c:otherwise></c:choose>'>
               			    <a href="<%=servletPath%>/portal/main/detailNews.action?newsId=${news.newsId}" target="_blank">
                        	<img class="newsPic" src="${news.newsImage }">
                        	</a>
                            <div class="newsText">
                            	<span class="newsTitle"><a href="<%=servletPath%>/portal/main/detailNews.action?newsId=${news.newsId}" target="_blank">${news.title }</a></span>
                                <p style="width:300px;height:80px; display:block;overflow:hidden; color: #727272">${news.profile }</p><br/>
                                <span class="newsTime" style="float:right;color:#727272"><fmt:formatDate value="${news.newsTime}" pattern="yyyy-MM-dd"/></span>
                    		</div>
                    	</div>
                     </c:forEach> 
          </div>
 </div>
  
<!--以上是最新资讯-->


<div class="layout-1160">
    <div class="titl1"><h3>合作伙伴</h3></div>
    <div class="partners_box">
        <ul>
        	<c:forEach items="${portalPatterns}" var="pattern">
            <li>
            	<a href="${pattern.href }" target="_blank"><img src="${pattern.image }" alt="img"></a>
            </li>
            </c:forEach>
        </ul>
    </div>
</div>
<%@include file="./common/footer.jsp" %>
</body>

</html>

<script>

var caches = [];


/**
 * 获取项目列表
 * @param int type 项目状态[financing-融资中项目，prepared-预热项目，successed-成功的项目]
 * @param string sort 排序类型
 * @param string by 排序字段
 */
function getProject(type, sort, by)
{
    var cacheKey = type + "_" + sort + "_" + by;
    if (caches[cacheKey] != undefined) {
        $("#list_" + type).html(caches[cacheKey]);
        return false;
    }
    
    var postData = {
        "projectState": type,
        "sort": sort,
        "orderby": by,
        "_force_refresh" : ""
    };
    var html="";
    
    $.ajax({
        type: "post",
        url: "<%=servletPath%>/portal/main/getProject.action",
        data:postData,
        dataType: "json",
        timeout: 1000,
        async : false,
        success: function(data, textStatus){
			var projects = data.projects;
			if(projects!="undefined"){
				$.each(projects, function(i, p) {
					if(type=="financing")
						html += buildFinancingProject(p,i+1);
					else if(type=="successed"){
						html += buildSuccessedProject(p,i+1);
					}
					else if(type=="prepared"){
						html +=buildPreparedProject(p,i+1);
						setInterval(function(){ getRTime(p.projectId, p.prebuyEndTime)}, 1000);
					}
				});

				caches[cacheKey] = html;
				$("#list_" + type).html(html);
				
			}
       },
      complete: function(XMLHttpRequest, textStatus){
      },
      error: function(){
      		//请求出错处理
    	  popBox("获取数据超时", "error", 3);
      }
	});
	}

	$(document)
			.ready(
					function() {
						// 跑马灯效果
						$("#scrollDiv").textSlider({
							line : 1,
							speed : 1000,
							timer : 3000
						});

						// 排序按钮绑定事件
						$("li[data-eventname=sortproject]").bind(
								"click",
								function() {
									var type = $(this).attr("data-type");
									var sort = $(this).attr("data-sort");
									var by = $(this).attr("data-by");
									getProject(type, sort, by);
									$(this).attr("data-sort",
											sort == "DESC" ? "ASC" : "DESC");
									$(this).addClass('on').siblings().removeClass('on');
								});

						// 分类项目绑定事件
						$("li[data-eventname=name]").bind(
								"mouseover",
								function() {
									var dataType = $(this).attr("data-type");
									$("#trade_all").attr("data-type",dataType.split("-")[1]);
									getProject(dataType, '', ''); // 分类项目
								});

						$("#trade_all")
								.bind(
										"click",
										function() {
											var url = "<%=servletPath%>/portal/main/projectlist.action?project.projectState="+ $(this).attr("data-type");
											location = url;
										});

						// 首先预加载第一个分类选项卡（主要是为了避免当右侧没数据时候样式问题）
						$("li[data-eventname=name]").eq(0).mouseover();
						
						getProject('prepared', '', ''); // 预热项目
						getProject('financing', '', ''); // 融资项目
						getProject('successed', '', ''); // 成功项目
					});
</script>
