<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改用户</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
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
	( function($) {
		$( function() {
			var validateFormRule = {
				rules : {
					"user.userName" : {
						required : true
					}
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				$("#data_form").submit();
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/usermgr/index.action";
			});

			
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
			
		 <c:if test="${not empty user.city}">
			 initCity("city","${user.province}","${user.city}");
		</c:if>	
		<c:if test="${not empty user.contactCity}">
			 initCity("city_contact","${user.contactProvince}","${user.contactCity}");
		</c:if>					
			
		});
	})(jQuery)
</script>

	</head>

	<body>

		<div class="grid_body">

			<form action="<%= servletPath%>/portal/usermgr/updateUser.action" method="post" name="data_form" id="data_form">
				<input type="hidden" name="user.userId" value="${user.userId}" />
				<div class="grid_body">
					<table class="content">
						<thead>
							<tr>
								<th colspan="2">
									修改用户
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="title">
									登录手机号码
								</td>
								<td>
									<input type="text" name="user.mobileNo"
										value="${user.mobileNo }" class="line_input" />
								</td>
							</tr>						
							<tr>
								<td width="150px;" class="title">
									用户名称
								</td>
								<td>
									<input type="text" name="user.userName"
										value="${user.userName }" class="line_input" />
								</td>
							</tr>


							<tr>
								<td class="title">
									邮箱地址
								</td>
								<td>
									<input type="text" name="user.email" value="${user.email }" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title">
									真实姓名
								</td>
								<td>
									<input type="text" name="user.realName" value="${user.realName }" class="line_input" />
								</td>
							</tr>
							<tr>
								<td class="title" >
									是否实名认证
								</td>
								<td>
									<input type="checkbox" name="user.realNameAuth" value="1" <c:if test="${user.realNameAuth=='1' }">checked</c:if> />是
								</td>
							</tr>

							<tr>
								<td class="title" >
									身份证号码
								</td>
								<td>
									<input type="text" name="user.identityCard" value="${user.identityCard}"  class="line_input"/>

								</td>
							</tr>
							<tr>
								<td class="title">
									所在城市
								</td>
								<td>
									<select name='user.province' id='province'>
									<option value=''>请选择省份</option>
									<c:forEach items="${provinces}" var="province" varStatus="index">
									<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
									</c:forEach>			
									</select><select name='user.city' id='city'>
									<option value=''>请选择城市</option>
									</select>   								
								</td>
							</tr>
							
							<tr>
								<td class="title">
								  收货地址
								</td>
								<td>
			                        <select name='user.contactProvince' id='province_contact'>
				                        <option value=''>请选择省份</option>
				                        <c:forEach items="${provinces}" var="province" varStatus="index">
										<option value="${province.id}" <c:if test="${province.id==user.province }">selected</c:if>>${province.name}</option>
										</c:forEach>	
			                        </select>
			                        <select  name='user.contactCity' id='city_contact'>
			                        <option value=''>请选择城市</option>
			                        </select> 
			                        <label style="*margin-bottom: 17px" for="">地址:</label>
			                        <input type="text" name="user.contactAddress" value="${user.contactAddress}"  class="line_input" size="40px"/>
			                        <label style="*margin-bottom: 17px" for="">邮编:</label>
			                        <input type="text" name="user.contactZip" value="${user.contactZip}"  class="line_input"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									
								</td>
								<td>
					
								</td>
							</tr>							
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2">
									<a id="submitBtn" class="sub" href="javascript:void(0);">提交</a>
									<a id="resetBtn" class="reset" href="javascript:void(0);">重置</a>
									<a id="backBtn" class="return" href="javascript:void(0);">返回</a>
								</td>
							</tr>

						</tfoot>
					</table>
				</div>
			</form>
		</div>

		<div class="pop_tree">
			<div class="pop_head">
			</div>
			<div class="pop_body">
			</div>
			<div class="pop_foot">
				<a href="javascript:void(0);" id="_PopSubBtn" class="button"
					data-popel="" data-vel="">确定</a>
				<a href="javascript:void(0);" id="_PopCloseBtn" class="button">关闭</a>
			</div>
		</div>
	</body>
</html>
