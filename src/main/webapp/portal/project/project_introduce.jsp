<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {
		var projectIntroduceEditorUE = UE.getEditor('projectIntroduceEditor');
		projectIntroduceEditorUE.options.initialFrameHeight=400;
	});
})(jQuery)
</script>

				<table class="content">
						<tr>
							<td class="title" style="width:100px">
								项目封面图片
							</td>
							<td>
								<input type="text" id="projectImage" name="project.projectImage" value="${project.projectImage}"  readonly="readonly" class="line_input" size="40">(570*280px)
									<script	type="text/javascript">
								var uploadData = {
								'data': '',
								'field': 'project_image',
								'resize':[0]
								};
								$('#project_image').uploadFile(uploadData,function(data){
									var rand = Math.ceil(Math.random()*10);
									if(data.code == 1) {
										var _test = data.url2;
										_test = _test.replace(/\&amp;/,'&');
										$('#projectImage').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#project_image_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#project_image_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type='file'	name='project_image' id='project_image' class="file_issue" />
							    <em id="project_image_msg"></em>										
							</td>
						</tr>
						<tr>
							<td class="title">
								项目背景图片
							</td>
							<td>
								<input type="text" id="backgroundImage" name="project.backgroundImage" value="${project.backgroundImage}"  readonly="readonly" class="line_input" size="40">(798*405px)
									<script	type="text/javascript">
								var uploadData = {
								'data': '',
								'field': 'backgroundImage_image',
								'resize':[0]
								};
								$('#backgroundImage_image').uploadFile(uploadData,function(data){
									var rand = Math.ceil(Math.random()*10);
									if(data.code == 1) {
										var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
										$('#backgroundImage').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#backgroundImage_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#backgroundImage_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type='file'	name='backgroundImage_image' id='backgroundImage_image' class="file_issue" />
							    <em id="backgroundImage_msg"></em>									
							</td>
						</tr>					
						<tr>
							<td class="title">
								介绍视频
							</td>
							<td>
								 
							</td>
						</tr>
						<tr>
							<td class="title">
								项目详情
							</td>
							<td>
							    <input type="hidden" name="projectDoc.projectIntroduce" id="projectDoc.projectIntroduce" value=""/>
							
								    <script type="text/plain" id="projectIntroduceEditor" name="projectIntroduceEditor" style="height:250px;width:90%">
										${projectDoc.projectIntroduceHtml}
									</script>
							</td>
						</tr>						
				</table>
