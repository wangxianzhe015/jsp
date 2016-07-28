<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
//邮箱认证
$(document).ready(function(){
	$.formValidator.initConfig({formid:"realNameAuth",validatorgroup:"realNameAuth",onerror:function(msg){return false;},onsuccess:function(){
		var realName = $("#realName").val();
		var identityCode = $("#identityCode").val(); 
		 $.post("<%=servletPath%>/portal/uc/ajaxSaveRealName.action",{'realName':realName,'identityCode':identityCode},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				$("#realname_text").addClass('now');
	 				$(".safety_ico4").html("已实名认证");
	 				$(".realname_text_yes").show();
	 				$(".realname_text_no").hide();
	 				$("#realnameCloseBtn").click();
	 			}else{
					popBox(data.message,'error');	
	 			}
		    },"json");
		return false;
		}});
	$("#realName").formValidator({validatorgroup:"realNameAuth",onshow:" ",onfocus:"请输入真实姓名",oncorrect:" "}).inputValidator({min:1,max:20,onerror:"请输入真实姓名"});
	$("#identityCode").formValidator({validatorgroup:"realNameAuth",onshow:" ",onfocus:"请输入身份证号码",oncorrect:" "}).inputValidator({min:18,max:18,onerror:"请输入身份证号码"});

});
</script>
        <!--认证邮箱-->
        <div class="modal fade" id="myModa23" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="realnameCloseBtn" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">实名认证</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            <form id="realNameAuth">
                                <label for="">真实姓名 : </label>
                                <input id="realName" type="text"/>
                                <div id="realNameTip"> </div>
                                <br/>
                                <label for="">身份证号码: </label>
                                <input id="identityCode" type="text"/>
                                <div id="identityCodeTip"> </div>
                                <br/>
                                <button onclick="return jQuery.formValidator.pageIsValid('realNameAuth');"  class="sjdialog_btn">提交</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>