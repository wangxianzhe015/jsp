package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 横幅信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_BANNER")
public class Banner implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	@Column(name="BANNER_ID")
	@Id
	private Long bannerId;
	
	@Column(name="ORDER_NO")
	private Integer orderNo;
	
	@Column(name="TITLE")
	private String title;
	
	@Column(name="HREF")
	private String href;
	
	@Column(name="IMAGE")
	private String image;

	public Long getBannerId() {
		return bannerId;
	}

	public void setBannerId(Long bannerId) {
		this.bannerId = bannerId;
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
