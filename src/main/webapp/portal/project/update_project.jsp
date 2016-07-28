<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>编辑项目</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<%@include file="/common/common.jsp"%>
		<%@include file="/common/jqueryUI.jsp"%>		
		<link rel="stylesheet" type="text/css" href="<%=contextPath%>/common/css/tabpanel.css">
  		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.config.js"></script> 
		<script type="text/javascript" src="<%=contextPath%>/common/plugins/ueditor1_4_3/ueditor.all.min.js" ></script>
		<script type="text/javascript" src="<%=contextPath%>/portal/project/project_audit.js" ></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=resourcePath %>/js/common/global-upload.js"></script>
		<script>
		/*更换显示样式*/
		function setTab(name,cursel,n){
			for(i=1;i<=n;i++){
				var menu=document.getElementById(name+i);
				var con=document.getElementById("con_"+name+"_"+i);
				menu.className=i==cursel?"hover":"";
				con.style.display=i==cursel?"block":"none";
			}
		}
		</script>		
		<script>

	( function($) {
		$( function() {
 
			var validateFormRule = {
					rules : {
						"project.projectName" : {
							required : "请输入项目名称"
						},
						"project.projectDesc" : {
							required : "请输入项目描述(一句话)"
						},
						"project.projectProfile" : {
							required : "请输入项目简介"
						},
						"project.financeAmount":{
							required:"请输入融资金额",
							number:true
						},
						"project.founderInvestAmount":{
							required:"请输入项目方投资金额",
							number:true
						},
						"project.subscribeCount":{
							required:"请输入认购份数",
							digits:true
						},
						"project.minInvestAmount":{
							required:"单笔投资人最低投资金额",
							number:true
						},
						"project.prebuyBeginDate":{
							required:"预热开始日期"
						},
						"project.prebuyEndDate":{
							required:"预热结束日期"
						},						
						"project.raiseBeginDate":{
							required:"融资开始日期"
						},
						"project.raiseEndDate":{
							required:"融资结束日期"
						}
						
					}
				};
			var vo = validateForm("#data_form", validateFormRule);

			$("#submitBtn").click( function() {
				
				if (vo.form()){
					$("[name='projectDoc.projectIntroduce']").val(UE.getEditor("projectIntroduceEditor").getContent());
					$("[name='projectDoc.financeExplain']").val(UE.getEditor("financeExplainEditor").getContent());
					$("[name='projectDoc.riskControl']").val(UE.getEditor("riskControlEditor").getContent());
					$("[name='projectDoc.projectAgreement']").val(UE.getEditor("projectAgreementEditor").getContent());
					$("#data_form").submit();
				}
			});

			$("#resetBtn").click( function() {
				vo.resetForm();
			})

			$("#backBtn").click( function() {
				window.location.href = servletPath+"/portal/project/index.action";
			});

		});
	})(jQuery)
</script>

	</head>

	<body>
		<div class="grid_body">
			<form action="<%=servletPath %>/portal/project/update.action" method="post" name="data_form" id="data_form">
			    <input type="hidden" name="project.projectId" value="${project.projectId}"/>
			    <input type="hidden" name="projectDoc.projectId" value="${project.projectId}"/>
			    
				<table class="content">
					<thead>
						<tr>
							<th colspan="2">
								编辑项目
							</th>
						</tr>
					</thead>
					<tbody>
					
						<tr>
						<td>
							<div id="Tab1">
								<div class="Menubox">
									<ul>
										<li id="one1" onclick="setTab('one',1,8)" class="hover">基本资料</li>
										<li id="one2" onclick="setTab('one',2,8)">融资设置</li>
										<li id="one3" onclick="setTab('one',3,8)">项目介绍</li>
										<li id="one4" onclick="setTab('one',4,8)">融资情况</li>
										<li id="one5" onclick="setTab('one',5,8)">资料审核</li>
										<li id="one6" onclick="setTab('one',6,8)">股东回报</li>
										<li id="one7" onclick="setTab('one',7,8)">合作协议</li>
										<li id="one8" onclick="setTab('one',8,8)">分红填报</li>
									</ul>
								</div>
								<div class="Contentbox">
									<div id="con_one_1" class="hover">
										<%@include file="./base_info.jsp"%>
									</div>
									<div id="con_one_2" style="display:none">
										<%@include file="./stock_right.jsp"%>
									</div>
									<div id="con_one_3" style="display:none">
										<%@include file="./project_introduce.jsp"%>
									</div>
									<div id="con_one_4" style="display:none">
										<%@include file="./finance_explain.jsp"%>
									</div>	
									<div id="con_one_5" style="display:none">
										<%@include file="./project_certificate.jsp"%>
									</div>																		
									<div id="con_one_6" style="display:none">
										<%@include file="./project_risk.jsp"%>
									</div>	
									<div id="con_one_7" style="display:none">
										<%@include file="./project_agreement.jsp"%>
									</div>										
									<div id="con_one_8" style="display:none">
										<%@include file="./project_bonus.jsp"%>
									</div>																	
								</div>
							</div>
						</td>
					</tr>

					</tbody>
					<tfoot>
						<tr>
							<td colspan="2">

								<a id="auditBtn" class="sub" href="javascript:void(0);">审核项目</a>								
								<a id="submitBtn" class="sub" href="javascript:void(0);">保存</a>
								<a id="resetBtn" class="reset" href="javascript:void(0);">重置</a>
								<a id="backBtn" class="return" href="javascript:void(0);">返回</a>
							</td>
						</tr>

					</tfoot>
				</table>
			</form>
		</div>
		<div class="pop_tree">
			<div class="pop_head">
			</div>
			<div class="pop_body">
			</div>
			<div class="pop_foot">
				<a href="javascript:void(0);" id="_PopSubBtn" class="button"
					data-popel="" data-vel="">确定</a>
				<a href="javascript:void(0);" id="_PopCloseBtn" class="button">关闭</a>
			</div>
		</div>
		
		<!-- 修改函数的弹出窗 -->
		<div class="projectAuditDialog" title="项目审核处理" id="projectAuditDialog">
				<jsp:include page="auditing_opion.jsp"></jsp:include>
		</div>
	</body>
</html>
