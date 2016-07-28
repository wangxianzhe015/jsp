<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="个人设置"></c:set>
<%@include file="../common/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
</head>
<body>

 <%@include file="../common/uc_header.jsp" %>
   
<script>

function initCity(cityId,provinceId,selectedId){
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
					var selected=" ";
					if(v.id==selectedId){
						selected=" selected";
					}
					html += "<option value=\"" + v.id + "\""+selected+">"+v.name+"</option>";
				})
				
				$("#"+cityId).html(html);
			}
		}
	});
}
$(document).ready(function(){
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
		    $.post("<%=servletPath%>/portal/uc/ajaxUsernameSave.action",{'username':username},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				$("#username_x").click();
	 				$("#username_text").html(username);
	 				$("#username_edit").hide();
	 				$("#username_tip").html("");
	 			}else
	 			{
	 				$("#button_name").removeAttr('disabled');
					popBox(data.message,'error');
					$("#username_tip").html("请您注意：用户名只允许修改一次");
	 			}
		    },"json")  
			return false;
		}});	
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
		
		$("#province_contact").change(function(){ 
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
})
</script>

<div class="wrap clear">
    <div class="row mt-20">
        <div class="col-7 mr-10">
            <!--左侧栏-->
			<%@include file="./uc_menu.jsp" %>
        </div>
        <!--右侧栏-->
        <div class="col-23 bg_white">
			<div class="clear  user_tit_box mt-20">
                 <div class="fl user_tit font-wet">个人设置</div> 
            </div>

            <!--个人资料已填写-->
            <div class="register_record">

                <form id="face_form" method="post" action="<%=servletPath%>/portal/uc/savePersonalSetting.action">
                <div class="modifi_haed">
                    <dl class="clear">
                        <dt><img id="face_img" style="height:100px; width:100px; border-radius:50px;"src="${user.userImage }" alt=""/></dt>
                        <dd>
                            <span class="button" style="background: #9a9999;width: 80px;height: 28px;margin-top: 25px;margin-left: 0;float:left">
                                <a style="color: #fff">浏览</a>
					            <script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
								<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>
								<script type="text/javascript">
											var uploadData = {
											'data': '',
											'field': 'face',
											'resize':[0]
											};
											$('#face').uploadFile(uploadData,function(data){
												var rand = Math.ceil(Math.random()*10);
												if(data.code == 1) {
													$('#face_val').val(data.url2);
													data.url2 = data.url2.replace(/\&amp;/g,'&');
													$('#face_img').attr('src',data.url2);
													$('#face_msg').html(' ');
													return true;
												}else{
													$('#face_msg').html(data.message);
													return false;
												}
											});
								</script>
							<input type="hidden" name="user.userImage" value="${user.userImage }" id="face_val" />
							<input type='file' name='face' id='face' class="file_issue" /> 
					 </span>
                            <em id="face_msg" style="margin-left: 26px;float: left;margin-top: 30px"></em>
                            <b class="clear">支持的图片格式： JPG、JPEG、PNG、GIF</b>
                        </dd>
                    </dl>
                </div>
                <h3>个人信息<span><em>（*必填项）</em>为了防止与易宝支付同步时造成不必要的数据错误，请您正确填写信息，认证后将无法修改</span></h3>
                <div class="per_passage">
                    <ul>
                        <li><label for="">用户名 :</label><em id="username_text">${user.userName}</em><span id="username_edit" data-toggle="modal" data-target="#myModal1">修改</span></li>
                        <li><label for="">手机 :</label><em>${user.mobileNo }</em><span></span></li>
                        <li><label for="">邮箱 :</label><em>${user.email }</em><span></span></li>
                        <li><label for="">真实姓名 :</label><em>${user.realName}</em><span></span></li>
                        <li><label for="">身份证号 :</label><em>${user.identityCard }</em><span></span></li>
                    </ul>
                </div>
                <h3>收货地址<span><em>（*必填项）</em>请填写正确的收货地址，避免因为收货地址不正确而导致无法及时收到合同，礼物等物品</span></h3>
                <div class="rest_qita">       
                		<label style="*margin-bottom: 25px" for="">收货联系方式 :</label>
                        <input id="mobile_contact" name="user.contactMobile" class="pre_inp" type="text" value="${user.mobileNo }" />
                        <div id="mobile_contactTip" style="margin-left: 85px;"> </div>   
                                                 
                        <label style="*margin-bottom: 17px" for="">收货地区选择 :</label>
                        <select name='user.contactProvince' id='province_contact'>
	                        <option value=''>请选择省份</option>
	                        <c:forEach items="${provinces}" var="province" varStatus="index">
							<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
							</c:forEach>	
                        </select>
                        
                        <select  name='user.contactCity' id='city_contact'>
                        <option value=''>请选择城市</option>
                        </select> 
                     
                        <label style="*margin-bottom: 25px" for="">收货地址邮编 :</label>
                        <input id="zip" name="user.contactZip" class="email_inp" type="text" value="${user.contactZip}" />
                        <div id="zipTip" style="margin-left: 85px; margin-bottom:10px;"> </div>
                   
                        <label style="*margin-bottom: 25px" for="">收货详细地址 :</label>
                        <input id="address" name="user.contactAddress" class="pre_inp" type="text" value="${user.contactAddress }" />
                        <div id="addressTip" style="margin-left: 85px; margin-bottom:10px;"> </div>
                </div>
                <h3>其他信息<span><em>（*选填项）</em></span></h3>
                <div class="rest_qita">
                    
                        <label for="">个人说明 :</label>
                        <input id="my_oneword" name="user.profile" style="margin-bottom: 0" class="pre_inp" type="text" value="${user.profile }" />
                        <span  style="margin-left:105px;color:red">（不超过20个字符，个人说明建议采用公司+职务+真实姓名）</span>
                        <div id="my_onewordTip" style="margin-left: 85px; "> </div>
                        <br/>
                        <label for="">性别 :</label>
                        <label class="ib"><input type='radio' name='user.gender' value='0' checked="checked" /> 保密 &nbsp;&nbsp;</label>
                        <label class="ib"><input type='radio' name='user.gender' value='1' /> 男 &nbsp;&nbsp;</label>
                        <label class="ib"><input type='radio' name='user.gender' value='2' /> 女 &nbsp;&nbsp;</label><br>
                        <label style="*margin-bottom: 17px" for="">所在城市:</label>
						<select name='user.province' id='province'>
							<option value=''>请选择省份</option>
							<c:forEach items="${provinces}" var="province" varStatus="index">
							<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
							</c:forEach>			
						</select><select name='user.city' id='city'>
							<option value=''>请选择城市</option>
						</select>   
				<br/>
           			 <input id="info_sub" class="pre_btnsub" type="submit" onclick="return jQuery.formValidator.pageIsValid('1');" value="提交" style=" margin-bottom: 80px;"/>  
                		
                </div>
                </form>
              </div>

            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-small" style="width: 550px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="username_x" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>       
						<h4 class="modal-title">用户名修改</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            
                            <form id="username_form">
                                <label for="">旧用户名 :</label>
                                <i>${user.userName }</i>
                                <br/>
                                <label for="">新用户名 : </label>
                                <input id="username" type="text" name="username" style="width: 140px" type="text"/>
                                <div id="username_tip">请您注意：用户名只允许修改一次</div>
                                <br/>
                                <button id="button_name" class="sjdialog_btn" onclick="return jQuery.formValidator.pageIsValid('2');">确定修改</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

<!--首页底部-->
<%@include file="../common/footer.jsp" %>  
</body>
</html>
