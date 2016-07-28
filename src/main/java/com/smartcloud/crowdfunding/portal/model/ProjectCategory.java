package com.smartcloud.crowdfunding.portal.model;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

/**
 * 项目分类
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_CATEGORY")
public class ProjectCategory implements java.io.Serializable{
	
	//分类ID
	@Id
	@Column(name="CATEGORY_ID")
	private Long categoryId;
	
	//分类名称
	@Column(name="CATEGORY_NAME")
	private String categoryName;
	
	//父分类ID
	@Column(name="PARENT_CATEGORY_ID")
	private Long parentCategoryId;
	
	//显示顺序
	@Column(name="ORDER_NO")
	private Integer orderNo;
	
	@JoinColumn(name="children",columnDefinition="SELECT * from PORTAL_PROJECT_CATEGORY WHERE parent_category_id=$CATEGORY_ID",table="PORTAL_PROJECT_CATEGORY")
	private List<ProjectCategory> children;

	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Long getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(Long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public Integer getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}
	
	

}
