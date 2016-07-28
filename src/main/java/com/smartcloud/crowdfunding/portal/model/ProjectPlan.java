package com.smartcloud.crowdfunding.portal.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 项目计划
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_PLAN")
public class ProjectPlan implements java.io.Serializable{
	
	private static final long serialVersionUID = 1L;

	//项目ID
	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	
	//预计融资开店数量
	@Column(name="SHOP_NUM")
	private String shopNum;
	
	//开店筹备周期(天)
	@Column(name="PEROID_DAY")
	private Integer peroidDay;
	
	//预计店面地址
	@Column(name="SHOP_ADDRESS")
	private String shopAddress;
	
	//开业日期
	@Column(name="BUSINESS_DATE")
	private Date businessDate;
	
	//分红时间(天)
	@Column(name="PROFIT_DAY")
	private Integer profitDay;
	
	//预计年盈利额
	@Column(name="PROFIT_AMOUNT")
	private Float profitAmount;
	
	//其他计划
	@Column(name="OTHER_PLAN")
	private String otherPlan;

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getShopNum() {
		return shopNum;
	}

	public void setShopNum(String shopNum) {
		this.shopNum = shopNum;
	}

	public Integer getPeroidDay() {
		return peroidDay;
	}

	public void setPeroidDay(Integer peroidDay) {
		this.peroidDay = peroidDay;
	}

	public String getShopAddress() {
		return shopAddress;
	}

	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}

	public Date getBusinessDate() {
		return businessDate;
	}

	public void setBusinessDate(Date businessDate) {
		this.businessDate = businessDate;
	}

	public Integer getProfitDay() {
		return profitDay;
	}

	public void setProfitDay(Integer profitDay) {
		this.profitDay = profitDay;
	}

	public Float getProfitAmount() {
		return profitAmount;
	}

	public void setProfitAmount(Float profitAmount) {
		this.profitAmount = profitAmount;
	}

	public String getOtherPlan() {
		return otherPlan;
	}

	public void setOtherPlan(String otherPlan) {
		this.otherPlan = otherPlan;
	}

	
}
