package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="PORTAL_PROJECT_QUIT")
public class ProjectQuit implements java.io.Serializable{
	
	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//回购解决方案
	@Column(name="REPURCHASES_SOLUTION")
	private String repurchasesSolution;
	
	//股份转让解决方案
	@Column(name="TRANSFER_SOLUTION")
	private String transferSolution;

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getRepurchasesSolution() {
		return repurchasesSolution;
	}

	public void setRepurchasesSolution(String repurchasesSolution) {
		this.repurchasesSolution = repurchasesSolution;
	}

	public String getTransferSolution() {
		return transferSolution;
	}

	public void setTransferSolution(String transferSolution) {
		this.transferSolution = transferSolution;
	}
	
	
}
