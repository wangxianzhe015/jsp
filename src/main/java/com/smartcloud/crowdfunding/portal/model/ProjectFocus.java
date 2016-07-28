package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * 项目关注
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_FOCUS")
public class ProjectFocus implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="FOCUS_ID")
	private Long focusId;
	
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="FOCUS_TIME")
	private Timestamp focusTime;

	public Long getFocusId() {
		return focusId;
	}

	public void setFocusId(Long focusId) {
		this.focusId = focusId;
	}

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Timestamp getFocusTime() {
		return focusTime;
	}

	public void setFocusTime(Timestamp focusTime) {
		this.focusTime = focusTime;
	}
	
	

}
