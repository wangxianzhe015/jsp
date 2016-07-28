<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {
		var projectAgreementEditorUE = UE.getEditor('projectAgreementEditor');
		projectAgreementEditorUE.options.initialFrameHeight=300;
	});
})(jQuery)
</script>
				<table class="content">
						<tr>					
							<td>
							    <input type="hidden" name="projectDoc.projectAgreement" id="projectDoc.projectAgreement" value=""/>
							
								    <script type="text/plain" id="projectAgreementEditor" name="projectAgreementEditor" style="height:200px;width:95%">
										${projectDoc.projectAgreementHtml}
									</script>
							</td>
						</tr>	
						<tr>
							<td>
							   合同模板可使用替换名称以"[名称]"表示，可使用替换名有以下:
							  <li>[投资人姓名]</li>
							  <li>[投资人身份证]</li>
							  <li>[投资人手机号码]</li>
							  <li>[投资金额]</li>
							  <li>[持股比例]</li>
							  <li>[项目名称]</li>
							  <li>[项目地址]</li>
							  <li>[项目方管理公司]</li>
							</td>
						</tr>					
				</table>