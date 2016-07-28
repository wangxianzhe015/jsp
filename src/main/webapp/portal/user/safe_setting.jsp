<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="我的账户"></c:set>
	<%@include file="../common/meta.jsp" %>
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/uc/usercenter.js"></script>
</head>
<body>
<%@include file="../common/uc_header.jsp" %>

<script>
$(document).ready(function(){
	$('#e').click();
});
</script>
<div class="wrap clear">
    <div class="row mt-20">
        <div class="col-7 mr-10">
            <!--左侧栏-->
			<%@include file="./uc_menu.jsp" %>
        </div>
        <!--右侧栏-->
        <div class="col-23 bg_white" style="background: #fff">
        
			<div class="clear  user_tit_box mt-20">
                 <div class="fl user_tit font-wet">安全设置</div> 
            </div>

            <!--修改安全认证-->
            <div class="safety_approve">
                <div class="check_safety clear now">
                    <h3 class="safety_ico1">登 录 密 码</h3>
                    <p>安全强度高的登录密码可以使账号更安全，建议您设置一个包含数字和字母，<br>
						并长度超过6位以上的登录密码。</p>
                    <h4 data-backdrop="static" data-toggle="modal" data-target="#myModa00">修改密码</h4>
                </div>
                <div id="m_text" class="check_safety clear now">
                     <h3 class="safety_ico2 " >手机已认证</h3>
                     <p>手机认证可提高账号的安全性和信任级别，同时也是找回密码等操作时验证您身份的途径之一。</p>
                     <h4>认证通过</h4>
                                    
                </div>
                
                <div id="e_text" class="check_safety <c:if test="${user.emailAuth=='1'}">now </c:if> ">
					<c:choose>
						<c:when test="${user.emailAuth=='1'}">
							<h3 class="safety_ico3" >邮箱已认证</h3>
						</c:when>
						<c:otherwise>
							<h3 class="safety_ico3">邮箱未认证</h3>
						</c:otherwise>
					</c:choose>                
                    
                    <p >邮箱认证可提高账号的安全性，同时也是找回密码等操作时验证您身份的途径之一。</p>
                    
					<c:choose>
						<c:when test="${user.emailAuth=='1'}">
							 <h4 class="e_text_yes">认证通过</h4>
						</c:when>
						<c:otherwise>
						    <h4 class="e_text_yes" style="display: none">认证通过</h4>
							<h4 id="e" class="e_text_no" data-backdrop="static" data-toggle="modal" data-target="#myModa22">认证邮箱</h4>
						</c:otherwise>
					</c:choose>                     
                   
                    
                                   
                </div>
               <div id="realname_text" class="check_safety <c:if test="${not empty user.realName}">now </c:if> ">
					<c:choose>
						<c:when test="${not empty user.realName}">
							<h3 class="safety_ico4" >已实名认证</h3>
						</c:when>
						<c:otherwise>
							<h3 class="safety_ico4">未实名认证</h3>
						</c:otherwise>
					</c:choose>                
                    
                    <p >在平台进行项目投资，必须进行实名认证以保障交易的真实性。</p>
                    
					<c:choose>
						<c:when test="${not empty user.realName}">
							 <h4 class="realname_text_yes">认证通过</h4>
						</c:when>
						<c:otherwise>
						    <h4 class="realname_text_yes" style="display: none">认证通过</h4>
							<h4 id="realname" class="realname_text_no" data-backdrop="static" data-toggle="modal" data-target="#myModa23">实名认证</h4>
						</c:otherwise>
					</c:choose>                     
                   
                    
                                   
                </div>                
                <%
                /*
                <div class="check_safety clear <c:if test="${user.thirdPayAuth=='1'}">now </c:if>">
		              <h3 class="safety_ico6">同步易宝</h3>
		              <p>众投客为保障投资资金安全与第三方支付平台合作，进行项目融资资金的托管。</p>
		              <h4><a href="http://user.renrentou.com/user/identityverification" style="color: #fff;">同步易宝</a></h4>
		         </div>
		        */
		        %>
       
            </div>

        </div>

        
		<%@include file="./safesetting/auth_password.jsp" %>
		<%@include file="./safesetting/auth_mobile.jsp" %>
		<%@include file="./safesetting/auth_email.jsp" %>
		<%@include file="./safesetting/auth_realname.jsp" %>
    </div>
    </div>
</div>

<%@include file="../common/footer.jsp" %>  
</body>
</html>
