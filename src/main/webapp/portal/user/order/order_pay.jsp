<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../../common/common.jsp"%>
    <link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/order-confirm.css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/order-pay.css" />
    <script type="text/javascript" src="<%=resourcePath%>/js/common/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="<%=resourcePath%>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath%>/js/common/bootstrap.min.js"></script>
	
    <script>
	function refreshVerifyCode() {
		document.getElementById('imagecode').src="<%=contextPath%>/portal/common/verifycode.jsp?t="+ Math.random();
	}
	
	function listBankcards(){
		$.post("<%=servletPath%>/portal/order/listBankcards.action","",function(data){  
			var bankcards=data.bankcards;
			if(bankcards!=null && bankcards!="undefined"){
				var html="";
				$.each(bankcards, function(i, v) {
					html += '<option value="' + v.cardId+ '">' +v.cardTop+'******'+v.cardLast + '</option>';
				});
				$("#cardId").empty().html(html);
			}
		},"json");		
	}
	
	var requestid="";
    $(document).ready(function(){

    	$(".ui-show-detail").click(function(){
    		  $(".ui-order-detail-info").toggle(100);
   		});

    	$("#bankcardPayRadio").click(function(){
    		if($("#cardId").find("option").length>0){
    			$("#paycard_form").show();
    			$("#bindcard_form").hide();	
    		}else{
    			$("#bindcard_form").show();	
    			$("#paycard_form").hide();
    		}
    		$("#payaccount_form").hide();
    	});
    	
    	$("#accountPayRadio").click(function(){
    		$("#payaccount_form").show();
    		$('#bindcard_form').hide();	
    		$("#paycard_form").hide();
    	});  
    	
    	//银行卡支付手机验证码
    	$("#sendPayMobileCode").click(function(){
    		var orderId=$("#paycardForm input[id='orderId']").val();
    		var cardId=$("#cardId").val();
    		if(cardId==""){popBox("请选择银行卡","info");return false;}
    		var obj=$("#sendPayMobileCode");
    		
    		$.ajax({
    			url:"<%=servletPath%>/portal/order/sendMobileCode.action",
    			data:{"orderId":orderId,"cardId":cardId},
    			dataType:'json',
    			success:function(data) {
    				if(data.code==1) {
    					popBox('验证码已发送到您填写的手机上','success',2);
    					obj.unbind('click');
    					var time = 60;
    					var settime = setInterval(function () {
    						time--;obj.text(time + '后重新发送');
    						if (time <= 0) {clearInterval(settime);obj.bind('click');obj.text('重新发送'); }
    					}, 1000);
    				} else {
    					popBox(data.message,'error');
    				}
    				return false;
    			}
    		})   		
    	});
    	
    	//绑定银行卡手机验证码
    	$("#sendBindMobileCode").click(function(){
    		if($("#cardUserName").val()==""){popBox("请输入持卡人姓名","info");return false;}
    		if($("#cardIdentityId").val()==""){popBox("请输入持卡人身份证号码","info");return false;}
    		if($("#cardNo").val()==""){popBox("请输入卡号","info");return false;}
    		if($("#cardPhone").val()==""){popBox("请输入银行预留手机号","info");return false;}
    		
    		var obj=$("#sendBindMobileCode");
    		var info = $("#bindcardForm").serialize();
    		$.post("<%=servletPath%>/portal/pay/bindBankcard.action",info,function(data){  
    			if(data.code==1){
    				popBox(data.message,'success');
    				requestid=data.requestid;
    				var time = 60;
    				obj.unbind("click");
    				var settime = setInterval(function () {
    					time--;obj.text(time + '后重新发送');
    					if (time <= 0) {clearInterval(settime);obj.bind("click");obj.text('重新发送'); }
    				}, 1000);
    			}else{
    				popBox(data.message,'error');	
    			}
    		},"json"); 
    	})
    	
    	//绑定银行卡
    	$("#bindBankcard").click(function(){
    		var smscode=$("#bindMobilecode").val();
    		var identityid=$("#cardIdentityId").val();
    		var userName=$("#cardUserName").val();
    		if(smscode==""){popBox("请输入短信验证码","info");return false;}
    		if(identityid==""){popBox("请输入持卡人身份证号码","info");return false;}
    		if(userName==""){popBox("请输入持卡人姓名","info");return false;}
    		if(requestid==""){popBox("当前请求无效","error");return false;}
    		
    		$.post("<%=servletPath%>/portal/pay/confirmBindBankcard.action",
    				{'userName':userName,'identityid':identityid,'requestid':requestid,'verifycode':smscode},
    				function(data){  
    			if(data.code==1){
    				popBox(data.message,'success');	
    				listBankcards();
        			$("#paycard_form").show();
        			$("#bindcard_form").hide();	
        			$("#payaccount_form").hide();
    			}else{
    				popBox(data.message,'error');	
    			}
    		},"json");	    			
    	});
    	
    	$("#bankcardPay").click(function(){
			var recordid=$("#paycardForm input[id='orderId']").val();
			var mobilecode=$("#paycardForm input[id='mobilecode']").val();
			if(mobilecode==null||mobilecode==""){
				popBox("请输入验证码",'info');
				return ;
			}

		    $("#paycardForm").submit();   		
    	});
 
    	$("#accountPay").click(function(){
    		var accountBalance=$("#payaccountForm input[id='accountBalance']").val();
			var totalAmount=$("#payaccountForm input[id='totalAmount']").val();
			if(parseFloat(totalAmount)>parseFloat(accountBalance)){
				popBox('当前账户余额不足，请去充值或选择银行卡支付','info');
				return false;
			}
			var verifycode=$("#verifycode").val();
			if(verifycode==null || verifycode==""){
				popBox("请输入验证码",'info');
				return ;
			}
			$("#payaccountForm").submit();	
    	});
    	
    	$("#bankcardPayRadio").click();

    	
    });    
    </script>
</head>
<%@include file="../../common/uc_header.jsp"%>
<body class="page-header">
	<div class="clearfix mt20">
		<div class="z_container">
			<div class="order_process">
				<ul>
					<li>协议确认 
					     <span class="order_behind_arrow order_arrow"></span>
						<span class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>订单确认 <span
						class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
					<li class="active">支付 <span class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
					<li>完成 <span class="order_behind_arrow order_arrow"></span> <span
						class="order_ahead_arrow order_arrow"></span>
					</li>
				</ul>
			</div>
			
			<div class="main grid-1000">
			 <!-- 支付情况下显示 -->
			    <ul class="ui-order-info fn-clear mt20">
			        <li>
			            <div class="ft-14 fb" style="width:750px">众投客<span class="ft-16 mlr5">|</span>${order.project.projectName }</div>
			        </li>
			        <li>
			            <div class="ft-12"><span class="ft-red ft-18 fm-yahei fb mr10" id="spending">${order.totalAmount }</span>元</div>
			        </li>
			    </ul>
			    <div class="ui-order-detail fn-clear"><div class="ui-show-detail fn-right ft-gray ft-12">订单详情<i class="ml5 icon-ddxqp"></i></div></div>
			    <ul class="ui-order-detail-info fn-clear ft-12" style="display: none;">
			        <li><strong>商品名称：</strong>${order.project.projectName }</li>
			        <li><strong>商户名称：</strong><span>福建众投客网络科技有限公司</span></li>
			        <li><strong>商户订单号：</strong><span>${order.orderId }</span></li>
			        <li><strong>订单金额：</strong><span>${order.totalAmount }元</span></li>
			        <li><strong>购买时间：</strong><span>${order.createTime }</span></li>
			    </ul>
			
			
			
			<div class="ui-account p20">
			    <ul class="payment-types">
			        
			        <li class="fn-clear other-pay  bank-radio on">
			            <div class="fn-left">
			                <input type="radio" name="paytype" id="bankcardPayRadio" checked="checked">
			                <span class="ft-12 ml10">银行卡在线支付</span>
		                	<input type="radio" name="paytype" id="accountPayRadio">
			                <span class="ft-12 ml10">账户快捷支付</span>			                
			            </div>
			            
			            <div class="fn-right payments-dom">
			            </div>
			        </li>
			    </ul>
			</div>
			
			<div class="ui-other-payWay pb20" style="">
			
			<!-- 绑定银行卡表单 -->
			<div class="savingsCard-form" id="bindcard_form" style="display: none">
			    <div class="tip-message">
			    	   请先绑定银行卡
			    </div>			
			    <div class="fastPayList" >
			        <form method="post" id="bindcardForm">
			            <div class="ui-fm-item" data-see="name">
			                <label class="ui-fm-label mt5">姓名：</label>
			                <div>
			                     <input type="text" id="cardUserName" name="card.userName" class="ui-input  J-fm-name">                        
			                </div>
			            </div>
			            <div class="ui-fm-item">
			                <label class="ui-fm-label mt5">证件：</label>
			                <div class="ui-fm-select-group">
			                    <select class="ui-fm-select J-fm-identityType" name="holder_id_type">
			                        <option value="ID">身份证</option>
			                    </select>
			                    <input type="text"  id="cardIdentityId" name="card.identityid" class="ui-input ml20 J-fm-identity">      
			                </div>
			            </div>
			            <div class="ui-fm-item" data-see="bankCard">
			                <label class="ui-fm-label mt5">卡号：</label>
			                <div>
			                    <input type="text" id="cardNo" name="card.cardNo" class="ui-input J-fm-creditCard J_numberScaleClone">
			                </div>
			            </div>
			            <div class="ui-fm-item" data-see="phoneNo">
			                <label class="ui-fm-label mt5">银行预留手机号：</label>
			                <div>
			                    <input type="text" id="cardPhone" name="card.phone" class="ui-input J-fm-phone">
			                </div>
			            </div>
			            <div class="ui-fm-item ui-fm-special">
			                <label class="ui-fm-label mt5">短信验证码：</label>
			                <input type="text" name="bindMobilecode" id="bindMobilecode" class="ui-input pl10 J-fm-note">
			                <span id="sendBindMobileCode" class="ui-button-lwhite ml20 J-fm-getNote">点击获取验证码</span><br>
			            </div>
			            <div class="ui-fm-item">
			                <label class="ui-fm-label"></label>
			                <div class="ft-12 ft-gray">短信验证码15分钟内有效，若已失效或未收到验证码，请重新点击获取</div>
			            </div>
			
			            <div class="ui-fm-item">
			                <label class="ui-fm-label"> </label>
			                <div>
			                    <span class="ui-button-lred" id="bindBankcard">绑定银行卡</span>
			                </div>
			            </div>
			        </form>
			    </div>
			
			
			</div>

			<!-- 银行卡支付表单 -->
			<div class="savingsCard-form" id="paycard_form" style="display: none">
			    <div class="fastPayList" >

			        <form action="<%=servletPath%>/portal/order/bankcardPay.action" id="paycardForm" method="post">
			            <input type="hidden" id="orderId" name="orderId" value="${order.orderId }">

			            <div class="ui-fm-item" data-see="idCardNo">
			                <label class="ui-fm-label mt5">选择支付卡：</label>
			                <div class="ui-fm-select-group">
			                    <select class="ui-fm-select J-fm-identityType" style="width:400px" name="cardId" id="cardId">
									<c:forEach items="${bankcards}" var="bankcard">
									<option value="${bankcard.cardId }">${bankcard.cardTop }******${bankcard.cardLast }</option>
									</c:forEach>
								</select>       
			                </div>
			            </div>
			            <div class="ui-fm-item" data-see="bankCard">
			                <label class="ui-fm-label mt5">支付金额：</label>
			                <div>
			                    <input type="text" id="totalAmount" name="totalAmount" readonly="readonly" value="${order.totalAmount }"  class="ui-input J-fm-creditCard J_numberScaleClone">
			                </div>
			            </div>			            
			            <div class="ui-fm-item ui-fm-special">
			                <label class="ui-fm-label mt5">短信验证码：</label>
			                <input type="text" id="mobilecode" name="mobilecode" class="ui-input pl10 J-fm-note">
			                <span id="sendPayMobileCode" class="ui-button-lwhite ml20 J-fm-getNote">点击获取验证码</span><br>
			            </div>
			            <div class="ui-fm-item">
			                <label class="ui-fm-label"></label>
			                <div class="ft-12 ft-gray">短信验证码15分钟内有效，若已失效或未收到验证码，请重新点击获取</div>
			            </div>
			
			            <div class="ui-fm-item">
			                <label class="ui-fm-label"> </label>
			                <div>
			                    <span class="ui-button-lred J-formSubmit" id="bankcardPay">确认付款</span>
			                </div>
			            </div>
			        </form>
			    </div>
			</div>		
			
			
			<!-- 账户划款支付表单 -->
			<div class="savingsCard-form" id="payaccount_form" name="payaccount_form" style="display: none">
			    <div class="fastPayList" >
			    	<c:choose>
			    		<c:when test="${empty user.accountInfo.availableAmount ||  user.accountInfo.availableAmount<=0}">
			    		    <div class="ui-fm-item" style="margin-left: 40px;color: red">
			    				您当前账户可用余额为<b>0</b>元，请<a href="<%=servletPath%>/portal/uc/accountInfo.action"><b>去充值></b> </a>
			    			</div>
			    		</c:when>
			    		<c:otherwise>
					        <form action="<%=servletPath%>/portal/order/accountPay.action" method="post" id="payaccountForm">
					            <input type="hidden" id="orderId" name="orderId" value="${order.orderId }">
					            
					            <div class="ui-fm-item" data-see="bankCard">
					                <label class="ui-fm-label mt5">账户余额：</label>
					                <div>
					                    <input type="text" id="accountBalance" name="account_balance" readonly="readonly" value="${user.accountInfo.availableAmount}" class="ui-input J-fm-creditCard J_numberScaleClone">
					                </div>
					            </div>			           
					            <div class="ui-fm-item" data-see="bankCard">
					                <label class="ui-fm-label mt5">支付金额：</label>
					                <div>
					                    <input type="text" id="totalAmount" name="totalAmount" readonly="readonly" value="${order.totalAmount }"  class="ui-input J-fm-creditCard J_numberScaleClone">
					                </div>
					            </div>
					            <div class="ui-fm-item ui-fm-special">
					                <label class="ui-fm-label mt5">验证码：</label>
					                   <input type="text" id="verifycode" name="verifycode" class="ui-input pl10 J-fm-note">
			                           <span>
											<img id="imagecode" src="<%=contextPath %>/portal/common/verifycode.jsp" style="height:34px;width:76px;" />
										</span>
										<span>
											<a href="javascript:void(0);" onclick="refreshVerifyCode();" class="yanzheng_a left">看不清<br>换一张</a>
										</span>  
					            </div>
					
					            <div class="ui-fm-item">
					                <label class="ui-fm-label"> </label>
					                <div>
					                    <span class="ui-button-lred J-formSubmit" id="accountPay">确认付款</span>
					                </div>
					            </div>
					        </form>			    		
			    		</c:otherwise>
			    	</c:choose>

			    </div>
			</div>
							
			</div>
			</div>
		</div>
	</div>

<%@include file="../../common/footer.jsp"%>
</body>
</html>