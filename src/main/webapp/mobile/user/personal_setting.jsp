<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<%@include file="../common/meta.jsp" %>
<c:set var="pageTitle" value="个人资料"></c:set>
<c:set var="topPage" value="/mobile/uc/index.action"></c:set>
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

 <%@include file="../common/header.jsp" %>
   
    <!--main-->
    <div>
        <div class="form-wrap clearfix">
            <div class="form-leftside">头像</div>
            <div class="form-rightside">
                <div class="fl-right"><a href="#"><img id="user-avatar-img" src="<%=resourcePathM %>/images/right-arrow.png" alt="right arrow"></a></div>
                <div class="small-avatar fl-right"><img src="${user.userImage }" class="img-responsive img-circle" alt="small avatar"></div>

            </div>
        </div>
            <form id="face_form" method="post" action="<%=servletPath%>/mobile/uc/savePersonalSetting.action">
            <input type="file" id="user-avatar-hidden-file" name="user.userImage" style="display:none;"/>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    用户名
                </div>
                <div class="form-rightside">
                    <input type="text" class="w200-form transparent" value="${user.userName }" readonly>
                </div>
            </div>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    性别
                </div>
                <div class="form-rightside">
                    <select name='user.gender' id="" class="w200-form transparent">
                        <option value="0" <c:if test="${user.gender=='0' }">selected</c:if>></option>
                        <option value="1" <c:if test="${user.gender=='1' }">selected</c:if>>男</option>
                        <option value="2" <c:if test="${user.gender=='2' }">selected</c:if>>女</option>
                    </select>
                </div>
            </div>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    姓名
                </div>
                <div class="form-rightside">
                <c:choose>
	                <c:when test="${user.realName=='' }">
		                <button class="btn btn-ok">未认证</button>
	                </c:when>
	                <c:otherwise>
	                    ${user.realName}
	                </c:otherwise>
                </c:choose>
                </div>
            </div>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    身份证号码
                </div>
                <div class="form-rightside">
                <c:choose>
	                <c:when test="${empty user.identityCard}">
		                <span class="btn not-confirmed">未认证</span>
	                </c:when>
	                <c:otherwise>
	                    ${user.identityCard}
	                </c:otherwise>
                </c:choose>
                </div>
            </div>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    手机号码
                </div>
                <div class="form-rightside">
                    ${user.mobileNo }
                </div>
            </div>
            <div class="form-wrap clearfix">
                <div class="form-leftside">
                    邮箱
                </div>
                <div class="form-rightside">
                <c:choose>
	                <c:when test="${empty user.email}">
		                <span class="btn not-confirmed">未认证</span>
	                </c:when>
	                <c:otherwise>
	                    ${user.email}
	                </c:otherwise>
                </c:choose>
                </div>
            </div>
            <div>
                <div class="form-wrap bd-reset">
                    <div class="row">
                        <div class="col-xs-4">收件地区：</div>
                        <div class="col-xs-4">
                            <select name="user.contactProvince" id="province_contact" class="transparent" required>
                                <option value="" >请选择省份</option>
		                        <c:forEach items="${provinces}" var="province" varStatus="index">
								<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
								</c:forEach>	
                            </select>
                        </div>
                        <div class="col-xs-4">
                            <select name='user.contactCity' id='city_contact' class="transparent" required>
                                <option value="" >请选择城市</option>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="form-wrap bd-reset">
                    <div class="row">
                        <div class="col-xs-8 col-xs-offset-4">
                        <input type="text" id="address" name="user.contactAddress" placeholder="请输入详细地址" class="transparent" value="${user.contactAddress }">
                        </div>
                    </div>
                </div>
                <div class="form-wrap bd-reset">
                    <div class="row">
                        <div class="col-xs-4">邮政编码：</div>
                        <div class="col-xs-8">
                        <input type="text" id="zip" name="user.contactZip" placeholder="请输入邮政编码" class="transparent" value="${user.contactZip}">
                        </div>
                    </div>

                </div>
            </div>
            <div class="form-wrap  bd-reset">
                <button type="submit" class="btn btn-custom" data-toggle="modal" data-target="#myModal" style="font-size: 1.25em">保存修改</button>
            </div>
        </form>

    </div><!-- /.container -->

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    修改成功！
                </div>
                <div class="modal-footer text-center">
                    <a href="#" class="modal-ok" data-dismiss="modal">确定</a>
                </div>
            </div>
        </div>
    </div>

    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
    <script src="<%=resourcePathM%>/js/common/main.js"></script>

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
$(document).ready(function(){
	$("#user-avatar-img").on("click", function(){
		$("#user-avatar-hidden-file").click();
	});
	$.formValidator.initConfig({formid:"face_form",validatorgroup:"1",onerror:function(msg){
		return false;},onsuccess:function(){}});
	 	$("#my_oneword").formValidator({validatorgroup:"1",empty:true,onempty:" ",onshow:" ",onfocus:" ",oncorrect:" "})
	 			        .inputValidator({max:20,onerror: "不能超过20个字符"});
		$("#mobile_contact").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请填写收货时的联系方式",oncorrect:" "})
	   	      .inputValidator({min:11,onerror: "请填写收货时的联系方式"});
		$("#area_contact").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请选择地区",oncorrect:" "})
	   	      .inputValidator({min:1,onerror: "请选择地区"});
		$("#zip").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入正确的邮编",oncorrect:" "})
				 .regexValidator({regexp:"zipcode",datatype:"enum",onerror:"请输入6位数字"})
		$("#address").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入详细地址，5-60个字符",oncorrect:" "})
					 .inputValidator({min:5,max:60,onerror: "请输入详细地址，5-60个字符"});

	$.formValidator.initConfig({formid:"username_form",validatorgroup:"2",onerror:function(msg){
		return false;},onsuccess:function(){
			$("#button_name").attr('disabled','true');
			$("#username_tip").html("用户名正在修改中，请稍后");
			var username = $("#username").val();
		    $.post("<%=servletPath%>/mobile/uc/ajaxUsernameSave.action",{'username':username},function(data){  
	 			if(data.code==1)
	 			{
	 				showConfirmModal(data.message);
	 				$("#username_x").click();
	 				$("#username_text").html(username);
	 				$("#username_edit").hide();
	 				$("#username_tip").html("");
	 			}else
	 			{
	 				$("#button_name").removeAttr('disabled');
	 				showConfirmModal(data.message);
					$("#username_tip").html("请您注意：用户名只允许修改一次");
	 			}
		    },"json");
			return false;
		}});	
		$("#province").change(function(){ 
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
						
						$("#city").html(html);
					}
				}
			});
		});	
		
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

		function showConfirmModal(msg) {
			$('#confirm_msg').html(msg);
			$("#confirm_dialog").modal('show');
		};
		
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
