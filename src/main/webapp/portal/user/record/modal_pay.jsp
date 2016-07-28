<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

	<style>
	    .modal-header_index{
	        height: 16px;
	        padding-top: 8px;
	        padding-bottom: 0px;
	        border-bottom: none;
	    }
	    
	    .modal-content_index{
	        background: #fff;
	        width: 600px;
	        left: 50%;
	        margin-left: -300px;
	    }
	    .myModa_header_box_gettelcode_form_btn,.myModa_header_box_form_gettelcode{ background:#ff6633; color:#fff; cursor:pointer;} 
	</style>	
	<script type="text/javascript">
	/**
	 * 发送手机验证码
	 * @param obj 发送验证码按钮jq对象用于锁定按钮
	 * @returns {boolean}
	 */
	function sendMobileCodeByOnlinePay(obj) {
		var recordId=$("#online_pay_form input[id='recordId']").val();
		var cardId=$("#cardId").val();
		$.ajax({
			url:"<%=servletPath%>/portal/uc/onlinePay.action",
			data:{"recordId":recordId,"cardId":cardId},
			dataType:'json',
			success:function(data) {
				if(data.code==1) {
					popBox('验证码已发送到您填写的手机上','success',2);
					obj.attr('disabled', 'disabled');
					var time = 60;
					var settime = setInterval(function () {
						time--;obj.val(time + '后重新发送');
						if (time <= 0) {clearInterval(settime);obj.removeAttr('disabled');obj.val('重新发送'); }
					}, 1000);
				} else {
					popBox(data.message,'error');
				}
				return false;
			}
		})
	}

	 function onlinePay(){
			var recordid=$("#online_pay_form input[id='recordId']").val();
			var mobilecode=$("#mobilecode").val();
			if(mobilecode==null||mobilecode==""){
				popBox("请输入验证码",'info');
				return ;
			}

		    $.ajax({
		        type: "post",
		        url: "<%=servletPath%>/portal/uc/confirmPay.action",
		        data:{'recordId':recordid,'mobilecode':mobilecode},
		        dataType: "json",
		        async : true,
		        success: function(data, textStatus){
                    $("#modal_pay").modal('hide');
                    popBox(data.message, data.code>0 ? "success" : "error", 3, function(){
                        if (data.code==1) {
                        	window.location.reload();
                        }
                    });		
				},
		      	complete: function(XMLHttpRequest, textStatus){},
		      	error: function(){
		      		//请求出错处理
		    	  popBox("获取数据超时", "error", 3);
		      	}
			});
		}
	 
	 function accountPay(){
			var recordid=$("#account_pay_form input[id='recordId']").val();
			var verifycode=$("#verifycode").val();
			if(verifycode==null || verifycode==""){
				popBox("请输入验证码",'info');
				return ;
			}
			
		    $.ajax({
		        type: "post",
		        url: "<%=servletPath%>/portal/uc/accountPay.action",
		        data:{'recordId':recordid,'verifycode':verifycode},
		        dataType: "json",
		        async : true,
		        success: function(data, textStatus){
                    $("#modal_pay").modal('hide');
                    popBox(data.message, data.code>0 ? "success" : "error", 3, function(){
                        if (data.code==1) {
                        	window.location.reload();
                        }
                    });					
				},
		      	complete: function(XMLHttpRequest, textStatus){},
		      	error: function(){
		    	  popBox("获取数据超时", "error", 3);
		      	}
			});
		}	 
	/**
	 * 刷新发送手机验证码
	 */
	function refreshVerifyCode() {
		document.getElementById('imagecode').src="<%=contextPath%>/portal/common/verifycode.jsp?t="+ Math.random();
	}
	
	$(document).ready(function(){
		$('#online_pay_button').click(function(){
			onlinePay();
		})
	
		$('#account_pay_button').click(function(){
			accountPay();
		})
	
		showOnlinePay();
	
	});
	
	
	function showOnlinePay() {
		$('#account_pay_li').removeClass('myModa_header_box_login_li_now');
		$('#online_pay_li').addClass('myModa_header_box_login_li_now');
		$('#account_pay_form').hide();
		$('#online_pay_form').show();
	}
	
	function showAccountPay() {
		$('#online_pay_li').removeClass('myModa_header_box_login_li_now');
		$('#account_pay_li').addClass('myModa_header_box_login_li_now');
		$('#online_pay_form').hide();
		$('#account_pay_form').show();
	}
	
	</script>
	
<div class="modal fade" id="modal_pay">
    <div class="modal-dialog modal-small">
        <div class="modal-content modal-content_index">
            <div class="modal-header modal-header_index">
                <button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <ul class="myModa_header_box_login_ul">
                    <li id="online_pay_li" class="myModa_header_box_login_li myModa_header_box_login_li_now" style="width:80px" onclick="showOnlinePay();">在线支付</li>
                    <li id="account_pay_li" class="myModa_header_box_login_li" style="width:80px"  onclick="showAccountPay();">账户划款</li>
                </ul>
                <p class="clear-both"></p>
                
                <form autocomplete="off" name="online_pay_form" id="online_pay_form">
                    <input type="hidden" name="recordId" id="recordId" value="" />	
                    <table border="0px" class="myModa_header_box_login_form_table">
                        
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:80px" >项目名称:</span>
                            	<input type="text" id="projectName" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly"/>
                            </div>
                            <p class="clear-both"></p>
                        </div>
                        
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:80px">认购份数:</span>
                            	<input type="text" id="nums" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly"/>
                            </div>
                            <p class="clear-both"></p>
                        </div>

                       <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:80px">支付金额:</span>
                            	<input type="text" id="totalAmount" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly" />
                            </div>
                            <p class="clear-both"></p>
                          
                        </div>
                        
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:80px">选择支付卡:</span>
             					<select name="cardId" id="cardId" style="width:265px;height: 35px;margin-left: 5px">
									<c:forEach items="${bankcards}" var="bankcard">
									<option value=''>------请选择------</option>
									<option value="${bankcard.cardId }">${bankcard.cardTop }******${bankcard.cardLast }</option>
									</c:forEach>
								</select>                   
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="carIdTip"></div></div> 
                        </div>
                        
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:80px">验证码:</span>
                                 <input type="text" name="mobilecode" style="  width: 170px; float: left; margin-left: 5px;" class="fr myModa_header_box_login_form_input" id="mobilecode" />
                                <input type="button" class="myModa_header_box_form_gettelcode" id="myModa_header_box_register_yzm_btn" data-toggle="modal" data-backdrop="static" onclick="sendMobileCodeByOnlinePay(this);" value="获取验证码" />
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="smscodeTip"></div></div>
                        </div>                     
                        <input type="button"  id="online_pay_button" class="btn-ju myModa_header_box_login_form_btn" value="确认支付"/>
                    </table>
                    <br />
                </form>
                
                <form autocomplete="off" name="account_pay_form" id="account_pay_form">
                   <input type="hidden" id="recordId" name="recordId" value="" />	
                    <table border="0px" class="myModa_header_box_login_form_table">
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:60px">项目名称:</span>
                            	<input type="text" id="projectName" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly"/>
                            </div>
                            <p class="clear-both"></p>
                        </div>
                        
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:60px">认购份数:</span>
                            	<input type="text" id="nums" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly"/>
                            </div>
                            <p class="clear-both"></p>
                        </div>

                       <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:60px">支付金额:</span>
                            	<input type="text" id="totalAmount" class="fr input_text input_text myModa_header_box_login_form_input" value="" readonly="readonly" />
                            </div>
                            <p class="clear-both"></p>
                          
                        </div>

                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span" style="width:60px">验证码:</span>
                                
                                <input type="text" style="width: 170px; float: left; margin-left: 25px;" class="fr myModa_header_box_login_form_input" id="verifycode" />
	                           
	                           <div class="fl yanzheng_img">
									<img id="imagecode" src="<%=contextPath %>/portal/common/verifycode.jsp" style="height:34px;width:76px;" />
								</div>
								
								<div class="fr">
									<a href="javascript:void(0);" onclick="refreshVerifyCode();" class="yanzheng_a left">看不清<br>换一张
									</a>
								</div>      
                                
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="verfiycodeTip"></div></div>
                        </div>   
                        <input type="button" id="account_pay_button" class="btn-ju myModa_header_box_login_form_btn" value="确认支付"/>
                    </table>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

