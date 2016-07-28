<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	$.formValidator.initConfig({formid:"form_info_a",validatorgroup:"1",wideword:false,onerror:function(msg){return false;},onsuccess:function(){form_sub("info_a");return false;}});
	$("#name").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入2-10位汉字数字或字母",oncorrect:"输入正确"})
			  .regexValidator({regexp:"projectname",datatype:"enum",onerror:"请输入2-10位汉字数字或字母"});			  
	$("#oneword").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入2-15位汉字数字或字母",oncorrect:"输入正确"})
	 			 .inputValidator({min:2,max:15,onerror: "长度为2-15位"});
		//	  	 .regexValidator({regexp:"projectname",datatype:"enum",onerror:"请输入2-10位汉字数字或字母"});
	$("#trade_two").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请选择行业",oncorrect:"输入正确"})
			   	   .inputValidator({min:1,onerror: "请选择行业"});
	$("#area").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请选择地区",oncorrect:"输入正确"})
	   	      .inputValidator({min:1,onerror: "请选择地区"});
	$("#address").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入5-60位汉字数字或字母",oncorrect:"输入正确"})
				 .regexValidator({regexp:"address1",datatype:"enum",onerror:"请输入5-60位汉字数字或字母"});

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
<div class="modal fade" id="myModa_basic" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-small" style="width: 600px">
		<div class="modal-content">
			<div class="modal-header">
				<button id="info_a_x" type="button" class="modal-close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">项目基本信息修改</h4>
			</div>
			<div class="modal-body">
				<div class="basic_form">
					<form id="form_info_a" method="post">
						<input name="project.projectId" value="${project.projectId }" type="hidden" /> 
						<label for="">项目名称:</label><input id="name" name="project.projectName" style="width:300px" type="text" value="${project.projectName }" /><div id="nameTip" style="margin: 5px 0 -30px 87px"></div><br /> 
						<label for="">一句话介绍 :</label><input id="oneword" name="project.projectDesc" style="width:300px" type="text" value="${project.projectDesc }" /><div id="onewordTip" style="margin: 5px 0 -30px 87px"></div><br /> 
						<label for="">行业 :</label>
						<select name='project.industryCategory' id='trade_one'>
							<option value=''>请选择行业</option>'
							<c:forEach items="${projectCategories}" var="projectCategory" varStatus="index">
							<option value="${projectCategory.categoryId }" <c:if test="${projectCategory.categoryId==project.industryCategory }">selected</c:if>>${projectCategory.categoryName }</option>
							</c:forEach>
						</select>
						<br /> 
						<label for="">所在地 :</label>
						<select name='project.province' id='province'>
							<option	value=''>请选择省份</option>
							<c:forEach items="${provinces}" var="province" varStatus="index">
							<option value="${province.id}" <c:if test="${province.id==project.province }">selected</c:if>>${province.name}</option>
							</c:forEach> 
						</select>
						<select name='project.city' id='city'>
							<option value=''>请选择城市</option>
						</select>
						<div id="areaTip" style="margin: 5px 0 -30px 87px"></div> <br /> 
						<input id="address" name="project.address" style="margin-left: 88px;width:300px"  type="text" value="${project.address }" />
						<span style="margin-left: 8px">(区/县)街道地址</span>
						<div id="addressTip" style="margin: 5px 0 -30px 87px"></div>
						<br/>
						<div class="dia_btn">
							<button onclick="return jQuery.formValidator.pageIsValid('1');"	style="margin-right: 15px">提交</button>
							<button type="button" data-dismiss="modal">取消</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>