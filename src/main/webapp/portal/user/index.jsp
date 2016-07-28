<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="用户中心"></c:set>
<%@include file="../common/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>

</head>
<body>

<%@include file="../common/uc_header.jsp" %>
<div class="wrap clear">
    <div class="row mt-20">
        <div class="col-7 mr-10">
			<%@include file="./uc_menu.jsp" %>
        </div>
      <div class="col-23 bg_white">
           	    <div class="pos_r_title pos_r_title_02"> 
           	        <p>
           	    	<span><a href="<%=servletPath%>/portal/uc/personalSetting.action">完善个人资料</a></span>
           	    	</p>
           	    </div>
			    <div class="border bg_white1 mt-10 user_info_box">
                	<div class="user_pic fl"> 
                			 <c:choose>
								 <c:when test="${empty user.userImage }">
								      <img src="<%=resourcePath %>/images/default-avatar-2.png" class="user_face"> 
								 </c:when>
								 <c:otherwise>
								 	<img src="${user.userImage }" class="user_face">
								 </c:otherwise>
							 </c:choose>
                	</div>
	                <div class="text_box">
	                    <div>
	                        <strong class="font-wet"><span class="f20 color-9" id="js_date"></span> 
	                        	<span id="username_text" class="f20 color-3 mr-15">${user.userName }</span>
	                        	<c:if test="${user.nameChanged!='1' }"> 
	                        		<span style="color: blue; cursor: pointer; text-decoration: underline;" id="username_edit" data-toggle="modal" data-target="#userNameChanges ">换个响亮的名字吧</span>
	                        	</c:if>
	                        </strong>
	                    </div>
						
	                    <div class="mt-10">
	                    	您于<span class="under"><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></span>注册<br>
	                    	<span>最近登录时间：<span class="under"><fmt:formatDate value="${logonLog.logonTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></span>
	                    </div>
	                    <div class="mt-10">账户余额：${user.accountInfo.availableAmount } 元 <a href="<%=servletPath %>/portal/uc/accountInfo.action" class=" ml-15 mr-15">充值</a> <br>
	                    <span class="mr-15">冻结金额：${user.accountInfo.freezeAmount } 元 </span>
	                    </div>
	                    <div class="user_list mt-15">
	                        <ul class="clear">
	                             <c:if test="${empty user.emailAuth || user.emailAuth!='1'}">
	                            	 <li><a href="<%=servletPath%>/portal/uc/safeSetting.action">邮箱未认证</a></li>
	                           	 </c:if>       
	                           	  <c:if test="${user.emailAuth=='1'}">
	                            	 <li class="email over">邮箱已认证</li>
	                           	 </c:if>            
	                             <li class="tel over">手机已认证</li>

	                             <c:if test="${empty user.realName || user.realNameAuth!='1'}">
	                            	 <li  class="pos"><a href="<%=servletPath%>/portal/uc/safeSetting.action">未实名认证</a></li>
	                           	 </c:if>       
	                           	  <c:if test="${user.realNameAuth=='1'}">
	                            	 <li class="pos over">已实名认证</li>
	                           	 </c:if>  	                           	                            
	                        </ul>
	                    </div>
	                </div>
            </div>
             
            <div class="border bg_white1 mt-20 user_info_box">
                 <div class="news-remind">
                      <div class="news-remind-more">
                           <span>个人消息提醒：</span>
                           <a href="<%=servletPath%>/portal/uc/receiveMessages.action">更多></a>
                      </div>
                      <ul class="news-remind-ul">
                      		<c:forEach items="${messages}" var="message" varStatus="index">
                     		 <li>
                              <i style="float: left;width: 636px;overflow: hidden;white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">${message.content}</i>
                              <span><fmt:formatDate value="${message.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                          	</li>
                          </c:forEach>
                      	                         
                       </ul>
                 </div>
            </div>

        </div>
    </div>
</div>

<!-- 用户名修改 -->
<div class="modal fade" id="userNameChanges" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-small" style="width: 550px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button id="username_x" type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>       
						<h4 class="modal-title">用户名修改</h4>
                    </div>
                    <div class="modal-body">
                        <div class="dialog_form">
                            
                            <form id="username_form_changes">
                                <label for="">旧用户名 :</label>
                                <i>${user.userName }</i>
                                <br/>
                                <label for="">新用户名 : </label>
                                <input id="username" type="text" name="username" style="width: 140px" type="text"/>
                                <div id="username_tip">请您注意：用户名只允许修改一次</div>
                                <br/>
                                <button id="button_name" class="sjdialog_btn" onclick="return jQuery.formValidator.pageIsValid('2');">确定修改</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
<!-- 用户名修改 -->

<script>
    var submitProjectId = 0;
    $(document).ready(function(){

    	$.formValidator.initConfig({formid:"username_form_changes",validatorgroup:"2",onerror:function(msg){
    		return false;},onsuccess:function(){
    			$("#button_name").attr('disabled','true');
    			$("#username_tip").html("用户名正在修改中，请稍后");
    			var username = $("#username").val();
    		    $.post("<%=servletPath%>/portal/uc/ajaxUsernameSave.action",{'username':username},function(data){  
    	 			if(data.code==1)
    	 			{
    	 				popBox(data.message,'success');
    	 				$("#username_x").click();
    	 				$("#username_text").html(username);
    	 				$("#username_edit").hide();
    	 				$("#username_tip").html("");
    	 			}else
    	 			{
    	 				$("#button_name").removeAttr('disabled');
    					popBox(data.message,'error');
    					$("#username_tip").html("请您注意：用户名只允许修改一次");
    	 			}
    		    },"json")  
    			return false;
    		}});	

    });
</script>
<script language="javaScript">
    now = new Date(),hour = now.getHours()
    if(hour < 6){$('#js_date').html('凌晨好：');}
    else if (hour < 9){$('#js_date').html('早上好：');}
    else if (hour < 12){$('#js_date').html('上午好：');}
    else if (hour < 14){$('#js_date').html('中午好：');}
    else if (hour < 17){$('#js_date').html('下午好：');}
    else if (hour < 19){$('#js_date').html('傍晚好：');}
    else if (hour < 22){$('#js_date').html('晚上好：');}
    else {$('#js_date').html('夜里好：');}
</script>
<!--首页底部-->
<%@include file="../common/footer.jsp" %>
</body>
</html>
