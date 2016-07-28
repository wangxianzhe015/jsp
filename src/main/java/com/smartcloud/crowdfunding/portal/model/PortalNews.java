package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Order;

/**
 * 网站新闻
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_NEWS")
public class PortalNews implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="NEWS_ID")
	private Long newsId;

	@Column(name="NEWS_TIME")
	@Order(sort="desc")
	private Timestamp newsTime;
	
	@Column(name="TITLE")
	private String title;
	
	@Column(name="NEWS_IMAGE")
	private String newsImage;
	
	@Column(name="PROFILE")
	private String profile;
	
	@Column(name="READ_COUNT")
	private Integer readCount;
	
	@Column(name="CONTENT")
	private byte[] content;
	
	private String contentHtml;



	public Long getNewsId() {
		return newsId;
	}

	public void setNewsId(Long newsId) {
		this.newsId = newsId;
	}

	public Timestamp getNewsTime() {
		return newsTime;
	}

	public void setNewsTime(Timestamp newsTime) {
		this.newsTime = newsTime;
	}

	public String getNewsImage() {
		return newsImage;
	}

	public void setNewsImage(String newsImage) {
		this.newsImage = newsImage;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public Integer getReadCount() {
		return readCount;
	}

	public void setReadCount(Integer readCount) {
		this.readCount = readCount;
	}
	
	

}
