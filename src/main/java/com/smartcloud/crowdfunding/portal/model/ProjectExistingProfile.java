package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 现有项目概况
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_EXISTING_PROFILE")
public class ProjectExistingProfile implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	@Column(name="SHOP_NAME")
	private String shopName;

	@Column(name="SHOP_ADDRESS")
	private String shopAddress;
	//店铺筹备总投资
	@Column(name="TOTAL_AMOUNT")
	private Float totalAmount;
	//从筹备到营运周期
	@Column(name="OPERATE_CYCLE")
	private Integer operateCycle;
	//盈利可分红时间
	@Column(name="PROFIT_DAY")
	private Integer profitDay;
	//营业面积
	@Column(name="AREA")
	private Integer area;
	//客流量(位/天)
	@Column(name="PASS_FLOW")
	private Integer passFlow;
	//人均消费
	@Column(name="CONSUMPTION")
	private Integer consumption;
	
	//上年度营业收入
	@Column(name="PRE_YEAR_INCOME")
	private Float preYearIncome;
	
	//上年度净利润
	@Column(name="PRE_YEAR_PROFIT")
	private Float preYearProfit;
	
	//上季度营业收入
	@Column(name="PRE_QUAR_INCOME")
	private Float preQuarterIncome;
	
	//上季度净利润
	@Column(name="PRE_QUAR_PROFIT")
	private Float preQuarterProfit;

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getShopAddress() {
		return shopAddress;
	}

	public void setShopAddress(String shopAddress) {
		this.shopAddress = shopAddress;
	}

	public Float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Integer getOperateCycle() {
		return operateCycle;
	}

	public void setOperateCycle(Integer operateCycle) {
		this.operateCycle = operateCycle;
	}

	public Integer getProfitDay() {
		return profitDay;
	}

	public void setProfitDay(Integer profitDay) {
		this.profitDay = profitDay;
	}

	public Integer getArea() {
		return area;
	}

	public void setArea(Integer area) {
		this.area = area;
	}

	public Integer getPassFlow() {
		return passFlow;
	}

	public void setPassFlow(Integer passFlow) {
		this.passFlow = passFlow;
	}

	public Integer getConsumption() {
		return consumption;
	}

	public void setConsumption(Integer consumption) {
		this.consumption = consumption;
	}

	public Float getPreYearIncome() {
		return preYearIncome;
	}

	public void setPreYearIncome(Float preYearIncome) {
		this.preYearIncome = preYearIncome;
	}

	public Float getPreYearProfit() {
		return preYearProfit;
	}

	public void setPreYearProfit(Float preYearProfit) {
		this.preYearProfit = preYearProfit;
	}

	public Float getPreQuarterIncome() {
		return preQuarterIncome;
	}

	public void setPreQuarterIncome(Float preQuarterIncome) {
		this.preQuarterIncome = preQuarterIncome;
	}

	public Float getPreQuarterProfit() {
		return preQuarterProfit;
	}

	public void setPreQuarterProfit(Float preQuarterProfit) {
		this.preQuarterProfit = preQuarterProfit;
	}

	
	
}
