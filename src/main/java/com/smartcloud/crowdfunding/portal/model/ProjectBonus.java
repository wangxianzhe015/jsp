package com.smartcloud.crowdfunding.portal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 项目分红信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_BONUS")
public class ProjectBonus implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	//项目ID
	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//分红年度
	@Column(name="BONUS_YEAR")
	private String bonusYear;
	
	//分红总金额
	@Column(name="BONUS_AMOUNT")
	private Float bonusAmount;
	
	//分红总期数
	@Column(name="BONUS_PERIODS")
	private Integer bonusPeriods;
	
	//盈利可分红时间(天)
	@Column(name="BONUS_DAYS")
	private Integer bonusDays;
	
	//平均月回报率
	@Column(name="AVE_MONTHLY_RET_RATE")
	private Float aveMonthlyRetRate;
	
	//平均年回报率
	@Column(name="AVE_YEAR_RET_RATE")
	private Float aveYearRetRate;
	
	//月平均净利润
	@Column(name="AVE_MONTHLY_PROFIT")
	private Float aveMonthlyProfit;
	
	//月营业平均收入
	@Column(name="AVE_MONTHLY_INCOME")
	private Float aveMonthlyIncome;
	
	//最近分红金额
	@Column(name="LASTEST_BONUS_AMOUNT")
	private Float lastestBonusAmount;
	
	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getBonusYear() {
		return bonusYear;
	}

	public void setBonusYear(String bonusYear) {
		this.bonusYear = bonusYear;
	}

	public Float getBonusAmount() {
		return bonusAmount;
	}

	public void setBonusAmount(Float bonusAmount) {
		this.bonusAmount = bonusAmount;
	}

	public Integer getBonusPeriods() {
		return bonusPeriods;
	}

	public void setBonusPeriods(Integer bonusPeriods) {
		this.bonusPeriods = bonusPeriods;
	}

	public Integer getBonusDays() {
		return bonusDays;
	}

	public void setBonusDays(Integer bonusDays) {
		this.bonusDays = bonusDays;
	}

	public Float getAveMonthlyRetRate() {
		return aveMonthlyRetRate;
	}

	public void setAveMonthlyRetRate(Float aveMonthlyRetRate) {
		this.aveMonthlyRetRate = aveMonthlyRetRate;
	}

	public Float getAveYearRetRate() {
		return aveYearRetRate;
	}

	public void setAveYearRetRate(Float aveYearRetRate) {
		this.aveYearRetRate = aveYearRetRate;
	}

	public Float getAveMonthlyProfit() {
		return aveMonthlyProfit;
	}

	public void setAveMonthlyProfit(Float aveMonthlyProfit) {
		this.aveMonthlyProfit = aveMonthlyProfit;
	}

	public Float getAveMonthlyIncome() {
		return aveMonthlyIncome;
	}

	public void setAveMonthlyIncome(Float aveMonthlyIncome) {
		this.aveMonthlyIncome = aveMonthlyIncome;
	}

	public Float getLastestBonusAmount() {
		return lastestBonusAmount;
	}

	public void setLastestBonusAmount(Float lastestBonusAmount) {
		this.lastestBonusAmount = lastestBonusAmount;
	}
	
	
}
