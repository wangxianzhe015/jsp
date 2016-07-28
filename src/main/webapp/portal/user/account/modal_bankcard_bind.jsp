<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
var requestid=null;
function submitbind(){
	var info = $("#bindcard_form").serialize();
	$.post("<%=servletPath%>/portal/pay/bindBankcard.action",info,function(data){  
		if(data.code==1){
			popBox(data.message,'success');
			requestid=data.requestid;
			var time = 60;
			var obj=$("#sendSmsCode");
			var settime = setInterval(function () {
				time--;obj.text(time + '后重新发送');
				if (time <= 0) {clearInterval(settime);obj.removeAttr('disabled');obj.text('重新发送'); }
			}, 1000);			
		}else{
			popBox(data.message,'error');	
		}
	},"json");

}

function confirmbind(){
	var smscode=$("#verifycode").val();
	var identityid=$("#identityid").val();
	var userName=$("#userName").val();
	var cardNo=$("#cardno").val();
	
	$.post("<%=servletPath%>/portal/pay/confirmBindBankcard.action",
			{'userName':userName,'identityid':identityid,'cardNo':cardNo,'requestid':requestid,'verifycode':smscode},
			function(data){  
		if(data.code==1){
			$('#myModa_bankcard_bind').modal('hide');
			popBox(data.message,'success');	
			window.location.reload();
		}else{
			popBox(data.message,'error');	
		}
	},"json");	
}

$(document).ready(function(){
	$.formValidator.initConfig({formid:"bindcard_form",validatorgroup:"1",wideword:false,onerror:function(msg){return false;},onsuccess:function(){
		submitbind();
		return false;
	}});
	
	$("#cardno").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入银行卡卡号",oncorrect:"输入正确"}).inputValidator({min:1,onerror: "不能为空"});
	$("#userName").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入持卡人姓名",oncorrect:"输入正确"}).regexValidator({regexp:"chinese2",datatype:"enum",onerror:"请输入真实姓名"});
	$("#identityid").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入持卡人身份证",oncorrect:"输入正确"}).regexValidator({regexp:"notempty",datatype:"enum",onerror:"请输入身份证号码"})
	$("#phone").formValidator({validatorgroup:"1",onshow:" ",onfocus:"请输入银行预留的手机号",oncorrect:"输入正确"}).inputValidator({min:1,onerror: "不能为空"});
	
});
</script>
<div class="modal fade" id="myModa_bankcard_bind" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-small" style="width: 600px;height: 400px">
		<div class="modal-content">
			<div class="modal-header">
				<button id="info_a_x" type="button" class="modal-close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">添加银行卡信息</h4>
			</div>
			<div class="modal-body">
				<div class="basic_form">
					<form id="bindcard_form" method="post" >
						<input name="card.cardId" value="${card.cardId}" type="hidden" /> 
						<label for="">卡持有人:</label>
						<input id="userName" name="card.userName" type="text" value="${user.realName }" />
						<div id="userNameTip" style="margin: 5px 0 -30px 87px"></div>
						<br/>
						<label for="">身份证号码:</label>
						<input id="identityid" name="card.identityid" style="width:300px" type="text" value="${user.identityCard }" />
						<div id="identityidTip" style="margin: 5px 0 -30px 87px"></div>
						<br/>
						<label for="">银行卡卡号:</label>
						<input id="cardno" name="card.cardNo" style="width:300px" type="text" value="${card.cardNo }" />
						<div id="cardnoTip" style="margin: 5px 0 -30px 87px"></div>
						<br /> 
						<label for="">预留手机号:</label>
						<input id="phone" name="card.phone" style="width:300px"  type="text" value="${sessionUser.mobileNo }" />
						<div id="phoneTip" style="margin: 5px 0 -30px 87px"></div>
						<br/>
						<label for="">短信验证码:</label>
						<input id="verifycode" type="text" value="" />					
						<button onclick="return jQuery.formValidator.pageIsValid('1');" id="sendSmsCode" style="margin-right: 15px" >发送验证短信</button>
						
						<div class="dia_btn">
							<button onclick="confirmbind()"	style="margin-right: 15px">绑定银行卡</button>
							<button type="button" data-dismiss="modal">取消</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>