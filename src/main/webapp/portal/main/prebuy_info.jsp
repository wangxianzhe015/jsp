<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="attention-list">	
	<div class="box schedule-box">
			<div class="space-30"></div>
			<ul class="attention-ul2">
				<li><b>${project.progress}%</b> <em>已完成</em></li>
				<li><b>${project.remainingDays }天/<span>${project.prebuyDays }天</span></b> <i>剩余</i></li>
			</ul>
			<div class="space-20"></div>
			<div class="progress-s progress-s4">
				<p>
					<b style="width: ${project.progress}%"></b>
				</p>
			</div>            
            <div class="money-box">
        		<h2>已预购金额:</h2>
				<p class="current-money"><span class="yen">¥</span>${project.raisedTotalAmount }</p>    
                <p class="target-money prepub-target">如果你喜欢这个项目，请分享给你的小伙伴，喜欢的人越多越能帮助项目顺利上线！<b>预热还有<em>${project.remainingDays }</em>天结束</b></p>
            </div>             
			<div class="money-box">
	                <h2>筹资目标:</h2>
	                <p class="target-money" style="font-size: 18px;">
	                	<em><span class="yen">¥</span>${project.financeAmount}</em>元
	                </p>			
					<h2>项目方出资:</h2>
					<p class="target-money" style="font-size: 18px;">
						<em><span class="yen">¥</span>${project.founderInvestAmount }</em>元
					</p>					
					<p class="target-money" style=" font-size: 18px;">
						已预约份数:<em><span>${project.subscribedTotalCopies }</span></em>&nbsp;&nbsp; 单笔最低:<em><span class="yen">¥</span>${project.minInvestAmount }</em>元
					</p>								
			</div>        
            <div class="reserve"> 
               <%/*  
                <div class="project-status-detail ">
                    <div class="project-pre-seller-bg">
                        <div class="project-pre-seller-indicator">
                            <div class="indicate i-${project.subscribedInverstorCount}">
                                <i><s></s></i>
                                <div class="like-number"><b></b>${project.subscribedInverstorCount}人</div>
                                <span class="corner-outer"><span class="corner-inner"></span></span>
                            </div>
                        </div>
                    </div>
                </div>
                */ %>              
 				<div class="space-20"></div>
			 	<div class="countdown">
					倒计时：
					<i class="t_d_${project.projectId }">00天</i> 
					<i class="t_h_${project.projectId }">00小时</i>
					<i class="t_m_${project.projectId }">00分</i> 
					<i class="t_s_${project.projectId }">00秒</i>
				</div>
				<div class="space-20"></div>
	               
				<div class="subscribe-btn <c:if test="${empty sessionUser}">ajax_login</c:if>  <c:if test="${not empty sessionUser}">prebuy</c:if>">
					<a href="javascript: void(0)">立即预约</a>
				</div>
                
            </div>
            
        </div>	

	<div class="space-20"></div>
</div>
<script>
setInterval(function(){getRTime("${project.projectId}", ${project.prebuyEndTime})}, 1000);
</script>