<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
  		<c:forEach items="${hotProjects}" var="hotProject" varStatus="index">
  		    		<c:if test="${index.count%3==0}">
						<c:set var="evenClass" value="hot-no-b"/>
					</c:if>
					
					<c:if test="${hotProject.projectState=='prepared' }">
							<!-- 预热项目 -->
							<div class="hot-project-list ${evenClass}">
								<div class="project-list-t"></div>
								<div class="project-list-c">
									<a href="<%=servletPath %>/portal/main/showProject.action?projectId=${hotProject.projectId}">
										<img src="${hotProject.projectImage }" style="width: 237px;height: 158px;" alt="${hotProject.projectName }">
									</a>
									<div class="space-10"></div>
									<p class="text-text" title="${hotProject.projectName }">${hotProject.projectName }</p>
									<div class="space-10"></div>
									<p class="text-text2">${hotProject.projectDesc }</p>
									<p class="text-text4">正在预热中......</p>
									<p class="text-text" style="margin-top: 5px">出让股份：${hotProject.investorInvestRate}%</p>
									<div class="space-20"></div>
									<div class="hot-project-ul2 hot-project-ul5">
										<div>
											<span>融资金额</span> <span>￥${hotProject.financeAmount}元</span>
										</div>
										<div>
											<span>单笔投资</span> <span>￥${hotProject.minInvestAmount}元</span>
										</div>
										<div>
											<span>上线时间</span> <span><fmt:formatDate value="${hotProject.raiseBeginDate}" pattern="yyyy-MM-dd"/></span>
										</div>
									</div>
								</div>
							</div>
						</c:if>
						<c:if test="${hotProject.projectState=='financing' }">
							<div class="hot-project-list ${evenClass}">
                                   <div class="project-list-t"></div>
                                   <div class="project-list-c">
                                        <a href="<%=servletPath %>/portal/main/showProject.action?projectId=${hotProject.projectId}">
                                            <img src="${hotProject.projectImage }" style="width: 237px;height: 158px;"  alt="${hotProject.projectName }">
                                        </a>
                                        <div class="space-10"></div>
                                        <p class="text-text" title="${hotProject.projectName }">${hotProject.projectName } </p>
                                        <div class="space-10"></div>
                                        <p class="text-text2">${hotProject.projectDesc }</p>
                                         <b>融资进度</b>
                                        <em>出让股份：${hotProject.investorInvestRate}%</em>
                                        <div class="progress-s progress-s3">
                                             <p><b style="width: ${hotProject.progress}%"></b></p>
                                             <i>${hotProject.progress}%</i>
                                        </div>
                                        <div class="space-20"></div>
                                        <div class="hot-project-ul2 hot-project-ul5">
                                             <div>
                                                   <span>融资金额</span>
                                                   <span>￥${hotProject.financeAmount }元</span>
                                              </div>
                                              <div>
                                                   <span>单笔投资</span>
                                                   <span>￥${hotProject.minInvestAmount }元</span>
                                              </div>
                                              <div>
                                                   <span>上线时间</span>
                                                   <span><fmt:formatDate value="${hotProject.raiseBeginDate}" pattern="yyyy-MM-dd"/></span>
                                              </div>
                                        </div>
                                   </div>
                              </div>
						
						</c:if>
					</c:forEach>