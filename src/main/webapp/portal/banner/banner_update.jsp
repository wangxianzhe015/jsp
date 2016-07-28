<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>修改横幅</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>		
		<script>
	( function($) {
		$( function() {
			var validateFormRule = {
				rules : {
					"banner.title" : {
						required : true
					}
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				if (vo.form())
					$("#data_form").submit();
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/banner/index.action";
			});

		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/banner/updateBanner.action" method="post" name="data_form" id="data_form">
				<input type="hidden" name="banner.bannerId" value="${banner.bannerId }"/>
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								编辑广告横幅
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;" class="title">
								标题
							</td>
							<td>
								<input type="text" name="banner.title" value="${banner.title }" class="line_input" size="40px"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								显示顺序
							</td>
							<td>
								<input type="text" name="banner.orderNo" value="${banner.orderNo }" class="line_input" size="40px" />
							</td>
						</tr>
						<tr>
							<td class="title">
								链接地址
							</td>
							<td>
								<input type="text" name="banner.href" value="${banner.href }" class="line_input" size="60px" />
							</td>
						</tr>
						<tr>
							<td class="title">
								图片
							</td>
							<td>
								<input type="text" name="banner.image" id="image" value="${banner.image }" class="line_input" size="60px"/>
								<input type='file' name='banner_image_path' id='banner_image_path' class="file_issue" />
								<em id="banner_image_msg"> </em> 
								<script type="text/javascript">
										var uploadData = {
										'data': '',
										'field': 'banner_image_path',
										'resize':[0]
										};
										$('#banner_image_path').uploadFile(uploadData,function(data){
											
											var rand = Math.ceil(Math.random()*10);
											if(data.code == 1) {
												var _test = data.url2;
												_test = _test.replace(/\&amp;/,'&');
												$('#image').val(data.url2);
							
												data.url2 = data.url2.replace(/\&amp;/g,'&');
												$('#banner_image_msg').html(data.message);
												return true;
											}else{
												alert(data.message);
												$('#banner_image_msg').html(data.message);
												return false;
											}
										});
								</script> 								
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
			</form>
		</div>
	</body>
</html>
