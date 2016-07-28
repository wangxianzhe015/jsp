<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="layout-1190">
	<div class="news-prefecture">
		<div class="prefecture-c">
			<div class="financing-box">
				<c:forEach items="${projects}" var="project" varStatus="index">
					<c:set var="evenClass" value=""/>
					<c:if test="${(index.count) %2==0}">
						<c:set var="evenClass" value="run-king2"/>
					</c:if>
					
					
					<c:if test="${project.projectState=='financing' }">

						<!-- 融资项目 -->
						<div class="run-king ${evenClass}">
							<div class="run-king-l">
								<a
									href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
									target="_blank"> <img
									src="${project.projectImage }"
									alt="${project.projectName }" title="${project.projectName }" />
									<div class="prefecture-text prefecture-text2 text_bottom"
										style="display:none;">
										<div class="hot-project-t hot-project-t4">
											<div class="t4-text">
												<div class="t3-text-div1">
													项目方出资比例：<i>${project.founderInvestRate}%</i>
												</div>
												<div class="t3-text-div2">
													收益：<i>${project.founderIncomeRate}%</i>
												</div>
											</div>
										</div>
										<div class="hot-project-b hot-project-b4">
											<div class="t4-text">
												<div class="t3-text-div1">
													投资人出资比例：<i>${project.investorInvestRate}%</i>
												</div>
												<div class="t3-text-div2">
													收益：<i>${project.investorIncomeRate}%</i>
												</div>
											</div>
										</div>
									</div>
									<p>
										<i onclick="return false" title="${project.projectName }">${project.projectName }</i>
									</p>
									<div class="rzxm"></div> <span class="position-span king-span"
									title="${project.provinceName}${project.cityName}">${project.cityName }</span>
								</a>
							</div>
							<div class="run-king-r">
								<div class="run-king-show">
									<div class="height-r">
										<p class="text-text">${project.projectName }</p>
										<div class="space-10"></div>
										<p class="textTp"></p>
									</div>
									<em>融资进度</em>
									<div class="progress-s progress-s2 hotMargin">
										<p>
											<b style="width: ${project.progress}%"></b>
										</p>
										<i>${project.progress}%</i>
									</div>
									<div class="hot-project-ul2 run-king-ul2 run-f14">
										<div>
											<span>融资总额</span> <span>￥${project.financeAmount}元</span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${project.minInvestAmount}元</span>
										</div>
										<div>
											<span>剩余时间</span> <span>${project.remainingDays}天</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${project.projectState=='prepared' }">
						<!-- 预热项目 -->
						<div class="run-king ${evenClass}">
							<div class="run-king-l">
								<a
									href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
									target="_blank"> <img
									src="${project.projectImage }"
									alt="${project.projectName }" title="${project.projectName }" />
									<div class="prefecture-text prefecture-text2 text_bottom"
										style="display:none;">
										<div class="hot-project-t hot-project-t4">
											<div class="t4-text">
												<div class="t3-text-div1">
													项目方出资比例：<i>${project.founderInvestRate}%</i>
												</div>
												<div class="t3-text-div2">
													收益：<i>${project.founderIncomeRate}%</i>
												</div>
											</div>
										</div>
										<div class="hot-project-b hot-project-b4">
											<div class="t4-text">
												<div class="t3-text-div1">
													投资人出资比例：<i>${project.investorInvestRate}%</i>
												</div>
												<div class="t3-text-div2">
													收益：<i>${project.investorIncomeRate}%</i>
												</div>
											</div>
										</div>
									</div>
									<p>
										<i onclick="return false" title="${project.projectName }">${project.projectName }</i>
									</p>
									<div class="yexm"></div> <span class="position-span king-span"
									title="${project.provinceName}${project.cityName}">${project.cityName}</span>
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
										<p class="text-text">${project.projectName}</p>
										<div class="space-10"></div>
										<p class="textTp"></p>
									</div>

									<p class="text-text4">
										倒计时： <i class="t_d_${project.projectId}">00天</i> 
										<i class="t_h_${project.projectId}">00时</i>
										<i class="t_m_${project.projectId}">00分</i> 
										<i class="t_s_${project.projectId}">00秒</i>
									</p>
									<script>setInterval(function(){getRTime("${project.projectId}", ${project.prebuyEndTime})}, 1000);</script>
									<div class="hot-project-ul2 run-king-ul2 run-f14">
										<div>
											<span>上线时间</span> <span>${project.formatOnlineDate}</span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${project.minInvestAmount}元</span>
										</div>
										<div>
											<span>融资金额</span> <span>￥${project.financeAmount}元</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${project.projectState=='successed' }">
						<!-- 成功项目 -->
						<div class="run-king ${evenClass}">
							<div class="run-king-l">
								<a
									href="<%=servletPath %>/portal/main/showProject.action?projectId=${project.projectId}"
									target="_blank"> <img
									src="${project.projectImage }"
									alt="${project.projectName }" title="${project.projectName }" />
									<p>
										<i onclick="return false" title="${project.projectName }">${project.projectName }</i>
									</p> <!--div class="jgjyw"></div--> 
									<span class="position-span king-span" title="${project.provinceName}${project.cityName}">${project.cityName}</span>
									<div class="rankImg3">
										<div class="rankC">
											<i class="greenImg1"></i>

										</div>
									</div>
								</a>
							</div>
							<div class="run-king-r">
								<ul class="run-king-ul runKing${index.count}">
									<li class="on"><span></span> <i>融资成功</i></li>
									<li><span></span> <i>经营中</i></li>
									<li class="king-noB"><span></span> <i>分红</i></li>
								</ul>
								<div class="run-king-show${index.count}">
									<div class="run-king-text">
										已筹资：<span>￥${project.raisedTotalAmount }元</span>
									</div>
									<div class="hot-project-ul2 run-king-ul2">
										<div>
											<span>完成时间</span> <span>${project.tradeEndDate}</span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${project.minInvestAmount}元</span>
										</div>
										<div>
											<span>融资金额</span> <span>￥${project.financeAmount}元</span>
										</div>
									</div>
								</div>
								<div class="run-king-show${index.count}" style="display: none">
									<div class="run-king-text">
										融资开店数量：<span>${project.shopCount }家</span>
									</div>
									<div class="run-king-text2">
										<span>地址：</span><i>${project.province}${project.city}${project.address}</i>
									</div>
								</div>
								<div class="run-king-show${index.count}" style="display: none">
									<div class="run-king-text">
										开店筹备时长：<span>60天</span>
									</div>
									<div class="hot-project-ul2 run-king-ul2">
										<div>
											<span>盈利可分红时间</span> 
											<span>180天</span>
										</div>
										<div>
											<span>月营业均收入</span>
											
										</div>
										<div>
											<span>月平均净利润</span>
											
										</div>
									</div>
								</div>
								<div class="run-king-show${index.count}" style="display: none">
									<div class="run-king-text run-king-text3">
										第一次分红开始时间：<span></span>
									</div>
									<div class="hot-project-ul2 run-king-ul3">
										<div>
											<span>分红总金额</span> <span>￥0元</span>
										</div>
										<div>
											<span>平均月回报率</span> <span>0%</span>
										</div>
										<div>
											<span>平均年回报率</span> <span>0%</span>
										</div>
									</div>
									<div class="hot-project-ul2 run-king-ul3 run-king-ul4">
										<div>
											<span>分红年度</span> <span></span>
										</div>
										<div>
											<span>分红总期数</span> <span>0期</span>
										</div>
										<div>
											<span>最新分红金额</span> <span>0元</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					
				</c:forEach>
			</div>
		</div>
	</div>
</div>
