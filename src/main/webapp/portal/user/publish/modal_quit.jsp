<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div class="modal fade" id="myModa_quit" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style="width: 550px">
			<div class="modal-content">
				<div class="modal-header">
					<button id="transaction_x" type="button" class="modal-close"
						data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">退出机制</h4>
				</div>
				<div class="modal-body">
					<div class="quit_form">
						<form id="form_transaction">
							<table>
								<input type="hidden" name="projectQuit.projectId" value="${projectQuit.projectId }" />
								<tr>
									<td class="quit_tdle" style="padding: 12px 5px;">提出方发生条件与解决机制状况类型</td>
									<td style="text-align: center">份额股转让</td>
									<td style="text-align: center">份额股回购</td>
								</tr>
								<tr>
									<td class="quit_tdle">有限合伙人</td>
									<td class="td_hei">
										<div>
											<em>如：我想卖出股份</em> <br /> <label for="">解决方案 :</label>
											<textarea style="resize: none" name="projectQuit.transferSolution">${projectQuit.transferSolution }</textarea>
										</div>

									</td>
									<td class="td_hei">
										<div>
											<em>如：我想再次购买别人的股份</em> <br /> <label for="">解决方案 :</label>
											<textarea style="resize: none" name="projectQuit.repurchasesSolution">${projectQuit.repurchasesSolution }</textarea>
										</div>
									</td>
								</tr>
							</table>
							<div class="dia_btn" style="margin-top: 40px">
								<button onclick="form_sub('transaction')" type="button" style="margin-right: 15px">提交</button>
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