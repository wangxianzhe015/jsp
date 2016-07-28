<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

	<!-- 收益计算器 -->
	<div class="modal fade" id="myModa_calculator" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="modal-close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">收益计算器</h4>
				</div>
				<div class="modal-body">
					<table>
						<tbody>
							<tr>
								<th>合伙人</th>
								<th>投资额</th>
								<th>出资比例</th>
								<th>份额占股比例</th>
							</tr>
							<tr>
								<th>项目融资额</th>
								<th>￥${project.financeAmount }元</th>
								<th>100%</th>
								<th>100%</th>
							</tr>
							<tr>
								<th>投资人
									<p>（其他有限合伙人）</p>
								</th>
								<th>￥${project.financeAmount-project.founderInvestAmount}</th>
								<th>${project.investorInvestRate }%</th>
								<th>${project.investorInvestRate }%</th>
							</tr>
							<tr>
								<th>项目方
									<p>（普通合伙人）</p>
								</th>
								<th>￥${project.founderInvestAmount}元</th>
								<th>${project.founderInvestRate}%</th>
								<th>${project.founderInvestRate}%</th>
							</tr>
							<tr>
								<th>投资人
									<p>（有限合伙人）</p>
								</th>
								<th><input type="text" placeholder="请在此输入金额例如：50000"
									id="amount" data-eventname="checkNumber"
									style="text-align: center"></th>
								<th id="rate"></th>
								<th id="share"></th>
							</tr>
						</tbody>
					</table>
					<p>注：您输入的投资金额不能小于该项目最低投资金额！</p>
					<form onsubmit="return false">
						<button class="now" id="counterBtn" style="cursor: pointer">计算</button>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->