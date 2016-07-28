<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
( function($) {
	$( function() {

		// 调用日期控件
		$("[name='project.raiseBeginDate']").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat:"yy/mm/dd",
			regional:"zh-CN"
		});	
		$("[name='project.raiseEndDate']").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat:"yy/mm/dd",
			regional:"zh-CN"
		});	

		$("[name='project.prebuyBeginDate']").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat:"yy/mm/dd",
			regional:"zh-CN"
		});	
		$("[name='project.prebuyEndDate']").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat:"yy/mm/dd",
			regional:"zh-CN"
		});	
		
		//$("[name='project.raiseBeginDate']").datepicker("disable").attr("readonly","readonly");
		//$("[name='project.prebuyBeginDate'").datepicker("disable").attr("readonly","readonly");
		
		   $('#founderInvestAmount').blur(function(){
		        var total = parseInt($('#financeAmount').val());
		    	if($('#founder_pay').val() == false)
		    	{	
		    		var fp_min = 0; 
		    		$('#founderInvestAmount').val(fp_min);
		    	}
		    	
		    	var founder_pay=$('#founderInvestAmount').val();
		        if(total>0 && && parseInt(total) > founder_pay){
		        	$('#investorAmount').val(parseInt(total-founder_pay).toFixed(2));
		            $('#subscribeCount').blur();
		            
		        }else
		        {
		        	$('#founderInvestAmount').val("");
		        	$('#investorAmount').val("");
		            $('#subscribeCount').val("");
					$('#minInvestAmount').val("");
		        }
		        
		       
		    });

		$('#subscribeCount').blur(
					function() {
						if (!$('#founderInvestAmount').val()) {
							$('#founderInvestAmount').blur();
							$('#subscribeCount').val("");
						} else {
							if (parseInt($("#subscribeCount").val()) > 0) {
								//if (parseInt($("#subscribeCount").val()) > 199) {
								//	$("#subscribeCount").val('199');
								//}
								$("#subscribeCount").val(parseInt($("#subscribeCount").val()));
								var price = $("#financeAmount").val()- $("#founderInvestAmount").val();
								price = (price / $("#subscribeCount").val()).toFixed(2);
								$('#minInvestAmount').val(price);
							} else {
								$('#subscribeCount').val("1");
								var price = ($("#financeAmount").val() - $("#founderInvestAmount").val()).toFixed(2);
								$('#minInvestAmount').val(price);
							}
						}

					})

			$('#founderIncomeRate').blur(
					function() {
						var founderIncomeRate = (parseFloat($('#founderIncomeRate').val())).toFixed(2);
						$('#founderIncomeRate').val(founderIncomeRate);
						if (founderIncomeRate > 0 && founderIncomeRate < 100) {
							var investorIncomeRate = (100 - founderIncomeRate).toFixed(2);
							$('#investorIncomeRate').val(investorIncomeRate);
						} else {
							$('#founderIncomeRate').val("");
							$('#investorIncomeRate').val("");
						}
					});
		});
	})(jQuery)
</script>

<table class="content">
						<tr>
							<td class="title">
								筹集资金
							</td>
							<td>
								<input type="text" id="financeAmount" name="project.financeAmount" value="${project.financeAmount}" class="line_input" />(元)
							</td>
						</tr>
						<tr>
							<td class="title">项目方出资</td>
							<td><input type="text" id="founderInvestAmount"
								name="project.founderInvestAmount"
								value="${project.founderInvestAmount}" class="line_input" />元
							</td>
						</tr>
						<tr>
							<td class="title">投资方出资</td>
							<td><input type="text" id="investorAmount"
								name="project.investorAmount"
								value="${project.investorAmount}" class="line_input" />元
							</td>
						</tr>	
						<tr>
							<td class="title">认购份数</td>
							<td><input type="text" id="subscribeCount"
								name="project.subscribeCount"
								value="${project.subscribeCount}" class="line_input" />份</td>
						</tr>
						<tr>
							<td class="title">限购份数</td>
							<td><input type="text" id="limitCount" name="project.limitCount"
								value="${project.limitCount}" class="line_input" />份(为空或0表示不限购)</td>
						</tr>	
						<tr>
							<td class="title">单笔投资人最低投资金额</td>
							<td><input id="minInvestAmount" type="text" name="project.minInvestAmount"
								value="${project.minInvestAmount}" class="line_input" /> 元
								(*最低投资金额=投资人出资总额 /认购份数)</td>
						</tr>
						<tr>
							<td class="title">项目方收益比例</td>
							<td><input type="text" id="founderIncomeRate"
								name="project.founderIncomeRate" value="${project.founderIncomeRate}"
								class="line_input" />%</td>
						</tr>
						<tr>
							<td class="title">投资方收益比例</td>
							<td><input type="text" id="investorIncomeRate"
								name="project.investorIncomeRate"
								value="${project.investorIncomeRate}" class="line_input" />%</td>
						</tr>
						<tr>
							<td class="title">
								项目预热时间<font color="red">*</font>
							</td>
							<td>
							
								从<input type="text" name="project.prebuyBeginDate" value='<fmt:formatDate value="${project.prebuyBeginDate }" pattern="yyyy-MM-dd"/>' />
								至<input type="text" name="project.prebuyEndDate" value='<fmt:formatDate value="${project.prebuyEndDate }" pattern="yyyy-MM-dd"/>' />
							</td>
						</tr>					
						<tr>
							<td class="title">
								项目融资时间<font color="red">*</font>
							</td>
							<td>
							
								从<input type="text" name="project.raiseBeginDate" value='<fmt:formatDate value="${project.raiseBeginDate }" pattern="yyyy-MM-dd"/>' />
								至<input type="text" name="project.raiseEndDate" value='<fmt:formatDate value="${project.raiseEndDate }" pattern="yyyy-MM-dd"/>' />
							</td>
						</tr>					
</table>
