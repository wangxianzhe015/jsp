<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
<style>
    .modal-header_index{
        height: 16px;
        padding-top: 8px;
        padding-bottom: 0px;
        border-bottom: none;
    }
    .modal-content_index{
        background: #fff url(<%=resourcePath%>/images/header_box_modal_bg.jpg) no-repeat left top ;
        width: 600px;
        left: 50%;
        margin-left: -300px;
    }
    .myModa_header_box_gettelcode_form_btn,.myModa_header_box_form_gettelcode{ background:#ff6633; color:#fff; cursor:pointer;} 
</style>
<!------登陆模态框 -->
<div class="modal fade" id="myModa_header_box_login">
    <div class="modal-dialog modal-small">
        <div class="modal-content modal-content_index">
            <div class="modal-header modal-header_index">
                <button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <ul class="myModa_header_box_login_ul">
                    <li id="myModa_header_box_login_li" class="myModa_header_box_login_li myModa_header_box_login_li_now" onclick="showLogin();">登录</li>
                    <li id="myModa_header_box_register_li" class="myModa_header_box_login_li" onclick="showRegister();">注册</li>
                </ul>
                <p class="clear-both"></p>
                <form autocomplete="off" action="" method="post" name="myModa_header_box_login_form" id="myModa_header_box_login_form">
                    <table border="0px" class="myModa_header_box_login_form_table">
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span">手机号:</span>
                                <!--<input type="text" name="username"  class="fr myModa_header_box_login_form_input" id="myModa_header_box_login_form_usename" placeholder="请输入登录名/手机号/邮箱" />  -->
                            	<input type="text" class="fr input_text input_text myModa_header_box_login_form_input" id="myModa_header_box_login_form_usename" />
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_login_form_usenameTip"></div></div>
                        </div>


                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span">密码:</span>
                                <input type="password" name="password" class="fr myModa_header_box_login_form_input" id="myModa_header_box_login_form_password" />
                                <!--<input type="text" class="fr input_text myModa_header_box_login_form_input" id="myModa_header_box_login_form_password_two" value="请输入密码" />
                      			<input type="password" class="fr input_text myModa_header_box_login_form_input" id="myModa_header_box_login_form_password" style="display:none; color:#000;"/>-->
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_login_form_passwordTip"></div></div> 
                        </div>
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <input checked="checked" class="fl myModa_header_box_login_form_div_checkbox" id="remembername" value="1" name="remembername" type="checkbox"/>
                                <p class="fl">记住用户名</p>
                                <a href="<%=servletPath %>/portal/registry/findPassword.action" class="fr">忘记密码?</a>
                            </div>
                            <p class="clear-both"></p>
                        </div>
                        <input type="hidden" name="btn_submit" value="login" />
                        <input type="hidden" name="captcha" value="1" />
                        <input type="reset" name="reset" style="display: none;" />
                        <button type="submit" id="login_button" class="btn-ju myModa_header_box_login_form_btn">登录</button>
                    </table>
                    <br />
                </form>
                <form autocomplete="off"  action="<%=servletPath %>/portal/registry/add.action" method="post" name="myModa_header_box_login_form" id="myModa_header_box_register_form">
                    <table border="0px" class="myModa_header_box_login_form_table">
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span">手机号:</span>
                                <!-- <input type="text" name="mobile" class="fr myModa_header_box_login_form_input" id="myModa_header_box_register_form_mobile" placeholder="请输入手机号" />  -->
                             	<input type="text" class="fr input_text input_text myModa_header_box_login_form_input" name="mobile" id="myModa_header_box_register_form_mobile" />
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_register_form_mobileTip"></div></div>
                        </div>
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span">验证码:</span>
                                 <input type="text" name="mobilecode" style="  width: 170px; float: left; margin-left: 35px;" class="fr myModa_header_box_login_form_input" id="myModa_header_box_register_form_telcode" />
                                <!--<input type="text" style="  width: 170px; float: left; margin-left: 25px;" class="fr input_text input_text myModa_header_box_login_form_input" id="myModa_header_box_register_form_telcode" value="请输入验证码" />-->
                                <input type="button" class="myModa_header_box_form_gettelcode" name="verifyCode" id="myModa_header_box_register_yzm_btn" data-toggle="modal" data-backdrop="static" onclick="common_showMobileSend();" value="获取验证码" />
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_register_form_telcodeTip"></div></div>
                        </div>


                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <span class="fl myModa_header_box_login_form_div_top_span">密码:</span>
                                  <input type="password" name="password" class="fr myModa_header_box_login_form_input" id="myModa_header_box_register_form_password" />
                            	<!--<input type="text" class="fr myModa_header_box_login_form_input" id="myModa_header_box_register_form_password_two" value="请输入密码"  />
                      			<input type="password" class="fr myModa_header_box_login_form_input" id="myModa_header_box_register_form_password" style="display:none; color:#000;"/>-->
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_register_form_passwordTip"></div></div>
                        </div>
                        <div class="myModa_header_box_login_form_div" style="width: 370px;">
                            <div class="myModa_header_box_login_form_div_top" style="width: 370px;">
                                <input class="fl myModa_header_box_login_form_div_checkbox" name="xieyi" id="myModa_header_box_register_form_xieyi_input_value" value="1" type="checkbox" checked />
                                <p class="fl">我已阅读并同意<br/>
                                	<a href="#" class="myModa_header_box_register_form_xieyi" data-toggle="modal" data-backdrop="static" data-target="#myModa_header_box_register_form_xieyi">《众投客网站注册协议书》</a><br/>
                                    <a href="#" class="myModa_header_box_register_form_xieyi" data-toggle="modal" data-backdrop="static" data-target="#myModa_risk_agreement">《众投客投资风险提示书》</a>
                                </p>
                            </div>
                            <p class="clear-both"></p>
                            <div class="myModa_header_box_login_form_div_bottom"><div id="myModa_header_box_register_form_xieyiTip"></div></div>
                        </div>
                        <input type="hidden" name="btn_submit" value="register" />
                        <button type="submit" id="register_button" class="btn-ju myModa_header_box_login_form_btn">注册</button>
                        <div class="myModa_header_box_login_form_div">
                            <div class="myModa_header_box_login_form_div_top">
                                <p class="fl" style=" margin-left: 115px;">已有账号</p>
                                <a href="javascript:void(0);" class="fr" onclick="showLogin();" style=" margin-right: 45px;color: #0066cc; text-decoration: underline;">立即登录?</a>
                            </div>
                            <p class="clear-both"></p>
                        </div>
                    </table>
                </form>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!--协议模态框 -->
<%@include file="./agreement.jsp" %>
<%@include file="./risk_agreement.jsp" %>
<!--验证码态框 -->
<%@include file="./mobilecode.jsp" %>

<script type="text/javascript">
var login_url=null; //初始化登录后跳转的连接

/**
 * 弹出发送验证码框前检查手机号是否合法
 * @returns {boolean}
 */
function common_showMobileSend() {
	var mobile = $('#myModa_header_box_register_form_mobile').val();
	if(!/^1\d{10}$/.test(mobile)) {
		popBox('请填写正确的手机号码','error')
		return false;
	}
	$('#myModa_header_box_form_gettelcode').modal('show');
}


/**
 * 发送手机验证码
 * @param obj 发送验证码按钮jq对象用于锁定按钮
 * @returns {boolean}
 */
function common_sendMobileCode(obj, msg_type) {
	var mobile = $('#myModa_header_box_register_form_mobile').val();
	var code  = $('#myModa_header_box_gettelcode_form_code').val();
	msg_type = msg_type ? msg_type : 'txt';
	//var obj = $(obj);
	if(!/^1\d{10}$/.test(mobile)) {popBox('请填写正确的手机号码','info');return false;}
	if(!$.trim(code)){popBox('请填写验证码','info');return false;}
	$.ajax({
		url:"<%=servletPath%>/portal/registry/sendMobileCode.action",
		data:{mobile:mobile,verfiyCode:code,msg_type:msg_type},
		dataType:'json',
		success:function(data) {
			if(data.code==1) {
				$('#myModa_header_box_form_gettelcode').modal('hide');
				popBox('验证码已发送到您填写的手机上','success',2);
				obj.attr('disabled', 'disabled');
				var time = 60;
				var settime = setInterval(function () {
					time--;obj.val(time + '后重新发送');
					if (time <= 0) {clearInterval(settime);obj.removeAttr('disabled');obj.val('重新发送'); }
				}, 1000);
			} else if(data.code!=-5) {
				$('#myModa_header_box_form_gettelcode').modal('hide');
				popBox(data.message,'error');
			} else {
				popBox(data.message,'error');
			}
			common_updateCode();
			return false;
		}
	})
}

/**
 * 刷新发送手机验证码
 */
function common_updateCode() {
	document.getElementById('mobile_fresh_valicode').src="<%=contextPath%>/portal/common/verifycode.jsp?t="+ Math.random();
}

$(document).ready(function(){
	/**
	 * 注册
	 */
	$.formValidator.initConfig({formid:"myModa_header_box_register_form",validatorgroup:"99",onerror:function(msg){/*popBox(msg,'error');*/return false;},onsuccess:function(){
		if(!$("input[type='checkbox'][id='myModa_header_box_register_form_xieyi_input_value']").is(':checked')) {
			//popBox('请选择注册协议后再提交','info');return false;
		}
		$('#register_button').attr('disabled', 'disabled');
		$.post("<%=servletPath%>/portal/registry/ajaxAdd.action",{mobile:$('#myModa_header_box_register_form_mobile').val(),mobilecode:$('#myModa_header_box_register_form_telcode').val(),password:$('#myModa_header_box_register_form_password').val(),xieyi:$('#myModa_header_box_register_form_xieyi_input_value').val(),btn_submit:'register'},function(data){
			if(data.code==1) {
				//执行回调地址
				$("body").append(data.data);
				popBox(data.message,'success',2);
				setTimeout(function(){window.location.reload();},2000)
			} else {
				$('#register_button').removeAttr('disabled');
				popBox(data.message,'error');
			}
		})
		return false;
	}});
	$("#myModa_header_box_register_form_mobile").formValidator({validatorgroup:"99",onshow:"请输正确的11位手机号码",onfocus:"请输入正确的手机号码",oncorrect:"该手机号可以注册"})
		.inputValidator({min:11,max:11,onerror:"你输入的手机号非法,请确认"})
		.functionValidator({
			fun:function(val, obj){
				var res = /^1\d{10}$/.test(val);
				if(res==false) {
					return false;
				}
				return true;
			},
			onerror : "手机号码格式不正确"
		})
		.ajaxValidator({
			type : "get",
			url : "<%=servletPath%>/portal/registry/checkMobile.action?",
			datatype : "json",
			success : function(data){
				if( data.code == -1 ) {
					return true;
				} else {
					return false;
				}
			},
			buttons: $("#button"),
			error: function(){ popBox('服务器没有返回数据，可能服务器忙，请重试','error');},
			onerror : "手机号码格式不正确或手机号已存在",
			onwait : "正在对手机号进行合法性校验，请稍候..."
		});
	$("#myModa_header_box_register_form_telcode").formValidator({validatorgroup:"99",onshow:"请输入手机验证码",onfocus:"手机验证码不能为空",oncorrect:" "}).inputValidator({min:1,empty:{leftempty:false,rightempty:false,emptyerror:"手机验证码不能有空符号"},onerror:"手机验证码不能为空,请确认"});
	$("#myModa_header_box_register_form_password").formValidator({validatorgroup:"99",onshow:"请输入密码",onfocus:"密码不能为空",oncorrect:" "}).inputValidator({min:6,empty:{leftempty:false,rightempty:false,emptyerror:"密码两边不能有空符号"},onerror:"密码不能为空,请确认"});
	
	/** * 登陆 */
	$.formValidator.initConfig({formid:"myModa_header_box_login_form",validatorgroup:"98",onerror:function(msg){},onsuccess:function(){
		var remembername = 0;
		if($("input[type='checkbox'][name='remembername']").is(':checked')) {
			remembername = 1;
		}
		$('#login_button').attr('disabled', 'disabled');
		$.post('<%=servletPath%>/portal/login/ajaxLogin.action',{mobile:$('#myModa_header_box_login_form_usename').val(),password:$('#myModa_header_box_login_form_password').val(),btn_submit:'login',remembername:remembername},function(data){
			if(data.code==1) {
				function successJump() {
					if(login_url) {
						setTimeout(function(){window.location.href=login_url;},2000)
					} else {
						setTimeout(function(){window.location.reload();},2000)
					}
                }
				popBox(data.message,'success',2);successJump();
			} else if(data.code=='-5') {
				$('#login_button').removeAttr('disabled', 'disabled');
				popBox(data.message,'info');
			}else {
				$('#login_button').removeAttr('disabled', 'disabled');
				popBox(data.message,'error');
			}
		})
		return false;
	}});
	$("#myModa_header_box_login_form_usename").formValidator({validatorgroup:"98",onshow:"请输入用户名或者手机号码",onfocus:"请输入正确的用户名或手机号码",oncorrect:" "})
		.inputValidator({min:6,empty:{leftempty:false,rightempty:false,emptyerror:"用户名两边不能有空符号"},onerrormin:'用户名长度最少6位',onerror:"用户名不能为空,请确认"})
		.functionValidator({
			fun:function(val,obj){
				var reg = /^1[0-9]d{9}$/; //手机
				var reg2 = /^[a-zA-Z0-9]{6,30}$/; //用户名
				var reg3  = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/; //邮箱
				if(val[0]==0 || (!reg.test($.trim(val)) && !reg2.test($.trim(val)) && !reg3.test($.trim(val))) ) {
					return false;
				}
				return true;
			},
			onerror : "请输入正确的用户名或手机号码"
		});
	$("#myModa_header_box_login_form_password").formValidator({validatorgroup:"98",onshow:"请输入密码",onfocus:"密码不能为空",oncorrect:" "}).inputValidator({min:6,empty:{leftempty:false,rightempty:false,emptyerror:"密码两边不能有空符号"},onerrormin:'密码最少6位',onerror:"密码不能为空,请确认"});

	/**
	 * 显示登录
	 */
    $('.ajax_login').unbind("click");
	$('.ajax_login').live("click", function(){
		var url = $(this).attr('href'); //获取点击的链接
		if(url) {
			login_url = url;
		}
		common_show_user();
		return false;
	});
	/**
	 * 登录事件
	 */
	$('#login_button').click(function(){
		return jQuery.formValidator.pageIsValid(98);
	})
	/**
	 * 注册事件
	 */
	$('#register_button').click(function(){
		return jQuery.formValidator.pageIsValid(99);
	})
});

/**
 * 显示登陆隐藏注册
 */
function showLogin() {
	$('#myModa_header_box_register_li').removeClass('myModa_header_box_login_li_now');
	$('#myModa_header_box_login_li').addClass('myModa_header_box_login_li_now');
	$('#myModa_header_box_register_form').hide();
	$('#myModa_header_box_login_form').show();
}
/**
 * 显示注册隐藏登陆
 */
function showRegister() {
	$('#myModa_header_box_login_li').removeClass('myModa_header_box_login_li_now');
	$('#myModa_header_box_register_li').addClass('myModa_header_box_login_li_now');
	$('#myModa_header_box_login_form').hide();
	$('#myModa_header_box_register_form').show();
}

/**
 * 显示登录/注册框
 * @params type 显示类型(login|register)
 * @params url 登录后台跳转的链接
 */
function common_show_user(type, url) {
	type = type ? type : 'login';
	url = url ? url : '';
	if(url) {
		setCookie('loginsuccjump_url', url, 1);
	}
	if(type=='register') {
	   showRegister();
	} else {
	   showLogin();
	}
	$('#myModa_header_box_login').modal({
		backdrop: 'static'
	})
	$('#myModa_header_box_login').modal('show');
}

/**
 * 提交分组表单
 * 分组ID
 */
function on_submit(groupid) {
	return jQuery.formValidator.pageIsValid(groupid);
}
</script>
