<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="投资项目"></c:set>
	<%@include file="../common/meta.jsp" %>

	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery.roundabout-1.0.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery.easing.1.3.js"></script
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/index.js"></script>
	
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/project-list.css" />
</head>
<body>

<%@include file="../common/header.jsp" %>

<script>
//$(function () {
//    $('.nav_ul01 li').on('click', function () {
//        $(this).addClass('on').siblings().removeClass('on');
//    });
//    $('.nav_ul02 li').on("click", function () {
//        $(this).addClass('on').siblings().removeClass('on');
//    });
//    $('.nav_ul03 li').on("click", function () {
//        $(this).addClass('on').siblings().removeClass('on');
//    });
//})

$(document).ready(function () {
    $('#featured-area ul').roundabout({
        easing: 'easeOutInCirc',
        duration: 500
    });
});
</script>


<!-- 推荐项目 -->
<div class="wrap" id="featured-area"> 
    <ul> 
      		<c:forEach items="${recommendProjects }" var="recommendProject">
            <li>
                <a href="<%=servletPath %>/portal/main/showProject.action?projectId=${recommendProject.projectId}" target="_blank">
                    <img src="${recommendProject.projectImage }" alt="${recommendProject.projectName }" />
                </a>
            </li>
            </c:forEach>
    </ul> 
</div>

<!--分类选项-->
<%@include file="./project_category.jsp"%>
<!--项目列表-->
<%@include file="./project_result.jsp" %>


<!-- 分页 -->
<div class="wrap paging list_pading">
    <div class="pages list_pages"> 
	<%@include file="./page.jsp" %>
	</div>
</div><!-- 分页结束 -->


<!--首页底部-->
<%@include file="../common/footer.jsp" %>

</body>
</html>




<script>
/**
 * 初始化
 */
function init()
{
    var province = 0;
    var city = 0;

    setCity(province);

    $("#province").find("option[value=" + province + "]").attr("selected", true);
    $("#city").find("option[value=" + city + "]").attr("selected", true);
}

/**
 * 切换省select时候触发渲染市select
 */
function setCity(province)
{
    if (province <= 0) {
        return false;
    }

    var citys = areas[province].childs;
    var optHtml = "<option value='0'>市/区</option>";
    for (var i in citys) {
        var id = citys[i].id;
        var name = citys[i].shortname;
        optHtml += "<option value='" + id + "'>" + name + "</option>";
    }
    $("#city").html(optHtml);
}

$(document).ready(function(){
    $("#searchCity").bind("click", function(){
        var cityId = parseInt($("#city").val());
        if (cityId <= 0) {
            return false;
        }

        location = _url.replace('city/0', 'city/' + cityId);
    });

    init(); // 初始化城市选择框
});
</script>