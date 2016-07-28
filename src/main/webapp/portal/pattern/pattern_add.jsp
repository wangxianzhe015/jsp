<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>新增合作伙伴</title>
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
					"pattern.title" : {
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
				window.location.href = servletPath+"/portal/pattern/index.action";
			});

		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/pattern/addPattern.action" method="post" name="data_form" id="data_form">
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								新增合作伙伴
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="150px;" class="title">
								标题
							</td>
							<td>
								<input type="text" name="pattern.title" value="" class="line_input" size="40px"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								显示顺序
							</td>
							<td>
								<input type="text" name="pattern.orderNo" value="1" class="line_input" size="40px"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								链接地址
							</td>
							<td>
								<input type="text" name="pattern.href" value="" class="line_input" size="60px"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								图片
							</td>
							<td>
								<input type="text" name="pattern.image" id="image" value="" class="line_input" size="60px"/>
								<input type='file' name='pattern_image_path' id='pattern_image_path' class="file_issue" />
								<em id="pattern_image_msg"> </em> 
								<script type="text/javascript">
										var uploadData = {
										'data': '',
										'field': 'pattern_image_path',
										'resize':[0]
										};
										$('#pattern_image_path').uploadFile(uploadData,function(data){
											
											var rand = Math.ceil(Math.random()*10);
											if(data.code == 1) {
												var _test = data.url2;
												_test = _test.replace(/\&amp;/,'&');
												$('#image').val(data.url2);
							
												data.url2 = data.url2.replace(/\&amp;/g,'&');
												$('#pattern_image_msg').html(data.message);
												return true;
											}else{
												alert(data.message);
												$('#pattern_image_msg').html(data.message);
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
