<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="./common.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title> - 草根天使投资放心、实体店铺融资省心的股权众筹平台</title>
	<%@include file="./meta.jsp"%>
	<c:set var="pageTitle" value="众投客"></c:set>
	<c:set var="topPage" value=""></c:set>
	<link rel="stylesheet" type="text/css" href="<%=resourcePathM %>/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcePathM %>/css/style.css" />
</head>
<body>

<%@include file="./header.jsp" %>

<style>
.notfind_box{ height: 100px; border-radius: 5px; margin-top: 100px; text-align: center;}
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

<script type="text/javascript" src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
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
</body>
</html>