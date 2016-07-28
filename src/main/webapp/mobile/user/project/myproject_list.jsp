<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<%@include file="../../common/meta.jsp" %>
<c:set var="pageTitle" value="项目中心"></c:set>
<c:set var="topPage" value="/mobile/uc/index.action"></c:set>
    <!-- Bootstrap core CSS -->
    <link href="<%=resourcePathM %>/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/style.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<%@include file="../../common/header.jsp"%>

    <!--main-->
    <div>
    	<div class="top-menu">
    		<ul class="tabs">
    			<li class="couple-tab active">
    				<a data-toggle="tab" href="#menu1">认购项目</a>
    			</li>
    			<li class="couple-tab">
    				<a data-toggle="tab" href="#menu2">发布项目</a>
    			</li>
   			</ul>
		</div>
    	<div class="tab-content">
    	    <div id="menu1" class="tab-pane fade in active">
	            <div class="form-wrap-no-padding">
	                <div class="row">
	                    <div class="col-xs-4 text-right"><img src="<%=resourcePathM %>/images/box02.jpg" class="img-responsive margintop-20" alt="box image"></div>
	                    <div class="col-xs-5">
	                        <h2 class="font-normal">令狐冲烤鱼东二环泰禾店</h2>
	                        <p class="font-small">认购金额：  ${project.financingAmount }元</p>
	                        <p class="font-small">认购份数：  10份</p>
	                        <p class="font-small">项目状态：  上线融资</p>
	                    </div>
	                    <div class="col-xs-3">
	                        <a href="#" class="btn pay-status-btn font-small margintop-60 yellow">待支付</a>
	                    </div>
	                </div>
	
	            </div>
            </div>
    	    <div id="menu2" class="tab-pane fade in">
			<c:forEach items="${projects}" var="project" varStatus="index">
	            <div class="form-wrap-no-padding" id="project_${project.projectId }">
	                <div class="row">
	                    <div class="col-xs-4 text-right">
						<c:choose>
							<c:when test="${project.projectState=='published' || project.projectState=='auditing'}">
								 <img class="img-responsive margintop-20" src="${project.projectImage }" />
							</c:when>
							<c:otherwise>
								<a href="<%=servletPath %>/mobile/main/showProject.action?projectId=${project.projectId}"
									title="${project.projectName }" target="_blank"> 
									<img class="img-responsive margintop-20" src="${project.projectImage }" />
								</a>
							</c:otherwise>
						</c:choose>
						</div>
	                    <div class="col-xs-8">
	                        <h2 class="font-normal">${project.companyName}</h2>
	                        <p class="font-small">融资金额：  ${project.financeAmount }万元</p>
	                        <p class="font-small">单笔最低：  ${project.minInvestAmount }元</p>
	                        <p class="font-small">项目状态：  上线融资</p>
	                    </div>
	                </div>
	            </div>
            </c:forEach>
            </div>
        </div>
    </div><!-- /.container -->

    <!-- Modal phone fail -->
    <div class="modal fade" id="myModal-remount" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    请输入充值金额
                </div>
                <div class="modal-footer text-center">
                    <a href="#" class="modal-ok" data-dismiss="modal">确定</a>
                </div>
            </div>
        </div>
    </div>

    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
    $('.couple-tab > a').on('click', function(){
        var tab_id=$(this).attr('data-tab');
        $('.couple-tab > a').removeClass('active')
        $('.tab-content').removeClass('current');
        $(this).addClass('active');
        $("#"+tab_id).addClass('current');

    });

});
</script>
</body>
</html>
