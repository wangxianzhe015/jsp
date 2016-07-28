<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script>

/**
 * 获取当前预购分数
 * @return int
 */
function getCurrentNum()
{
    var currentNum = parseInt($("#prebuynum").val());
    if (isNaN(currentNum) || currentNum < 1) {
        currentNum = 1;
    }
    return currentNum;
}

$(document).ready(function(){
    // 认购
    $("#buyspan,#buy").bind("click", function(){
        location = "<%=servletPath%>/portal/uc/buy.action?projectId=${project.projectId}";
    });

    // 预购
    $(".prebuy").bind("click", function(){
        $("#myModa_yuyue").modal("show");
    });
    $("#prebugsubmitbtn").bind("click", function(){
        var postData = {
            "projectId": projectId,
            "prebuyNum": getCurrentNum()
        };
        $("#myModa_yuyue").modal("hide");
        $.ajax({
            type: "get",
            url: "<%=servletPath%>/portal/uc/prebuy.action",
            data: postData,
            success: function(data){
                popBox(data.message, data.code>0 ? "success" : "info", 3, function(){
                    if (data.code==1) {
                        location = location;
                    } else {
                    	
                    }
                });
            }
        });
    });
    
    $("#prebugcancelbtn").bind("click", function(){
        $("#myModa_yuyue").modal("hide");
    });
    
    // 预约份数增减
    $('.number_up,.number_down').click(function(){
        var type = $(this).attr("class") == "number_down" ? 0 : 1; // 1-增加，2-减少
        var currentNum = getCurrentNum();
        var limitNum=${project.limitCount};
        if (isNaN(totalNum) || (currentNum <= 1 && !type)) {//不限制预购份数上限
            return false;
        }
        
        if (type) {
            currentNum = currentNum + 1;
        } else {
            currentNum -= 1;
        }
        
        if(limitNum!=null && limitNum>0){
        	if(currentNum>limitNum){
           		popBox("每人最多认购"+limitNum+"份",'info');
           		currentNum=limitNum;		
        	}
        }        

        
        var amount = currentNum * ${project.minInvestAmount};

        $("#prebuynum").val(currentNum);
        $("#prebuyamount2").html(amount.toFixed(2)+"元");
    });
    // 手动修改份数矫正
    $("#prebuynum").bind("blur", function(){
        var currentNum = getCurrentNum();
        var amount = currentNum * ${project.minInvestAmount};
        $("#prebuynum").val(currentNum);
        $("#prebuyamount2").html(amount.toFixed(2)+"元");
    });
    $("#prebuynum").val(1);

});
</script>
	<!--预购弹框-->
	<div class="modal fade" id="myModa_yuyue" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-small" style=" width:600px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="modal-close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">预约认购</h4>
				</div>
				<div class="modal-body">
					<p class="yuyue_tishi">
						<span>＊</span>预约认购为您的认购意向，并非正式认购，众投客平台的项目是按份数来认购的。
					</p>
					<p class="clear"></p>
					<ul>
						<li style="width: 35%">项目融资目标：<span>${project.financeAmount }元</span></li>
						<%/* <li style="width: 30%">总份数：<span>${project.subscribeCount }份</span></li> */ %>
						<li style="width: 35%">单份金额：<span>${project.minInvestAmount}元/份</span></li>
					</ul>
					<form onsubmit="return false" style="margin-left: 8px">
						<div class="yuyue_foot">
							<div class="details-number">
								<span>预约认购份数：</span>&nbsp; <a href="javascript: void(0)"
									class="number_down">-</a> 
									<input type="text" id="prebuynum" value="1" class="inputVal"
									onkeyup="this.value=this.value.replace(/\D/g,'')"
									onafterpaste="this.value=this.value.replace(/\D/g,'')"
									onkeydown="if(event.keyCode==32) return false"> 
									<a href="javascript: void(0)" class="number_up">+</a>份
							</div>
							<p>
								预约认购总金额：<span id="prebuyamount2">${project.minInvestAmount}元</span>
							</p>
						</div>
						<div class="foot_btn">
							<button id="prebugsubmitbtn">提交</button>
							<button type="button" class="btn btn-default" data-dismiss="modal" style="background:#ccc; margin-left:15px;">取消</button>
						</div>

					</form>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
