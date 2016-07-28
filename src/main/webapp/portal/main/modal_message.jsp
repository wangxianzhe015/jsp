<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){

    // 私信
	$.formValidator.initConfig({
        formid:"talk_form",
        autotip:true,
        onerror:function(){
            $("#myModal1").modal('hide');
            popBox("您填写的内容不完整，请检查下哦", "info", 3, function(){
                $("#myModal1").modal('show');
            });
            return false;
        },
        onsuccess:function(){
            var postData = {
                "projectId": projectId,
                "content": $("#talk_content").val()
            };
            $.ajax({
                type: "post",
                url: "<%=servletPath%>/portal/uc/talk.action",
                dataType: "json",
                data: postData,
                success: function(data){
                    $("#myModal1").modal('hide');
                    popBox(data.message, data.code>0 ? "success" : "info", 3, function(){
                        if (data.code==-2) {
                            common_show_user();
                            return false;
                        }
                        if (data.code==-1) {
                            $("#myModal1").modal('show');
                        }
                    });
                }
            });

            return false;
        }
    });
    
    // 私信内容验证
    $("#talk_content").formValidator({
        onshow: "请输入私信内容",
        onfocus: "请输入私信内容, 20-200个字符",
        onerror: "请输入私信内容, 20-200个字符",
        oncorrect: "内容可以发送了"
    }).inputValidator({
		min: 20,
        max: 200
	});

    $("#talk_submit").bind("click", function(){
        $("#talk_form").submit();
    });
});
</script>
	<!--私信弹框-->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="modal-close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">私信</h4>
				</div>
				<div class="modal-body">
					<form id="talk_form">
						<textarea id="talk_content" placeholder="请输入私信内容..." style="width: 100%; height: 150px"></textarea>
						<div id="talk_contentTip" style="margin-top: 10px; width:250px"></div>
						<br />
						<div class="subscribe-btn" id="talk_submit">
							<a href="javascript: void(0)">提交</a>
						</div>
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
