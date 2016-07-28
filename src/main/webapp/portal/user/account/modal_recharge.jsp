<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
var rechargeOrderId=null;
function recharge(){
	var info = $("#recharge_form").serialize();
	$.post("<%=servletPath%>/portal/pay/recharge.action",info,function(data){  
		if(data.code==1){
			popBox(data.message,'success');
			rechargeOrderId=data.orderid;
			var time = 60;
			var obj=$("#recharge_sendsmscode");
			var settime = setInterval(function () {
				time--;obj.text(time + '后重新发送');
				if (time <= 0) {clearInterval(settime);obj.removeAttr('disabled');obj.text('重新发送'); }
			}, 1000);			
		}else{
			popBox(data.message,'error');	
		}
	},"json");

}

function confirmRecharge(){
	var amount=$("#recharge_amount").val();
	var smscode=$("#recharge_verifycode").val();
	if(amount==null||amount==""){
		popBox("请输入充值金额",'error');
		return ;
	}	
	if(smscode==null||smscode==""){
		popBox("请输入验证码",'error');
		return ;
	}

		
	
	$.post("<%=servletPath%>/portal/pay/confirmRecharge.action",{'amount':amount,'orderid':rechargeOrderId,'verifycode':smscode},
			function(data){  
				if(data.code==1){
					$('#myModa_recharge').modal('hide');
					popBox(data.message,'info',5);	
					window.location.reload();
				}else{
					popBox(data.message,'error');	
				}
			},"json");	
}

$(document).ready(function(){
	$.formValidator.initConfig({formid:"recharge_form",validatorgroup:"3",wideword:false,onerror:function(msg){return false;},onsuccess:function(){
		recharge();
		return false;
	}});
	
	$("#recharge_account").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入充值金额",oncorrect:"输入正确"}).inputValidator({min:1,type:'number',onerror: "请输入充值金额"});
	$("#cardId").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请选择支付银行卡",oncorrect:"输入正确"}).inputValidator({min:1,onerror: "请选择支付银行卡"});

});
</script>
<div class="modal fade" id="myModa_recharge" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-small" style="width: 600px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close" ><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">账户充值</h4>
			</div>
			
			<div class="basic_form" style="margin-left:40px">
				<form id="recharge_form" method="post" action="<%=servletPath %>/portal/pay/recharge.action">
					<label for="">账户余额：</label><span>${user.accountInfo.availableAmount} 元</span></p>
					<label for="">选择支付卡:</label>
					<select name="cardId" id="cardId" style="width:220px">
						<c:forEach items="${bankcards}" var="bankcard">
						<option value=''>------请选择------</option>
						<option value="${bankcard.cardId }">${bankcard.cardTop }******${bankcard.cardLast }</option>
						</c:forEach>
					</select>
					<div id="cardIdTip" style="margin: 5px 0 -30px 87px"></div>
					<br/>					
					<label for="">充值金额:</label>
					<input id="recharge_amount" name="amount" type="text" value="" /> 元
					<div id="recharge_amountTip" style="margin: 5px 0 -30px 87px"></div>
					<br/>
					<label for="">短信验证码:</label>
					<input id="recharge_verifycode" type="text" value="" />					
					<button onclick="return jQuery.formValidator.pageIsValid('3');" id="recharge_sendsmscode" style="margin-right: 15px;width: 100px" >发送验证短信</button>
					<br/>
					<br/>
					<input type="button" onclick="confirmRecharge();" style="width: 180px; height: 40px;  margin-left: 50px; margin-right: 30px;" class="btn-ju-bdr" value="立即充值"/>
					<input type="button" style="width: 180px; height: 40px; background:#ccc;" class="btn-ju-bdr" data-dismiss="modal" value="取消"/>
					<div class="space-30"></div>
					<p/>
				</form>
               <p class="tip" style="margin:30px;"> 温馨提示<br/>
1.很多用户因超出银行卡限额，导致充值失败，请您查询好您使用的银行卡的限额，以保证充值成功。<br/>
2.所有银行，目前只支持借记卡充值，暂不支持信用卡。<br/>
3.为了您的账户安全，请在充值前进行身份认证设置。<br/>
4.有问题请联系客服 400-079-9617（周一至周五 9:00 - 18:00）<br/></p>				
			</div>
		</div>
		<!-- /.modal-content --> 
	</div>
	<!-- /.modal-dialog --> 
</div>