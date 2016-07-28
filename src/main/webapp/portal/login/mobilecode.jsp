<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="modal fade" id="myModa_header_box_form_gettelcode" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-small"style=" width:600px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">输入验证码</h4>
            </div>
            <div class="modal-body" style="height:400px; overflow: auto; width:600px; padding:0;">
                <form action="" method="post" name="myModa_header_box_login_form" autocomplete="off" id="myModa_header_box_gettelcode_form">
                    <table border="0px" class="myModa_header_box_login_form_table">
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <input type="text" class="fl myModa_header_box_login_form_input" id="myModa_header_box_gettelcode_form_code" placeholder="请输入图形验证码" style=" width:180px;" />
                                <img src="<%=contextPath %>/portal/common/verifycode.jsp" id="mobile_fresh_valicode" class="fl myModa_header_box_gettelcode_form_img">
                                <span onclick="common_updateCode();" class="fr myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_shuaxin">刷新</span>
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom" style="padding-left:0px;"><div id="myModa_header_box_gettelcode_form_codeTip"></div></div>
                        </div>

                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <button type="button" onclick="common_sendMobileCode($('#myModa_header_box_register_yzm_btn'),'txt');" class="fl myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code">获取短信验证码</button>
                                <button type="button" onclick="common_sendMobileCode($('#myModa_header_box_register_yzm_btn'),'voice');" class="fr myModa_header_box_gettelcode_form_btn myModa_header_box_gettelcode_form_btn_code">获取语音验证码</button>
                            </div>
                        </div>
                    </table>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->