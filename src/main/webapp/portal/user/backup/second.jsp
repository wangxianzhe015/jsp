<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>发布项目 - 草根天使投资放心、实体店铺融资省心的股权众筹平台</title>
<meta name="keywords" content="人人投,众筹,众筹网,股权众筹,众筹平台,天使投资,店铺融资,草根天使,开分店融资,股权众筹平台" />
<meta name="description" content="人人投(www.renrentou.com)是草根天使投资放心、实体店铺（吃、喝、玩、乐店铺）融资省心的股权众筹平台,旨在搭建一个高效、安全、快捷的互联网股权众筹平台." />
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
</head>
<body>
	<%@include file="../../common/uc_header.jsp"%>
	<script>
$( document ).ready(function(e) {
	$("#founder_pay").focus();
    //份数参考
	function jisuan(pay_t,pay_p)
    {
		var pay_i = pay_t-pay_p;
		var reg = /^\d*$/;	
		var pay_r;
		var pay_rh;
		$("#fstj").html('');
		for(var i=1;i<199;i++)
		{
			pay_r = pay_i/i;
			if(reg.test(pay_r))
			{
				pay_rh = "<p><span>份数:&nbsp;"+i+"</span><span>金额:&nbsp;"+pay_r+"</span></p>";
				$("#fstj").append(pay_rh);
			}
		}
		
    }

    $('#founder_pay').blur(function(){
        var toltal = parseInt($('#finance_total').val());
    	if($('#founder_pay').val() == false)
    	{
    		var fp_min = toltal * 3 / 10; 
    		$('#founder_pay').val(fp_min);
    	}
    	var founder_pay=$('#founder_pay').val();
        if(toltal>0 && founder_pay>0 && parseInt(toltal) > founder_pay){
            $('#fraction').blur();
        }else
        {
        	$('#founder_pay').val("");
            $('#fraction').val("");
			$('#lest_finance').val("");
        }
    });

	$('#fraction').blur(function()
	{
		 if(!$('#founder_pay').val())
		 {
			 $('#founder_pay').blur();
			 $('#fraction').val("");
		 }else
		 {
			 if(parseInt($("#fraction").val()) > 0)
			 {
				 if(parseInt($("#fraction").val()) > 199 )
				 {
					 $("#fraction").val('199');
				 }
				 $("#fraction").val(parseInt($("#fraction").val()));
				 var price = $("#finance_total").val() - $("#founder_pay").val();
				 price = (price / $("#fraction").val()).toFixed(2);
				 $('#lest_finance').val(price);
			 }else
			 {
				 $('#fraction').val("1");
				 var price = ($("#finance_total").val() - $("#founder_pay").val()).toFixed(2);
				 $('#lest_finance').val(price);
			 }
		 }
		 
	})
	 $('#founder_income_rate').blur(function(){
         var founder_income_rate= (parseFloat($('#founder_income_rate').val())).toFixed(2);
         $('#founder_income_rate').val(founder_income_rate);
         if(founder_income_rate > 0 && founder_income_rate < 100)
         {
      		var investor_income_rate = (100-founder_income_rate).toFixed(2);
         	 $('#investor_income_rate').val(investor_income_rate);
         }else
         {
        	 $('#founder_income_rate').val("");
        	 $('#investor_income_rate').val("");
         }       
     });

	 $("#sub").click(function(){
		 $('#founder_pay').blur();
		 $('#founder_income_rate').blur();
		 if($("#finance_total").val() == false)
		 {
			 popBox('融资总额不能为空','error');
			 return false
		 }
		 if($("#founder_pay").val() == false)
		 {
			 popBox('项目方出资不能为空','error');
			 return false
		 }if($("#fraction").val() == false)
		 {
			 popBox('认购份数不能为空','error');
			 return false
		 }
	});
});
</script>

	<div class="wrap clear">
		<div class="row mt-20">
			<div class="col-7 mr-10">
				<!--左侧栏-->
				<%@include file="../uc_menu.jsp"%>
			</div>
			<!--右侧栏-->
			<div class="col-23 bg_white">
				<div class="pos_xiangm">
					<h3>发布项目</h3>
				</div>
				<div class="pos_jindu">
					<div class="release-list">
						<ul class="release-ul releaseBg2">
							<li><a>基本资料</a></li>
							<li><a>股权设置</a></li>
							<li><a>项目编辑</a></li>
							<li><a>支付账号注册</a></li>
							<li><a class="release-w">平台审核</a></li>
						</ul>
					</div>
					<p></p>
					<h3>股权设置</h3>
					<form id="form_publish_second" method="post" action="<%=servletPath %>/portal/uc/publishThird.action" class="guquan_seting">
						<input type="hidden" name="status" value="${status }"/>
						<input type="hidden" name="project.projectId" value="${project.projectId }"/>
						<table class="tab_guq"
							style="table-layout:fixed;  margin-left: -44px;">
							<tr>
								<td class="dui_right">融资总额 :</td>
								<td width="290">
									<input id="finance_total" class="fl" name="project.financeAmount" type="text" value="${project.financeAmount }" readonly="true" /><span class="fl dui_right_span">元</span>
								</td>
								<td></td>
							</tr>
							<tr>
								<td class="dui_right">项目方出资 :</td>
								<td width="290">
									<input id="founder_pay" class="fl" name="project.founderInvestAmount" type="text" value="${project.founderInvestAmount }" /><span class="fl dui_right_span">元</span>
								</td>
								<td class="red_x">
									<span>（*出资金额应不低于融资总额的30%）</span>
								</td>
							</tr>
							<tr>
								<td class="dui_right">认购份数 :</td>
								<td width="290">
									<input id="fraction" class="fl" name="project.subscribeCount" type="text" value="${project.subscribeCount }" /><span class="fl dui_right_span">份</span>
								</td>
								<td class="red_x">
									<span>（*认购份数=投资人出资总额/最低投资金额 最多199份）</span>
								</td>
							</tr>
							<tr>
								<td class="dui_right">单笔投资人最低投资金额 :</td>
								<td width="290">
									<input id="lest_finance" class="fl" name="project.minInvestAmount" type="text" readonly="true" value="${project.minInvestAmount }" /><span class="fl dui_right_span">元</span>
								</td>
								<td class="red_x"><span>（*最低投资金额=投资人出资总额 /认购份数）</span></td>
							</tr>
						</table>
						<div class="next_step" style="width: 350px">
							<a href="<%=servletPath%>/portal/uc/publishFirst.action?project.projectId=${project.projectId}">上一步</a>
							<button id="sub" style="*margin-bottom: -18px">下一步</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>

</body>
</html>