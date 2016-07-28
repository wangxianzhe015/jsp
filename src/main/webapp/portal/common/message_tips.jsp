<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="./common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title> - 草根天使投资放心、实体店铺融资省心的股权众筹平台</title>
<meta name="keywords" content="人人投,众筹,众筹网,股权众筹,众筹平台,天使投资,店铺融资,草根天使,开分店融资,股权众筹平台" />
<meta name="description" content="人人投(www.renrentou.com)是草根天使投资放心、实体店铺（吃、喝、玩、乐店铺）融资省心的股权众筹平台,旨在搭建一个高效、安全、快捷的互联网股权众筹平台." />
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
</head>
<body>

<%@include file="./uc_header.jsp" %>

<script type="text/javascript">
var pgo=0;
function JumpUrl(){
	if(pgo==0){
		location='${tips.backUrl}';
		pgo=1;
	}	
}
$(document).ready(function(){
    var sto = null;
    (function waitSecond() {
        var waitSecondVar = parseInt($("#waitSecond").html());
        if (waitSecondVar > 1) {
            $("#waitSecond").html(--waitSecondVar);
            sto = setTimeout(waitSecond, 1000);
        } else {
            clearTimeout(sto);
            JumpUrl();
        }
    })();
});
</script>

<style>
.notfind_box{ height: 500px; border-radius: 5px; margin-top: 100px; text-align: center;}
.notfind_box b{ width: 100%; display: block; font-size: 30px; font-weight: normal; line-height: 80px; margin-top: 90px;}
.notfind_box p{ font-size: 18px; line-height: 40px;}
.notfind_box p span{ color: #a60000;}
.bt_click{ display: block; width: 100px; height: 30px; line-height: 30px; border: none; border-radius: 5px; color: #fff; background: #f63; font-size: 16px; margin: 40px auto; cursor: pointer;}
.notfind_box a:hover{ color:#fff;}
</style>

  <div class="wrap border-c notfind_box">
    <b>${tips.message}</b>
    <p><span><span id="waitSecond">${tips.waitSecond}</span>秒钟后</span>将自动跳转&nbsp;&nbsp;如果没有自动跳转</p>
    <a class="bt_click" href="${tips.backUrl}">点击跳转</a>
  </div>
  
  <%@include file="./footer.jsp" %>
</body>
</html>