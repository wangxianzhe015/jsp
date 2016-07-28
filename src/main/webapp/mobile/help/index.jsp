<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="帮助中心"></c:set>
	<c:set var="topPage" value="/mobile/main/index.action?menuId=main"></c:set>
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
       
        <div class="help-banner">
            <!--<img src="./assets/img/help-banner.png" alt="banner image">-->
            <div class="row">
                <div class="col-xs-8 text-center">
                    <div id="banner-text-title">HELP CENTER</div>
                    <div id="banner-text-des">Do my best to help you</div>
                </div>
                <div class="col-xs-4 text-center">
                    <img src="<%=resourcePathM %>/images/qrcode.png" class="img-responsive center-block img-qr-code" alt="qr-code">
                    <div id="qr-code-des">扫描微信二维码<br/>
                        咨询在线客服</div>
                </div>
            </div>
        </div>
        <div class="main-list">
            <ul>
                <li><a href="<%=servletPath %>/mobile/help/regist.action">注册及认证</a></li>
                <li><a href="<%=servletPath %>/mobile/help/charge.action">充值指引</a></li>
                <li><a href="<%=servletPath %>/mobile/help/invest.action">我要投资</a></li>
                <li><a href="<%=servletPath %>/mobile/help/qa.action">疑难解答</a></li>
            </ul>
        </div>

    </div><!-- /.container -->

    <!-- FOOTER -->
	<%@include file="../common/footer.jsp" %>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

    <script>
        $(document).ready(function() {
            $('.btnDecrease').on('click', function() {
                var selClass = $('#selClass').val();
                if (selClass == '')selClass = 1;
                if (selClass>1) selClass--;
                $('#selClass').val(selClass);
            });
            $('.btnIncrease').on('click', function() {
                var selClass = $('#selClass').val();
                if (selClass == '')selClass = 0;
                selClass++;
                $('#selClass').val(selClass);
            });
            $('#btnSubmit').on('click', function() {
                //showConfirmModal('预约成功！');
                showConfirmModal('您已经预约过此项目！');
            });
        });
        function showConfirmModal(msg) {
            $('#confirm_msg').html(msg);
            $("#confirm_dialog").modal('show');
        }
    </script>
    </body>
    </html>