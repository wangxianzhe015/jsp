<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {
		var financeExplainEditorUE = UE.getEditor('financeExplainEditor');
		financeExplainEditorUE.options.initialFrameHeight=400;
	});
})(jQuery)
</script>
				<table class="content">
						<tr>
							<td>
							    <input type="hidden" name="projectDoc.financeExplain" id="projectDoc.financeExplain" value=""/>
							
								    <script type="text/plain" id="financeExplainEditor" name="financeExplainEditor" style="height:250px;width:95%">
										${projectDoc.financeExplainHtml}
									</script>
							</td>
						</tr>						
				</table>