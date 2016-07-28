/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;


@Entity
@Table(name = "GAS_PORTAL_CATALOG")
public class Portal implements Serializable {

	public static final String DELETE_USERPORTALS_BY_PORTAL = "DELETE_USERPORTALS_BY_PORTAL";

	@Id
	@Column(name = "CATALOG_ID")
	private Long catalogId;

	@Column(name = "CATALOG_CODE")
	private String catalogCode;

	@Column(name = "CATALOG_TITLE")
	@Condition(operator = OPERATOR.LIKE)
	private String catalogTitle;

	@Column(name = "CATALOG_ACCESS")
	private String catalogAccess;
	
	@Column(name = "CATALOG_ROLEIDS")
	private String roleIds;
	@Column(name = "CATALOG_ROLENAMES")
	private String roleNames;

	@Column(name = "CATALOG_STAUS")
	private String catalogStaus;
	@Column(name = "CATALOG_CONTENT")
	private String catalogContent;
	@Column(name = "CATALOG_URL")
	private String catalogUrl;

	@Column(name = "CATALOG_HEIGHT")
	private String catalogHeight;
	@Column(name = "CATALOG_MEMO")
	private String catalogMemo;
	
	public String getRoleNames() {
		return roleNames;
	}

	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}

	public Long getCatalogId() {
		return catalogId;
	}

	public void setCatalogId(Long catalogId) {
		this.catalogId = catalogId;
	}

	public String getCatalogCode() {
		return catalogCode;
	}

	public void setCatalogCode(String catalogCode) {
		this.catalogCode = catalogCode;
	}

	public String getCatalogTitle() {
		return catalogTitle;
	}

	public void setCatalogTitle(String catalogTitle) {
		this.catalogTitle = catalogTitle;
	}

	public String getCatalogAccess() {
		return catalogAccess;
	}

	public void setCatalogAccess(String catalogAccess) {
		this.catalogAccess = catalogAccess;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public String getCatalogStaus() {
		return catalogStaus;
	}

	public void setCatalogStaus(String catalogStaus) {
		this.catalogStaus = catalogStaus;
	}

	public String getCatalogContent() {
		return catalogContent;
	}

	public void setCatalogContent(String catalogContent) {
		this.catalogContent = catalogContent;
	}

	public String getCatalogUrl() {
		return catalogUrl;
	}

	public void setCatalogUrl(String catalogUrl) {
		this.catalogUrl = catalogUrl;
	}

	public String getCatalogHeight() {
		return catalogHeight;
	}

	public void setCatalogHeight(String catalogHeight) {
		this.catalogHeight = catalogHeight;
	}

	public String getCatalogMemo() {
		return catalogMemo;
	}

	public void setCatalogMemo(String catalogMemo) {
		this.catalogMemo = catalogMemo;
	}

}
