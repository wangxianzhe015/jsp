<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="账户资金"></c:set>
<%@include file="../common/meta.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript"
	src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript"
	src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript"
	src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
<style type="text/css">
.cardUl li {
	    display: inline;
	    cursor: pointer;
	    color: #a5a5a5;
	    overflow: hidden;
	    position: relative;
}

.cardUl li .icon_add {
	background: url(<%=resourcePath%>/images/add.jpg) no-repeat 0px 0px;
	    line-height: 26px;
	    display: inline-block;
	    padding: 0 0 0 30px;
	    margin-top: 40px;
}

.space-30 {
	height: 30px;
	overflow: hidden;
}

.remindBox {
	float: left;
	display: block;
	width: 700px;
	padding-top: 80px;
	padding-left: 30px;
}

.remindTitle {
	font-size: 16px;
	font-weight: bold;
}

.remindTip {
	line-height: 25px;
}

.accountName {
	font-size: 20px;
	margin-top: 30px;
}

.loginTime {
	font-size: 14px;
	color: #999999;
}

.inforBox {
	width: 910px;
	margin-left: 20px;
}

.Box01 {
	width: 130px;
	background-color: #f0f0f0;
	font-size: 18px;
	text-align: center;
	float: left;
}

.Box02 {
	width: 30px;
	background-color: #f0f0f0;
	font-size: 20px;
	text-align: center;
	float: left;
	padding: 20px;
	font-weight: bold;
}

.Box03 {
	width: 130px;
	background-color: #ffffff;
	border-top: 3px solid #Ff6666;
	font-size: 18px;
	text-align: center;
	float: left;
	color: #ff6666;
	cursor: pointer;
}

.Box04 {
	width: 130px;
	background-color: #ffffff;
	border-top: 3px solid #Ff6666;
	font-size: 18px;
	text-align: center;
	float: left;
	color: #ff6666;
	cursor: pointer;
}

.Box05 {
	width: 670px;
	background-image: url(<%=resourcePath%>/images/fr.png);
	background-repeat: no-repeat;
	background-position: center;
	font-size: 16px;
	float: left;
	color: #ff6666;
	cursor: pointer;
	padding: 10px 62px;
	display: none;
	margin-left: 20px;
	margin-top: 0px;
}

.money01 {
	float: left;
	text-align: center;
	padding: 0 50px;
	margin-top: 15px;
}

.money02 {
	float: left;
	margin-top: 15px;
	font-weight: bold;
}
</style>
</head>
<body>

	<%@include file="../common/uc_header.jsp"%>
	<script>
function sub(e)
{
	var id = e;
	if($("#amount_"+id).val() >= 1)
	{
		$(this).attr('disabled','true');
		$("#form_"+id).submit();
	}else
	{
		popBox('金额必须大于1元','error');
		return false;
	}
}
</script>

	<div class="wrap clear">
		<div class="row mt-20">
			<div class="col-7 mr-10">
				<%@include file="./uc_menu.jsp"%>
			</div>

			<div class="col-23 bg_white">
				<div class="clear  user_tit_box">
					<div class="fl user_tit font-wet">账户资金</div>
				</div>
				<div style="height:40px; background:#f8f8f8;"></div>

				<div class="border-c accountrecharge_cont">
					<dl class="fl accountrecharge_cont_dl">
						<dt class="fl ml-20 accountrecharge_cont_dt">
							<img class="userPic" style="margin-top:50px;" src="">
							<p class="f16 font-wet"></p>
						</dt>
						<dd class="fr mr-20 ml-20 accountrecharge_cont_dd"
							style="overflow:hidden;">
							<p class="accountName">
								账户名 <span class="loginTime">上次登陆时间：2015-10-28 15:45</span>
							</p>
							<div class="col-23 bg_white">
								<div class="clear  user_tit_box">
									<div class="fl user_tit">银行卡绑定:</div>
								</div>
								<div>
									<ul class="cardUl" id="cardList">

										<li style="margin-left:20px;"><a id="cardinfo" data-cardid="301"> <span>622848******7079</span>
										</a></li>

									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<!--以上是银行卡信息-->


							<br />
							<br />


						</dd>

						<div class="inforBox">
							<div class="Box01">
								账户总资产<br />0.00元
							</div>
							<div class="Box02">=</div>
							<div class="Box03">
								累计投资<br />0.00元
							</div>
							<div class="Box02">+</div>
							<div class="Box04">
								可用金额<br />0.00元
							</div>
							<div class="Box06" style="background-color:#f0f0f0; float:left;">
								<button class="fr btn-ju-bdr f18 accountrecharge_cont_btn"
									data-toggle="modal" data-backdrop="static"
									data-target="#myModa_recharge">充值</button>
								<button class="fr btn-ju-bdr f18 accountrecharge_cont_btn"
									data-toggle="modal" data-backdrop="static"
									data-target="#myModa_withdraw">提现</button>
							</div>
						</div>

						<div class="Box05">
							<div class="money01">
								累计金额<br />50.00元
							</div>
							<div class="money02">—</div>
							<div class="money01">
								累计提现金额<br />30.00元
							</div>
							<div class="money02">—</div>
							<div class="money01">
								累计账户划款金额<br />20.00元
							</div>
						</div>
						<script>
									$(function () {
										$(".Box04").mouseover(function () {
											$(".Box05").show();
												});
												$(".Box04").mouseout(function () {
														$(".Box05").hide();
												});
									});
								</script>
						<!--以上是账户信息-->


						<!--温馨提示-->
						<div class="remindBox">
							<p class="remindTitle">温馨提示</p>
							<p class="remindTip">
								1.请认真填写您的信息，该信息将影响您的分红； <br />
								2.为了不影响您的分红到账，填写的银行卡用户名与真实姓名必须要保持一致；<br />
								3.该信息完善后，用户需要通过众投客(www.zhongtouke.com)官方客服人员来修改，客服电话：400-079-9617
							</p>

						</div>
				</div>
			</div>


		</div>

	</div>

	</div>

	<%@include file="./account/modal_recharge.jsp"%>
	<%@include file="./account/modal_withdraw.jsp"%>
	<%@include file="./account/modal_bankcard_bind.jsp"%>
	<%@include file="./account/modal_bankcard_unbind.jsp"%>

	<!--首页底部-->
	<%@include file="../common/footer.jsp"%>
</body>
</html>