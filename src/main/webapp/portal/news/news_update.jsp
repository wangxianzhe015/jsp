<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title> 修改新闻</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>
		<script type="text/javascript" src="<%=contextPath %>/common/javascripts/pop_select.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>		
		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.config.js"></script> 
		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.all.min.js" ></script> 
		
		<script>
	( function($) {
		$( function() {

			var contentEditorUE = UE.getEditor('contentEditor');
				contentEditorUE.options.initialFrameHeight=400;
								
			var validateFormRule = {
				rules : {
					"news.title" : {
						required : true,
						maxlength:64
					},
					"news.profile" : {
						required : true,
						maxlength:128
					}					
				}
			};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				if (vo.form()){
					$("[name='news.content']").val(UE.getEditor("contentEditor").getContent());
					$("#data_form").submit();
				}
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/news/index.action";
			});
			


		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/news/updateNews.action" method="post" name="data_form" id="data_form">
				<input type="hidden" name="news.newsId" value="${news.newsId }"/>
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								修改新闻
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="title" style="width:100px">
								公告标题
							</td>
							<td>
								<input type="text" name="news.title" value="${news.title }" size="60px"/>
							</td>
						</tr>
						<tr>
							<td class="title" style="width:100px">
								新闻摘要
							</td>
							<td>
								<textarea type="text" id="news.profile" name="news.profile" style="margin: 0px; width: 70%; height: 40px;">${news.profile }</textarea>
							</td>
						</tr>							
						<tr>
							<td class="title" style="width:100px">
								新闻图片
							</td>
							<td>
								<input type="text" name="news.newsImage" id="image" value="${news.newsImage }" class="line_input" size="60px"/>
								<input type='file' name='news_image_path' id='news_image_path' class="file_issue" />
								<em id="news_image_msg"> </em> 
								<script type="text/javascript">
										var uploadData = {
										'data': '',
										'field': 'news_image_path',
										'resize':[0]
										};
										$('#news_image_path').uploadFile(uploadData,function(data){
											
											var rand = Math.ceil(Math.random()*10);
											if(data.code == 1) {
												var _test = data.url2;
												_test = _test.replace(/\&amp;/,'&');
												$('#image').val(data.url2);
							
												data.url2 = data.url2.replace(/\&amp;/g,'&');
												$('#news_image_msg').html(data.message);
												return true;
											}else{
												alert(data.message);
												$('#news_image_msg').html(data.message);
												return false;
											}
										});
								</script> 								
							</td>
						</tr>							
						<tr>
							<td class="title">
								新闻内容
							</td>
							<td> 
							     <input type="hidden" name="news.content" id="news.content" value=""/>
								 <script type="text/plain" id="contentEditor" name="contentEditor" style="height:250px;width:95%">
								 ${news.contentHtml}
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
