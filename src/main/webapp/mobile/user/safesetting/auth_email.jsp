<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="邮箱认证"></c:set>
	<c:set var="topPage" value="/mobile/uc/safeSetting.action"></c:set>
	<%@include file="../../common/meta.jsp" %>
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

<%@include file="../../common/header.jsp" %>

<!--认证邮箱-->
<div>
    <div>
        <form id="emailreset">
            <div class="form-wrap-no-padding bd-reset">
		        <div class="row">
			        <div class="col-xs-4">
		            	<p>邮箱地址</p>
			        </div>
			        <div class="col-xs-8">
			            <input id="email" type="text" class="form-control transparent" placeholder="请输入正确的邮箱地址"/>
			        </div>
		        </div>
            </div>
            <div class="form-wrap-no-padding bd-reset">
		        <div class="row">
			        <div class="col-xs-12">
			            <div id="emailTip"></div>
			        </div>
		        </div>
            </div>
            <div class="form-wrap-no-padding bd-reset">
		        <div class="row">
			        <div class="col-xs-4">
			            <p>验证码</p>
			        </div>
			        <div class="col-xs-4">
			            <input id="emailcode" class="form-control transparent type="text" placeholder="请输入验证码"/>
			        </div>
			        <div class="col-xs-4">
			            <span id="ecode" class="w100p btn btn-custom">获取验证码</span>
			        </div>
		        </div>
            </div>
            <div class="form-wrap-no-padding bd-reset">
		        <div class="row">
			        <div class="col-xs-12">
			            <span  class="e_yanzheng" style="visibility:hidden;">获取验证码</span>
			        </div>
		        </div>
            </div>
            <div class="form-wrap-no-padding bd-reset">
		        <div class="row">
			        <div class="col-xs-4">
			        </div>
			        <div class="col-xs-8">
			            <div id="emailcodeTip"> </div>
			        </div>
		        </div>
            </div>
            <div class="form-wrap-no-padding bd-reset">
	            <button onclick="return jQuery.formValidator.pageIsValid('emailreset');"  class="btn btn-custom">提交</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Alert -->
<div class="modal fade" id="confirm_dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header text-center">
                <span id="confirm_msg"></span>
            </div>
            <div class="modal-footer text-center">
                <a href="#" class="modal-ok" data-dismiss="modal">确定</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
<script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
<script src="<%=resourcePathM %>/js/common/main.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>

<script>
//邮箱认证
function showConfirmModal(msg) {
	$('#confirm_msg').html(msg);
	$("#confirm_dialog").modal('show');
};

$(document).ready(function(){
	$("#ecode").click(function(){
		 var email = $("#email").val();
		 $.get("<%=servletPath%>/mobile/uc/ajaxSendEmail.action",{'email':email,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				showConfirmModal(data.message);
	 				email_text();
	 			}else
	 			{
	 				showConfirmModal(data.message);	
	 			}
		    },"json");
	});
	$.formValidator.initConfig({formid:"emailreset",validatorgroup:"emailreset",onerror:function(msg){return false;},onsuccess:function(){
		var email = $("#email").val();
		var code = $("#emailcode").val(); 
		 $.get("<%=servletPath%>/mobile/uc/ajaxEmailConfirm.action",{'email':email,'code':code,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				showConfirmModal(data.message);
	 				$("#e_text").addClass('now');
	 				$(".safety_ico3").html("邮箱已认证");
	 				$(".e_text_yes").show();
	 				$(".e_text_no").hide();
	 			}else
	 			{
	 				showConfirmModal(data.message);	
	 			}
		    },"json");
		return false;
		}});

	$("#emailcode").formValidator({validatorgroup:"emailreset",onshow:" ",onfocus:"请输入正确的验证码",oncorrect:" "})
					.inputValidator({min:6,max:6,onerror:"请输入正确的验证码"})
});
</script>
</body>
</html>
