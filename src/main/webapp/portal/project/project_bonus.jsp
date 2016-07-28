<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" >
( function($) {
	$( function() {
		
		
});
})(jQuery)
</script>

				<table class="content">
						<tr>
							<td width="150px;" class="title">
								分红年度
							</td>
							<td>
								<input type="text" name="bonus.bonusYear" value="${project.bonus.bonusYear}" size="40"/>
							</td>
						</tr>
						<tr>
							<td width="150px;" class="title">
								分红总金额
							</td>
							<td>
								<input type="text" name="bonus.bonusAmount" value="${project.bonus.bonusAmount}" size="40"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								分红总期数
							</td>
							<td>
							
								<input type="text" name="bonus.bonusPeriods" value="${project.bonus.bonusPeriods}" size="40"/>
							</td>
						</tr>						
						<tr>
							<td class="title">
								盈利可分红时间(天)
							</td>
							<td>
								<input type="text" name="bonus.bonusDays" value="${project.bonus.bonusDays}" size="40"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								平均月回报率
							</td>
							<td>
							<input type="text" name="bonus.aveMonthlyRetRate" value="${project.bonus.aveMonthlyRetRate}" size="40"/>
							</td>
						</tr>
						<tr>
							<td class="title">
								平均年回报率
							</td>
							<td>
								<input type="text" name="bonus.aveYearRetRate" value="${project.bonus.aveYearRetRate}" size="40"/>
							</td>
						</tr>												
						<tr>
							<td class="title">
								月平均净利润
							</td>
							<td>
								<input type="text" name="bonus.aveMonthlyProfit" value="${project.bonus.aveMonthlyProfit}" size="40"/>

							</td>
						</tr>												
						<tr>
							<td class="title">
								月营业平均收入
							</td>
							<td>
								<input type="text" name="bonus.aveMonthlyIncome" value="${project.bonus.aveMonthlyIncome}" size="40"/>	
							</td>
						</tr>

						<tr>
							<td class="title">
								最近分红金额
							</td>
							<td>
								<input type="text" name="bonus.lastestBonusAmount" value="${project.bonus.lastestBonusAmount }" size="40"/>								
							</td>
						</tr>																	
				</table>
