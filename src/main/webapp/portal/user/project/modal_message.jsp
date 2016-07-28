<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<style>
.btn_sub {
	background: none repeat scroll 0 0 #da4f32;
	border: medium none;
	border-radius: 3px;
	color: #fff;
	cursor: pointer;
	margin-left: 200px;
	padding: 0px 30px;
}
</style>
<script>
var messageProjectId = 0;
$(document).ready(function(){
    // 发信信
    $("a[data-eventname=message]").bind("click", function(){
        messageProjectId = $(this).attr("data-project-id");
        $("#message").modal("show");
    });
    
	$.formValidator.initConfig({
        formid:"talk_form",
        autotip:true,
        onerror:function(){
            $("#message").modal('hide');
            popBox("请输入信息内容, 20-200个字符", "info", 3, function(){
                $("#message").modal('show');
            });
            return false;
        },
        onsuccess:function(){
            var postData = {
                "projectId": messageProjectId,
                "content": $("#talk_content").val()
            };
            $.ajax({
                type: "post",
                url: "<%=servletPath%>/portal/uc/talk.action",
                dataType: "json",
                data: postData,
                success: function(data){
                    $("#message").modal('hide');
                    popBox(data.info, data.code>0 ? "success" : "error", 3, function(){
                        if (data.code<=0) {
                            $("#message").modal('show');
                        }
                    });
                }
            });

            return false;
        }
    });
    // 信息内容验证
    $("#talk_content").formValidator({
        onshow: " ",
        onfocus: "请输入信息内容, 20-200个字符",
        onerror: "请输入信息内容, 20-200个字符",
        oncorrect: "内容可以发送了"
    }).inputValidator({
		min: 20,
        max: 200
	});
});
</script>

	<!-- 私信弹框 -->
	<div class="modal fade" id="message" tabindex="-1" role="dialog"
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
						<textarea name="talk_content" id="talk_content"
							placeholder="请输入私信内容..." style="width: 550px; height: 150px"></textarea>
						<div id="send_webmsgTip" style="margin-top: 10px; width:250px"></div>
						<div id="send_emailTip" style="margin-top: 10px; width:250px"></div>
						<div id="talk_contentTip" style="margin-top: 10px; width:250px"></div>
						<br /> <input class="btn_sub" type="submit" value="提交" id="talk_submit"> 
					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>