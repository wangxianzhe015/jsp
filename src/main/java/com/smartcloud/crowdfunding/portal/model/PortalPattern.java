package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 合作伙伴资源链接
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PATTERN")
public class PortalPattern implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	@Column(name="PATTERN_ID")
	@Id
	private Long patternId;
	
	@Column(name="ORDER_NO")
	private Integer orderNo;
	
	@Column(name="TITLE")
	private String title;
	
	@Column(name="HREF")
	private String href;
	
	@Column(name="IMAGE")
	private String image;

	public Long getPatternId() {
		return patternId;
	}

	public void setPatternId(Long patternId) {
		this.patternId = patternId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
}
