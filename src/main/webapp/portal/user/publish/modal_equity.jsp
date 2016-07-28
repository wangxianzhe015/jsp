<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<script>
$( document ).ready(function(e) {
	$("#finance_total").focus();
    //份数参考
	function jisuan(pay_t,pay_p)
    {
		var pay_i = pay_t-pay_p;
		var reg = /^\d*$/;	
		var pay_r;
		var pay_rh;
		$("#fstj").html('');
		for(var i=1;i<199;i++)
		{
			pay_r = pay_i/i;
			if(reg.test(pay_r))
			{
				pay_rh = "<p><span>份数:&nbsp;"+i+"</span><span>金额:&nbsp;"+pay_r+"</span></p>";
				$("#fstj").append(pay_rh);
			}
		}
		
    }
    //计算融资金额
    $('#finance_total').blur(function(){
    	toltal = parseInt($('#finance_total').val());
    	$('#finance_total').val(toltal);
    	if($('#founder_pay').val() == false)
    	{
    		$('#founder_pay').val(toltal*0.3);
    	}
    	$('#founder_pay').blur();
    });
    $('#founder_pay').blur(function(){
        var founder_pay=$('#founder_pay').val();
        $('#founder_pay').val(founder_pay);
        var toltal=$('#finance_total').val();
        if(toltal>0 && founder_pay>0 && parseInt(toltal) > founder_pay){
        	$('#investor_pay').val((toltal-founder_pay).toFixed(2));
            $('#founder_pay_rate').val((founder_pay/toltal*100).toFixed(2));            
            $('#investor_pay_rate').val(100.00-$('#founder_pay_rate').val());
            $('#fraction').blur();
  //          jisuan(toltal,founder_pay);
        }else
        {
        	$('#finance_total').val("");
        	$('#founder_pay').val("");
            $('#investor_pay').val("");                         
            $('#founder_pay_rate').val("");
            $('#investor_pay_rate').val("");
            $('#fraction').val("");
			$('#lest_finance').val("");
        }
    });
	$('#fraction').blur(function()
	{
		 if(!$('#founder_pay').val())
		 {
			 $('#founder_pay').blur();
			 $('#fraction').val("");
		 }else
		 {
			 if(parseInt($("#fraction").val()) > 0)
			 {
				 if(parseInt($("#fraction").val()) > 199 )
				 {
					 $("#fraction").val('199');
				 }
				 $("#fraction").val(parseInt($("#fraction").val()));
				 var price = $("#finance_total").val() - $("#founder_pay").val();
				 price = (price / $("#fraction").val()).toFixed(2);
				 $('#lest_finance').val(price);
			 }else
			 {
				 $('#fraction').val("1");
				 var price = ($("#finance_total").val() - $("#founder_pay").val()).toFixed(2);
				 $('#lest_finance').val(price);
			 }
		 }
		 
	})
	//收益比例计算
	 $('#founder_income_rate').blur(function(){
         var founder_income_rate= (parseFloat($('#founder_income_rate').val())).toFixed(2);
         $('#founder_income_rate').val(founder_income_rate);
         if(founder_income_rate > 0 && founder_income_rate < 100)
         {
      		var investor_income_rate = (100-founder_income_rate).toFixed(2);
         	 $('#investor_income_rate').val(investor_income_rate);
         }else
         {
        	 $('#founder_income_rate').val("");
        	 $('#investor_income_rate').val("");
         }       
     });

	 $("#financing_sub").click(function(){
		 $('#finance_total').blur();
		 $('#founder_income_rate').blur();
		 if($("#finance_total").val() == false)
		 {
			 popBox('融资总额不能为空','error');
			 return false
		 }
		 if($("#fraction").val() == false)
		 {
			 popBox('项目方出资不能为空','error');
			 return false
		 }if($("#fraction").val() == false)
		 {
			 popBox('认购份数不能为空','error');
			 return false
		 }
		 if($("#founder_income_rate").val() == false)
		 {
			 popBox('项目方收益比例不能为空','error');
			 return false
		 }
		 form_sub('financing_sub');
	});
});
</script>
	<!--融资需求-->
	<div class="modal fade" id="myModa_equity" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style="width: 620px">
			<div class="modal-content">
				<div class="modal-header">
					<button id="financing_sub_x" type="button" class="modal-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">融资需求修改</h4>
				</div>
				<div class="modal-body">
					<div class="existing_form">
						<p style="color:#ff6633；margin-left:5px;">
							带<a style="color:#ff6633">*</a>为必填项，其他为自动计算
						</p>
						<form id="form_financing_sub">
							<input type="hidden" name="project.projectId" value="${project.projectId }" /> 
							<label for=""><a style="color:#ff6633">*</a>融资金额 :</label> 
							<input id="finance_total" name="project.financeAmount" type="text" value="${project.financeAmount }" /><span>元</span> 
							<br />
							
							<label for=""><a style="color:#ff6633">*</a>项目方出资金额 :</label> 
							<input id="founder_pay" name="project.founderInvestAmount" type="text" style="width: 90px" value="${project.founderInvestAmount }" /><span>元</span> 
							
							<label for="" class="exit_rit" style="width: 120px!important;">投资人出资金额:</label> 
							<input id="investor_pay" name="project.investorAmount" readonly="true" type="text" value="${project.investorAmount }" style="width: 90px" /><span>元</span> 
							<br />

							<label for=""><a style="color:#ff6633">*</a>认购份数 :</label> 
							<input id="fraction" name="project.subscribeCount" type="text" value="${project.subscribeCount }" style="width: 90px" /><span>份</span> 
							
							<label for="" class="exit_rit" style="width: 120px!important;">个人最低投资金额:</label> 
							<input id="lest_finance" name="project.minInvestAmount" readonly="true" type="text" value="${project.minInvestAmount }" style="width: 90px" /><span>元</span> 
							<br />

							<label for=""><a style="color:#ff6633"></a>项目方出资所占比例 :</label> 
							<input id="founder_pay_rate" name="project.founderInvestRate" readonly="true" type="text" value="${project.founderInvestRate }" style="width: 90px" />% 
							
							<label for="" class="exit_rit" style="width: 120px!important;">投资人出资比例:</label> 
							<input id="investor_pay_rate" name="project.investorInvestRate" readonly="true" type="text" value="${project.investorInvestRate }" style="width: 90px" />%
							<br /> 
							
							<label for=""><a style="color:#ff6633">*</a>项目方收益所占比例:</label> 
							<input id="founder_income_rate" name="project.founderIncomeRate" type="text" value="${project.founderIncomeRate }" style="width: 90px" />% 
							
							<label for="" class="exit_rit" style="width: 120px!important;">投资人收益比例:</label> 
							<input id="investor_income_rate" name="project.investorIncomeRate" readonly="true" type="text" value="${project.investorIncomeRate }" style="width: 90px" />%
							
							<div class="dia_btn" style="margin-top: 40px">
								<button id="financing_sub" type="button" style="margin-right: 15px">提交</button>
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
