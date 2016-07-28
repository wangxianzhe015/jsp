<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="绑定银行卡"></c:set>
<c:set var="topPage" value="/mobile/uc/accountInfo.action"></c:set>
<%@include file="../common/meta.jsp" %>
    <!-- Bootstrap core CSS -->
    <link href="<%=resourcePathM %>/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/style.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<%@include file="../common/header.jsp" %>
    <div class="content mrgt0"> 
    	<div class="note">
    		绑定的银行卡作为众投客平台唯一的支付和收益渠道，银行卡绑定后将无法更改，请慎重选择！
    	</div>
    	<p class="bank_title">选择银行</p>
    	<ul class="bank_list">
    		<li>
    			<a href="javascript:" data-checked="1">
    				<img src="<%=resourcePathM%>/images/ic_bank01.png" class="img-responsive"/>中国银行
    			</a>
    			<a href="javascript:" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank02.png" class="img-responsive"/>农业银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank03.png" class="img-responsive"/>工商银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank04.png" class="img-responsive"/>建设银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank05.png" class="img-responsive"/>招商银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank06.png" class="img-responsive"/>中信银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank07.png" class="img-responsive"/>兴业银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank08.png" class="img-responsive"/>光大银行
    			</a>
    		</li>
    	</ul>
    	<ul class="bank_list bank_list2" style="display: none;">
    		<li>
    			<a href="javascript:" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank09.png" class="img-responsive"/>中国邮政
    			</a>
    			<a href="javascript:" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank10.png" class="img-responsive"/>浦发银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank11.png" class="img-responsive"/>民生银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank12.png" class="img-responsive"/>交通银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank13.png" class="img-responsive"/>华夏银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank14.png" class="img-responsive"/>广发银行
    			</a>
    		</li>
    		<li>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank15.png" class="img-responsive"/>上海银行
    			</a>
    			<a href="javascript:" class="unchecked" data-checked="0">
    				<img src="<%=resourcePathM%>/images/ic_bank16.png" class="img-responsive"/>北京银行
    			</a>
    		</li>
    	</ul>
    	<p class="more_bank"><a href="javascript:">查看更多银行<i class="fa fa-chevron-down"></i></a></p>
    	<div class="bank_form">    	
	    	<form action="#" method="post" role="form" class="form-horizontal">
	    		<div class="form-group row">
	    			<div class="col-xs-4 label1">
	    				<label class="control-label">持卡人姓名：</label>
	    			</div>
	    			<div class="col-xs-8">
	    				<input type="text" class="form-control transparent" name="" placeholder="" value="${user.realName }"/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-4 label1">
	    				<label class="control-label">身份证号码：</label>
	    			</div>
	    			<div class="col-xs-8">
	    				<input type="text" class="form-control transparent" name="" placeholder="" value="${user.identityCard}"/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-4 label1">
	    				<label class="control-label">银行卡卡号：</label>
	    			</div>
	    			<div class="col-xs-8">
	    				<input type="text" class="form-control transparent" name="" placeholder="请输入储蓄卡卡号" value=""/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-4 label1">
	    				<label class="control-label">预留手机号：</label>
	    			</div>
	    			<div class="col-xs-8">
	    				<input type="text" class="form-control transparent" name="" placeholder="请输入银行预留手机号" value="${user.contactMobile}"/>
	    			</div>
	    		</div>
	    		<div class="form-group row">
	    			<div class="col-xs-4 label1">
	    				<label class="control-label">短信验证码：</label>
	    			</div>
	    			<div class="col-xs-4">
	    				<input type="text" class="form-control transparent" name="" placeholder="请输入验证码"/>
	    			</div>
	    			<div class="col-xs-4 nopadding-left">
	    				<button type="button" class="btn btn-custom nomargin">获取验证码</button>
	    			</div>
	    		</div>
	    		<div class="form-group row mrgt30">
	    			<div class="col-xs-12">
	    				<button type="button" class="btn btn-custom2" id="btnSubmit">绑定银行卡</button>
	    			</div>
	    		</div>   		
	    	</form>
	    </div>
	    <div class="modal fade custom_modal" id="confirm_dialog" tabindex="-1" role="dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				<span id="confirm_msg">请选择银行</span>
    			</div>
    			<div class="modal-footer">
    				<div class="row">
    					<div class="col-xs-12"><a href="javascript:" data-dismiss="modal">确定</a></div>    					
    				</div>
    			</div>
    		</div>
    	</div>
    </div>    
	<%@include file="../index/mobilecode_dialog.jsp" %>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

<script>
$(document).ready(function() {
	$('.more_bank a').on('click', function() {
		var i = $(this).children('i');
		$('.bank_list2').slideToggle('slow', function() {
			if ($(this).is(':visible')) {
				i.removeClass('fa-chevron-down');
				i.addClass('fa-chevron-up');
			} else {
				i.removeClass('fa-chevron-up');
				i.addClass('fa-chevron-down');
			}
		});
	});
	$('.bank_list a').on('click', function() {
		var checked = $(this).attr('data-checked');
		if (checked == '1') {
			$(this).removeClass('checked');
			$(this).addClass('unchecked');
			$(this).attr('data-checked', '0');
		} else if (checked == '0'){
			setAllUncheck();
			$(this).addClass('checked');
			$(this).removeClass('unchecked');
			$(this).attr('data-checked', '1');
		} 
	});
});
function setAllUncheck() {
	$('.bank_list a').each(function() {
		var checked = $(this).attr('data-checked');
		if (checked == 1) {
			$(this).attr('data-checked', '0');
			$(this).removeClass('checked');
			$(this).addClass('unchecked');
		}
	});
}

</script>
</body>
</html>
