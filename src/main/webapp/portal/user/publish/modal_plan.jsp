<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<script>
$(document).ready(function(){
	$('#e_business_time').datetimepicker({lang:'ch'});
	$.formValidator.initConfig({formid:"form_info_c",validatorgroup:"3",wideword:false,onerror:function(msg){return false;},onsuccess:function(){form_sub("info_c");return false;}});
	$("#e_pnum").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			  .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});			  
	$("#period_time").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			   	   .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#e_address").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入5-60个汉字数字或字母",oncorrect:"输入正确"})
 				 .regexValidator({regexp:"address1",datatype:"enum",onerror:"请输入5-60个汉字数字或字母"});   
	$("#e_business_time").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请选择时间",oncorrect:"输入正确"})
	   	       			.inputValidator({min:1,onerror: "请选择时间"});
	$("#p_profit_time").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
				 .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#p_profit_amount").formValidator({validatorgroup:"3",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			  .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});	
	$("#else_project").formValidator({validatorgroup:"3",onshow:" ",onfocus:"不超过80个字",oncorrect:"输入正确"})
						.inputValidator({min:1,max:80,onerror: "不超过80个字"});	  
	
});
</script>
	<!--开店计划-->
	<div class="modal fade" id="myModa_plan" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style="width: 590px">
			<div class="modal-content">
				<div class="modal-header">
					<button id="info_c_x" type="button" class="modal-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">开店计划</h4>
				</div>
				<div class="modal-body">
					<div class="existing_form">
						<form id="form_info_c">
							<input type="hidden" name="projectPlan.projectId" value="${projectPlan.projectId }" /> 
							<label for="">预期融资开店数量:</label> 
							<input id="e_pnum" name="projectPlan.shopNum" type="text" value="${projectPlan.shopNum }" /><span>家</span>
							<div id="e_pnumTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">开店筹备时间周期 :</label> 
							<input id="period_time" name="projectPlan.peroidDay" type="text" value="${projectPlan.peroidDay }" /><span>天</span>
							<div id="period_timeTip" style="margin: 5px 0 -30px 165px">
							</div>
							<br/> 
							<label for="">预期店面地址 :</label> 
							<input id="e_address" name="projectPlan.shopAddress" type="text" value="${projectPlan.shopAddress }" />
							<div id="e_addressTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">预期开业时间 :</label> 
							<input id="e_business_time" name="projectPlan.businessDate" readonly="ture" type="text" value='<fmt:formatDate value="${projectPlan.businessDate}" pattern="yyyy-MM-dd"/>'/><span>（*融资成功后）</span>
							<div id="e_business_timeTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">预期分红时间 :</label> 
							<input id="p_profit_time" name="projectPlan.profitDay" type="text" value="${projectPlan.profitDay }" /><span>天（*融资成功后）</span>
							<div id="p_profit_timeTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> <label for="">第一年预计盈利 :</label> 
							<input id="p_profit_amount" name="projectPlan.profitAmount" type="text" value="${projectPlan.profitAmount }" /><span>元</span>
							<div id="p_profit_amountTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> <label for="">其他计划 :</label>
							<textarea style="resize: none" id="else_project" name="projectPlan.otherPlan">${projectPlan.otherPlan }</textarea>
							<div id="else_projectTip" style="margin: 5px 0 -30px 165px">
							</div>
							<br />
							<div class="dia_btn" style="margin-top: 40px">
								<button onclick="return jQuery.formValidator.pageIsValid('3');" style="margin-right: 15px">提交</button>
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