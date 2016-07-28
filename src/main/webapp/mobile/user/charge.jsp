<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="余额充值"></c:set>
<c:set var="topPage" value="/mobile/uc/accountInfo.action"></c:set>
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
    <!--main-->
    <div>

        <form class="pd-reset">
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">开户银行：</div>
                    <div class="col-xs-8">
                    	<img src="<%=resourcePathM %>/images/china-bank-icon01.png" alt="bank icon" style="margin-right: 10px">
                    	<span>中国银行</span>
                    	<img src="<%=resourcePathM %>/images/check-complete.png" class="fl-right" alt="check complete icon">
                   	</div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">持卡人姓名：</div>
                    <div class="col-xs-8">
                    	<input type="text" class="form-control transparent" value="${user.realName }">
                   	</div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">银行卡卡号：</div>
                    <div class="col-xs-8"><input type="text" placeholder="" class="form-control transparent" value="${user.identityCard }"></div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">预留手机号：</div>
                    <div class="col-xs-8"><input type="text" placeholder="" class="form-control transparent"></div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">充值金额(元)：</div>
                    <div class="col-xs-8"><input type="text" placeholder="请输入充值金额" class="form-control transparent"></div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">充值金额(元)：</div>
                    <div class="col-xs-4"><input type="text" placeholder="请输入验证码" class="form-control transparent"></div>
                    <div class="col-xs-4"><button class="btn btn-custom form-control transparent mr-reset">获取验证码</button></div>
                </div>

            </div>

            <div class="form-wrap  bd-reset">
                <button type="submit" class="btn btn-custom" data-toggle="modal" data-target="#myModal-overzero-fail" style="font-size: 1.25em">提交认证</button>
            </div>
        </form>

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
