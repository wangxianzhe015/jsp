<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="modal fade" id="sendMobileCodeDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="modal-close" data-dismiss="modal" aria-label="Close">
                	<span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">发送验证码</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" autocomplete="off" name="form1" id="form2">
                    <table border="0px">
                        <tr>
                            <td align="right">验证码:</td>
                            <td>
	                            <input class="fl" id="code" autocomplete="off" type="text" placeholder="请输入验证码" style=" height: 34px; border: 1px solid #ccc; border-radius: 5px; margin: 8px; padding-left: 10px; font-size: 14px;" />
	                            <div class="fl yanzheng_img">
	                            	<img id="mobile_fresh_valicode" src="<%=contextPath %>/portal/common/verifycode.jsp" />
	                            </div>
	                            <div class="fr">
									<a href="javascript:void(0);" onclick="updateCode();" class="yanzheng_a left" style="line-height: 50px;margin-left: 10px;">看不清，换一张</a>
								</div>
							</td>
                        </tr>
                    </table>
                    <div style="height: 36px; margin-top: 10px;">
                        <button type="button" onclick="sendMobileCode($('#btn_yzm2'),'txt');" class="fl myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code" style=" margin-left: 56px;">获取短信验证码</button>
                        <button type="button" onclick="sendMobileCode($('#btn_yzm2'),'voice');" class="fr myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code" style=" margin-right: 143px;">获取语音验证码</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
