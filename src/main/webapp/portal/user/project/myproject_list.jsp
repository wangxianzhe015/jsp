<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="我的项目"></c:set>
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
					<div class="fl user_tit font-wet">我发布的项目</div>
				</div>
	
				<div class="gray_tit_box mt-10">
					<a href="<%=servletPath %>/portal/uc/findMyProject.action" <c:if test="${empty projectState || projectState=='' }">class="now" </c:if> >全部</a> 
					<a href="<%=servletPath %>/portal/uc/findMyProject.action?projectState=published" <c:if test="${projectState=='published' }">class="now" </c:if> >待审核项目</a>
					<a href="<%=servletPath %>/portal/uc/findMyProject.action?projectState=auditing" <c:if test="${projectState=='auditing' }">class="now" </c:if> >项目审核</a>
					<a href="<%=servletPath %>/portal/uc/findMyProject.action?projectState=prepared" <c:if test="${projectState=='prepared' }">class="now" </c:if> >预约认购</a>
					<a href="<%=servletPath %>/portal/uc/findMyProject.action?projectState=financing" <c:if test="${projectState=='financing' }">class="now" </c:if> >上线融资</a>
					<a href="<%=servletPath %>/portal/uc/findMyProject.action?projectState=successed" <c:if test="${projectState=='successed' }">class="now" </c:if>>融资成功</a>
				</div>



				<c:forEach items="${projects}" var="project" varStatus="index">
					<div class="clear gray_bg mt-10" id="project_${project.projectId }">
						<div class="col-6 mr-10">
							<div class="user_pic text-c">
								<c:choose>
									<c:when test="${project.projectState=='published' || project.projectState=='auditing'}">
										 <img src="${project.projectImage }" />
									</c:when>
									<c:otherwise>
										<a href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
											title="${project.projectName }" target="_blank"> 
											<img src="${project.projectImage }" />
										</a>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text-c mt-5">
							</div>
						</div>
						<div class="col-16 mr-10">
							<div class="blue user_bt">
								<c:choose>
									<c:when test="${project.projectState=='published' || project.projectState=='auditing'}">
										 ${project.projectName }
									</c:when>
									<c:otherwise>
										<a href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
											title="${project.projectName }" target="_blank">${project.projectName }</a>
									</c:otherwise>
								</c:choose>							
								
							</div>
							<div style="margin: 10px 0px 0px 0px">
                                     <p class="lh24">
 									 <c:if test="${empty project.projectState || project.projectState=='' || project.projectState=='published' }">
										 <a href="<%=servletPath %>/portal/uc/publishFirst.action?project.projectId=${project.projectId}">修改</a>
	                            		 <span style="color: #999999"> | </span>
	                            		 <a href="javascript:void(0)"  style="color:#f00;" data-eventname="delete" data-project-id="${project.projectId }">删除</a>
	                                     
	                                     <p class="lh24"></p>
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


	<!--提交弹框-->
	<%@include file="./modal_submit_audit.jsp" %>
	
    <!-- 项目方打款 -->
	<%@include file="./modal_founder_pay.jsp" %>

	<!--删除弹框-->
	<%@include file="./modal_delete_project.jsp" %>

	<style>
.btn_sub {
	background: none repeat scroll 0 0 #da4f32;
	border: medium none;
	border-radius: 3px;
	color: #fff;
	cursor: pointer;
	margin-left: 200px;
	padding: 0px 30px;
}
</style>

	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>
</body>
</html>


<script>
var submitProjectId = 0;
var deleteProjectId = 0;
$(document).ready(function(){
    $("a[data-eventname=submit]").bind("click", function(){
        submitProjectId = $(this).attr("data-project-id");
        $("#submit-dialog").modal("show");
        return false;
    });

    $("a[data-eventname=delete]").bind("click", function(){
        deleteProjectId = $(this).attr("data-project-id");
        $("#delete-dialog").modal("show");
        return false;
    });

    $("input[data-eventname=submit]").bind("click", function(){
    	url = "<%=servletPath%>/portal/uc/publishFifth.action?project.projectId=" + submitProjectId;
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent) || /MSIE(\d+\.\d+);/.test(navigator.userAgent)){
            var referLink = document.createElement('a');
            referLink.href = url;
            document.body.appendChild(referLink);
            referLink.click();
        } else {
            location.href = url;
        }
    });

    $("input[data-eventname=delete]").bind("click", function(){
    	url = "<%=servletPath%>/portal/uc/removeProject.action?project.projectId=" + deleteProjectId;
        if (/MSIE (\d+\.\d+);/.test(navigator.userAgent) || /MSIE(\d+\.\d+);/.test(navigator.userAgent)){
            var referLink = document.createElement('a');
            referLink.href = url;
            document.body.appendChild(referLink);
            referLink.click();
        } else {
            location.href = url;
        }
    });

    $("input[data-eventname=cancel]").bind("click", function(){
        $("#submit-dialog,#delete-dialog").modal("hide");
    });

	$(".xmfdk").bind('click',function(){
		$("#pay_s").html($(this).attr('data-famount-s'));
		$("#pay_t").html($(this).attr('data-famount-t'));
		$("#pay_ed").html($(this).attr('data-famount-ed'));
		$("#pay_pid").html($(this).attr('data-pid'));
	});
	$("#ajax_xmfdk").bind('click',function(){
		$("#ajax_xmfdk").attr('disabled','true');
		var pay_t = Number($("#pay_t").html());
		var pay_ed = Number($("#pay_ed").html());
		var pay_pid = Number($("#pay_pid").html());
		var amount_pro = Number($("#amount_pro").val());
		$.post("http://user.renrentou.com/project/AjaxXmfdk",{'project_id':pay_pid,'amount_pro':amount_pro},function(data){  
 			if(data.status==1)
 			{
 				popBox(data.msg,'success');
 				pay_ed = pay_ed+amount_pro;
 				$("#dk_"+pay_pid).attr('data-famount-ed',pay_ed);
 				if(pay_ed == pay_t)
 				{
 					$("#dk_"+pay_pid).css('display','none');
 				}
 				$("#xmfdk_button").click();
 				$("#ajax_xmfdk").removeAttr('disabled');
 			}else
 			{
				popBox(data.msg,'error');
				$("#ajax_xmfdk").removeAttr('disabled');
 			}
	    },"json")
	});
});
</script>