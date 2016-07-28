<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
	<c:set var="pageTitle" value="实名认证"></c:set>
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

<!--认证邮箱-->
    <div>
        <form id="realNameAuth" action="#" method="post" role="form" class="pd-reset">
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">真实姓名</div>
                    <div class="col-xs-8">
                    	<input id="realName" type="text" placeholder="请输入真实的中文姓名" class="w100p transparent" value="${user.realName }">
                   	</div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">手机号码</div>
                    <div class="col-xs-8">
                    	<input type="text" placeholder="请输入正确的手机号码" class="w100p transparent" value="${user.mobileNo }">
					</div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">身份证号码</div>
                    <div class="col-xs-8">
                    	<input type="text" placeholder="请输入正确的身份证号码" class="w100p transparent" value="${user.identityCard }">
					</div>
                </div>

            </div>

            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-4 text-right">收件地区</div>
                    <div class="col-xs-4">
                        <select name="" id="province_contact" class="w100p transparent" required>
                            <option value="" selected>请选择省份</option>
	                        <c:forEach items="${provinces}" var="province" varStatus="index">
							<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
							</c:forEach>	
                        </select>
                    </div>
                    <div class="col-xs-4">
                        <select name="" id="city_contact" class="w100p transparent" required>
                            <option value="" selected>请选择城市</option>
                        </select>
                    </div>
                </div>

            </div>
            <div class="form-wrap bd-reset">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-4"><input type="text" placeholder="请输入详细地址" class="w100p transparent" value="${user.contactZip }"></div>
                </div>
            </div>

            <div class="form-wrap  bd-reset">
                <button type="submit" class="btn btn-custom" data-toggle="modal" data-target="#myModal-cardnum-fail" style="font-size: 1.25em">提交认证</button>
            </div>
        </form>

    </div><!-- /.container -->


    <!-- Modal phone fail -->
    <div class="modal fade" id="myModal-phone-fail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    手机号码格式错误
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
function initCity(cityId,provinceId,selectedId){
	var html="<option value=\"\">请选择城市</option>";
	$.ajax({
		url : servletPath+"/mobile/city/getCitys.action?provinceId="+provinceId,
		type : 'GET',
		global : false,
		dataType : 'json',
		success : function(data) {
			var citys = data.citys;
			if (citys.length > 0) {
				$.each(citys, function(i, v) {
					var selected=" ";
					if(v.id==selectedId){
						selected=" selected";
					}
					html += "<option value=\"" + v.id + "\""+selected+">"+v.name+"</option>";
				});
				
				$("#"+cityId).html(html);
			}
		}
	});
}

//邮箱认证
$(document).ready(function(){
	$.formValidator.initConfig({formid:"realNameAuth",validatorgroup:"realNameAuth",onerror:function(msg){return false;},onsuccess:function(){
		var realName = $("#realName").val();
		var identityCode = $("#identityCode").val(); 
		 $.post("<%=servletPath%>/portal/uc/ajaxSaveRealName.action",{'realName':realName,'identityCode':identityCode},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				$("#realname_text").addClass('now');
	 				$(".safety_ico4").html("已实名认证");
	 				$(".realname_text_yes").show();
	 				$(".realname_text_no").hide();
	 				$("#realnameCloseBtn").click();
	 			}else{
					popBox(data.message,'error');	
	 			}
		    },"json");
		return false;
		}});
	$("#realName").formValidator({validatorgroup:"realNameAuth",onshow:" ",onfocus:"请输入真实姓名",oncorrect:" "}).inputValidator({min:1,max:20,onerror:"请输入真实姓名"});
	$("#identityCode").formValidator({validatorgroup:"realNameAuth",onshow:" ",onfocus:"请输入身份证号码",oncorrect:" "}).inputValidator({min:18,max:18,onerror:"请输入身份证号码"});
	
	$("#province_contact").change(function(){ 
		var provinceId=$(this).children('option:selected').val();
		var html="<option value=\"\">请选择城市</option>";
		$.ajax({
			url : servletPath+"/mobile/city/getCitys.action?provinceId="+provinceId,
			type : 'POST',
			global : false,
			dataType : 'json',
			success : function(data) {
				var citys = data.citys;
				if (citys.length > 0) {
					$.each(citys, function(i, v) {
						html += "<option value=\"" + v.id + "\">"+v.name+"</option>";
					});
					
					$("#city_contact").html(html);
				}
			}
		});
	});

<c:if test="${user.city!=null}">
	 initCity("city","${user.province}","${user.city}");
</c:if>	
<c:if test="${user.contactCity!=null}">
	 initCity("city_contact","${user.contactProvince}","${user.contactCity}");
</c:if>		


});
</script>
</body>
</html>