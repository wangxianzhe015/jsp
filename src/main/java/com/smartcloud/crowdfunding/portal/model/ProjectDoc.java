package com.smartcloud.crowdfunding.portal.model;

import java.io.UnsupportedEncodingException;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="PORTAL_PROJECT_DOC")
public class ProjectDoc implements java.io.Serializable{

	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//项目介绍
	@Column(name="PROJECT_INTRODUCE")
	private byte[] projectIntroduce;
	
	//融资情况
	@Column(name="FINANCE_EXPLAIN")
	private byte[] financeExplain;
	
	//项目风控(改为股东回报)
	@Column(name="PROJECT_RISK_CTL")
	private byte[] riskControl;
	
	//项目合作协议
	@Column(name="PROJECT_AGREEMENT")
	private byte[] projectAgreement;
	
	
	//风险控制评价
	private String riskControlHtml;
	//项目合作协议
	private String projectAgreementHtml;
	
	//项目介绍
	private String projectIntroduceHtml;
	//融资情况
	private String financeExplainHtml;
	
	public String getProjectIntroduceHtml() {

		if(projectIntroduce!=null){
			try {
				String html= new String(projectIntroduce,"UTF-8");
				return html;
			} catch (UnsupportedEncodingException e) {
			}
		}
		return "";
	}

	public String getFinanceExplainHtml() {
		if(financeExplain!=null){
			try {
				String html= new String(financeExplain,"UTF-8");
				return html;
			} catch (UnsupportedEncodingException e) {
			}
		}
		return "";
	}

	public String getRiskControlHtml() {
		if(riskControl!=null){
			try {
				String html= new String(riskControl,"UTF-8");
				return html;
			} catch (UnsupportedEncodingException e) {
			}
		}
		return "";
	}
	
	public String getProjectAgreementHtml() {
		if(projectAgreement!=null){
			try {
				String html= new String(projectAgreement,"UTF-8");
				return html;
			} catch (UnsupportedEncodingException e) {
			}
		}
		return "";
	}

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public byte[] getProjectIntroduce() {
		return projectIntroduce;
	}

	public void setProjectIntroduce(byte[] projectIntroduce) {
		this.projectIntroduce = projectIntroduce;
	}

	public byte[] getFinanceExplain() {
		return financeExplain;
	}

	public void setFinanceExplain(byte[] financeExplain) {
		this.financeExplain = financeExplain;
	}

	public byte[] getRiskControl() {
		return riskControl;
	}

	public void setRiskControl(byte[] riskControl) {
		this.riskControl = riskControl;
	}

	public byte[] getProjectAgreement() {
		return projectAgreement;
	}

	public void setProjectAgreement(byte[] projectAgreement) {
		this.projectAgreement = projectAgreement;
	}

	public void setRiskControlHtml(String riskControlHtml) {
		this.riskControlHtml = riskControlHtml;
	}

	public void setProjectAgreementHtml(String projectAgreementHtml) {
		this.projectAgreementHtml = projectAgreementHtml;
	}

	public void setProjectIntroduceHtml(String projectIntroduceHtml) {
		this.projectIntroduceHtml = projectIntroduceHtml;
	}

	public void setFinanceExplainHtml(String financeExplainHtml) {
		this.financeExplainHtml = financeExplainHtml;
	}
	
	

}
