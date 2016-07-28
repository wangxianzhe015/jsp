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
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery.datetimepicker.js"></script>
</head>
<body>

<%@include file="../../common/uc_header.jsp"%>
<script>
//图片保存
function up_img(css_id){
	var img = $("#img_"+css_id+"_val").val();
	var img_name = "img_"+css_id;
	var id = $("[name='project.projectId']").val();
	
	if(img == false)
	{
		popBox('请先上传图片','error');
		return false;
	}
	$.post("<%=servletPath%>/portal/uc/saveImage.action",{'projectId':id,'imagePath':img,'imageName':img_name},function(data){  
			if(data.code==1)
			{
				popBox(data.message,'success');
				$("#"+css_id+"_x").click();
			}else
			{
				popBox(data.message,'error');
				$("#"+css_id+"_x").click();	
			}
    },"json")  
}


//表单基本信息保存
function form_sub(css_id)
{
	var info = $("#form_"+css_id).serialize();
	var id = $("[name='project.projectId']").val();
	
	if(info.indexOf("project.projectId")==-1)
		info = info+'&project.projectId='+id;
	
	$.post("<%=servletPath%>/portal/uc/saveData.action",info,function(data){  
		if(data.code==1)
		{
			popBox(data.message,'success');
			$("#"+css_id+"_x").click();
		}else
		{
			popBox(data.message,'error');	
			$("#"+css_id+"_x").click();
		}
	},"json");

}


$(document).ready(function(){
	//编辑器保存
	$("#editor_buttion").click(function(){
		$("[name='project.projectIntroduce']").val(UE.getEditor("projectIntroduceEditor").getContent());
		var vproduce=$("[name='project.projectIntroduce']").val();
		var id = $("[name='project.projectId']").val();
		$.post("<%=servletPath%>/portal/uc/saveProjectIntroduce.action",{'project.projectId':id,'project.projectIntroduce':vproduce},function(data){  
			if(data.code==1)
			{
				popBox(data.message,'success');
				$("#editor_buttion_x").click();
			}else
			{
				popBox(data.message,'error');	
				$("#editor_buttion_x").click();
			}
		},"json");
	})
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
				<div class="pos_xiangm">
					<h3>发布项目</h3>
				</div>
				<div class="pos_jindu">
					<div class="release-list">
						<ul class="release-ul releaseBg3">
							<li><a>基本资料</a></li>
							<li><a>股权设置</a></li>
							<li><a>项目编辑</a></li>
							<li><a>支付账号注册</a></li>
							<li><a class="release-w">平台审核</a></li>
						</ul>
					</div>
					<p></p>
					<div class="tab_pie">
						<ol class="clear">
							<li class="tab_hei">店铺简介</li>
						</ol>
					</div>
					<div>
						<div class="intor_title clear"></div>
						<div class="intro_list">
							<p>
								<span>背景图宣传图</span><em data-backdrop="static"
									data-toggle="modal" data-target="#myModa_zhanSimgh">修改</em>
							</p>

							<p>
								<span>项目展示封面</span><em data-backdrop="static"
									data-toggle="modal" data-target="#myModa_zhanSimgh2">修改</em>
							</p>

							<p>
								<span>店铺基本信息</span><em data-backdrop="static"
									data-toggle="modal" data-target="#myModa_basic">修改</em>
							</p>

							<p>
								<span>编辑项目介绍</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_introduce">修改</em>
							</p>

							<p>
								<span>证件提交</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_certificate">修改</em>
							</p>

							<p>
								<span>修改融资需求</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_equity">修改</em>
							</p>
						</div>
					</div>
					
					<!--预算及退出-->
					<div class="tab_pie">
						<ol class="clear">
							<li class="tab_hei">预算及退出</li>
						</ol>
					</div>
					<div>
						<!--class="dian_intro"-->
						<div class="intro_list" style="margin-bottom: 20px">
							<p>
								<span>现有店铺概括</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_existing">修改</em>
							</p>

							<p>
								<span>开店计划</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_plan">修改</em>
							</p>

							<!-- <p><span>融资需求</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_equity">修改</em></p> -->

							<p>
								<span>退出机制</span><em data-backdrop="static" data-toggle="modal" data-target="#myModa_quit">修改</em>
							</p>
						</div>
					</div>

				</div>
				<div class="next_step" style="width: 350px">
					<a href="<%=servletPath %>/portal/uc/publishSecond.action?project.projectId=${project.projectId}">上一步</a>
					<a href="<%=servletPath %>/portal/uc/publishFourth.action?project.projectId=${project.projectId}">下一步</a>
				</div>
			</div>
		</div>
	</div>
	<input id="project.projectId" name="project.projectId" type="hidden" value="${project.projectId }" />

	<!--修改背景展示图-->
	<%@include file="./modal_background_image.jsp" %>
	
	<!--修改封面展示图-->
	<%@include file="./modal_foreground_image.jsp" %>
	
	<!--项目基本信息修改-->
	<%@include file="./modal_basic.jsp" %>

	<!--编辑项目介绍-->
	<%@include file="./modal_introduce.jsp" %>

	<!--证件信息修改-->
	<%@include file="./modal_certificate.jsp" %>

	<!--现有店铺概括-->
	<%@include file="./modal_existing.jsp" %>
	
	<!-- 修改融资需求 -->
	<%@include file="./modal_equity.jsp" %>
	<!-- 开店计划 -->
	<%@include file="./modal_plan.jsp" %>

	<!--退出机制     暂无用 -->
	<%@include file="./modal_quit.jsp" %>

	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>

</body>
</html>