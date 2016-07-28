package com.smartcloud.crowdfunding.portal.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;

@Entity
@Table(name="PORTAL_PROJECT_PROGRESS")
public class ProjectProgress implements java.io.Serializable{

	@Id
	@Column(name="PROGRESS_ID")
	private Long progressId;
	
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	@Column(name="PROGRESS_NO")
	private Integer progressNo;
	
	@Column(name="PROJECT_STATE")
	private String projectState;
	
	//处理结果
	@Column(name="DEAL_RESULT")
	private String dealResult;
	
	//处理意见
	@Column(name="DEAL_OPION")
	private String dealOpion;
	
	@Column(name="FINISH_DATE")
	private Date finishDate;
	
	//项目状态名称
	private String projectStateName;

	public Long getProgressId() {
		return progressId;
	}

	public void setProgressId(Long progressId) {
		this.progressId = progressId;
	}

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public Integer getProgressNo() {
		return progressNo;
	}

	public void setProgressNo(Integer progressNo) {
		this.progressNo = progressNo;
	}

	public String getProjectState() {
		return projectState;
	}

	public void setProjectState(String projectState) {
		this.projectState = projectState;
	}

	public Date getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(Date finishDate) {
		this.finishDate = finishDate;
	}

	public String getProjectStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PROJECT_STATE, projectState);
	}

	public void setProjectStateName(String projectStateName) {
		this.projectStateName = projectStateName;
	}

	public String getDealResult() {
		return dealResult;
	}

	public void setDealResult(String dealResult) {
		this.dealResult = dealResult;
	}

	public String getDealOpion() {
		return dealOpion;
	}

	public void setDealOpion(String dealOpion) {
		this.dealOpion = dealOpion;
	}
	
	
	
}
