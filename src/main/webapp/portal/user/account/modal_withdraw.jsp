<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
function withdraw(){
	var info = $("#withdraw_form").serialize();
	$.post("<%=servletPath%>/portal/pay/withdraw.action",info,function(data){  
		if(data.code==1){
			$('#myModa_withdraw').modal('hide');
			popBox(data.message,'success');		
			window.location.reload();
		}else{
			popBox(data.message,'error');	
		}
	},"json");

}
$(document).ready(function(){
	$.formValidator.initConfig({formid:"withdraw_form",validatorgroup:"4",wideword:false,onerror:function(msg){return false;},onsuccess:function(){
		withdraw();
		return false;
	}});
	
	$("#withdraw_amount").formValidator({validatorgroup:"4",onshow:" ",onfocus:"请输入提现金额",oncorrect:"输入正确"}).inputValidator({min:1,type:'number',onerror: "请输入提现金额"});
	$("#withdraw_cardId").formValidator({validatorgroup:"4",onshow:" ",onfocus:"请选择收款银行卡",oncorrect:"输入正确"}).inputValidator({min:1,onerror: "请选择收款银行卡"});

});
</script>
<div class="modal fade" id="myModa_withdraw" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 600px">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close" style="margin:0;"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">账户提现</h4>
			</div>
			<div class="basic_form" style="margin-left:40px">
				<form id="withdraw_form" method="post">
				    <label for="">账户余额：</label><span>${user.accountInfo.availableAmount} 元</span><p/>
					<label for="">收款账号：</label>
					<select name="cardId" id="withdraw_cardId" style="width:220px">
						<c:forEach items="${bankcards}" var="bankcard">
						<option value=''>------请选择------</option>
						<option value="${bankcard.cardId }">${bankcard.cardTop }******${bankcard.cardLast }</option>
						</c:forEach>
					</select>
					<div id="withdraw_cardIdTip" style="margin: 5px 0 -30px 87px"></div>				
					<br/>				    
					<label for="">提现金额：</label><input id="withdraw_amount"  name="amount" type="text" value="" /> 元
					<div id="withdraw_amountTip" style="margin: 5px 0 -30px 87px"></div>	
					<br/>
					
					<input type="button" onclick="return jQuery.formValidator.pageIsValid('4');" style="width: 180px; height: 40px;  margin-left: 50px; margin-right: 30px;" class="btn-ju-bdr" value="立即提现"/>
					<input type="button" style="width: 180px; height: 40px; background:#ccc;" class="btn-ju-bdr" data-dismiss="modal" value="取消"/>
					<div class="space-30"></div>
				</form>
                <br/><p>温馨提示<br/>
                    1.当日充值的金额需要24小时之后才能提现<br/>
                    2.在工作日9:00——16:00所提交的提现指令，处理成功后，工行、农行、招行、建行、<br/>光大、交通、北京、深发、中信在工作日提交当日到账，其他银行2至3个工作日内到账。<br/>
                    3.提现手续费：3元/笔。
                    </p><br/><br/>				
			</div>
		</div>

	</div>

</div>