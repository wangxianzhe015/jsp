<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="重置密码"></c:set>
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

<!--弹框-->
<!--修改密码-->
    <div>
        <form id="pwdreset">
            <input id="pwd" name="pwd" class="form-control transparent" type="password" type="text" placeholder="请输入原密码"/>
            <br/>
            <input id="new_pwd" name="new_pwd" class="form-control transparent" type="password" type="text" placeholder="请输入至少6个字符的新密码"/>
            <br/>
            <input id="new_pwd_re" name="new_pwd_re" class="form-control transparent" type="password" type="text" placeholder="请再次输入新密码"/>
            <br/>
            <button class="btn btn-custom">保存修改</button>
        </form>
    </div>
    <!-- /.modal-dialog -->

    <!-- Modal -->
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
function loging_href()
 {
	location.href="<%=servletPath%>/mobile/uc/safeSetting.action";
 }
 
function showConfirmModal(msg) {
	$('#confirm_msg').html(msg);
	$("#confirm_dialog").modal('show');
};

//密码认证
$(document).ready(function(){
	$.formValidator.initConfig({formid:"pwdreset",validatorgroup:"pwdreset",onerror:function(msg){return false;},onsuccess:function(){
		var pwd = $("#pwd").val();
		var new_pwd = $("#new_pwd").val();
		var new_pwd_re = $("#new_pwd_re").val();  
		
		$.post("<%=servletPath%>/mobile/uc/ajaxResetPassword.action",
				{'password':pwd,'newPassword':new_pwd,'new_pwd_re':new_pwd_re},function(data){  
 	    	if(data.code==1){
 	    		showConfirmModal(data.message);
 				setTimeout("loging_href()",2000);
 			}else{
 				showConfirmModal(data.message);	
 			}
		    },"json");
		return false;
	}});
	$("#pwd").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
    .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
	$("#new_pwd").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
			     .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
	$("#new_pwd_re").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请再一次输入新密码",oncorrect:"输入正确"})
					.compareValidator({desid:"new_pwd",operateor:"=",onerror:"两次密码输入不一致,请确认"});
});
</script>
</body>
</html>
        