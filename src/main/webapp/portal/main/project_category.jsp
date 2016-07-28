<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >

function selectedCategory(category){
	$("[name='project.industryCategory']").val(category);
	$("#queryForm").submit();
}
function selectedState(state){
	$("[name='project.projectState']").val(state);
	$("#queryForm").submit();
}
function selectedCity(city){
	$("[name='project.city']").val(city);
	$("#queryForm").submit();
}

function selectedSort(sort){
	$("[name='sort']").val(sort);
	$("#queryForm").submit();
}

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
});
})(jQuery)
</script>

<form id="queryForm" name="queryForm" action="<%=servletPath%>/portal/main/projectlist.action" method="post">
   <input type="hidden" name="project.projectState" value="${project.projectState}"/>
   <input type="hidden" name="project.industryCategory" value="${project.industryCategory}"/>
   <input type="hidden" name="project.city" value="${project.city}"/>
   <input type="hidden" name="sort" value="${sort}"/>
   
</form>
<div class="newList-box" id="list">
	<div class="newList-list">
		<ul class="newList-list-ul">
			<p>分类选择：</p>
			<li <c:if test="${empty project.industryCategory}"> class="on" </c:if>>
			<a href="javascript:selectedCategory('')">全部</a>
			</li>

			<c:forEach items="${projectCategories}" var="projectCategory">
			<li <c:if test="${projectCategory.categoryId==project.industryCategory}"> class="on" </c:if>>
			    <a href='javascript: selectedCategory("${projectCategory.categoryId}")'> ${projectCategory.categoryName}</a>
			</li>
			</c:forEach>
		</ul>
		<div class="clear-both"></div>

		<ul class="newList-list-ul">
			<p>项目类型：</p>
				<li <c:if test="${empty project.projectState}"> class="on" </c:if>>
					<a href="javascript:selectedState('')">全部</a>
				</li>
			<c:forEach items="${projectStates}" var="projectState">
				<li <c:if test="${projectState.dictId==project.projectState}"> class="on" </c:if>>
					<a href='javascript:selectedState("${projectState.dictId}")'>${projectState.dictName}</a>
				</li>
			</c:forEach>
		</ul>
		<div class="clear-both"></div>

		<ul class="newList-list-ul">
			<p>热门地区：</p>
			<li <c:if test="${empty project.city}"> class="on" </c:if>>
				<a href="javascript:selectedCity('')">全部</a>
			</li>
			<li <c:if test="${project.city=='1120050'}"> class="on" </c:if>>
				<a href="javascript:selectedCity('1120050')">福州</a>
			</li>
			<li <c:if test="${project.city=='1000000'}"> class="on" </c:if>>
				<a href="javascript:selectedCity('1000000')">北京</a>
			</li>
			<li <c:if test="${project.city=='1080000'}"> class="on" </c:if>>
				<a href="javascript:selectedCity('1080000')">上海</a>
			</li>
			<li <c:if test="${project.city=='1180050'}"> class="on" </c:if>>
				<a href="javascript:selectedCity('1180050')">广州</a>
			</li>
			<li <c:if test="${project.city=='1180150'}"> class="on" </c:if>>
				<a href="javascript:selectedCity('1180150')">深圳</a>
			</li>
			
			<li><a href="javascript: void(0)" id="cityShow">更多城市></a>
				<div class="newList-city">
					<div class="current-city">
						当前城市：<em>全国</em>
					</div>
					<div class="cityClose"></div>
					<div class="current-city2">
					<c:forEach items="${provinces}" var="province">
						<a href="javascript:selectedCity('${province.id }')" <c:if test="${project.city==province.id}"> class="on" </c:if> style="color: #4C4C4C">${province.name} </a>
					</c:forEach>
					</div>

					<div class="city-select">
						<select id="province">
							<option value="0">省/自治区</option>
							 <c:forEach items="${provinces}" var="province">
							 <option value="${province.id}">${province.name }</option>
							 </c:forEach>
							</select> 
						<select id="city">
							<option value="0">市/区</option>
						</select> <a href="javascript: void(0)" id="searchCity">查询</a>
					</div>
					<div class="clear-both"></div>
				</div></li>
		</ul>
		<div class="clear-both"></div>
		<ul class="newList-list-ul noBottom">
			<p>默认排序：</p>
			<li <c:if test="${empty sort}"> class="on" </c:if>><a href="javascript:selectedSort('')">全部</a>
			</li>
			<li <c:if test="${sort=='onlineDate'}"> class="on" </c:if>> <a href="javascript:selectedSort('onlineDate')">上线时间</a>
			</li>
			<li <c:if test="${sort=='financeAmount'}"> class="on" </c:if>><a href="javascript:selectedSort('financeAmount')">众筹金额</a>
			</li>

		</ul>
		<div class="clear-both"></div>
	</div>
</div>
<div class="space-30"></div>