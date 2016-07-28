<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="找回密码"/>
	<%@include file="../common/meta.jsp" %>
	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/register.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>

	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/password.css" />
</head>
<body>

<%@include file="../common/header.jsp" %>

<script>
$(document).ready(function(){
	$.formValidator.initConfig({formid:"form1",validatorgroup:"10",onerror:function(msg){return false;},onsuccess:function(){}});
	$("#code").formValidator({onshow:" ",onfocus:"请输入正确的手机或邮箱验证码",oncorrect:"输入正确"})
				.inputValidator({min:6,max:6,onerror:"请输入6位验证码"})
// 			  .ajaxValidator({
// 				    type : "get",
// 				    url : "/ajax/AjaxCodeCheck",
// 				    datatype : "json",
// 				    success : function(data){
// 								if(data.status == 1)
// 								{
// 									return true;
// 								}else
// 								{
// 									return false;
// 								}
// 							},
// 				    buttons: $("#button"),
// 	//			    error: function(){alert("服务器没有返回数据，可能服务器忙，请重试");},
// 				    onerror : "请输入正确的手机或邮箱验证码",
// 				    onwait : " "
// 				});
	$("#new_pwd").formValidator({validatorgroup:"10",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
			     .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
	$("#new_pwd_re").formValidator({validatorgroup:"10",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
	                .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
					.compareValidator({desid:"new_pwd",operateor:"=",onerror:"两次密码输入不一致,请确认"});

});
</script>
    <div class="main_box">
        <div class="main_nei">
            <div class="title">
                <h1>找回密码</h1>
                <div class="title_jindu">
                    <p class="diwei"><img src="<%=resourcePath %>/images/xiugai_jindu_jindu2.jpg" alt=""/></p>
                    <ul>
                        <li>输入注册邮箱/手机</li>
                        <li class="re">设置新密码</li>
                        <li>完成</li>
                    </ul>
                </div>
            </div> 
            <div class="main_from">
                    <form action="<%=servletPath %>/portal/registry/passwordSuccess.action" method="post" name="form1" id="form1" class="form_b">
                        <table border="0px" style="font-size:12px" width="630px">
                            <tr>
                                <td><input name="code" type="text" class="pasd" id="code" style="" placeholder="邮箱或短信验证码"/></td>
                                <td><div id="codeTip" style="width:250px"></div></td>
                            </tr>
                            <tr>
                                <td><input name="newPassword" type="password" class="pasd" id="new_pwd"  placeholder="请输入新密码" />
                                <td><div id="new_pwdTip" style="width:200px;margin-top: 30px"></div></td>
                            </tr>
                            <tr>
                                <td><input name="new_pwd_re" type="password" class="pasd" id="new_pwd_re" placeholder="再次输入新密码" />
                                <td><div id="new_pwd_reTip" style="width:200px;margin-top: 30px;" class="onError"></div></td>
                            </tr>
                        </table>
                        <button id="button" class="btn">下一步</button>
                    </form>
            </div>
        </div>
    </div>
<!--首页底部-->
<%@include file="../common/footer.jsp" %>
</body>
</html>