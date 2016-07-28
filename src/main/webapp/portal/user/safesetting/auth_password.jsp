<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
function loging_href()
 {
	location.href="<%=servletPath%>/portal/uc/index.action";
 }
//密码认证
$(document).ready(function(){
	$.formValidator.initConfig({formid:"pwdreset",validatorgroup:"pwdreset",onerror:function(msg){return false;},onsuccess:function(){
		var pwd = $("#pwd").val();
		var new_pwd = $("#new_pwd").val();
		var new_pwd_re = $("#new_pwd_re").val();  
		
		$.post("<%=servletPath%>/portal/uc/ajaxResetPassword.action",
				{'password':pwd,'newPassword':new_pwd,'new_pwd_re':new_pwd_re},function(data){  
 	    	if(data.code==1){
 				popBox(data.message,'success');
 				$("#pwdtext").click();
 				setTimeout("loging_href()",2000);
 			}else{
				popBox(data.message,'error');	
 			}
		    },"json");
		return false;
	}});
	$("#pwd").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
    .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
	$("#new_pwd").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请输入6-16位数字和英文字母",oncorrect:"输入正确"})
			     .regexValidator({regexp:"password",datatype:"enum",onerror:"请输入6-16位数字和英文字母"})
	$("#new_pwd_re").formValidator({validatorgroup:"pwdreset",onshow:" ",onfocus:"请再一次输入新密码",oncorrect:"输入正确"})
					.compareValidator({desid:"new_pwd",operateor:"=",onerror:"两次密码输入不一致,请确认"});
});
</script>
        <!--弹框-->
        <!--修改密码-->
        <div class="modal fade" id="myModa00" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="pwdtext" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">修改密码</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            <form id="pwdreset">
                                <label for="">原密码 : </label>
                                <input id="pwd" name="pwd" type="password" type="text"/>
                                <div id="pwdTip"></div>
                                <br/>
                                <label for="">新密码 : </label>
                                <input id="new_pwd" name="new_pwd" type="password" type="text"/>
                                <div id="new_pwdTip"></div>
                                <br/>
                                <label for="">确认新密码 : </label>
                                <input id="new_pwd_re" name="new_pwd_re" type="password" type="text"/>
                                <div id="new_pwd_reTip"></div>
                                <br/>
                                <button onclick="return jQuery.formValidator.pageIsValid('pwdreset');" class="sjdialog_btn">提交</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>