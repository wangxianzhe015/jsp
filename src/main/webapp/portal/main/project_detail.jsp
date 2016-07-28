<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="${project.projectName }"></c:set>
<%@include file="../common/meta.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index-news.css" />
<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/user.css" />
<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/project-detail.css" />

<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/project-detail.js"></script>

</head>

<body>
<style>
/* 收益计算器 */
#myModa_calculator .modal-header,#myModa_rengou .modal-header {
	background: #ff6633;
	color: #fff;
	border-radius: 6px;
	padding: 10px 15px;
}

#myModa_calculator .modal-title {
	background:url(<%=resourcePath%>/images/modal_jisuanqi.jpg) no-repeat;
	padding-left: 45px;
	line-height: 50px;
}

#myModa_calculator table {
	width: 570px;
	border: 1px solid #ccc;
}

#myModa_calculator table tr {
	width: 25%;
	border: 1px solid #ccc;
}

#myModa_calculator table th {
	border: 1px solid #ccc;
	line-height: 40px;
}

#myModa_calculator table p {
	color: #000;
}

#myModa_calculator table th input {
	width: 90%;
	height: 100%;
	border: none;
	overflow: auto;
	padding-left: 5%;
}

#myModa_calculator p {
	color: #f00;
	text-align: center;
	line-height: 52px;
}

#myModa_calculator form {
	width: 100%;
	text-align: center;
}

form button {
	cursor: pointer;
	width: 290px;
	height: 55px;
	border: none;
	color: #f63;
	font-size: 24px;
	background: #ccc;
	border-radius: 5px;
	margin-bottom: 5px;
}

form button.now {
	color: #fff;
	background: #f63;
}

/* 视频标签 */
#videoDiv ul li {
	background: #cecece none repeat scroll 0 0;
	border-radius: 2px;
	color: #fff;
	cursor: pointer;
	float: left;
	font-size: 12px;
	height: 20px;
	line-height: 20px;
	margin: 0 10px 0 5px;
	text-align: center;
	width: 65px;
}

#videoDiv li.now {
	background: rgba(0, 0, 0, 0) url("<%=resourcePath%>/images/sicon01.gif") no-repeat scroll 0 0;
	height: 29px;
	line-height: 27px;
	position: relative;
	top: -4px;
}

/* 评论回复框 */
.commentInput {
	width: 98%;
	height: 130px;
	margin-top: 20px;
	margin-bottom: 20px
}

.button {
	cursor: pointer;
	width: 290px;
	height: 34px;
	border: none;
	color: #f63;
	font-size: 20px;
	background: #ccc;
	border-radius: 5px;
	margin-bottom: 5px;
}

b {
	font-weight: bold;
}

i {
	font-style: italic;
}
</style>

<script>
var status = 0;
function button_select()
{
	if(status == '-1' || status == '-2' || status == '-3')
	{
		$("#buttonA").click();
	}else if(status == '-4')
	{
		$("#buttonB").click();
	}else if(status == '-5')
	{
		$("#buttonC").click();
	}		
}
function button_text()
{
    var time=60,
        timer=null;
    $('#code_code').hide();
    $('#button_text').show().text(time+'秒后重试');
    timer=setInterval(function(){
        time--;
        if(time<1){
            clearInterval(timer);
            $('#button_text').hide();
            $('#code_code').show().text('重新获取验证码');
            time=60;
        }else{
            $('#button_text').text(time+'秒后重试');
        }
    },1000)
}
</script>
<%@include file="../common/header.jsp" %>

	<!--店铺介绍-->
	<div class="details-box">
		<div class="details-content">
			<div class="details-top">
				<div class="details-top-l">
					<div class="details-l-img">
						<img
							src="${project.projectImage}"
							alt="${project.projectName}">
					</div>
					<div class="share-list">

					</div>
					<div class="item2">${project.projectStateName }</div>
				</div>
				<div class="details-top-r">
					<div class="r-text1">${project.projectName}</div>
					<div class="space-10"></div>
					<div class="r-text2">${project.projectDesc }</div>
					<div class="space-10"></div>
					<ul class="r-text3">
						<li style=" z-index:4;">
						<a href="javascript: void(0)"class="a-btn">
						 <c:if test="${project.projectState=='prepared' }">
						     <span class="span-bg <c:if test="${empty logon || logon=='false'}">ajax_login</c:if>  <c:if test="${logon=='true'}"> prebuy </c:if>">立即预约</span>
						 </c:if>
						  <c:if test="${project.projectState=='financing' }">
						      <span class="span-bg <c:if test="${empty logon || logon=='false'}">ajax_login</c:if>  <c:if test="${logon=='true'}"> buy </c:if>">立即认购</span>
						 </c:if>
						 
						</a>
							<div class="text-content">
								<p>
									${project.projectProfile }
								</p>
							</div>
						</li>
					</ul>
				</div>
				<div class="clear-both"></div>
			</div>
		</div>
		<div class="details-content2">
			<div class="details-center">
				<div class="details-center-l">
					<ul class="shop-list" id="shopList">
						<li class="on" data-id="1" data-eventname="menu"><a href="javascript:;">项目介绍</a></li>
						<li class="<c:if test="${empty sessionUser }">ajax_login </c:if>" data-id="2" data-eventname="menu"><a href="javascript:;">融资情况</a></li>
						<li class="<c:if test="${empty sessionUser }">ajax_login </c:if>" data-id="3" data-eventname="menu"><a href="javascript:;">股东回报</a></li>
						<li class="<c:if test="${empty sessionUser }">ajax_login </c:if>" data-id="5" data-eventname="menu"><a href="javascript:;">项目评论</a></li>
						<div class="clear-both"></div>
					</ul>
					<!--项目简介-->
					<div class="process-list" id="ShowContent1">
						<%@include file="./details/project_introduce.jsp" %>
					</div>
					
					<!--融资情况-->
					<div class="process-list" style=" display:none;" id="ShowContent2">
					    <%@include file="./details/project_plan.jsp" %>
					</div>
					
					<!--风控点评-->
					<div class="process-list" style=" display:none;" id="ShowContent3">
						<%@include file="./details/project_risk.jsp" %>
					</div>
					
					<!--项目评论-->
					<div class="process-list" style=" display:none;" id="ShowContent5">
						<div class="risk-tips risk-tips2">
							<h4>项目评论：</h4>
							<div class="space-10"></div>
							<div class="textarea-box textarea-box2">
								<textarea id="comment_content"></textarea>
								<span id="comment_contentTip"></span>
							</div>
							<div class="space-20"></div>
							<div class="submit-btn">
								<a href="javascript:;" id="commentBtn" class="<c:if test="${empty sessionUser }">ajax_login </c:if>">提 交</a>
							</div>
						</div>
						<div class="comment-box">
							<span id="comment-list-top"></span>
						</div>
						<div class="space-50"></div>
						<div class="pages" id="pagerHtml"></div>
						<div class="clear-both space-50"></div>
					</div>
					
					<!--项目动态-->
					<div class="hot-project">
						<h4>热门项目：</h4>
						<div class="space-20"></div>
						<div class="project-box">
						   <%@include file="./details/hot_projects.jsp" %>
						</div>
						<div class="space-100"></div>
					</div>
				</div>
				
				<div class="details-center-r">
					<div class="attention-box">
						<ul class="attention-ul">
							<li style="cursor: pointer" class='<c:if test="${empty sessionUser }">ajax_login</c:if>' id="attention" >
								<b></b> <span id="attentionText">
											<c:choose>
											<c:when test="${isAttention=='1'}">
												 已关注
											</c:when>
											<c:otherwise>
												关注
											</c:otherwise>
										</c:choose>
								</span> <i>(<span id="focusCount">${project.focusCount}</span>)
							</i>
							</li>
							<%
							  /**<li style="cursor: pointer" id="counter">收益计算器</li>*/
							 %>
						</ul>
						<div class="attention-div">
							<div class="attention-list">
								<dl class="attention-dl">
									<dt>
										<img src="${user.userImage }" class="user_face">
									</dt>
									<dd>
										<b>发起人：${user.userName}</b>
										<div class="space-10"></div>
										<i data-toggle="modal" data-target="#myModal1" style="cursor: pointer">私信</i>
									</dd>
								</dl>
								<div class="space-30"></div>
								<p class="attention-p">
									<i>项目地点：</i>${project.provinceName}${project.cityName}
								</p>
								<div class="space-10"></div>
								<p class="attention-p">
									<i>一句话介绍：</i>${project.projectDesc }
								</p>
								<div class="space-30"></div>
							</div>

							<c:if test="${project.projectState=='prepared' }">
								<%@include file="./prebuy_info.jsp" %>
							</c:if>
							<c:if test="${project.projectState=='financing' }">
								<%@include file="./financing_info.jsp" %>
							</c:if>
							
							

							<!--资质审核-->
							<div class="contact-me contact-review">
								<%@include file="./details/project_audit.jsp" %>
							</div>
							<!--联系我们-->
							<%@include file="../common/contact_us.jsp" %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<%@include file="./modal_calculator.jsp" %>
	<%@include file="./modal_prebuy.jsp" %>
	<%@include file="./modal_message.jsp" %>

	<div class="arrow-top">
		<p>
			<a href="javascript:;"></a> <span>回到顶部</span>
		</p>
	</div>


	<script>
var projectId = "${project.projectId}";
var isAttention = "${isAttention}";
var sign = "";
var shareId = parseInt("0");
var position = "";
var caches = [];
var totalNum = parseInt("${project.subscribeCount}");
var lestFinance = "${project.minInvestAmount}";
var pretotalpeople = parseInt("${subscribedInverstorCount}");
var pretotalnum = parseInt("${subscribedTotalCopies}");


function fetchData(content)
{
    $("#ShowContent7").html(content);
}

// 关注
function attention()
{
    $("#attention").unbind("click");
    var op = Math.abs(isAttention - 1);
    $.ajax({
        type: "get",
        url: "<%=servletPath%>/portal/uc/attention.action",
        dataType: "json",
        data: {"op": op, "projectId": projectId},
        success: function(data){
            if (data.code == 1) {
                isAttention = op;
                if (op) {
                    $("#focusCount").html(parseInt($("#focusCount").html()) + 1);
                    $("#attentionText").html("已关注");
                } else {
                    $("#focusCount").html(parseInt($("#focusCount").html()) - 1);
                    $("#attentionText").html("关注");
                }
                popBox(data.message, 'success', 3);
            } else {
                popBox(data.message, 'info', 3, function(){
                    if (data.nologin != undefined) {
                        common_show_user();
                    }
                });
            }
            $("#attention").bind("click", attention);
        }
    });
}

function showShareTab(tabId)
{
    for (var i = 1; i <= 7; i++) {
        $("#ShowContent" + i).hide();
    }	
    $("#ShowContent" + tabId).show();
}

$(document).ready(function(){

			$.formValidator.initConfig({formid:"modal_form",validatorgroup:"rz", wideword:false,onerror:function(msg){return false;},
			    onsuccess:function(){
					var email_val = $("#modal_email").val();
					var mobile_val = $("#modal_mobile").val();
					var yzm_val = $("#modal_yzm").val();
					var username_val = $("#modal_username").val();
					var cardid_val = $("#u_body_num").val();
					$.post("/user/ajaxusersave",{'email_val':email_val,'mobile_val':mobile_val,'yzm_val':yzm_val,'username_val':username_val,'cardid_val':cardid_val},function(data){
						if(data.status == '1')
						{
							$("#buttonA_x").click();
							$("#zsxm").text(username_val);
							$("#sfzh").text(cardid_val);
							if(mobile_val)
							{
								$("#sjhm").html(mobile_val);
							}
							if(email_val)
							{
								$("#dzyx").html(email_val);
							}
							status = '-4'
							$("#buttonB").click();
						}else{
							status = data.user_status;
							if(status == '-3')
							{
								if(mobile_val)
								{
									$("#moblie_text").html(mobile_val);
									$("#sjhm").html(mobile_val);
								}
								if(email_val)
								{
									$("#email_text").html(email_val);
									$("#dzyx").html(email_val);
								}
								$("#yzm_text").html(' ');
							}
							popBox(data.msg,'error');
						}
					},'json')
					
			    	return false;}});
		
		    $("#modal_yzm").formValidator({validatorgroup:"rz",onshow:" ",onfocus:"请输入验证码",oncorrect:" "}).regexValidator({regexp:"notempty",datatype:"enum",onerror:"请输入验证码"})
		
		    $("#modal_username").formValidator({validatorgroup:"rz",onshow:" ",onfocus:"请输入真实姓名",oncorrect:" "}).regexValidator({regexp:"chinese2",datatype:"enum",onerror:"请输入真实姓名"})
		
		    $("#u_body_num").formValidator({validatorgroup:"rz",onshow:" ",onfocus:"请输入身份证号码",oncorrect:" "}).regexValidator({regexp:"notempty",datatype:"enum",onerror:"请输入身份证号码"})
			  .ajaxValidator({
				    type : "get",
				    url : "http://www.renrentou.com/user/AjaxCardCheck",
				    datatype : "json",
				    success : function(data){
						if(data.status == 1)
						{  
							return true;
						}else
						{ 
		//					popBox(data.msg,'error');
							return false;
						}
					},
		//			buttons: $("#button"),
		//			error: "",
				    onerror : "身份证不正确或已被认证",
				    onwait : " "
				})
		    
		
	
    $("li[data-eventname=menu],span[data-eventname=menu]").bind("click", function(){
        var tabId = $(this).attr("data-id");
        showShareTab(tabId);
        // 评论选项卡
        //TODO :待实现
        if (tabId == 5) {
            //pager("http://www.renrentou.com/comment/comment/project_id/8630/p/1", 0);
        }
    });

    // 关注项目
    $("#attention").bind("click", attention);

    // 计算器
    $("#counter").bind("click", function(){
        $("#myModa_calculator").modal("show");
    });
    
    $("#counterBtn").bind("click", function(){
        var postData = {
            "project_id": projectId,
            "amount": $("#amount").val()
        };
        $.ajax({
            type: "get",
            url: "http://www.renrentou.com/project/counter",
            dataType: "jsonp",
            data: postData,
            jsonp: "callback",
            success: function(data){
                if (data.status) {
                    $("#rate").html(data.data.rate);
                    $("#share").html(data.data.share);
                } else {
                    $("#myModa_calculator").modal("hide");
                    popBox(data.info, "info", 3, function(){
                        $("#myModa_calculator").modal("show");
                    });
                }
            }
        });
    });

    // 检测输入的是否是数字
    $("input[data-eventname=checkNumber]").bind("keyup", function(){
        if ($(this).val() == $(this).attr("value2")) {
            return;
        }
        if ($(this).val().search(/^\d*(?:\.\d{0,2})?$/) == -1) {
            $(this).val($(this).attr("value2") ? $(this).attr("value2") : "");
        } else {
            $(this).attr("value2", $(this).val());
        }
    });



    // 切换视频标签
    $("li[data-eventname=li-video]").bind("click", function(){
        var videoType = $(this).attr("data-video-type");

        if ($("div[data-event-id=video_" + videoType + "]").html() == undefined) {
            return false;
        }

        // 隐藏已经显示的视频
        $(".hot-video").hide();
        $("li[data-eventname=li-video]").removeClass("now");

        // 显示标签中的视频
        $("div[data-event-id=video_" + videoType + "]").show();
        $(this).addClass("now");
    });

    // 评论列表分页
    $("#pagerHtml a").live("click", function(){
        var url = $(this).attr("href");
        pager(url, 1);
    });
    function pager(url, type){
        $.ajax({
            type: "get",
            url: url,
            dataType: "jsonp",
            jsonp: "callback",
            success: function(data){
                if (data.status) {
                    $(".comment-box").html('<span id="comment-list-top"></span>' + data.content);
                    $("#pagerHtml").html(data.pagerHtml);
                    if (type) {
                        location = location.href.split("#")[0] + "#comment-list-top";
                    }
                }
            }
        });
    }

    // 发表评论，因为发现在同一个页面中使用两次formValidator会互相影响，所以没有继续使用formValidator
    // 建议使用validator会比formValidator更灵活稳定
    function comment(){
        var content = $("#comment_content").val();
        if (content.length < 5 || content.length > 400) {
            $("#comment_contentTip").html("<span style='color:red'>评论内容必须在5-400字符之间哦</span>");
            return false;
        }
        $("#comment_contentTip").html("");

        var postData = {
            "project_id": projectId,
            "content": $("#comment_content").val()
        };
        $.ajax({
            type: "get",
            url: "http://www.renrentou.com/comment/doComment",
            dataType: "jsonp",
            jsonp: "callback",
            data: postData,
            success: function(data){
                if (data.status) {
                    $("#comment-list-top").after(data.content);
                    $("#comment_content").val("");
                }
                else {
                    popBox(data.info, "info", 3, function(){
                        if (data.nologin != undefined) {
                            common_show_user();
                            return false;
                        }
                    });
                }
            }
        });

        return false;
    }
    $("#commentBtn").bind("click", comment);

    // 执行取消
    $("button[data-eventname=cancel]").live("click", function(){
        // 隐藏回复框
        $("form[data-eventname=commentForm]").hide();
    });

    // 显示回复框
    $("a[data-eventname=reply]").live("click", function(){
        // 首先要隐藏已经显示的其它的回复框
        $("form[data-eventname=commentForm]").hide();
        // 回复类型: 1-对回复的回复，2-对评论的回复
        var replyType = $(this).attr("data-reply-type");
        // 被回复的内容ID(可能是评论的，也可能是回复的)
        var replyId = $(this).attr("data-reply-id");
        // 被回复的内容username(可能是评论的，也可能是回复的)
        var replyUsername = $(this).attr("data-reply-username");

        // 显示回复框
        initSelector(replyType, replyId).formSelector.show();
        initSelector(replyType, replyId).contentSelector.val("回复给" + replyUsername + ": ");
    });

    // 执行回复
    $("button[data-eventname=submit]").live("click", function(){
        // 回复类型: 1-对回复的回复，2-对评论的回复
        var replyType = $(this).attr("data-reply-type");
        // 被回复的内容ID(可能是评论的，也可能是回复的)
        var replyId = $(this).attr("data-reply-id");
        // 顶级评论ID(也就是属于哪条评论)
        var commentId = replyType == 2 ? $(this).attr("data-comment-id") : replyId;
        // 回复内容
        var content = initSelector(replyType, replyId).contentSelector.val();
        // 验证提交的内容是否为空
        var reg = /^[^u4e00-u9fa5]+[^:]+:\s*([^\s].*)$/;
        if (!reg.test(content)) {
            popBox("您回复的内容不完整", "info", 3);
            return false;
        }
        content = content.match(reg)[1];

        var postData = {
            "project_id": projectId,
            "type": replyType,
            "reply_id": replyId,
            "comment_id": commentId,
            "content": content
        };
        $.ajax({
            type: "get",
            url: "http://www.renrentou.com/comment/doReply",
            dataType: "jsonp",
            data: postData,
            jsonp: "callback",
            success: function(data){
                if (data.status) {
                    $("#reply-list-top-" + commentId).before(data.content);
                    initSelector(replyType, replyId).contentSelector.val("");
                    // 回复成功后隐藏回复框
                    initSelector(replyType, replyId).formSelector.hide();
                } else {
                    popBox(data.info, "info", 3, function(){
                        if (data.nologin != undefined) {
                            common_show_user();
                            return false;
                        }
                    });
                }
            }
        });
        return false;

    });

    /**
     * 初始化选择器
     * @param int replyType 回复的类型[1-对回复的回复，2-对评论的回复]
     * @param int replyId 被回复用户的ID
     */
    function initSelector(replyType, replyId)
    {
        // 根据不同的回复类型设置不同的选择器标识
        var formSelector = "#form-" + replyType + "-" + replyId; // 表单
        var contentSelector = "#input-" + replyType + "-" + replyId; // 内容
        var submitSelector = "#submit-" + replyType + "-" + replyId; // 提交
        var cancelSelector = "#cancel-" + replyType + "-" + replyId; // 取消

        return {
            "formSelector": $(formSelector),
            "contentSelector": $(contentSelector),
            "submitSelector": $(submitSelector),
            "cancelSelector": $(cancelSelector)
        };
    }
});
</script>
<%@include file="../common/footer.jsp" %>
</body>
</html>
