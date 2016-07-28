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
                <form action="" method="post" autocomplete="off" name="form1" id="form1">
                    <div class="form-group row">
                        <label class="col-xs-6">验证码:</label>
	                    <div class="col-xs-6 yanzheng_img">
	                       	<img id="mobile_fresh_valicode" src="<%=contextPath %>/portal/common/verifycode.jsp" />
                        </div>
                    </div>
                    <div class="form-group row">
                           <div class="col-xs-12">
							<a href="javascript:void(0);" onclick="updateCode();" class="yanzheng_a left" style="line-height: 50px;margin-left: 10px;">看不清，换一张</a>
						</div>
					</div>
                    <div class="form-group row">
                        <input class="form-material" id="code" autocomplete="off" type="text" placeholder="请输入验证码" style=" height: 34px; border: 1px solid #ccc; border-radius: 5px; margin: 8px; padding-left: 10px; font-size: 14px;" />
					</div>
                    <div class="form-group row">
                    <div class="col-xs-6">
                        <button type="button" onclick="sendMobileCode($('#btn_yzm2'),'txt');" class="btn btn-custom fl myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code" >获取短信验证码</button>
                    </div>
                    <div class="col-xs-6">
                        <button type="button" onclick="sendMobileCode($('#btn_yzm2'),'voice');" class="btn btn-custom fr myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code" >获取语音验证码</button>
                    </div>
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
