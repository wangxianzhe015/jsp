package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 项目回复
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_REPLY")
public class ProjectReply implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="REPLY_ID")
	private Long replyId;
	
	@Column(name="COMMENT_ID")
	private Long commentId;
	
	@Column(name="USER_ID")
	private String userId;
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="MESSAGE")
	private String message;
	
	@Column(name="CREATE_TIME")
	private Timestamp createTime;

	public Long getReplyId() {
		return replyId;
	}

	public void setReplyId(Long replyId) {
		this.replyId = replyId;
	}

	public Long getCommentId() {
		return commentId;
	}

	public void setCommentId(Long commentId) {
		this.commentId = commentId;
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
