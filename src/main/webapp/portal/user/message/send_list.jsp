<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--头部开始-->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<c:set var="pageTitle" value="消息中心"></c:set>
<%@include file="../../common/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/user.css" />
<script type="text/javascript" src="<%=contextPath%>/common/javascripts/page.js"></script>

</head>
<body>
<%@include file="../../common/uc_header.jsp" %>
<div class="wrap clear">
    <div class="row mt-20">
        <div class="col-7 mr-10">
            <!--左侧栏开始-->
			<%@include file="../uc_menu.jsp" %>
			<!--左侧栏结束-->
        </div>
        <!--右侧栏-->
        <div class="col-23 bg_white">
			<div class="clear  user_tit_box">
                <div class="fl user_tit font-wet">消息中心</div>
                <div class="fr more_box">
                	<a href="<%=servletPath %>/portal/uc/receiveMessages.action" >收信箱</a>
                    <a href="<%=servletPath %>/portal/uc/sendMessages.action" class="now">发信箱</a>
                    <a href="javascript:void(0);">&nbsp;</a>
                </div>
            </div>
            <div class="information_check">
            	<div class="audit_check">
	  	
	  						<c:if test="${not empty messages }">
		  						<c:forEach items="${messages}" var="message" varStatus="index">
			                   		
				               		<p>
			                   			    收信人： ${message.toName }	<em><fmt:formatDate value="${message.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></em>                                  
				                    </p>
					                	 <span id="msg_${message.messageId }" style="font-weight: normal; cursor: pointer;" data-toggle="modal" data-toggle="modal" data-backdrop="static" data-target="#myModa_information_02${index.count }" title="点击、查看详情" alt="点击、查看详情" > 
					                      ${message.content }
					                  </span>
									  <%@include file="./reply_dialog.jsp" %>  
								</c:forEach>          
							</c:if>
							<c:if test="${empty messages }">
								<p>没有发送的消息</p>
							</c:if>          			                    			                	                    	                    
	                </div> 
               </div>
            <div class="pages">
			<form action="<%=servletPath %>/portal/uc/receiveMessages.action" method="post" name="page_form" id="page_form">
				<div class="grid_foot">
					<div class="foot_left">
						当前第
						<c:out value="${page.currentPage}"></c:out>
						页/共
						<c:out value="${page.totalPage}"></c:out>
						, 每页显示
						<c:out value="${page.pageSize}"></c:out>
						条记录/共
						<c:out value="${page.totalCount}"></c:out>
						条,跳转到
						<select class="gotoPage" data-formAction="<%=servletPath %>/portal/uc/sendMessages.action" data-formId="page_form">

						</select>
						页
					</div>
					<div class="foot_right">
						<input type="hidden" name="page.pageSize"
							value="${page.pageSize }">
						<input type="hidden" name="page.count" value="${page.count }">
						<input type="hidden" name="page.currentPage"
							value="${page.currentPage }" />
						<input type="hidden" name="page.beginPage"
							value="${page.beginPage }">
						<input type="hidden" name="page.totalCount"
							value="${page.totalCount }">
						<input type="hidden" name="page.totalPage"
							value="${page.totalPage}">
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">首页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:firstPage('<%=servletPath %>/portal/uc/sendMessages.action', null, null);">首页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.first==true}">
								<a href="javascript:void(0);">上一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:prevPage('<%=servletPath %>/portal/uc/sendMessages.action', null, 'page_form');">上一页</a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">下一页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:nextPage('<%=servletPath %>/portal/portal/uc/sendMessages.action', null, 'page_form');">下一页</a>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${page.last==true}">
								<a href="javascript:void(0);">末页</a>
							</c:when>
							<c:otherwise>
								<a
									href="javascript:lastPage('<%=servletPath %>/portal/uc/sendMessages.action', null, 'page_form');">末页</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</form>                        
            
            </div>
        </div>
        
    </div>
    
</div>

<!--底部开始-->
<%@include file="../../common/footer.jsp" %>
</body>
</html>


<!--底部结束-->
<script type="text/javascript">

	function message_detail(msg_id){
		var url = "http://user.renrenchou.com/remind/messagedetail";
		$.post(url,{msg_id:msg_id,'random':Math.random()},function(data){
			//var sdata = eval('('+data+')');
			if(data.status==1)
			{
				$("#msg_"+msg_id).css('font-weight','normal');
				$("#msg_"+msg_id).removeAttr("onclick");
				var massage_unread_num = Number($("#massage_unread_num").html());
				massage_unread_num = massage_unread_num - 1;
				if(massage_unread_num > 0)
				{
					$("#massage_unread_num").html(massage_unread_num);
				}else
				{
					$("#massage_unread_text").css('display','none');
					$("#massage_unread_num").html('0');
				}
			}
		});
	}
	
	function reply_sure(key,toId,toName){
		
		var  content = $("#message_"+key+"_con").val();
		if( content == '' || content == '请输入回复信息' ){
			$("#message_"+key+"_con").focus();
			$("#message_"+key+"_con").val('请输入回复信息');
			return false;
		}
		var url = "http://user.renrenchou.com/remind/replymessage";
		$.post(url,{'toId':toId,'toName':toName,'content':content,'random':Math.random()},function(data){
			if( data.code == 1 ){
				$("#myModa_information_02"+key).hide();
				popBox(data.message,'info');
				window.location.reload();
				
			}
		});
	}

	function clear_focus(key){
		
		if( $("#"+key).val() == '' || $("#"+key).val() == '请输入回复信息' ){
			$("#"+key).val('');
			$("#"+key).focus();
			return false;
		}
	}
</script>