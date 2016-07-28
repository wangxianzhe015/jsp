package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 系统消息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_SYSTEM_MESSAGE")
public class SystemMessage implements java.io.Serializable{
	
	public static final String MSG_TYPE_SYSTEM="system";
	
	public static final String MSG_TYPE_TALK="talk";
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="MSG_ID")
	private Long messageId;
	
	@Column(name="FROM_ID")
	private String fromId;
	
	@Column(name="FROM_NAME")
	private String fromName;
	
	@Column(name="TO_ID")
	private String toId;
	
	@Column(name="TO_NAME")
	private String toName;

	@Column(name="MSG_TYPE")
	private String messageType;
	
	@Column(name="SEND_TIME")
	private Timestamp sendTime;
	
	@Column(name="TITLE")
	private String title;
	
	@Column(name="CONTENT")
	private String content;

	public Long getMessageId() {
		return messageId;
	}

	public void setMessageId(Long messageId) {
		this.messageId = messageId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getToName() {
		return toName;
	}

	public void setToName(String toName) {
		this.toName = toName;
	}

	public String getMessageType() {
		return messageType;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public Timestamp getSendTime() {
		return sendTime;
	}

	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}



}
