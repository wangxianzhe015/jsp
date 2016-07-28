<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="注册及认证"></c:set>
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
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/01.png" class="step-img" alt="01 image">
                            <span class="help-section-title">注册为用户</span>
                        </div>
                        <div>注册帐号：只需要输入手机号码，密码，点击注册，即可完成注册。<br/>
                            实名认证：正确填写个人信息包括真实姓名、身份证号码以及手机号码，点击提交。
                        </div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir10.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir11.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/02.png" class="step-img" alt="02 image">
                            <span class="help-section-title">实名认证</span>
                        </div>
                        <div>进入您的用户中心，找到安全设置，点击页面“实名认证选项”选项；</div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/03.png" class="step-img" alt="03 image">
                            <span class="help-section-title">填写认证信息</span>
                        </div>
                        <div>输入需要认证的信息，点击“提交”。<br/>
                            温馨提示：请认真仔细填写要认证的信息，这将影响日后的分红。</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir12.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir13.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/04.png" class="step-img" alt="04 image">
                            <span class="help-section-title">完成认证</span>
                        </div>
                        <div>完成认证后，您可以在众投客平台上进行发布与认购项目。<br/>
                            如果需要修改认证信息，请联系众投客客服人员<br/>
                            客服电话：400-079-9617</div>
                    </div>
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