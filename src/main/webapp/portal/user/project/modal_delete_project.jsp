<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div class="modal fade" id="delete-dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small">
			<div class="modal-content" style="text-align: center">
				<div class="modal-header">
					<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">提交删除</h4>
				</div>
				<div class="modal-body">您确定要删除该项目吗？</div>
				<div class="modal-body">
					<input type="button" value="确定" class="btn" data-eventname="delete" style="margin-left: 20px; height: auto; cursor: pointer; background: #FF6633; color: #FFF">
					<input type="button" value="取消" class="btn" data-eventname="cancel">
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>