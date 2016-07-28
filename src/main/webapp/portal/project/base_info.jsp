<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {

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
		
		<c:if test="${project.city!=null}">
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
})(jQuery)
</script>

				<table class="content">
						<tr>
							<td width="150px;" class="title">
								项目名称
							</td>
							<td>
								<input type="text" name="project.projectName" value="${project.projectName}"  class="line_input" size="60px"/>
							</td>
						</tr>
						<tr>
							<td width="150px;" class="title">
								项目描述
							</td>
							<td>
								<input type="text" id="project.projectDesc" name="project.projectDesc" value="${project.projectDesc}"  class="line_input" size="60px"/>(一句话)
							</td>
						</tr>
						<tr>
							<td class="title">
								项目简介
							</td>
							<td>
								<textarea type="text" id="project.projectProfile" name="project.projectProfile" style="margin: 0px; width: 70%; height: 65px;">${project.projectProfile }</textarea>
							</td>
						</tr>						
						<tr>
							<td class="title">
								项目类型
							</td>
							<td>
	
						<select name="project.projectType" id="project.projectType" >
						    <c:forEach items="${projectTypes}" var="projectType" varStatus="index">
							<option value="${projectType.dictId }" <c:if test="${projectType.dictId==project.projectType }">selected</c:if> >${projectType.dictName }</option>
							</c:forEach>
						</select>

							</td>
						</tr>
						<tr>
							<td class="title">
								是否置顶
							</td>
							<td>
								<select name="project.top">
									<option value="N" <c:if test="${empty project.top || project.top=='N' }"> selected </c:if> >否</option>
									<option value="Y" <c:if test="${project.top=='Y' }"> selected </c:if> >是</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="title">
								订单认购校验
							</td>
							<td>
								<select name="project.orderUnique">
									<option value="REBUYABLE" <c:if test="${empty project.orderUnique || project.orderUnique=='REBUYABLE' }"> selected </c:if> >可重复认购</option>
									<option value="UNREBUY" <c:if test="${project.orderUnique =='UNREBUY' }"> selected </c:if> >不可重复认购</option>
								</select>
							</td>
						</tr>						
						<tr>
							<td class="title">
								项目排序
							</td>
							<td>
								<input type="text" name="project.projectNo" value="${project.projectNo}"  class="line_input"/>
							</td>
						</tr>												
						<tr>
							<td class="title">
								项目状态
							</td>
							<td>
	
						<select name="project.projectState" id="project.projectState" >
							<c:forEach items="${projectStates}" var="projectState" varStatus="index">
							<option value="${projectState.dictId }" <c:if test="${projectState.dictId==project.projectState }">selected</c:if> >${projectState.dictName }</option>
							</c:forEach>
						</select>

							</td>
						</tr>												
						<tr>
							<td class="title">
								行业类别
							</td>
							<td>
	
							<select name="project.industryCategory" id="trade_one" >
								<option value="">请选择行业</option>
								<c:forEach items="${projectCategories}" var="projectCategory" varStatus="index">
								<option value="${projectCategory.categoryId }" <c:if test="${projectCategory.categoryId==project.industryCategory }">selected</c:if> >${projectCategory.categoryName }</option>
								</c:forEach>
							
							</select>

							</td>
						</tr>

						<tr>
							<td class="title">
								项目地址
							</td>
							<td>
									<select name="project.province" id="province">
									<option value="">请选择省份</option>
									<c:forEach items="${provinces}" var="province" varStatus="index">
									<option value="${province.id}" <c:if test="${province.id==project.province }">selected</c:if>>${province.name}</option>
									</c:forEach>
									</select>
									
									<select name="project.city" id="city">
									<option value="">请选择城市</option>
									</select>
									
									<input type="text" name="project.address" value="${project.address }" size="40"/>								
							</td>
						</tr>
						<tr>
							<td class="title">
								项目方公司名称
							</td>
							<td>
								<input type="text"  name="project.companyName" value="${project.companyName}" size="40"/>	

							</td>
						</tr>							
						<tr>
							<td class="title">
								项目方联系人
							</td>
							<td>
								<input type="text" name="project.projectFounder" value="${project.projectFounder}"  size="40"/>	

							</td>
						</tr>
						
						<tr>
							<td class="title">
								项目方联系电话
							</td>
							<td>
								<input type="text"  name="project.contactPhone" value="${project.contactPhone}" size="40"/>	
							</td>
						</tr>																	
				</table>
