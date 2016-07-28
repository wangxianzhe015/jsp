<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
//手机认证
$(document).ready(function(){
	$("#mcode").click(function(){
		 var mobile = $("#mobile").val();
		 $.get("<%=servletPath%>/portal/uc/ajaxSendSms.action",{'mobile':mobile,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				mobile_text();
	 			}else
	 			{
					popBox(data.message,'error');	
	 			}
		    },"json");
	});
	$.formValidator.initConfig({formid:"mobilereset",validatorgroup:"mobilereset",onerror:function(msg){return false;},onsuccess:function(){
		var mobile = $("#mobile").val();
		var code = $("#mobilecode").val(); 
		 $.get("<%=servletPath%>/portal/uc/ajaxMobileConfirm.action",{'mobile':mobile,'code':code,'rand':Math.random()},function(data){  
	 			if(data.code==1)
	 			{
	 				popBox(data.message,'success');
	 				$("#m_text").addClass('now');
	 				$(".m_text_yes").show();
	 				$(".m_text_no").hide();
	 				$("#mobiletext").click();
	 			}else
	 			{
					popBox(data.message,'error');	
	 			}
		    },"json");
		return false;
		}});
// 	$("#mobile").formValidator({onshow:" ",onfocus:"请输入正确的手机号码",oncorrect:"输入正确"})
// 			  .regexValidator({regexp:"mobile",datatype:"enum",onerror:"请输入正确的手机号码"})
	$("#mobilecode").formValidator({validatorgroup:"mobilereset",onshow:" ",onfocus:"请输入正确的验证码",oncorrect:" "})
				.inputValidator({min:6,max:6,onerror:"请输入正确的验证码"})
// 			  .ajaxValidator({
// 				    type : "get",
// 				    url : "http://user.renrentou.com/ajax/AjaxCodeCheck",
// 				    datatype : "json",
// 				    success : function(data){
// 						if(data.status == 1)
// 						{
// 							return true;
// 						}else
// 						{
// 							return false;
// 						}
// 					},
// 					buttons: $("#button"),
// 		//			error: "",
// 				    onerror : "请输入正确的验证码",
// 				    onwait : " "
// 				});
});
</script>
        <!--认证手机-->
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="mobiletext" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">认证手机</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            <form id="mobilereset">
                                <label for="">手机号码 : </label>
                                <input id="mobile" type="text"/>
                                <div id="mobileTip"> </div>
                                <br/>
                                <label for="">验证码 : </label>
                                <input id="mobilecode" style="width: 140px" type="text"/>
                                <span id="mcode" class="mobile_code">获取验证码</span>
                                <span  class="m_yanzheng" style="display:none">获取验证码</span>
                                <div id="mobilecodeTip"> </div>
                                <br/>
                                <button onclick="return jQuery.formValidator.pageIsValid('mobilereset');"  class="sjdialog_btn">提交</button>
                            <input type="hidden" name="_hash_" value="caea838fb76a60dd2eb02c658c8ea6d0" /></form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>