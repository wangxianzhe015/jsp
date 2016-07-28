<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="com.smartcloud.platform.component.mvc.exception.FrameworkException"%>
<%@page import="com.smartcloud.platform.component.common.utils.ChangeUtils"%>
<%@page import="com.smartcloud.platform.component.common.utils.SystemInfo"%>
<%@page import="java.lang.reflect.InvocationTargetException"%>
<%
	String errorTitle = null;
	String errorMsg = null;
	String errorStackInfo = null;
	Throwable e = (Throwable)request.getAttribute("sys_exception");
	String returnURL = (String)request.getAttribute("prev_page_url");
	
	if( e!=null) {
		if(e instanceof FrameworkException){
		   e=((FrameworkException)e).detail;
		}
		if(e instanceof InvocationTargetException){
		    errorMsg=((InvocationTargetException)e).getTargetException().getMessage();
		}
		else {
			errorMsg =  e.getMessage();
		}
		errorStackInfo = ChangeUtils.replaceString(SystemInfo.LINE_SEPARATOR, "<br>", ChangeUtils.getStackTraceStr(e));
	}
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/common/css/public.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/common/javascripts/jquery-1.7.1.min.js"></script>
<script language="javascript">
var $j = jQuery.noConflict();
$j(function(){
	$j(".show-details").toggle(function(){
		$j(this).closest(".btn-wrap").addClass("btn-hide").next(".details").show();	
	},function(){
		$j(this).closest(".btn-wrap").removeClass("btn-hide").next(".details").hide();
	})
})

function doBack(){
	if(window.opener!=null)
		window.close();

	var url="<%=returnURL%>";
	if(url==null || url=="" ||url=="null") {
		window.history.go(-1);
	}else{
		window.location.href=url;
	}
}
</script>
<html>
<head>
<style>
html, body, div, h1, h2, h3, h4, h5, h6, p, ul, li, dl, dt, dd, table, th, td, span, a, em, b, i, input, img { margin:0; padding:0;}
body {font:12px/180% Arial, Helvetica, sans-serif, "宋体";}
html,body{height:100%;}
textarea{word-wrap:break-word; word-break:break-all;}
ul,li{list-style:none;}
h1,h2,h3{font-size:14px;}
b{font-weight:normal; }
i, em{font-style:normal; }
.fl{float:left;}
.fr{float:right;}
.clearfix:after{content:" "; display:block; visibility:hidden; height:0; font-size:0; clear:both;}
.clearfix{*zoom:1;}
.left{text-align:left;}
.right{text-align:right;}
.center{text-align:center;}
.bn{border-bottom:none;}
.center{text-align:center;}
</style>
</head>
<body class="portal-new new-scroll">
<div class="radius error">
	<b class="b1"></b>
	<b class="b2"></b>
	<div class="rmain">
		<div class="hd">
			<h3>错误报告</h3>
		</div>
		<div class="bd">
			<div class="radius describe">
				<b class="b1"></b>
				<b class="b2"></b>
				<div class="rmain">
					<p class="error-item">
						<strong>操作过程中出现错误：</strong><br />
						<span class="tips-color"><%=errorMsg%></span> 
					</p>
					<p class="error-item">
						<strong>请尝试以下操作：</strong><br />
						<i class="dot">·</i>重新进入菜单,并执行相同操作。<br /> 
						<i class="dot">·</i>请与系统管理员联系，通知他们该链接不正确。 
					</p>
					<p class="error-item error-item-bn">
						<strong>如果您有任何疑问、意见、建议、咨询，请联系管理员</strong> 
					</p>
				</div>
				<b class="b3"></b>
				<b class="b4"></b>
			</div>
			<div class="btn-wrap">
				<input name="windowClose" type="button" class="btn-gray" value="关闭" onclick="window.close();"/>
				<input name="historyBack" class="btn-gray" type="button" value="返回上一页" onclick="doBack();" />
				<span class="btn-in"><input class="btn-color show-details" type="button" value="详细信息" /><i></i></span>
			</div>
			<div class="details">
				<p class="error-item">
					<span>
					   <%=errorStackInfo %>
					</span> 
				</p>
				<p class="double-line"></p>
			</div>
		</div>
	</div>
	<b class="b3"></b>
	<b class="b4"></b>
</div>
<SCRIPT language="javascript">
	if(window.parentWindow != undefined){	
		document.all("historyBack").style.display = "none";//弹出框，返回上一页隐藏
	}else{
		document.all("windowClose").style.display = "none";//关闭按钮隐藏
	}
</SCRIPT>
</body>
</html>
