<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div class="modal fade" id="myModa_zhanSimgh2" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style="width: 470px">
			<div class="modal-content">
				<div class="modal-header">
					<button id="cover_x" type="button" class="modal-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改封面展示图</h4>
				</div>
				<div class="modal-body">
					<div class="zhanshi_form">
						<p>您可以选择一张最能展现您项目的一张图片作为封面图</p>
						<form action="" class="clear">
							<dl>
								<dt>
									<img id="img_cover_img" src="${project.projectImage }" />
								</dt>
								<dd>
									<em>图片格式 支持jpg,jpeg,png格式,大小不能超过2M</em> <span class="button"
										style="background: #9a9999;width: 100px;height: 28px;margin-top: 25px;margin-left: 0">
										<a style="color: #fff">选择文件 &gt;</a> 
										<script type="text/javascript">
											var uploadData = {
											'data': '',
											'field': 'img_cover',
											'resize':[0]
											};
											$('#img_cover').uploadFile(uploadData,function(data){
												var rand = Math.ceil(Math.random()*10);
												if(data.code == 1) {
													var _test = data.url2;
													_test = _test.replace(/\&amp;/,'&');
													$('#img_cover_img').attr('src',_test);
													$('#img_cover_val').val(data.url2);
													return true;
												}else{
													alert(data.message);
													
													return false;
												}
											});
										</script> 
										<input type="hidden" name="img_cover_val" value="${project.projectImage }" id="img_cover_val" /> 
										<input type='file' name='img_cover' id='img_cover' class="file_issue" />
									</span>
								</dd>
							</dl>
							<div class="clear"></div>
							<div class="dia_btn">
								<button id="cover" onclick="up_img(this.id);" type="button" style="margin-right: 15px">提交</button>
								<button type="button" data-dismiss="modal">取消</button>
							</div>
							<input type="hidden" name="_hash_" value="cdee432b4f1e87bd0442fad5c1ebb75a" />
						</form>
					</div>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>