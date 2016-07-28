<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="资金管理"></c:set>
<c:set var="topPage" value="/mobile/uc/index.action"></c:set>
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
<input type="hidden" id="user-realname" value="${user.realName }"/>
<input type="hidden" id="user-card" value="${user.identityCard }"/>
<input type="hidden" id="servlet-path" value="<%=servletPath%>"/>
<%@include file="../common/header.jsp" %>
    <!--main-->
    <div>
       
        <div class="my-info">
            <div class="main-padding">
                <div class="text-center font-large">
                    账户总金额：${user.accountInfo.totalAmount }元
                </div>
            </div>
            <div class="main-padding dot-top-white">
                <div class="row text-center">
                    <div class="col-xs-6 dot-right-white">可用金额：     ${user.accountInfo.availableAmount }元</div>
                    <div class="col-xs-6">冻结金额：   ${user.accountInfo.freezeAmount }元</div>
                </div>
            </div>
        </div><!-- my info section-->
        
        <div class="myinfo-items">
            <div class="money-mng-btns clearfix">
                <div>
                    <div class="col-xs-6">
                        <button id="btn-recharge" class="btn btn-cyan btn-over" data-toggle="modal" data-target="#modal-name-recharge" >
                       		充值
                   		</button>
                    </div>
                    <div class="col-xs-6">
                        <button id="btn-withdraw" class="btn btn-cyan">提现</button>
                    </div>
                </div>
            </div>
            <ul>
                <li><a href="<%=servletPath %>/mobile/uc/logde.action" class="pd-reset">项目分红</a></li>
                <li><a href="<%=servletPath %>/mobile/uc/rechargeRecord.action" class="pd-reset">充值记录</a></li>
                <li><a href="<%=servletPath %>/mobile/uc/withdrawRecord.action" class="pd-reset">提现记录</a></li>
                <li><a href="<%=servletPath %>/mobile/uc/logPay.action" class="pd-reset">支付记录</a></li>
                <li><a href="<%=servletPath %>/mobile/uc/refundRecord.action" class="pd-reset">退款记录</a></li>
            </ul>

        </div><!-- my info item list section-->

    </div><!-- /.container -->

    <!-- Modal name recharge-->
    <div class="modal fade" id="modal-msgbox" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div id="msg-content" class="modal-header text-center">
                </div>
                <div class="modal-footer text-center">
                    <div class="row">
                        <div class="col-xs-6"><a href="#" class="modal-ok" data-dismiss="modal">取消</a></div>
                        <div class="col-xs-6"><a id="verify-url" class="modal-ok" >去认证</a></div>
                    </div>

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
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

<script>
$(document).ready(function(){
	var realname = $("#user-realname").val();
	var card = $("#user-card").val();
	var servlet_path = $("#servlet-path").val();
	
	$("#btn-recharge").on("click", function(){
		if (realname == ''){
			$("#msg-content").html(" 您还未进行实名认证，无法充值！");
			$("#verify-url")[0].href=servlet_path+"/mobile/uc/verifyRealName.action";
			$("#modal-msgbox").modal("show");
			return false;
		}
		if (card == ''){
			$("#msg-content").html(" 您的账户未绑定银行卡，无法充值");
			$("#verify-url")[0].href=servlet_path+"/mobile/uc/verifyCard.action";
			$("#modal-msgbox").modal("show");
			return false;
		}
		document.location=servlet_path+"/mobile/uc/charge.action";
	});
	$("#btn-withdraw").on("click", function(){
		if (realname == ''){
			$("#msg-content").html(" 您还未进行实名认证，无法充值！");
			$("#verify-url")[0].href=servlet_path+"/mobile/uc/verifyRealName.action";
			$("#modal-msgbox").modal("show");
			return false;
		}
		if (card == ''){
			$("#msg-content").html(" 您的账户未绑定银行卡，无法充值");
			$("#verify-url")[0].href=servlet_path+"/mobile/uc/verifyCard.action";
			$("#modal-msgbox").modal("show");
			return false;
		}
		document.location=servlet_path+"/mobile/uc/withdraw.action";
	});
});
</script>
</body>
</html>
    