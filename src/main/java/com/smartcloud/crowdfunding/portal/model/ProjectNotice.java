package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 * 项目公告
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_NOTICE")
public class ProjectNotice implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="NOTICE_ID")
	private Long noticeId;
	
	//项目ID
	@JoinColumn(name="PROJECT_ID")
	private Project project;
	
	//项目名称
	@Column(name="PROJECT_NAME")
	private String projectName;
	
	//项目状态
	@Column(name="PROJECT_STATE")
	private String projectState;
	
	@Column(name="NOTICE_TIME")
	private Timestamp noticeTime;
	//融资金额
	@Column(name="FINANCE_AMOUNT")
	private Float financeAmount;
	
	//简介
	@Column(name="PROFILE")
	private String profile;
	
	//内容
	@Column(name="CONTENT")
	private byte[] content;
	
	private String contentHtml;

	public Long getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(Long noticeId) {
		this.noticeId = noticeId;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectState() {
		return projectState;
	}

	public void setProjectState(String projectState) {
		this.projectState = projectState;
	}


	public Timestamp getNoticeTime() {
		return noticeTime;
	}

	public void setNoticeTime(Timestamp noticeTime) {
		this.noticeTime = noticeTime;
	}

	public Float getFinanceAmount() {
		return financeAmount;
	}

	public void setFinanceAmount(Float financeAmount) {
		this.financeAmount = financeAmount;
	}

	public byte[] getContent() {
		return content;
	}

	public void setContent(byte[] content) {
		this.content = content;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getContentHtml() {
		if(content!=null){
			try{
				contentHtml=new String(content,"UTF-8");
			}catch(Exception e){
				
			}
		}
		return contentHtml;
	}
	
	
	
	
}
