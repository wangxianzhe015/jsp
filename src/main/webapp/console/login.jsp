<%@page  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>登录</title>
	<meta name="keywords" content="云平台,领先的网络云安全专家" />
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/smp/css/css.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/smp/css/reglg.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/smp/css/rglgHead.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/themes/smp/css/rglgFoot.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/common/javascripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
$(function(){
	var isUserName,isPassWord = false;
	$('#userName').bind('blur',function isUserNameYz(){
		if($('#userName').val().length == 0){
			isUserName = false;
		}else{
			isUserName = true;
		}
	})

	$('#userPwd').bind('blur',function isPassWordYz(){
		if($('#userPwd').val().length == 0){
			isPassWord = false;
		}else{
			isPassWord = true;
		}
	})

	$('#submitBtn').bind('click',function(){
		$('#loginForm').submit();
	})
  	$("input[type='checkbox']").each(function(){
	    var a=$(this),
	    b=$.prop("checked");
	    $wrap=$("<span class='ui-select'></span>").on("click",function(b){
	       "SPAN"==b.target.nodeName&&(a.prop("checked")?$(this).css("backgroundPosition","0 0"):$(this).css("backgroundPosition","0 -33px"),a.trigger("click"))
	       }),b&&$wrap.css("background-position","0 -33px"),a.wrap($wrap)
	  })
})

</script>
</head>

<body>
    <%@include file="/themes/smp/header.jsp" %>
	<div id="main">
		<div class="login">
			<div class="left">
				<img src="<%=request.getContextPath()%>/themes/smp/images/loginad.png" />
			</div>
			<div class="right">
				<div class="r-con">
					<form action="<%=request.getContextPath()%>/platform/console/login/login.action" method="post" id="loginForm">
						<input type="hidden" name="browserVersion" id="browserVersion"/>
						<fieldset>
							<legend>登录页面</legend>
							<p class="r-c-con">
								<input type="text" name="user.userName" id="userName" class="ui-input input-t" />
								<span class="ico ico-1"></span>
								
							</p>
							<p class="r-c-con">
								<input type="password" name="user.password" id="userPwd" class="ui-input input-t" />
								<span class="ico ico-2"></span>
							
							</p>
							<p class="r-c-protocol">
								<a href="javascript:toGoto('#')">忘记密码</a>
						    	<input type="checkbox" checked="checked" id="isChecked">
						    	<label for="">记住用户名</label>
						    </p>
						    <div class="r-con-sub">
						    	<input type="button" id="submitBtn" class="ui-submit" value="立即登录" />
						    	<br />
						    	<br />
						    	没有账号 ? <a href="<%=request.getContextPath()%>/platform/portal/registry/index.action">立即注册</a>
						    	<br />
						    </div>
						    <div class="r-con-qq">
						    	您还可以使用合作账号登录
						    	<a href="#" class="login-QQ">腾讯账号</a>
						    	<a href="#" class="login-XL">新浪账号</a>
						    </div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--}主体 ed-->
	<%@include file="/themes/smp/foot.jsp" %>
</body>

</html>
