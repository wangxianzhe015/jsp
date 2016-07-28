<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div class="modal fade" id="myProject" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button id="xmfdk_button" type="button" class="modal-close" data-dismiss="modal" aria-label="Close" style="margin:0;"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">项目方打款</h4>
			</div>
			<div class="modal-body">
				<p><span id="pay_s" style="color: red;"></span></p>
				<p><b>应打款金额：</b><span id="pay_t"></span> 元</p>
				<p><b>已打款金额：</b><span id="pay_ed"></span> 元</p>
				<p style="display:none"><b>项目id</b><span id="pay_pid"></span></p>
				<p><b>打款金额：</b><input id="amount_pro" name="amount_pro" type="text" value="" /> 元</p>
				<button id="ajax_xmfdk" type="button" style="width: 70px; height: 30px;margin-top: 20px;  margin-left: 200px; margin-right: 30px;margin-bottom: 10px; " class="btn-ju-bdr">确定</button>
				<button style="width: 70px; height: 30px; background:#ccc;" class="btn-ju-bdr" data-dismiss="modal">取消</button>
			</div>
		</div>
		<!-- /.modal-content --> 
	</div>
	<!-- /.modal-dialog --> 
	</div>
