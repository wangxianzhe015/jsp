<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="充值指引"></c:set>
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
                            <span class="help-section-title">资金管理</span>
                        </div>
                        <div>在“我的中心”找到“资金管理”，然后点击“充值</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir01.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir02.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/02.png" class="step-img" alt="02 image">
                            <span class="help-section-title">确认充值信息</span>
                        </div>
                        <div>进入余额充值页面，确认您的充值信息</div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/03.png" class="step-img" alt="03 image">
                            <span class="help-section-title">输入充值金额</span>
                        </div>
                        <div>请输入您的充值金额<br/>
                            温馨提示：充值金额必须大于0元</div>
                    </div>
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir03.png" class="img-responsive" alt="circle image width 180"></div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-4"><img src="<%=resourcePathM %>/images/help-cir04.png" class="img-responsive" alt="circle image width 180"></div>
                    <div class="col-xs-8">
                        <div>
                            <img src="<%=resourcePathM %>/images/04.png" class="step-img" alt="04 image">
                            <span class="help-section-title">完成充值</span>
                        </div>
                        <div>完成充值后，您可以在“我的中心”，查看您的可用余额<br/>
                            如果在充值过程中遇到任何问题，请联系众投客客服人员<br/>
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