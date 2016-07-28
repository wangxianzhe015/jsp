<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
//邮箱认证
$(document).ready(function(){
	$("#ecode").click(function(){
		 var email = $("#email").val();
		 $.get("<%=servletPath%>/portal/uc/ajaxSendEmail.action",{'email':email,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				email_text();
	 			}else
	 			{
					popBox(data.message,'error');	
	 			}
		    },"json");
	});
	$.formValidator.initConfig({formid:"emailreset",validatorgroup:"emailreset",onerror:function(msg){return false;},onsuccess:function(){
		var email = $("#email").val();
		var code = $("#emailcode").val(); 
		 $.get("<%=servletPath%>/portal/uc/ajaxEmailConfirm.action",{'email':email,'code':code,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				$("#e_text").addClass('now');
	 				$(".safety_ico3").html("邮箱已认证");
	 				$(".e_text_yes").show();
	 				$(".e_text_no").hide();
	 				$("#emailtext").click();
	 			}else
	 			{
					popBox(data.message,'error');	
	 			}
		    },"json");
		return false;
		}});

	$("#emailcode").formValidator({validatorgroup:"emailreset",onshow:" ",onfocus:"请输入正确的验证码",oncorrect:" "})
					.inputValidator({min:6,max:6,onerror:"请输入正确的验证码"})
});
</script>
        <!--认证邮箱-->
        <div class="modal fade" id="myModa22" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="emailtext" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">认证邮箱</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            <form id="emailreset">
                                <label for="">邮箱地址 : </label>
                                <input id="email" type="text"/>
                                <div id="emailTip"> </div>
                                <br/>
                                <label for="">验证码 : </label>
                                <input id="emailcode" style="width: 140px" type="text"/>
                                <span id="ecode" class="email_code">获取验证码</span>
                                <span  class="e_yanzheng" style="display:none">获取验证码</span>
                                <div id="emailcodeTip"> </div>
                                <br/>
                                <button onclick="return jQuery.formValidator.pageIsValid('emailreset');"  class="sjdialog_btn">提交</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>