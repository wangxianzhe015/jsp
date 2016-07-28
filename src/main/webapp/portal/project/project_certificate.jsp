<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
				<table class="content">
						<tr>
							<td width="150px;" class="title">
								法人代表身份证
							</td>
							<td>
								<input type="text" id="legalIdCard" name="projectCert.legalIdCard" value="${projectCert.legalIdCard}"  readonly="readonly" class="line_input" size="40"/> 
								<input type='file' name='legal_id_path' id='legal_id_path' class="file_issue" />
								<em id="legal_id_path_msg"> </em> 
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
												$('#legalIdCard').val(data.url2);
							
												data.url2 = data.url2.replace(/\&amp;/g,'&');
												$('#legal_id_path_msg').html(data.message);
												return true;
											}else{
												alert(data.message);
												$('#legal_id_path_msg').html(data.message);
												return false;
											}
										});
								</script> 
							</td>
						</tr>
						<tr>
							<td class="title">
								法人代表个人信用报告
							</td>
							<td>
								<input type="text" id="legalCreditReport" name="projectCert.legalCreditReport" value="${projectCert.legalCreditReport}" readonly="readonly"  class="line_input" size="40"/>
								<input type='file' name='legal_credit' id='legal_credit' class="file_issue" />
								<em id="legal_credit_msg"></em> 								
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
											$('#legalCreditReport').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#legal_credit_msg').html(data.message);
											return true;
										}else{
											
											alert(data.message)
											$('#legal_credit_msg').html(data.message);
											return false;
										}
									});
									</script> 								
							</td>
						</tr>
						<tr>
							<td class="title">
								公司照片
							</td>
							<td>
								<input type="text" id="companyPhoto" name="projectCert.companyPhoto" value="${projectCert.companyPhoto}"  readonly="readonly" class="line_input" size="40"/>
									<input type='file' name='company_photo' id='company_photo' class="file_issue" />
									<em id="company_photo_msg"></em> 									
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
											$('#companyPhoto').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#company_photo_msg').html(data.message);
											return true;
										}else{
											alert(data.message)
											$('#company_photo_msg').html(data.message);
											return false;
										}
									});
									</script> 
								
							</td>
						</tr>							
						<tr>
							<td class="title">
								营业执照
							</td>
							<td>
								<input type="text" id="bizLicense" name="projectCert.bizLicense" value="${projectCert.bizLicense}" readonly="readonly"  class="line_input" size="40">
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
											$('#bizLicense').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#business_licence_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#business_licence_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type='file'	name='business_licence' id='business_licence' class="file_issue" />
									<em id="business_licence_msg"></em>								
							</td>
						</tr>
						<tr>
							<td class="title">
								营业执照副本
							</td>
							<td>
								<input type="text" id="bizLicenseCopy" name="projectCert.bizLicenseCopy" value="${projectCert.bizLicenseCopy}"  readonly="readonly" class="line_input" size="40">
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
										$('#bizLicenseCopy').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#business_licence_fb_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#business_licence_fb_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type='file' name='business_licence_fb' id='business_licence_fb' class="file_issue" />
								<em id="business_licence_fb_msg"></em> 								
							</td>
						</tr>		
						<tr>
							<td class="title">
								税务登记证
							</td>
							<td>
								<input type="text" id="taxRegCert" name="projectCert.taxRegCert" value="${projectCert.taxRegCert}"  readonly="readonly" class="line_input" size="40">
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
											$('#taxRegCert').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#tax_registration_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#tax_registration_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type='file' name='tax_registration' id='tax_registration' class="file_issue" />
									<em id="tax_registration_msg"></em>								
							</td>
						</tr>
						<tr>
							<td class="title">
								税务登记证副本
							</td>
							<td>
								<input type="text" id="taxRegCertCopy" name="projectCert.taxRegCertCopy" value="${projectCert.taxRegCertCopy}"  class="line_input" size="40">
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
											$('#taxRegCertCopy').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#tax_registration_fb_msg').html(data.message);
											return true;
										}else{
											alert(data.message)
											$('#tax_registration_fb_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type='file' name='tax_registration_fb' id='tax_registration_fb' class="file_issue" />
									<em id="tax_registration_fb_msg"></em> 
							</td>
						</tr>	
						<tr>
							<td class="title">
								组织机构代码证
							</td>
							<td>
								<input type="text" id="orgCodeCert" name="projectCert.orgCodeCert" value="${projectCert.orgCodeCert}"  readonly="readonly" class="line_input" size="40">
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
											$('#orgCodeCert').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#organizing_institution_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#organizing_institution_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type='file'	name='organizing_institution' id='organizing_institution' class="file_issue" />
								   <em id="organizing_institution_msg"></em>								
							</td>
						</tr>	
						<tr>
							<td class="title">
								组织机构代码证副本
							</td>
							<td>
								<input type="text" id="orgCodeCertCopy" name="projectCert.orgCodeCertCopy" value="${projectCert.orgCodeCertCopy}"  readonly="readonly" class="line_input" size="40">
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
											$('#orgCodeCertCopy').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#organizing_institution_fb_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#organizing_institution_fb_msg').html(data.message);
											return false;
										}
									});
								</script> 
								<input type='file'	name='organizing_institution_fb' id='organizing_institution_fb'	class="file_issue" />
								<em id="organizing_institution_fb_msg"></em>								
							</td>
						</tr>		

						<tr>
							<td class="title">
								场地租赁合同
							</td>
							<td>
								<input type="text" id="tenancyContract" name="projectCert.tenancyContract" value="${projectCert.tenancyContract}"  readonly="readonly" class="line_input" size="40">
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
										$('#tenancyContract').val(data.url2);
					
										data.url2 = data.url2.replace(/\&amp;/g,'&');
										$('#contract_tenancy_msg').html(data.message);
										return true;
									}else{
										alert(data.message)
										$('#contract_tenancy_msg').html(data.message);
										return false;
									}
								});
								</script> 
								<input type='file'	name='contract_tenancy' id='contract_tenancy' class="file_issue" />
							    <em id="contract_tenancy_msg"></em>								
							</td>
						</tr>		
						<tr>
							<td class="title">
								财务报表
							</td>
							<td>
								<input type="text" id="financialReport" name="projectCert.financialReport" value="${projectCert.financialReport}"  readonly="readonly" class="line_input" size="40">
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
											$('#financialReport').val(data.url2);
						
											data.url2 = data.url2.replace(/\&amp;/g,'&');
											$('#financial_statement_msg').html(data.message);
											return true;
										}else{
											alert(data.message);
											$('#financial_statement_msg').html(data.message);
											return false;
										}
									});
									</script> 
									<input type='file' name='financial_statement' id='financial_statement' class="file_issue" />
									<em id="financial_statement_msg"></em> 								
							</td>
						</tr>	
						<tr>
							<td class="title">
								行业许可证
							</td>
							<td>
								<input type="text" id="industryLicense" name="projectCert.industryLicense" value="${projectCert.industryLicense}" readonly="readonly" class="line_input" size="40">
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
									$('#industryLicense').val(data.url2);
				
									data.url2 = data.url2.replace(/\&amp;/g,'&');
									$('#hygienic_license_img_msg').html(data.message);
									return true;
								}else{
									alert(data.message)
									$('#hygienic_license_img_msg').html(data.message);
									return false;
								}
							});
							</script> 
							<input type='file'	name='hygienic_license_img' id='hygienic_license_img' class="file_issue" />
							<em id="hygienic_license_img_msg"></em> 								
							</td>
						</tr>																																															
				</table>