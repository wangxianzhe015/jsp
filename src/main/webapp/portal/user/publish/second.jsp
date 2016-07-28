<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<c:set var="pageTitle" value="发布项目"></c:set>
<%@include file="../../common/meta.jsp" %>
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

    $('#founder_pay').blur(function(){
        var toltal = parseInt($('#finance_total').val());
    	if($('#founder_pay').val() == false)
    	{
    		var fp_min = toltal * 2 / 10; 
    		$('#founder_pay').val(fp_min);

    	}

    	var founder_pay=$('#founder_pay').val();
		var investorAmount=($("#finance_total").val() - $("#founder_pay").val()).toFixed(2);
		$("#investor_pay").val(investorAmount);    	
		
        if(toltal>0 && founder_pay>0 && parseInt(toltal) > founder_pay){
            $('#fraction').blur();
        }else {
        	$('#founder_pay').val("");
            $('#fraction').val("");
			$('#lest_finance').val("");
			$("#investor_pay").val("");
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
				 $("#fraction").val(parseInt($("#fraction").val()));
				 var price = $("#finance_total").val() - $("#founder_pay").val();
				 $("#investor_pay").val(price);
				 
				 price = (price / $("#fraction").val()).toFixed(2);
				 $('#lest_finance').val(price);
			 }else{
				 $('#fraction').val("1");
				 var price = ($("#finance_total").val() - $("#founder_pay").val()).toFixed(2);
				 $("#investor_pay").val(price);
				 
				 $('#lest_finance').val(price);
			 }
		 }
		 
	})


	 $("#sub").click(function(){
		 $('#founder_pay').blur();
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
							<li><a>融资设置</a></li>
							<li><a class="release-w">平台审核</a></li>
						</ul>
					</div>
					<p></p>
					<h3>股权设置</h3>
					<form id="form_publish_second" method="post" action="<%=servletPath %>/portal/uc/publishFifth.action" class="guquan_seting">
						<input type="hidden" name="status" value="${status }"/>
						<input type="hidden" name="project.projectName" value="${project.projectName }"/>
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
									<input id="founder_pay" class="fl" name="project.founderInvestAmount" type="text" value="${project.founderInvestAmount }"  /><span class="fl dui_right_span">元</span>
								</td>
								<td class="red_x">
									<span>（*出资金额应不低于融资总额的20%）</span>
								</td>
							</tr>
							<tr>
								<td class="dui_right">投资方出资 :</td>
								<td width="290">
									<input id="investor_pay" class="fl" name="project.investorAmount" type="text" value="${project.investorAmount }" readonly="readonly"/><span class="fl dui_right_span">元</span>
								</td>
								<td class="red_x">
									
								</td>
							</tr>							
							<tr>
								<td class="dui_right">认购份数 :</td>
								<td width="290">
									<input id="fraction" class="fl" name="project.subscribeCount" type="text" value="${project.subscribeCount }" /><span class="fl dui_right_span">份</span>
								</td>
								<td class="red_x">
									<span>（*认购份数=投资人出资总额/最低投资金额）</span>
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
							<button id="sub" style="*margin-bottom: -18px">提交审核</button>
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