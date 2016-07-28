<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {
		var riskControlEditorUE = UE.getEditor('riskControlEditor');
		riskControlEditorUE.options.initialFrameHeight=400;
	});
})(jQuery)
</script>
				<table class="content">
						<tr>
							<td class="title" style="width:80px">
							     简介
							</td>
							<td>
								<textarea type="text" id="project.stockholderRepay" name="project.stockholderRepay" style="margin: 0px; width: 90%; height: 65px;">${project.stockholderRepay }</textarea>
							</td>
						</tr>
						<tr>
							<td class="title" style="width:80px">
							  详情
							</td>						
							<td>
							    <input type="hidden" name="projectDoc.riskControl" id="projectDoc.riskControl" value=""/>
							
								    <script type="text/plain" id="riskControlEditor" name="riskControlEditor" style="height:250px;width:95%">
										${projectDoc.riskControlHtml}
									</script>
							</td>
						</tr>						
				</table>