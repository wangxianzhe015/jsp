<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="登录众投客"/>
<c:set var="topPage" value="/mobile/main/index.action?menuId=main"/>
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

    <div class="content mrgt0">
    	<div class="register_form">    	
	    	<form action="<%=servletPath %>/portal/login/formLogin.action" method="post" role="form" class="form-horizontal" name="form1">
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<input type="text" class="form-control transparent" name="mobile" id="mobile" placeholder="请输入手机号码/用户名" value=""/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<input type="password" class="form-control transparent" name="password" id="password" placeholder="请输入密码" value=""/>
	    			</div>
	    		</div>	    		
	    		<div class="form-group row">
	    			<div class="col-xs-12">
                    <input type="checkbox" class="remembername" name="remembername">
    				<p id="remembername_check">
    				<img id="remembername_checked_img" src="<%=resourcePathM%>/images/ic_circle_check.png"/>
    				<img id="remembername_unchecked_img" src="<%=resourcePathM%>/images/ic_circle_uncheck.png"/>
    				下次自动登录
    				</p>
	    			</div>
	    		</div>
	    		<div class="form-group row mrgt30">
	    			<div class="col-xs-12">
	    				<button type="button" class="btn btn-custom2" id="login_button">登录</button>
	    			</div>
	    		</div>   		
	    		<div class="form-group row">
	    			<div class="col-xs-6 text-left">
	    				<p><a href="<%=servletPath%>/mobile/login/register.action">快速注册</a></p>
	    			</div>
	    			<div class="col-xs-6 text-right">
	    				<p><a href="<%=servletPath%>/mobile/registry/findPassword.action">忘记密码</a></p>
	    			</div>
	    		</div>
	    	</form>
	    </div>
	    <div class="modal fade custom_modal" id="confirm_dialog" tabindex="-1" role="dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				<span id="confirm_msg">用户已存在</span>
    			</div>
    			<div class="modal-footer">
    				<div class="row">
    					<div class="col-xs-12"><a data-dismiss="modal">确定</a></div>    					
    				</div>
    			</div>
    		</div>
    	</div>
    </div>    
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM%>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM%>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM%>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM%>/js/common/main.js"></script>
       
    <script>
    	$(document).ready(function() {
    		var login_url = null;
	    	$("#remembername_check").on("click", function(){
	    		$("#remembername_checked_img").toggle();
	    		$("#remembername_unchecked_img").toggle();
	    		var obj=$("input[name='remembername']");
	    		obj.prop("checked",!obj.prop("checked"));
	    	});
	    	$('#login_button').on('click', function() {
	    		
	    		var mobile = $("#mobile").val();
	    		var password = $("#password").val();
	    		if(mobile=='') {showConfirmModal('请输入手机号码');return false;}
	    		if(password=='') {showConfirmModal('请输入密码');return false;}
	    		//if(!/^1\d{10}$/.test(mobile)) {showConfirmModal('请填写正确的手机号码');return false;}
	    		
	    		var remembername = 0;
	    		if($("input[type='checkbox'][name='remembername']").is(':checked')) {
	    			remembername = 1;
	    		}

	    		$('#login_button').attr('disabled', 'disabled');
	    		$.post('<%=servletPath%>/mobile/login/ajaxLogin.action',{mobile:$('#mobile').val(),password:$('#password').val(),btn_submit:'login',remembername:remembername},function(data){
	    			if(data.code==1) {
	    				function successJump() {
	    					if(login_url) {
	    						setTimeout(function(){window.location.href=login_url;},2000)
	    					} else {
	    						setTimeout(function(){window.location.href = '<%=servletPath%>/mobile/uc/index.action';},2000)
	    					}
	                    }
	    				showConfirmModal(data.message);successJump();
	    			} else if(data.code=='-5') {
	    				$('#login_button').removeAttr('disabled', 'disabled');
	    				showConfirmModal(data.message);
	    			}else {
	    				$('#login_button').removeAttr('disabled', 'disabled');
	    				showConfirmModal(data.message,'error');
	    			}
	    		});

	    		//showConfirmModal('用户不存在');
	    		//showConfirmModal('手机号码格式错误');
	    		//showConfirmModal('密码格式错误');
	    		//showConfirmModal('请输入手机验证码');
	    		//showConfirmModal('验证码错误');
	    		//showConfirmModal('注册成功');
	    	});
    	});    	
    	function showConfirmModal(msg) {
    		$('#confirm_msg').html(msg);
    		$("#confirm_dialog").modal('show');
    	}
    	
    </script>
</body>
</html>