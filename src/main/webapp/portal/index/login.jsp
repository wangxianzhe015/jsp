<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="登录众投客"/>
<%@include file="../common/meta.jsp" %>	
<link rel="stylesheet" type="text/css"	href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
<link type="text/css" rel="stylesheet"	href="<%=resourcePath %>/css/register.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/register.js"></script>
</head>
<body>

	<%@include file="../common/header.jsp"%>
	<div class="wrap register" >
		<div class="col-19">
			<p class="register_title">登录</p>
			<form action="<%=servletPath %>/portal/login/formLogin.action" method="post" name="form1" id="form1">
				<table border="0px">
					<tr>
						<td align="right">手机号:</td>
						<td><input class="register_input" type="text" id="user" name="mobile" /></td>
						<td><div id="userTip"></div></td>
					</tr>

					<tr>
						<td align="right">密码:</td>
						<td><input class="register_input" type="password" id="password"  name="password"/></td>
						<td><div id="passwordTip"></div></td>
					</tr>
					<tr>
						<td align="right">验证码:</td>
						<td><input class="fl register_input" name="verifyCode" id="code" type="text" style="width:90px;" />
							<div class="fl yanzheng_img">
								<img id="fresh_valicode" src="<%=contextPath %>/portal/common/verifycode.jsp" style="height:34px;width:76px;" />
							</div>
							<div class="fr">
								<a href="javascript:void(0);" onclick="refreshCode();" class="yanzheng_a left">看不清<br>换一张
								</a>
							</div></td>
						<td><div id="codeTip"></div></td>
					</tr>
				</table>
				<br /> 
				
				<input type="submit" name="button" id="button" value="立即登录" class="border-no border-rdi btn_zhuce submit_login_button" style="margin-left: 60px;" /> 
				<a href="<%=servletPath %>/portal/registry/findPassword.action" class="forget_pw">忘记密码</a>
			</form>
		</div>
		<div class="col-11 register_right" >
			<p class="register_right_title" style="padding-top: 60px;">安全、高效、低门槛的实体店铺投融资平台！</p>
			<p class="register_right_p">没有账号？欢迎注册加入我们！</p>
			<button type="submit"
				onclick="location.href='<%=servletPath%>/portal/registry/registry.action';"
				class="border-no border-rdi btn_denglu">快速注册</button>
		</div>
	</div>
	<div class="row"></div>

	<script>
    function refreshCode() {
        document.getElementById('fresh_valicode').src='<%=contextPath %>/portal/common/verifycode.jsp?t=' + Math.random();
    }

    function opendialog(url,name,issubmit,id,w,h) {
        w = w ? w : 400;
        h = h ? h : 400;
        issubmit = issubmit ? issubmit : 0;
        id = id ? id : 'info';
        window.top.art.dialog({title:name, id:id, iframe:url, width:w, height:h, lock:true},
            function(){
                if(issubmit==0) {
                    window.top.art.dialog({id:id}).close();
                    return true;
                } else {
                    var d = window.top.art.dialog({id:id}).data.iframe;
                    var form = d.document.getElementById('dosubmit');
                    form.click();
                    return false;
                }
            },
            function(){
                window.top.art.dialog({id:id}).close();
            });void(0);
    }
    $(document).ready(function(){
        $.formValidator.initConfig({formid:"form1",validatorgroup:"10",onerror:function(msg){},onsuccess:function(){
            $('.submit_login_button').attr('disabled','disabled');
            $.post('<%=servletPath%>/portal/login/ajaxLogin.action',{mobile:$('#user').val(),password:$('#password').val(),code:$('#code').val(),btn_submit:'login'},function(data){
            	if(data.code==1) {
                    function successJump() {
                        //var url = document.referrer;
                        var url="<%=servletPath%>/portal/main/index.action";
                        
                        setTimeout(function(){window.location.href=url;},2000)
                    }
                    popBox(data.message,'success',2);successJump();
                } else if(data.code=='-5') {
                	$('.submit_login_button').removeAttr('disabled');
                    popBox(data.message,'info');refreshCode();
                }else {
                	$('.submit_login_button').removeAttr('disabled');
                    popBox(data.message,'error');refreshCode();
                }
            })
            return false;
        }});
    });

</script>
	<!--首页底部-->
	<%@include file="../common/footer.jsp"%>
</body>
</html>