<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="账户资金"></c:set>
	<%@include file="../common/meta.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<style type="text/css">
	.cardUl li {
	    width: 224px;
	    height: 120px;
	    text-align: center;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	    float: left;
	    margin: 10px;
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
	.space-30 { height: 30px;overflow: hidden;}
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
		<!-- col-7结束 -->

		<div class="col-23 bg_white">
			<div class="clear  user_tit_box">
				<div class="fl user_tit font-wet">账户资金</div>
			</div>
			<div style="height:40px; background:#f8f8f8;"></div>
			<div class="border-c accountrecharge_cont">
				<dl class="fl accountrecharge_cont_dl">
					<dt class="fl ml-20 accountrecharge_cont_dt">
	                	<c:choose>
								 <c:when test="${empty user.userImage }">
								      <img src="<%=resourcePath %>/images/default-avatar-2.png" class="user_face"> 
								 </c:when>
								 <c:otherwise>
								 	<img src="${user.userImage }" class="user_face">
								 </c:otherwise>
						 </c:choose>				
						<p class="f16 font-wet"></p>
					</dt>
					<dd class="fr mr-20 ml-20 accountrecharge_cont_dd">              
						<p class="f16 mt-10">账户总金额</p>
						<p class="f16"><b class="f20 color-zhu">${user.accountInfo.totalAmount }</b> 元</p>
						<p class="f16"><span>可提现金额：</span><b>${user.accountInfo.availableAmount }</b> 元</p>
						<p class="f16"><span>冻结金额：</span><b>${user.accountInfo.freezeAmount }</b> 元</p>
						<p class="f16"><span>累计充值：</span><b>${totalRechargeAmount }</b> 元</p>
						<p class="f16"><span>累计提现：</span><b>${totalDrawAmount }</b> 元</p>
						<p class="f16"><span>累计投资：</span><b>${totalInvestAmount }</b> 元</p>
					</dd>

					</dl>		
				<button class="fr btn-ju-bdr f18 accountrecharge_cont_btn" data-toggle="modal" data-backdrop="static" data-target="#myModa_recharge">充 值</button>
	 			<button class="fr btn-ju-bdr f18 accountrecharge_cont_btn" data-toggle="modal" data-backdrop="static" data-target="#myModa_withdraw">提 现</button>		 
			</div>
			
		</div><!-- col-23结束 -->
		<div >
	        <div class="col-23 bg_white">
				<div class="clear  user_tit_box">
					<div class="fl user_tit font-wet">银行卡绑定</div>
				</div>         
	            <div>
	            	<ul class="cardUl" id="cardList">
	            		<c:if test="${empty bankcards}" >
	            		   <li><a href="##" class="add" id="card${card.cardId }"><span class="icon_add" data-backdrop="static" data-toggle="modal" data-target="#myModa_bankcard_bind">增加银行卡</span></a></li>
	            		</c:if>
	            		
	            	    <c:forEach items="${bankcards }" var="card">
	            		<li>
	            		    <a id="cardinfo" data-cardid="${card.cardId }" >
	            			<span>${card.cardTop}******${card.cardLast }</span>
	            			</a>
	            		</li>
	            		</c:forEach>	            	
	            	</ul>
	                <div class="clear"></div>
	            </div>
	        </div>        
	    </div>				
	</div>

</div>

<%@include file="./account/modal_recharge.jsp" %>
<%@include file="./account/modal_withdraw.jsp" %>
<%@include file="./account/modal_bankcard_bind.jsp" %>
<%@include file="./account/modal_bankcard_unbind.jsp" %>

<!--首页底部-->
<%@include file="../common/footer.jsp"%>
</body>
</html>