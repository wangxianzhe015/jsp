<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.config.js"></script> 
<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.all.min.js" ></script> 
<script type="text/javascript" >
( function($) {
	$( function() {
		var projectIntroduceEditorUE = UE.getEditor('projectIntroduceEditor');
		projectIntroduceEditorUE.options.initialFrameHeight=400;
	});
})(jQuery)
</script>

	<div class="modal fade" id="myModa_introduce" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-big">
			<div class="modal-content">
				<div class="modal-header">
					<button id="editor_buttion_x" type="button" class="modal-close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">编辑项目介绍</h4>
				</div>
				<div class="modal-body">
					<div class="video_form">
						<form id="form_vproduce" name="introduceForm" action="<%=servletPath%>/portal/uc/editorSave.action" class="clear">
							<input type="hidden" name="project.projectIntroduce" id="project.projectIntroduce" value=""/>
							<input id="project.projectId" name="project.projectId" type="hidden" value="${project.projectId }" />
							 <script type="text/plain" id="projectIntroduceEditor" name="projectIntroduceEditor" style="height:250px;width:95%">
								${project.projectIntroduceHtml}
							</script>
							<div class="dia_btn">
								<button id="editor_buttion" type="button" style="margin-right: 15px">提交</button>
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