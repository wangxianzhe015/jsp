<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
								<h4>资质审核</h4>
								<ul class="review_sh">
								   	<c:choose>
										<c:when test="${! empty projectCert.legalIdCard}">
											<li class="on"><span>法人代表身份证</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>法人代表身份证</span> <i></i></li>
										</c:otherwise>
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.legalCreditReport}">
											<li class="on"><span>法人代表个人信用报告</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>法人代表个人信用报告</span> <i></i></li>
										</c:otherwise>										
									</c:choose>	
									<c:choose>
										<c:when test="${! empty projectCert.bizLicense}">
											<li class="on"><span>营业执照</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>营业执照</span> <i></i></li>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${! empty projectCert.bizLicenseCopy}">
											<li class="on"><span>营业执照副本</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>营业执照副本</span> <i></i></li>
										</c:otherwise>											
									</c:choose>
									<c:choose>
										<c:when test="${! empty projectCert.taxRegCert}">
											<li class="on"><span>税务登记证</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>税务登记证</span> <i></i></li>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${! empty projectCert.taxRegCertCopy}">
											<li class="on"><span>税务登记证副本</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>税务登记证副本</span> <i></i></li>
										</c:otherwise>	
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.orgCodeCert}">
											<li class="on"><span>组织机构代码证</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>组织机构代码证</span> <i></i></li>
										</c:otherwise>
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.orgCodeCertCopy}">
											<li class="on"><span>组织机构代码证副本</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>组织机构代码证副本</span> <i></i></li>
										</c:otherwise>										
									</c:choose>
									<c:choose>		
										<c:when test="${! empty projectCert.companyPhoto}">
											<li class="on"><span>公司照片</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>公司照片</span> <i></i></li>
										</c:otherwise>		
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.tenancyContract}">
											<li class="on"><span>场地租赁合同</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>场地租赁合同</span> <i></i></li>
										</c:otherwise>	
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.financialReport}">
											<li class="on"><span>财务报表</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>财务报表</span> <i></i></li>
										</c:otherwise>
									</c:choose>
									<c:choose>	
										<c:when test="${! empty projectCert.industryLicense}">
											<li class="on"><span>行业许可证</span> <i></i></li>
										</c:when>
										<c:otherwise>
											<li><span>行业许可证</span> <i></i></li>
										</c:otherwise>																																																																																			
									</c:choose>
							
								</ul>
