<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="众投客注册"/>
	<c:set var="topPage" value="/mobile/main/index.action?menuId=main"/>
	<%@include file="../common/meta.jsp" %>	
	
	<meta name="description" content="众投客(www.renrentou.com)是草根天使投资放心、实体店铺（吃、喝、玩、乐店铺）融资省心的股权众筹平台,旨在搭建一个高效、安全、快捷的互联网股权众筹平台." />
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
	    	<form action="" method="post" name="form1" id="form1" role="form" class="form-horizontal">
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<input type="text" id="mobile" class="form-control transparent" placeholder="请输入手机号码" value=""/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
		    		<div id="mobileTip"></div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<input type="password" class="form-control transparent" id="password" placeholder="请设置至少6个字符的登录密码" value=""/>
	    			</div>
	    		</div>	    		
	    		<div class="form-group row">
	    			<div id="passwordTip"></div>
	    		</div>
	    		<div class="form-group row">	    			
	    			<div class="col-xs-6">
	    				<input type="text" class="form-control transparent" id="telcode" placeholder="请输入手机验证码"/>
	    			</div>
	    			<div class="col-xs-6 nopadding-left">
	    				<input type="button" id="btn_yzm2" class="btn btn-custom nomargin" onclick="showMobileSend();" data-backdrop="static" value="获取手机验证码"/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div id="telcodeTip"></div>
    			</div>
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<p>
	    					<img id="agree_img" src="<%=resourcePathM%>/images/ic_circle_check.png"/>
	    					<img id="disagree_img" src="<%=resourcePathM%>/images/ic_circle_uncheck.png" style="display:none;"/>
	    					我已阅读并同意
	    					<a href="javascript:" data-toggle="modal" data-target="#agree_note">《众投客网站注册协议》</a>
    					</p>
	    				<input checked="checked" type="checkbox" value="1" style="display:none;" id="xieyi_check"/>
	    			</div>
	    		</div>
	    		<div class="form-group row mrgt30">
	    			<div class="col-xs-12">
	    				<input type="submit" class="btn btn-custom2" id="button" value="注册"/>
	    			</div>
	    		</div>   		
	    		<div class="form-group row">
	    			<div class="col-xs-12">
	    				<p class="text-center">已有账号，<a href="<%=servletPath%>/mobile/login/login.action">直接登录</a></p>
	    			</div>
	    		</div>
	    	</form>
	    </div>
	    <div class="modal fade agree_modal" id="agree_note" tabindex="-1" role="dialog">
	    	<div class="modal-content">
	    		<div class="modal-header">
    				<span id="agreement_header">众投客网站注册协议</span>
    				<a href="javascript:" class="ic_close" data-dismiss="modal"><img src="<%=resourcePathM%>/images/ic_close.png"/></a>
    			</div>
    			<div class="modal-body">
    				<%@include file="../login/agreement.jsp" %>
    			</div>
	    	</div>
	    </div> 
	    <div class="modal fade custom_modal" id="confirm_dialog" tabindex="-1" role="dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				<span id="confirm_msg"></span>
    			</div>
    			<div class="modal-footer">
    				<div class="row">
    					<div class="col-xs-12"><a href="javascript:" data-dismiss="modal">确定</a></div>    					
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
    <%@include file="mobilecode_dialog.jsp" %>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM%>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM%>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM%>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM%>/js/common/main.js"></script>
	<script type="text/javascript" src="<%=resourcePathM %>/js/common/formvalidator.js"></script>
	<script type="text/javascript" src="<%=resourcePathM %>/js/common/register.js"></script>
       
    <script>
    	$(document).ready(function() {
	    	$("#agree_img").on("click", function(){
	    		$(this).hide();
	    		$("#disagree_img").show();
	    		$("#xieyi_check").prop("checked",false);
	    	});
	    	$("#disagree_img").on("click", function(){
	    		$(this).hide();
	    		$("#agree_img").show();
	    		$("#xieyi_check").prop("checked",true);
	    	});
    	});    	
    	
    </script>
</body>
</html>