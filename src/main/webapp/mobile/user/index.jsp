<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="我的中心"></c:set>
<c:set var="topPage" value="/mobile/main/index.action"></c:set>
<%@include file="../common/meta.jsp" %>
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

<%@include file="../common/header.jsp" %>
    <div>
       
        <div class="my-info">
            <div class="main-padding">
                <div class="row">
                    <div class="col-xs-3">
                        <div class="logo-image"><img src="${sessionUser.userImage }" class="img-responsive img-circle" alt="profile image"></div>
                    </div>
                    <div class="col-xs-9">
                        <div class="tel-num">${sessionUser.mobileNo }</div>
                        <div class="date-time">上次登录：2015-12-07   12:06:11</div>
                    </div>
                </div>
            </div>
            <div class="main-padding dot-top-white">
                <div class="row text-center">
                    <div class="col-xs-6 dot-right-white">可用金额：    ${user.accountInfo.availableAmount }元</div>
                    <div class="col-xs-6">冻结金额：     ${user.accountInfo.freezeAmount }元</div>
                </div>
            </div>
        </div><!-- my info section-->
        
        <div class="myinfo-items">
            <ul>
                <li><a href="<%=servletPath%>/mobile/uc/findMyProject.action" id="project-center">项目中心</a></li>
                <li><a href="<%=servletPath%>/mobile/uc/accountInfo.action" id="fund-manage">资金管理</a></li>
                <li><a href="<%=servletPath%>/mobile/uc/personalSetting.action" id="personal-info">个人资料</a></li>
                <li><a href="<%=servletPath%>/mobile/uc/verifyRealName.action" id="verified">实名认证</a></li>
                <li><a href="<%=servletPath%>/mobile/uc/safeSetting.action" id="security-setting">安全设置</a></li>
            </ul>

            <a href="<%=servletPath%>/mobile/login/logout.action"  id="sign-out">退出登录</a>
        </div><!-- my info item list section-->


    </div><!-- /.container -->

    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

</body>
</html>
