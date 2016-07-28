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
	$("#name").formValidator({validatorgroup:"10",onshow:" ",onfocus:"请输入正确手机或邮箱",oncorrect:"输入正确"})
			  .regexValidator({regexp:"emailmobile",datatype:"enum",onerror:"请输入正确手机或邮箱"})
			  .ajaxValidator({
				    type : "get",
				    url : "<%=servletPath%>/portal/registry/checkEmailOrMobile.action",
				    datatype : "json",
				    success : function(data){
								if(data.code == 1)
								{
									return true;
								}else
								{
									return false;
								}
							},
				    buttons: $("#buttonPasswordFind"),
	//			    error: function(){alert("服务器没有返回数据，可能服务器忙，请重试");},
				    onerror : "邮箱或手机不存在",
				    onwait : " "
				});
	$("#code").formValidator({validatorgroup:"10",onshow:" ",onfocus:"请输入正确的验证码",oncorrect:"输入正确"})
			  .ajaxValidator({
				    type : "get",
				    url : "<%=servletPath%>/portal/registry/checkVerifyCode.action",
				    datatype : "json",
				    success : function(data){
						if(data.code == 1)
						{
							return true;
						}else
						{
							return false;
						}
					},
					buttons: $("#buttonPasswordFind"),
		//			error: "",
				    onerror : "请输入正确的验证码",
				    onwait : " "
				});
	
});
</script>
    <div class="main_box" style="width: 100%">
        <div class="main_nei" style="margin: 40px auto">
            <div class="title">
                <h1>找回密码</h1>
                <div class="title_jindu">
                    <p class="diwei"><img src="<%=resourcePath %>/images/xiugai_jindu.jpg" alt=""/></p>
                    <ul>
                        <li class="re">输入注册邮箱/手机</li>
                        <li>设置新密码</li>
                        <li>完成</li>
                    </ul>
                </div>
            </div> 
            <div class="main_from">
                <div class="from_left"></div>
                <div class="from_right">
                    <form action="<%=servletPath %>/portal/registry/passwordReset.action" method="post" name="form1" id="form1">
                        <table border="0px" style="font-size:12px" width="630px">
                            <tr>
                                <td><input name="name" type="text" id="name" style="width:256px;height: 35px;
                                background: url(<%=resourcePath%>/images/xiugai_xinxi.png) no-repeat left center;
                                padding-left: 30px" placeholder="请输入邮箱或手机"/></td>
                                <td><div id="nameTip" style="width:250px"></div></td>
                            </tr>
                            <tr>
                                <td><input name="code" type="text" id="code" style="width:110px" placeholder="请输入验证码" />
                                    <span><img id="fresh_valicode" src="<%=contextPath %>/portal/common/verifycode.jsp" alt=""/></span>
                                    <a href="javascript:void(0);" onclick="document.getElementById('fresh_valicode').src='<%=contextPath %>/portal/common/verifycode.jsp?t=' + Math.random();">看不清，换一张</a></td>
                                <td style="position: relative"><div id="codeTip" style="margin-top: 30px;*position: absolute;top: 12px"></div></td>
                            </tr>
                        </table>
                        <button id="buttonPasswordFind" class="btn">下一步</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
<!--首页底部-->
<%@include file="../common/footer.jsp" %>
</body>
</html>