<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="众投客注册"/>
	<%@include file="../common/meta.jsp" %>	
	
	<meta name="description" content="众投客(www.renrentou.com)是草根天使投资放心、实体店铺（吃、喝、玩、乐店铺）融资省心的股权众筹平台,旨在搭建一个高效、安全、快捷的互联网股权众筹平台." />
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/register.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/register.js"></script>

</head>
<body>

<%@include file="../common/header.jsp" %>

<div class="common-1188 register">
    <div class="col-19">
        <p class="register_title">用户注册</p>
        <form action="" method="post" autocomplete="off" name="form1" id="form1"  style=" margin-top: 10px;">
            <table border="0px">
                <tr>
                    <td align="right">手机号:</td>
                    <td><input class="register_input" type="text" id="mobile"  /></td>
                    <td><div id="mobileTip"></div></td>
                </tr>
                <tr>
                    <td align="right">手机验证码:</td>
                    <td>
                        <input class="register_input" type="text" id="telcode" style="width:145px; *width:138px; *float: left; _float: left;" />
	                    <div class="btn_yzm_div">
	                    	<input type="button" id="btn_yzm2" value="发送验证码" class="border-rdi btn_yzm" onclick="showMobileSend();" data-backdrop="static" />
	                    </div>
                    </td>
                    <td><div id="telcodeTip"></div></td>
                </tr>
                <tr>
                    <td align="right">密码:</td>
                    <td><input class="register_input" type="password" id="password"  /></td>
                    <td><div id="passwordTip"></div></td>
                </tr>
                <tr>
                    <td align="right">
                    	<input checked="checked" type="checkbox" value="1" style="width:15px; height:15px;" id="xieyi_check" class="border-rdi border-no"/>
                    </td>
                    <td style=" width:280px;">
                    	<p style="font-size:14px; width:280px; padding-left: 8px;">我已阅读并同意
                    		<a href="#" id="xieyi" data-toggle="modal" data-target="#myModa_header_box_register_form_xieyi" data-backdrop="static">《众投客网站服务协议》</a>
                    	</p>
                    </td>
                    <td><div></div></td>
                </tr>
            </table>
            <br />
            <input type="submit" name="button" id="button" value="立即注册" class="border-no border-rdi btn_zhuce" />
        </form>
    </div>
    <div class="col-11 register_right">
        <p class="register_right_title">安全、高效、低门槛的实体店铺投融资平台！</p>
        <p class="register_right_p">已有众投客账号？</p>
        <button type="submit" onclick="location.href='<%=servletPath %>/portal/login/login.action';" class="border-no border-rdi btn_denglu">登录</button>
    </div>
</div>
<div class="row"></div>
<%@include file="./mobilecode_dialog.jsp" %>
<%@include file="../common/footer.jsp" %>



</body>
</html>