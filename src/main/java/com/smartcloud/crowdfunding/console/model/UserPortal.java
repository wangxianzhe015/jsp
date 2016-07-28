/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;


@Entity
@Table(name = "GAS_USER_PORTAL")
public class UserPortal implements Serializable {
	public static final String QUERY_USER_PORTALS_BY_CON = "QUERY_USER_PORTALS_BY_CON";
	public static final String DIC_TYPE_PORTAL_LAYOUT = "portal_layout";
	public static final String DEFAULT_PORTAL_LAYOUT = "1";
	public static final String CHANGE_USERS_PORTAL_LAYOUT = "CHANGE_USERS_PORTAL_LAYOUT";

	public static final String CATALOG_STAUS_CLOSE = "0";
	public static final String CATALOG_STAUS_IN_USE= "1";

	@Id
	@Column(name = "USER_PORTAL_ID")
	private Long userPortalId;
	@Column(name = "USER_ID")
	private Long userId;
	@JoinColumn(name = "CATALOG_ID", table = "GAS_PORTAL", referencedColumnName = "CATALOG_ID")
	private Portal portal;
	@Column(name = "PORTAL_TITLE_SELF")
	private String portalTitleSelf;
	@Column(name = "PORTAL_HEIGHT")
	private String portalHeight;
	@Column(name = "PORTAL_X")
	private Integer portalX;
	@Column(name = "PORTAL_Y")
	private Integer portalY;
	@Column(name = "PORTAL_LAYOUT")
	private String portalLayout;

	public Long getUserPortalId() {
		return userPortalId;
	}

	public void setUserPortalId(Long userPortalId) {
		this.userPortalId = userPortalId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Portal getPortal() {
		return portal;
	}

	public void setPortal(Portal portal) {
		this.portal = portal;
	}

	public String getPortalHeight() {
		return portalHeight;
	}

	public void setPortalHeight(String portalHeight) {
		this.portalHeight = portalHeight;
	}

	public Integer getPortalX() {
		return portalX;
	}

	public void setPortalX(Integer portalX) {
		this.portalX = portalX;
	}

	public Integer getPortalY() {
		return portalY;
	}

	public void setPortalY(Integer portalY) {
		this.portalY = portalY;
	}

	public String getPortalTitleSelf() {
		return portalTitleSelf;
	}

	public void setPortalTitleSelf(String portalTitleSelf) {
		this.portalTitleSelf = portalTitleSelf;
	}

	public String getPortalLayout() {
		return portalLayout;
	}

	public void setPortalLayout(String portalLayout) {
		this.portalLayout = portalLayout;
	}

}
