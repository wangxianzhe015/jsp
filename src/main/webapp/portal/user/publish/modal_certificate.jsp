<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--证件信息修改-->
<div class="modal fade" id="myModa_certificate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-small" style="width: 500px;height: 800px">
		<div class="modal-content">
			<div class="modal-header">
				<button id="papers_x" type="button" class="modal-close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">证件信息修改</h4>
			</div>
			<div class="modal-body" style="height:400px; overflow: auto;">
				<div class="certificate_form">
					<form id="form_papers" class="clear">
						<input type="hidden" name="projectCert.projectId" value="${projectCert.projectId }" />
						<ul>
							<li>
								<p>法定代表人:</p> 
								<span class="button" style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script type="text/javascript">
										var uploadData = {
										'data': '',
										'field': 'legal_id_path',
										'resize':[0]
										};
										$('#legal_id_path').uploadFile(uploadData,function(data){
											
											var rand = Math.ceil(Math.random()*10);
											if(data.code == 1) {
												var _test = data.url2;
												_test = _test.replace(/\&amp;/,'&');
												$('#legal_id_path_val').val(data.url2);
							
												data.url2 = data.url2.replace(/\&amp;/g,'&');
												$('#legal_id_path_img').attr('src',_test);
												$('#legal_id_path_msg').html(data.message);
												return true;
											}else{
												alert(data.message);
												$('#legal_id_path_msg').html(data.message);
												return false;
											}
										});
									</script> 
									<input type="hidden" name="projectCert.legalIdCard" value="${projectCert.legalIdCard }" id="legal_id_path_val" /> 
									<input type='file' name='legal_id_path' id='legal_id_path' class="file_issue" />
									</span><em id="legal_id_path_msg"><c:if test="${empty projectCert.legalIdCard }"> 还未提交</c:if> </em> 
									
							</li>
							<li>
								<p>法定代表个人信用报告</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'legal_credit',
									'resize':[0]
									};
									$('#legal_credit').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#legal_credit_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#legal_credit_img').attr('src',_test);
											$('#legal_credit_msg').html(data.message);
											return true;
										}else{
											alert(data.message)
											$('#legal_credit_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.legalCreditReport" value="${projectCert.legalCreditReport }" id="legal_credit_val" /> 
									<input type='file' name='legal_credit' id='legal_credit' class="file_issue" />
									</span> <em id="legal_credit_msg"><c:if test="${empty projectCert.legalCreditReport }"> 还未提交</c:if></em> 
							</li>
							<li>
								<p>营业执照</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'business_licence',
									'resize':[0]
									};
									$('#business_licence').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#business_licence_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#business_licence_img').attr('src',_test);
											$('#business_licence_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#business_licence_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.bizLicense" value="${projectCert.bizLicense }" id="business_licence_val" /> 
									<input type='file'	name='business_licence' id='business_licence' class="file_issue" />
									</span> <em id="business_licence_msg"><c:if test="${empty projectCert.bizLicense }">还未提交</c:if></em>
							</li>
							<li>
								<p>营业执照副本</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
								var uploadData = {
								'data': '',
								'field': 'business_licence_fb',
								'resize':[0]
								};
								$('#business_licence_fb').uploadFile(uploadData,function(data){
									var rand = Math.ceil(Math.random()*10);
									if(data.code == 1) {
										var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
										$('#business_licence_fb_val').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#business_licence_fb_img').attr('src',_test);
										$('#business_licence_fb_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#business_licence_fb_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type="hidden" name="projectCert.bizLicenseCopy" value="${projectCert.bizLicenseCopy }" id="business_licence_fb_val" /> 
								<input type='file' name='business_licence_fb' id='business_licence_fb' class="file_issue" />
								</span><em id="business_licence_fb_msg"> <c:if test="${empty projectCert.bizLicenseCopy }"> 还未提交</c:if></em> 
							</li>
							<li>
								<p>税务登记证</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'tax_registration',
									'resize':[0]
									};
									$('#tax_registration').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#tax_registration_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#tax_registration_img').attr('src',_test);
											$('#tax_registration_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#tax_registration_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.taxRegCert" value="${projectCert.taxRegCert}" id="tax_registration_val" /> 
									<input type='file' name='tax_registration' id='tax_registration' class="file_issue" />
									</span> <em id="tax_registration_msg"><c:if test="${empty projectCert.taxRegCert }">还未提交</c:if></em>
							</li>
							<li>
								<p>税务登记证副本</p> 
								<span class="button" style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'tax_registration_fb',
									'resize':[0]
									};
									$('#tax_registration_fb').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
												_test = _test.replace(/\&amp;/,'&');
											$('#tax_registration_fb_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#tax_registration_fb_img').attr('src',_test);
											$('#tax_registration_fb_msg').html(data.message);
											return true;
										}else{
											alert(data.message)
											$('#tax_registration_fb_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.taxRegCertCopy" value="${projectCert.taxRegCertCopy }" id="tax_registration_fb_val" /> <input type='file'
									name='tax_registration_fb' id='tax_registration_fb' class="file_issue" />
									</span><em id="tax_registration_fb_msg"><c:if test="${empty projectCert.taxRegCertCopy }">还未提交</c:if></em> 
							</li>
							<li>
								<p>组织机构代码证</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'organizing_institution',
									'resize':[0]
									};
									$('#organizing_institution').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#organizing_institution_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#organizing_institution_img').attr('src',_test);
											$('#organizing_institution_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#organizing_institution_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.orgCodeCert" value="${projectCert.orgCodeCert }" id="organizing_institution_val" /> 
									<input type='file'	name='organizing_institution' id='organizing_institution' class="file_issue" />
								   </span><em id="organizing_institution_msg"><c:if test="${empty projectCert.orgCodeCert }">还未提交</c:if></em>
							</li>
							<li>
								<p>组织机构代码证副本</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'organizing_institution_fb',
									'resize':[0]
									};
									$('#organizing_institution_fb').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#organizing_institution_fb_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#organizing_institution_fb_img').attr('src',_test);
											$('#organizing_institution_fb_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#organizing_institution_fb_msg').html(data.message);
											return false;
										}
									});
								</script> 
								<input type="hidden" name="projectCert.orgCodeCertCopy" value="${projectCert.orgCodeCertCopy }" id="organizing_institution_fb_val" /> 
								<input type='file'	name='organizing_institution_fb' id='organizing_institution_fb'	class="file_issue" />
								</span> 
								<em id="organizing_institution_fb_msg"><c:if test="${empty projectCert.orgCodeCertCopy }">还未提交 </c:if></em>
							</li>
							<li>
								<p>公司照片</p> <span class="button" style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'company_photo',
									'resize':[0]
									};
									$('#company_photo').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#company_photo_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#company_photo_img').attr('src',_test);
											$('#company_photo_msg').html(data.message);
											return true;
										}else{
											alert(data.message)
											$('#company_photo_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.companyPhoto" value="${projectCert.companyPhoto}"	id="company_photo_val" /> 
									<input type='file' name='company_photo' id='company_photo' class="file_issue" />
									</span><em id="company_photo_msg"><c:if test="${empty projectCert.companyPhoto }">还未提交</c:if></em> 
							</li>
							<li>
								<p>场地租凭合同</p> 
								    <span class="button" style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
								var uploadData = {
								'data': '',
								'field': 'contract_tenancy',
								'resize':[0]
								};
								$('#contract_tenancy').uploadFile(uploadData,function(data){
									var rand = Math.ceil(Math.random()*10);
									if(data.code == 1) {
										var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
										$('#contract_tenancy_val').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#contract_tenancy_img').attr('src',_test);
										$('#contract_tenancy_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#contract_tenancy_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type="hidden" name="projectCert.tenancyContract" value="${projectCert.tenancyContract}" id="contract_tenancy_val" /> 
								<input type='file'	name='contract_tenancy' id='contract_tenancy' class="file_issue" />
							    </span> <em id="contract_tenancy_msg"><c:if test="${empty projectCert.tenancyContract }">还未提交 </c:if></em>
							</li>
							<li>
								<p>财务报表</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
									var uploadData = {
									'data': '',
									'field': 'financial_statement',
									'resize':[0]
									};
									$('#financial_statement').uploadFile(uploadData,function(data){
										var rand = Math.ceil(Math.random()*10);
										if(data.code == 1) {
											var _test = data.url2;
											_test = _test.replace(/\&amp;/,'&');
											$('#financial_statement_val').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#financial_statement_img').attr('src',_test);
											$('#financial_statement_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#financial_statement_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type="hidden" name="projectCert.financialReport" value="${projectCert.financialReport}" id="financial_statement_val" /> 
									<input type='file' name='financial_statement' id='financial_statement' class="file_issue" />
									</span> <em id="financial_statement_msg"><c:if test="${empty projectCert.financialReport }">还未提交</c:if></em> 
							</li>
							<li>
								<p>卫生许可证</p> <span class="button"
								style="background: #f63;width: 100px;height: 30px;margin-top: 16px;margin-left: 0">
									<a style="color: #fff">选择图片 ></a> 
									<script	type="text/javascript">
							var uploadData = {
							'data': '',
							'field': 'hygienic_license_img',
							'resize':[0]
							};
							$('#hygienic_license_img').uploadFile(uploadData,function(data){
								var rand = Math.ceil(Math.random()*10);
								if(data.code == 1) {
									var _test = data.url2;
									_test = _test.replace(/\&amp;/,'&');
									$('#hygienic_license_img_val').val(data.url2);
				
									data.url2 = data.url2.replace(/\&amp;/g,'&');
									$('#hygienic_license_img_img').attr('src',_test);
									$('#hygienic_license_img_msg').html(data.message);
									return true;
								}else{
									alert(data.message)
									$('#hygienic_license_img_msg').html(data.message);
									return false;
								}
							});
							</script> 
							<input type="hidden" name="projectCert.industryLicense" value="${projectCert.industryLicense }" id="hygienic_license_img_val" /> 
							<input type='file'	name='hygienic_license_img' id='hygienic_license_img' class="file_issue" />
							</span>  <em id="hygienic_license_img_msg"><c:if test="${empty projectCert.industryLicense }">还未提交</c:if></em> 
							</li>
						</ul>
						<div class="dia_btn">
							<button onclick="form_sub('papers');" type="button" style="margin-right: 15px">提交</button>
							<button type="button" data-dismiss="modal">取消</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>