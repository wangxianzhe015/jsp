<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="attention-list">
	<div class="space-30"></div>
	<ul class="attention-ul2">
		<li><b>${project.progress}%</b> <em>已完成</em></li>
		<li><b>${project.remainingDays }天/<span>${project.raiseDays }天</span></b> <i>剩余</i></li>
	</ul>
	<div class="space-20"></div>
	<div class="progress-s progress-s4">
		<p>
			<b style="width: ${project.progress}%"></b>
		</p>
	</div>
	<div class="money-box">
			<h2>已筹资:</h2>
			<p class="current-money">
				<span class="yen">¥</span>${project.raisedTotalAmount }
			</p>
			<p class="target-money">
				此项目须在&nbsp;<fmt:formatDate value="${project.raiseEndDate}" pattern="yyyy-MM-dd"/>&nbsp;前，获得<em><span class="yen">¥</span>${project.financeAmount }</em>元的支持才可成功!
			</p>
			<h2>目标融资</h2>
			<p class="target-money" style=" font-size: 18px;">
				<em><span class="yen">¥</span>${project.financeAmount }</em>元
			</p>
			<h2>项目方出资</h2>
			<p class="target-money" style=" font-size: 18px;">
				<em><span class="yen">¥</span>${project.founderInvestAmount }</em>元
			</p>							
			<p class="target-money" style=" font-size: 18px;">
				剩余份数:<em><span>${project.remainingCopies }</span></em>&nbsp;&nbsp; 单笔最低:<em><span class="yen">¥</span>${project.minInvestAmount }</em>元
			</p>					
	</div>	

	<div class="space-30"></div>
	<div class="subscribe-btn">
		<span class="reserve-btn cannotbuy">筹款结束</span>
	</div>
	<div class="space-30"></div>
</div>
