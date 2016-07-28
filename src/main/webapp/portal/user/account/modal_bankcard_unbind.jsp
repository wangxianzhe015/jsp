<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
var unbind_cardid="";
function submitUnBind(){
	var identityid = $("#useridentityCard").val();
	$.post("<%=servletPath%>/portal/pay/unbindBankcard.action",{'cardId':unbind_cardid,'identityid':identityid},function(data){  
		if(data.code==1){
			popBox(data.message,'success');
			window.location.reload();
		}else{
			popBox(data.message,'error');	
		}
	},"json");

}


$(document).ready(function(){
	$.formValidator.initConfig({formid:"unbind_form",validatorgroup:"2",wideword:false,onerror:function(msg){return false;},onsuccess:function(){
		submitUnBind();
		return false;
	}});
	
	$("#useridentityCard").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入持卡人身份证",oncorrect:"输入正确"}).inputValidator({min:1,onerror: "不能为空"});
	$("#cardinfo").bind("click",
			function(){
				//unbind_cardid= $(this).attr("data-cardid");
				//$("#myModa_bankcard_unbind").modal('show');
				popBox("若需要解除银行卡绑定或换银行卡，请与客服联系400-079-9617",'info',5);
			});	
});
</script>
<div class="modal fade" id="myModa_bankcard_unbind" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-small" style="width: 600px;height: 300px">
		<div class="modal-content">
			<div class="modal-header">
				<button id="info_b_x" type="button" class="modal-close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">解除银行卡绑定</h4>
			</div>
			<div class="modal-body">
				<div class="basic_form">
					<form id="unbind_form" method="post" >
						<input name="cardId" value="${card.cardId}" type="hidden" /> 
						<label for="">身份证号码:</label>
						<input id="useridentityCard" name="identityid" style="width:300px" type="text" value="${user.identityCard }" />
						<div id="useridentityCardTip" style="margin: 5px 0 -30px 87px"></div>
						
						<br /> 						
						<div class="dia_btn">
							<button onclick="return jQuery.formValidator.pageIsValid('2');"	style="margin-right: 15px">解除绑定</button>
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