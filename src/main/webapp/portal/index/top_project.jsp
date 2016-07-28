<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="layout-1190">
	<div class="news-prefecture">
        <div class="prefecture-t prefecture-t-b">
               <div class="space-10"></div>
               <h4>精彩项目<a name="hot-3" id="hot-3"></a></h4>
               <div class="clear-both"></div>
        </div>	
		<div class="prefecture-c">
			<div class="financing-box">
					<c:if test="${topProject.projectState=='financing' }">

						<!-- 融资项目 -->
						<div class="run-king" style="width:1130px;height:300px">
							<div class="run-king-l">
								<a
									href="<%=servletPath %>/portal/main/showProject.action?projectId=${topProject.projectId}"
									target="_blank"> <img
									src="${topProject.projectImage }"
									alt="${topProject.projectName }" title="${topProject.projectName }" />
									<p>
										<i onclick="return false" title="${topProject.projectName }">${topProject.projectName }</i>
									</p>
									<div class="rzxm"></div> <span class="position-span king-span"
									title="${topProject.provinceName}${topProject.cityName}">${topProject.cityName }</span>
								</a>
							</div>
							<div class="run-king-r">
								<div class="run-king-show">
									<div class="height-r">
										<p class="text-text">${topProject.projectName }</p>
										<div class="space-10"></div>
										<p class="textTp"></p>
									</div>
									<em>融资进度</em>
									<div class="progress-s progress-s2 hotMargin">
										<p>
											<b style="width: ${topProject.progress}%"></b>
										</p>
										<i>${topProject.progress}%</i>
									</div>
									<div class="hot-project-ul2 run-king-ul2 run-f14">
										<div>
											<span>融资总额</span> <span>￥${topProject.financeAmount}元</span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${topProject.minInvestAmount}元</span>
										</div>
										<div>
											<span>剩余时间</span> <span>${topProject.remainingDays}天</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${topProject.projectState=='prepared' }">
						<!-- 预热项目 -->
						<div class="run-king" style="width:1130px">
							<div class="run-king-l">
								<a
									href="<%=servletPath %>/portal/main/showProject.action?projectId=${topProject.projectId}"
									target="_blank"> <img
									src="${topProject.projectImage }"
									alt="${topProject.projectName }" title="${topProject.projectName }" />
									<p>
										<i onclick="return false" title="${topProject.projectName }">${topProject.projectName }</i>
									</p>
									<div class="yexm"></div> <span class="position-span king-span"
									title="${topProject.provinceName}${topProject.cityName}">${topProject.cityName}</span>
									<div class="rankImg3">
										<div class="rankC">
											<i class="greenImg1"></i>
										</div>
									</div>
								</a>
							</div>
							<div class="run-king-r">
								<div class="run-king-show">
									<div class="height">
										<p class="text-text">${topProject.projectName}</p>
										<div class="space-10"></div>
										<p class="textTp"></p>
									</div>

									<p class="text-text4">
										倒计时： <i class="t_d_${topProject.projectId}">00天</i> 
										<i class="t_h_${topProject.projectId}">00时</i>
										<i class="t_m_${topProject.projectId}">00分</i> 
										<i class="t_s_${topProject.projectId}">00秒</i>
									</p>
									<script>setInterval(function(){getRTime("${topProject.projectId}", ${topProject.prebuyEndTime})}, 1000);</script>
									<div class="hot-project-ul2 run-king-ul2 run-f14">
										<div>
											<span>上线时间</span> <span><fmt:formatDate value="${topProject.raiseBeginDate}" pattern="yyyy-MM-dd"/></span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${topProject.minInvestAmount}元</span>
										</div>
										<div>
											<span>融资金额</span> <span>￥${topProject.financeAmount}元</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
			</div>
		</div>
	</div>
</div>
