package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 项目点评
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_COMMENT")
public class ProjectComment implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="COMMENT_ID")
	private Long commentId;
	
	@Column(name="PROJECT_ID")
	private Long projectId;
	@Column(name="USER_ID")
	private String userId;
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="MESSAGE")
	private String message;
	
	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	public Long getCommentId() {
		return commentId;
	}

	public void setCommentId(Long commentId) {
		this.commentId = commentId;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	
	
	
}
