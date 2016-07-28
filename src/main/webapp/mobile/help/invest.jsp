<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="我要投资"></c:set>
	<c:set var="topPage" value="/mobile/help/index.action"></c:set>
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
    <div class="main-content">
       
        <div class="wrap-rounded">
            <div class="help-section text-center">
                <img src="<%=resourcePathM %>/images/step-image.png" class="img-responsive center-block" alt="step image">
                <ul class="step-des">
                    <li><img src="<%=resourcePathM %>/images/step-1.png" alt="step number"><span>注册并<br/>实名认证</span></li>
                    <li><img src="<%=resourcePathM %>/images/step-2.png" alt="step number"><span>选择项目</span></li>
                    <li><img src="<%=resourcePathM %>/images/step-3.png" alt="step number"><span>认购项目</span></li>
                    <li><img src="<%=resourcePathM %>/images/step-4.png" alt="step number"><span>成为股东</span></li>
                    <li><img src="<%=resourcePathM %>/images/step-5.png" alt="step number"><span>坐享分红</span></li>
                </ul>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/01.png" class="step-img" alt="01 image">
                            <span class="help-section-title">注册并实名认证</span>
                        </div>
                        <div>注册帐号：只需要输入手机号码，密码，点击注册，即可完成注册。<br/>
                            实名认证：正确填写个人信息包括真实姓名、身份证号码以及手机号码，点击提交。</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir05.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir06.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/02.png" class="step-img" alt="02 image">
                            <span class="help-section-title">选择优质项目</span>
                        </div>
                        <div>进入众投客首页，点击底部的“项目”，选择最适合自己的项目进行认购。</div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/03.png" class="step-img" alt="03 image">
                            <span class="help-section-title">认购项目</span>
                        </div>
                        <div>进入项目页面，点击“立即认筹”，选择认购的份数，确认认购的信息，并完成订单的支付。</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir07.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir08.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/04.png" class="step-img" alt="04 image">
                            <span class="help-section-title">成为股东</span>
                        </div>
                        <div>项目融资成功，您作为项目的股东之一，，每个月获得分红报酬</div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/05.png" class="step-img" alt="05 image">
                            <span class="help-section-title">坐享分红</span>
                        </div>
                        <div>项目按月分红，您可以在“资金管理”中查看您的项目分红记录。</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir09.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
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