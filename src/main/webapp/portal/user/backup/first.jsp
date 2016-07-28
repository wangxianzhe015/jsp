<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>发布项目 - 草根天使投资放心、实体店铺融资省心的股权众筹平台</title>
<meta name="keywords" content="人人投,众筹,众筹网,股权众筹,众筹平台,天使投资,店铺融资,草根天使,开分店融资,股权众筹平台" />
<meta name="description" content="人人投(www.renrentou.com)是草根天使投资放心、实体店铺（吃、喝、玩、乐店铺）融资省心的股权众筹平台,旨在搭建一个高效、安全、快捷的互联网股权众筹平台." />
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/jquery.datetimepicker.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery.datetimepicker.js"></script>

</head>
<body>

	<%@include file="../../common/uc_header.jsp"%>
	<script>
$(document).ready(function(){
	$('#raiseBeginDate').datetimepicker({lang:'ch',formatDate: 'dd-mm-yy'});
	$('#raiseEndDate').datetimepicker({lang:'ch',formatDate: 'dd-mm-yy'});
	
	$.formValidator.initConfig({formid:"form_publish_first",onerror:function(msg){return false;},onsuccess:function(){
		 $("#button_next").attr('disabled','true');
		}});
	$("#projectName").formValidator({onshow:" ",onfocus:"请输入2-10位汉字数字或字母",oncorrect:"输入正确"}).regexValidator({regexp:"projectname",datatype:"enum",onerror:"请输入2-10位汉字数字或字母"});			  
	$("#financeAmount").formValidator({onshow:" ",onfocus:"请输入正确的筹资金额",oncorrect:"输入正确"}).regexValidator({regexp:"amount",datatype:"enum",onerror:"请输入正确的筹资金额"});
	$("#industryCategory").formValidator({onshow:" ",onfocus:"请选择行业",oncorrect:"请选择行业"}).inputValidator({min:1,onerror: "请选择行业"});
	$("#address").formValidator({onshow:" ",onfocus:"请输入店铺地址",oncorrect:" "}).regexValidator({regexp:"projectname",datatype:"enum",onerror:"请输入2-10位汉字数字或字母"});
	$("input[name='xieyi']").formValidator({onshow:" ",onfocus:" ",oncorrect:" "}).inputValidator({min:1,onerror:"请阅读并同意《委托融资服务协议》"});

		

	$("#province").change(function(){ 
			var provinceId=$(this).children('option:selected').val();
			var html="<option value=\"\">请选择城市</option>";
			$.ajax({
				url : servletPath+"/portal/city/getCitys.action?provinceId="+provinceId,
				type : 'POST',
				global : false,
				dataType : 'json',
				success : function(data) {
					var citys = data.citys;
					if (citys.length > 0) {
						$.each(citys, function(i, v) {
							html += "<option value=\"" + v.id + "\">"+v.name+"</option>";
						})
						
						$("#city").html(html);
					}
				}
			});
		});

	
	<c:if test="${not empty project.city}">
	var html="<option value=\"\">请选择城市</option>";
	$.ajax({
		url : servletPath+"/portal/city/getCitys.action?provinceId=${project.province}",
		type : 'POST',
		global : false,
		dataType : 'json',
		success : function(data) {
			var citys = data.citys;
			if (citys.length > 0) {
				$.each(citys, function(i, v) {
					var selected=" ";
					if(v.id=="${project.city}"){
						selected=" selected";
					}
					html += "<option value=\"" + v.id + "\""+selected+">"+v.name+"</option>";
				})
				
				$("#city").html(html);
			}
		}
	});		    
</c:if>		
});
</script>
	<div class="wrap clear">
		<div class="row mt-20">
			<div class="col-7 mr-10">
				<!--左侧栏-->
				<%@include file="../uc_menu.jsp"%>
			</div>

			<!--右侧栏-->
			<div class="col-23 bg_white">
				<div class="pos_jindu">
					<div class="release-list">
						<ul class="release-ul releaseBg1">
							<li><a>基本资料</a></li>
							<li><a>股权设置</a></li>
							<li><a>项目编辑</a></li>
							<li><a>支付账号注册</a></li>
							<li><a class="release-w">平台审核</a></li>
						</ul>
					</div>
					<p></p>
					<h3>基本信息</h3>
                <form id="form_publish_first" name="form_publish_first" method="post" action="<%=servletPath%>/portal/uc/publishSecond.action">
                	<input type="hidden" name="status" value="${status }"/>
                	<input type="hidden" name="project.projectId" value="${project.projectId }"/>
                    <label for="">项目名称 :</label><input type="text" id="projectName" name="project.projectName" class="iup"  value="${project.projectName }"/><div id="projectNameTip" style="display:inline-block"></div><br/>
                    <label for="">筹资金额 :</label><input type="text" id="financeAmount" name="project.financeAmount" class="iup"  value="${project.financeAmount }" />元<div id="financeAmountTip"  style="display:inline-block"></div><br/>
                    <label for="">开始日期 :</label><input type="text" id="raiseBeginDate" name="project.raiseBeginDate" readonly="readonly" value='<fmt:formatDate value="${project.raiseBeginDate}" pattern="yyyy-MM-dd"/>' class="iup"/> <br/>
                    <label for="">结束日期 :</label><input type="text" id="raiseEndDate" name="project.raiseEndDate" readonly="readonly" value='<fmt:formatDate value="${project.raiseEndDate}" pattern="yyyy-MM-dd"/>' class="iup"/> <br/>
                    
                    <label for="">行业类别 :</label>
					<select  name='project.industryCategory' id='industryCategory'>
							<option value=''>请选择行业</option>
							<c:forEach items="${projectCategories}" var="projectCategory" varStatus="index">
							<option value="${projectCategory.categoryId }" <c:if test="${projectCategory.categoryId==project.industryCategory }">selected</c:if>>${projectCategory.categoryName }</option>
							</c:forEach>
					</select>
					<div id="industryCategoryTip"  style="display:inline-block"></div>
                    <br/>
                    <label for="">新店地址 :</label>
                    <select name='project.province' id='province' >
                    	<option value=''>请选择省份</option>
						<c:forEach items="${provinces}" var="province" varStatus="index">
						<option value="${province.id}" <c:if test="${province.id==project.province }">selected</c:if>>${province.name}</option>
						</c:forEach>                    	
                    </select>
                    <select name='project.city' id='city'>
                    	<option value=''>请选择城市</option>
                    </select>
                    <input name="project.address" id="address" class="iup" value="${project.address }" style="width:230px"/>
                    <div id="addressTip"  style="display:inline-block"></div>
                    <br>
                    <label for="">项目简介 :</label>
					<textarea type="text" id="projectProfile" name="project.projectProfile" style="margin: 10px; width: 80%; height: 90px;">${project.projectProfile}</textarea>
					<br>               
                    <div class="rad">
                        <input id="xieyi" name="xieyi" type="checkbox" checked='checked' value="1"/>
                        <em data-target="#finance_agreement" data-toggle="modal" data-backdrop="static">我已阅读并同意《委托融资服务协议》</em>
                        <div id="xieyiTip"></div>
                    </div>
                    <div class="next_step" style="width: 150px;margin: 20px auto">
                        <button id="submitBtn" class="">下一步</button>
                    </div>
                	                    
                </form>
				</div>
			</div>
			<%@include file="./finance_agreement.jsp" %>

		</div>
	</div>

	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>
</body>
</html>