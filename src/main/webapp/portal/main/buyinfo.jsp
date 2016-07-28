<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../common/common.jsp"%>
<c:set var="pageTitle" value="认购项目"></c:set>
<%@include file="../common/meta.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/subscribe.css?" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
</head>
<body>

<%@include file="../common/header.jsp" %>
<script>
    function checkNums(){
        var alNums = ${project.remainingCopies };
        var limitNums=${project.limitCount};//限购
        var nums = parseInt($('#nums').val());
        var code = $('#code').val();
        if(nums > 0){
            if(limitNums!=null && limitNums>0){
            	if(nums>limitNums){
            		popBox("每人最多认购"+limitNums+"份",'info');
            		return false;
            	}
            }
            
        	if(nums > alNums){
                popBox('认购份数大于当前剩余份数，请您重新选择！','info');
                return false;
            }
            
        }
        else{
            popBox('认购份数未选择，请您重新选择！','info');
            return false;
        }
        if(!code){
            popBox('请输入验证码！','info');
            return false;
        }
        return true;
    }
    
   $(function(){
       $.formValidator.initConfig({formid:"form", autotip:true, submitonce:true});
       $("#code").formValidator({onshow:"请输入验证码",onfocus:"请输入验证码",oncorrect:""}).regexValidator({regexp:"notempty",datatype:"enum",onerror:"验证码不能为空"});
       var lestamount = ${project.minInvestAmount};
       var alNums = ${project.remainingCopies };
       var limitNums=${project.limitCount};//限购
       
       if(alNums <=0){
           $('.inputVal').val(0);
           $('#amount').html(0);
           $('#nums').val(0);
           $('#amounts').val(0);
       }
       $('.number_up').click(function(){
           
           var sum = 1;
           sum = sum + Number($('.inputVal').val()) ;
           
           if(limitNums!=null && limitNums>0){
           	if(sum>limitNums){
           		popBox("每人最多认购"+limitNums+"份",'info');
           		sum = limitNums;
           	}
           }
           
           if(sum > alNums)
               sum = alNums;
           
           if(alNums <=0){sum = 0;}
           $('.inputVal').val(sum);
           $('#amount').html((sum*lestamount).toFixed(2));
           $('#nums').val(sum);
           $('#amounts').val((sum*lestamount).toFixed(2));
           });
        $('.number_down').click(function(){
           var sum = 1;
           sum = Number($('.inputVal').val()) - 1;
           if(sum < 1){
               sum = 1;
           }
           if(alNums <=0){sum = 0;}
           $('.inputVal').val(sum);
           $('#amount').html((sum*lestamount).toFixed(2));
           $('#nums').val(sum);
           $('#amounts').val((sum*lestamount).toFixed(2));
           });
        
       })
       
       function submitOrder(){
	    var projectId = $('#pid').val();
	    var nums=$('#nums').val();
	   
		$.post("<%=servletPath%>/portal/uc/checkBuyNum.action",{'projectId':projectId,'nums':nums},function(data){  
 			if(data.code==-1){
 				popBox(data.message,'error');
 				return ;
 			}else{
 				$('#pay').submit();
 			}
	    },"json");
		
	   	
   		}
</script>
<div class="wrap-bg">

    <div class="wrap  user_tit_box">
        <div class="fl user_tit font-wet">确认认购信息</div>

    </div>

    <div class="wrap sub_cont">
        <div class="sub_cont_top">
            <dl class="fl">
                <dt class="fl"><img src="${project.projectImage }" onerror="this.src='http://img2.renrenchou.com/s/v2/images/www_project/subscribe/img.jpg'"/></dt>
                <dd class="fr">${project.projectName }</dd>
            </dl>
            <div class="fr sub_cont_top_r">
                <div class="sub_cont_top_r_num">
                    <p class="fl number"><span class="fl">认购份数：</span><a href="javascript:;" class="fl number_down">-</a><input type="text" name="" value="1" class="fl inputVal" disabled="true" onkeyup="this.value=this.value.replace(/\D/g,'')" onkeydown="if(event.keyCode==32) return false"><a href="javascript:;" class="fl number_up">+</a>份</p>
                    <p class="fl yuan_fen">¥ <span>${project.minInvestAmount }</span>元/份</p>
                    <p class="fl yuan_fen">当前剩余份数： <span>${project.remainingCopies }</span></p>
                </div>
                <div class="clear-both"></div>
                <form action="<%=servletPath %>/portal/uc/submitOrder.action" class="form" method="post" name="pay" id="pay" onsubmit="return checkNums();">
                    <div class="form_top">
                      <span class="fl">验证码:</span>
                      <input type="text" class="fl" id="code" name="code" placeholder="请输入验证码" />
                      <input type="hidden" name="nums" value="1" id="nums" />
                      <input type="hidden" name="amounts" value="${project.minInvestAmount }" id="amounts" />
                      <input type="hidden" name="projectId" value="${project.projectId }" id="pid" />
                      <img id="project_freeze_check" src="<%=contextPath %>/portal/common/payimgcode.jsp?t=<%=new Date().getTime() %>" class="fl"/>
                      <a class="fl" href="javascript:void(0);" onclick="$('#project_freeze_check').attr('src','<%=contextPath %>/portal/common/payimgcode.jsp?t='+Math.random())">看不清?换一张</a>
                    </div>
                    <p class="clear-both"></p>
                    <div class="codeTip"><div id="codeTip"></div></div>
                </form>
            </div>
        </div>
        <div class="sub_cont_bot">
          <p class="p_sub_cont_bot"><b>实付款：</b>¥<span id="amount">${project.minInvestAmount }</span> 元</p>
          <button id="paybtn" class="btn_sub_cont_bot" onclick="submitOrder();">提交订单</button>
        </div>
    </div>
</div>
<!--首页底部-->
<%@include file="../common/footer.jsp" %>
</body>
</html>