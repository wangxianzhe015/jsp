package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 项目证件
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_CERT")
public class ProjectCert implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//法人身份证
	@Column(name="LEGAL_ID_CARD")
	private String legalIdCard;
	
	//法人代表信用报告
	@Column(name="LEGAL_CREDIT_REPORT")
	private String legalCreditReport;
	
	//营业执照
	@Column(name="BIZ_LICENSE")
	private String bizLicense;
	
	//营业执照副本
	@Column(name="BIZ_LICENSE_COPY")
	private String bizLicenseCopy;
	
	//税务登记证
	@Column(name="TAX_REG_CERT")
	private String taxRegCert;
	
	//税务登记证副本
	@Column(name="TAX_REG_CERT_COPY")
	private String taxRegCertCopy;
	
	//组织机构代码证
	@Column(name="ORG_CODE_CERT")
	private String orgCodeCert;
	
	//组织机构代码证副本
	@Column(name="ORG_CODE_CERT_COPY")
	private String orgCodeCertCopy;
	
	//公司照片
	@Column(name="COMPANY_PHOTO")
	private String companyPhoto;
	
	//场地租赁合同
	@Column(name="TENANCY_CONTRACT")
	private String tenancyContract;
	
	//财务报表
	@Column(name="FINANCIAL_REPORT")
	private String financialReport;
	
	//行业许可证
	@Column(name="INDUSTRY_LICENSE")
	private String industryLicense;
	
	//是否通过
	@Column(name="IS_PASS")
	private String pass;
	
	//不通过原因
	@Column(name="REASON")
	private String reason;

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getLegalIdCard() {
		return legalIdCard;
	}

	public void setLegalIdCard(String legalIdCard) {
		this.legalIdCard = legalIdCard;
	}

	public String getLegalCreditReport() {
		return legalCreditReport;
	}

	public void setLegalCreditReport(String legalCreditReport) {
		this.legalCreditReport = legalCreditReport;
	}

	public String getBizLicense() {
		return bizLicense;
	}

	public void setBizLicense(String bizLicense) {
		this.bizLicense = bizLicense;
	}

	public String getBizLicenseCopy() {
		return bizLicenseCopy;
	}

	public void setBizLicenseCopy(String bizLicenseCopy) {
		this.bizLicenseCopy = bizLicenseCopy;
	}

	public String getTaxRegCert() {
		return taxRegCert;
	}

	public void setTaxRegCert(String taxRegCert) {
		this.taxRegCert = taxRegCert;
	}

	public String getTaxRegCertCopy() {
		return taxRegCertCopy;
	}

	public void setTaxRegCertCopy(String taxRegCertCopy) {
		this.taxRegCertCopy = taxRegCertCopy;
	}

	public String getOrgCodeCert() {
		return orgCodeCert;
	}

	public void setOrgCodeCert(String orgCodeCert) {
		this.orgCodeCert = orgCodeCert;
	}

	public String getOrgCodeCertCopy() {
		return orgCodeCertCopy;
	}

	public void setOrgCodeCertCopy(String orgCodeCertCopy) {
		this.orgCodeCertCopy = orgCodeCertCopy;
	}

	public String getCompanyPhoto() {
		return companyPhoto;
	}

	public void setCompanyPhoto(String companyPhoto) {
		this.companyPhoto = companyPhoto;
	}

	public String getTenancyContract() {
		return tenancyContract;
	}

	public void setTenancyContract(String tenancyContract) {
		this.tenancyContract = tenancyContract;
	}

	public String getFinancialReport() {
		return financialReport;
	}

	public void setFinancialReport(String financialReport) {
		this.financialReport = financialReport;
	}

	public String getIndustryLicense() {
		return industryLicense;
	}

	public void setIndustryLicense(String industryLicense) {
		this.industryLicense = industryLicense;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
}
