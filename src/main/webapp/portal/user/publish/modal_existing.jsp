<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

	<script>
$(document).ready(function(){
	$.formValidator.initConfig({formid:"form_info_b",validatorgroup:"2",onerror:function(msg){return false;},onsuccess:function(){form_sub("info_b");return false;}});
	$("#pname1").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入2-10位汉字数字或字母",oncorrect:"输入正确"})
			  .regexValidator({regexp:"projectname",datatype:"enum",onerror:"请输入2-10位汉字数字或字母"});			  
	$("#address1").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入5-60个汉字数字或字母",oncorrect:"输入正确"})
			  	 .regexValidator({regexp:"address1",datatype:"enum",onerror:"请输入5-60个汉字数字或字母"});
	$("#x_totalamount").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			   	   .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#operat_cycle").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
	   	      .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#par_time").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
				 .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#parea").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			  .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});		  
	$("#pflow").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			  	  .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#pconsumption").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
			   	   .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#y_income").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
	   	     .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#y_profit").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
				 .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#q_income").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
	      .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
	$("#q_profit").formValidator({validatorgroup:"2",onshow:" ",onfocus:"请输入数字",oncorrect:"输入正确"})
		 .regexValidator({regexp:"num1",datatype:"enum",onerror:"请输入数字"});
});
</script>

	<!--现有店铺概括-->
	<div class="modal fade" id="myModa_existing" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style="width: 590px">
			<div class="modal-content">
				<div class="modal-header">
					<button id="info_b_x" type="button" class="modal-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">现有店铺概括</h4>
				</div>
				<div class="modal-body" style="height:500px; overflow: auto;">
					<div class="existing_form">
						<form id="form_info_b" method="post">
							<b style="font-size:16px;padding-left: 60px; display:block;">现有店铺：</b>
							<input type="hidden" name="existingProfile.projectId" value="${existingProfile.projectId }" /> 
							<label for="">店铺名称:</label> 
							<input id="pname1" name="existingProfile.shopName" type="text" value="${existingProfile.shopName }" /><div id="pname1Tip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">店铺地址 :</label> 
							<input id="address1" name="existingProfile.shopAddress" type="text" value="${existingProfile.shopAddress }" /><div id="address1Tip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">店铺筹备总投资 :</label> 
							<input id="x_totalamount" name="existingProfile.totalAmount" type="text" value="${existingProfile.totalAmount }" /><span>元</span>
							<div id="x_totalamountTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> <label for="">从筹备到运营周期 :</label> 
							<input id="operat_cycle" name="existingProfile.operateCycle" type="text" value="${existingProfile.operateCycle }" /><span>天</span>
							<div id="operat_cycleTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">盈利可分红时间 :</label> 
							<input id="par_time" name="existingProfile.profitDay" type="text" value="${existingProfile.profitDay }" /><span>天</span>
							<div id="par_timeTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">店铺营业面积 :</label> 
							<input id="parea" name="existingProfile.area" type="text" value="${existingProfile.area }" /><span>平米</span>
							<div id="pareaTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">客流量 :</label> 
							<input id="pflow" name="existingProfile.passFlow" type="text" value="${existingProfile.passFlow }" /><span>位/日</span>
							<div id="pflowTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">人均消费 :</label> 
							<input id="pconsumption" name="existingProfile.consumption" type="text" value="${existingProfile.consumption }" /><span>元</span>
							<div id="pconsumptionTip" style="margin: 5px 0 -30px 165px">
							</div>
							<br /> 
							<label for="">上年度营业收入:</label> 
							<input id="y_income" name="existingProfile.preYearIncome" type="text" value="${existingProfile.preYearIncome }" /><span>元</span>
							<div id="y_incomeTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">上年度净利润:</label> 
							<input id="y_profit" name="existingProfile.preYearProfit" type="text" value="${existingProfile.preYearProfit }" /><span>元</span>
							<div id="y_profitTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">上季度营业收入:</label> 
							<input id="q_income" name="existingProfile.preQuarterIncome" type="text" value="${existingProfile.preQuarterIncome }" /><span>元</span>
							<div id="q_incomeTip" style="margin: 5px 0 -30px 165px"></div>
							<br /> 
							<label for="">上季度净利润:</label> 
							<input id="q_profit" name="existingProfile.preQuarterProfit" type="text" value="${existingProfile.preQuarterProfit }" /><span>元</span>
							<div id="q_profitTip" style="margin: 5px 0 -30px 165px"></div>


							<div class="dia_btn" style="margin-top: 40px">
								<button onclick="return jQuery.formValidator.pageIsValid('2');"
									style="margin-right: 15px">提交</button>
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
