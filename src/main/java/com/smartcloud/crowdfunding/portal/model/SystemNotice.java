package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.annotation.Order;

/**
 * 系统公告
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_SYSTEM_NOTICE")
public class SystemNotice implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="NOTICE_ID")
	private Long noticeId;

	@Column(name="NOTICE_TIME")
	@Order(sort="desc")
	private Timestamp noticeTime;
	
	@Column(name="TITLE")
	private String title;
	
	@Column(name="CONTENT")
	private byte[] content;
	
	private String contentHtml;

	public Long getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(Long noticeId) {
		this.noticeId = noticeId;
	}

	public Timestamp getNoticeTime() {
		return noticeTime;
	}

	public void setNoticeTime(Timestamp noticeTime) {
		this.noticeTime = noticeTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public byte[] getContent() {
		return content;
	}

	public void setContent(byte[] content) {
		this.content = content;
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
