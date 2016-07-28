package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.apache.commons.lang.ArrayUtils;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.dict.ProjectCategoryDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.enums.OrderState;
import com.smartcloud.crowdfunding.portal.model.enums.SubscribeType;
import com.smartcloud.platform.component.common.utils.ChangeUtils;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;
import com.smartcloud.platform.component.persistence.annotation.Condition;
import com.smartcloud.platform.component.persistence.annotation.Order;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;

/**
 * 项目信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT")
public class Project implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//项目名称
	@Column(name="PROJECT_NAME")
	@Condition(operator=OPERATOR.LIKE)
	private String projectName;
	
	//项目描述(一句话)
	@Column(name="PROJECT_DESC")
	private String projectDesc;
	
	//项目简介
	@Column(name="PROJECT_PROFILE")
	private String projectProfile;
	
	//项目类型
	@Column(name="PROJECT_TYPE")
	private String projectType;
	
	//项目状态(未审核，已审核,已上线,筹集中,已结束)
	@Column(name="PROJECT_STATE")
	private String projectState;
	
	//项目封面图片
	@Column(name="PROJECT_IMAGE")
	private String projectImage;
	
	//项目背景图
	@Column(name="BACKGROUND_IMAGE")
	private String backgroundImage;
	

	
	//项目关注度
	@Column(name="FOCUS_COUNT")
	private Integer focusCount;
	
	//省份
	@Column(name="PROJECT_PROVINCE")
	private String province;
	               
	private String provinceName;
	//城市
	@Column(name="PROJECT_CITY")
	private String city;
	
	private String cityName;
	//区
	@Column(name="PROJECT_AREA")
	private String area;
	
	//项目地址
	@Column(name="PROJECT_ADDRESS")
	private String address;
	
	//开店数量
	@Column(name="SHOP_COUNT")
	private Integer shopCount;
	
	//视频介绍
	@Column(name="VODIO_PATH")
	private String vodioPath;
	
	//项目发起人
	@Column(name="PROJECT_FOUNDER")
	private String projectFounder;
	
	//项目方公司名称
	@Column(name="COMPANY_NAME")
	private String companyName;
	
	//项目排序
	@Column(name="PROJECT_NO")
	private Integer projectNo;
	
	//项目方联系电话
	@Column(name="CONTACT_PHONE")
	private String contactPhone;
	
	
	//融资金额
	@Column(name="FINANCE_AMOUNT")
	private Float financeAmount;
	
	//预热开始时间
	@Column(name="PREBUY_BEGIN_DATE")
	private Date prebuyBeginDate;
	
	//预热结束时间
	@Column(name="PREBUY_END_DATE")
	private Date prebuyEndDate;
	
	//融资开始时间
	@Column(name="RAISE_BEGIN_DATE")
	private Date raiseBeginDate;
	
	//融资结束时间
	@Column(name="RAISE_END_DATE")
	private Date raiseEndDate;
	
	//筹集结束时间
	private Long raiseEndTime;
	
	//预热结束时间
	private Long prebuyEndTime;
	
	//融资筹集天数
	private Integer raiseDays;
	
	//预约认购天数
	private Integer prebuyDays;
	
	//剩余天数
	private Integer remainingDays;
	
	//剩余份数
	private Integer remainingCopies;
	
	//项目方出资比例
	@Column(name="FOUNDER_INVEST_RATE")
	private Float founderInvestRate;
	
	//项目方出资金额
	@Column(name="FOUNDER_INVEST_AMOUNT")
	private Float founderInvestAmount; 
	
	//投资人出资金额
	@Column(name="INVESTOR_AMOUNT")
	private Float investorAmount;
	
	//项目方收益率
	@Column(name="FOUNDER_INCOME_RATE")
	private Float founderIncomeRate;
	
	//投资人出资比例
	@Column(name="INVESTOR_INVERST_RATE")
	private Float investorInvestRate;
	
	//投资人收益率
	@Column(name="INVESTOR_INCOME_RATE")
	private Float investorIncomeRate;
	
	//认购份数
	@Column(name="SUBSCRIBE_COUNT")
	private Integer subscribeCount;
	
	//单笔最小投资金额
	@Column(name="MIN_INVEST_AMOUNT")
	private Float minInvestAmount;
	
	//行业分类
	@Column(name="INDUSTRY_CATEGORY")
	private String industryCategory;
	
	//上线时间
	@Column(name="ONLINE_DATE")
	private Date onlineDate;
	
	private String formatOnlineDate;

	//实际融资完成时间
	@Column(name="TRADE_END_DATE")
	private Date tradeEndDate;
	
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@Order(sort="desc")
	@Column(name="CREATE_TIME")
	private Timestamp createTime;
	
	//筹集进度
	@Column(name="FINANCE_PROGRESS")
	private String progress;
	
	//项目进度明细
	@JoinColumn(name="projectProgresses",referencedColumnName="PROJECT_ID")
	private List<ProjectProgress> projectProgresses;
	
	//项目订购列表
	@JoinColumn(name="orders",referencedColumnName="PROJECT_ID")
	private List<ProjectOrder> orders;

	//项目分红
	@OneToOne
	@JoinColumn(name="bonus")
	private ProjectBonus bonus;
	
	//限购份数
	@Column(name="LIMIT_COUNT")
	private Integer limitCount;
	
	//股东回报
	@Column(name="STOCKHOLDER_REPAY")
	private String stockholderRepay;

	private String stockholderRepayHtml;
	
	//已筹集资金
	private Float raisedTotalAmount;
	
	//已预约认购总金额
	private Float subscribedTotalAmount;
	
	//已预约认购总份数
	private Integer subscribedTotalCopies;
	
	//已预约认购投资人数
	private Integer subscribedInverstorCount;
	
	//项目状态中文描述
	private String projectStateName;
	//行业分类中文描述
	private String industryCategoryName;
	//认购类型
	private String subscribeType;

	//是否置顶项目
	@Column(name="IS_TOP")
	private String top;
	//订单唯一性检查方式:
	//REBUYABLE:允许重复认购(无待支付订单情况)
	//UNREBUY:  不允许重复认购
	@Column(name="ORDER_UNIQUE")
	private String orderUnique;
	
	public Long getProjectId() {
		return projectId;
	}
	
	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}

	public String getProjectState() {
		return projectState;
	}

	public void setProjectState(String projectState) {
		this.projectState = projectState;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getVodioPath() {
		return vodioPath;
	}

	public void setVodioPath(String vodioPath) {
		this.vodioPath = vodioPath;
	}

	public String getProjectFounder() {
		return projectFounder;
	}

	public void setProjectFounder(String projectFounder) {
		this.projectFounder = projectFounder;
	}

	public Float getFinanceAmount() {
		return financeAmount;
	}

	public void setFinanceAmount(Float financeAmount) {
		this.financeAmount = financeAmount;
	}

	public Date getRaiseBeginDate() {
		return raiseBeginDate;
	}

	public void setRaiseBeginDate(Date raiseBeginDate) {
		this.raiseBeginDate = raiseBeginDate;
	}

	public Date getRaiseEndDate() {
		return raiseEndDate;
	}

	public void setRaiseEndDate(Date raiseEndDate) {
		this.raiseEndDate = raiseEndDate;
	}

	/**
	 * 获取项目方投资比例
	 * @return
	 */
	public Float getFounderInvestRate() {
		if(founderInvestAmount==null){
			return 0F;
		}
		
		Float result=founderInvestAmount/financeAmount;
		DecimalFormat format=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String p=format.format(result*100);
		founderInvestRate=Float.parseFloat(p);
		return founderInvestRate;
	}

	public void setFounderInvestRate(Float founderInvestRate) {
		this.founderInvestRate = founderInvestRate;
	}

	public Float getFounderInvestAmount() {
		return founderInvestAmount;
	}

	
	public Float getFounderIncomeRate() {
		return founderIncomeRate;
	}

	public void setFounderIncomeRate(Float founderIncomeRate) {
		this.founderIncomeRate = founderIncomeRate;
	}

	/**
	 * 获取投资人投资比例
	 * @return
	 */
	public Float getInvestorInvestRate() {
		if(investorAmount==null){
			return 0F;
		}
		
		Float result=investorAmount/financeAmount;
		DecimalFormat format=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String p=format.format(result*100);
		investorInvestRate=Float.parseFloat(p);
		
		return investorInvestRate;
	}

	public void setInvestorInvestRate(Float investorInvestRate) {
		this.investorInvestRate = investorInvestRate;
	}

	/**
	 * 获取投资人收益率
	 * @return
	 */
	public Float getInvestorIncomeRate() {
		return investorIncomeRate;
	}

	public void setInvestorIncomeRate(Float investorIncomeRate) {
		this.investorIncomeRate = investorIncomeRate;
	}

	public void setFounderInvestAmount(Float founderInvestAmount) {
		this.founderInvestAmount = founderInvestAmount;
	}

	public Integer getSubscribeCount() {
		return subscribeCount;
	}

	public void setSubscribeCount(Integer subscriptionNumber) {
		this.subscribeCount = subscriptionNumber;
	}

	public Float getMinInvestAmount() {
		return minInvestAmount;
	}

	public void setMinInvestAmount(Float minInvestAmount) {
		this.minInvestAmount = minInvestAmount;
	}

	public String getIndustryCategory() {
		return industryCategory;
	}

	public void setIndustryCategory(String industryCategory) {
		this.industryCategory = industryCategory;
	}

	public Date getOnlineDate() {
		return onlineDate;
	}

	public void setOnlineDate(Date onlineDate) {
		this.onlineDate = onlineDate;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getProjectImage() {
		return projectImage;
	}

	public void setProjectImage(String projectImage) {
		this.projectImage = projectImage;
	}

	public String getBackgroundImage() {
		return backgroundImage;
	}

	public void setBackgroundImage(String backgroundImage) {
		this.backgroundImage = backgroundImage;
	}

	/**
	 * 获取资金筹集进度
	 * @return
	 */
	public String getProgress() {
		float totalAmount=this.getRaisedTotalAmount();
		float value=totalAmount/financeAmount * 100;
		if(value!=0){
			DecimalFormat decimalFormat=new DecimalFormat(".0");//构造方法的字符格式这里如果小数不足2位,会以0补足.
			progress=decimalFormat.format(value);
			if(progress.startsWith(".")){//小数点补0
				progress="0"+progress;
			}
		}else{
			progress="0";
		}
		
		return progress;
	}

	public void setProgress(String progress) {
		this.progress = progress;
	}

	public String getProjectDesc() {
		return projectDesc;
	}

	public void setProjectDesc(String projectDesc) {
		this.projectDesc = projectDesc;
	}

	public Integer getFocusCount() {
		return focusCount;
	}

	public void setFocusCount(Integer projectFocus) {
		this.focusCount = projectFocus;
	}

	public Integer getShopCount() {
		return shopCount;
	}

	public void setShopCount(Integer shopNumber) {
		this.shopCount = shopNumber;
	}

	/**
	 * 获取融资天数
	 * @return
	 */
	public Integer getRaiseDays() {
		if(raiseEndDate!=null && raiseBeginDate!=null){
			this.raiseDays= DateUtils.compareDate(
					DateUtils.formatDate(raiseBeginDate, "yyyy-MM-dd"), 
					DateUtils.formatDate(raiseEndDate, "yyyy-MM-dd"), 0);
		};
		return raiseDays;
	}
	
	/**
	 * 获取预约认购天数
	 * @return
	 */
	public Integer getPrebuyDays() {
		if(prebuyEndDate!=null && prebuyBeginDate!=null){
			this.prebuyDays= DateUtils.compareDate(
					DateUtils.formatDate(prebuyBeginDate, "yyyy-MM-dd"), 
					DateUtils.formatDate(prebuyEndDate, "yyyy-MM-dd"), 0);
		};
		return prebuyDays;
	}
	

	/**
	 * 获取已筹集到的总金额
	 * @return
	 */
	public Float getRaisedTotalAmount() {
		raisedTotalAmount=0F;//已付款总金额
		if(getOrders()!=null){
			for(ProjectOrder order:orders){//合计“已购”类型的总金额
				
				if("1".equals(order.getValid())){//只统计有效的订单
					if(ArrayUtils.contains(new String[]{
							Constants.PROJECT_STATE_FINANCING,
							Constants.PROJECT_STATE_SUCCESSED,
							Constants.PROJECT_STATE_OPERATING,
							Constants.PROJECT_STATE_DIVIDENDS},projectState)){
						
						if(order.getSubscribeType()==SubscribeType.BUY && 
								ArrayUtils.contains(new String[]{
										OrderState.PAY_SUCCESS.getValue(),
										OrderState.CONFIRM_SUCCESS.getValue(),
										OrderState.DEAL_FINISH.getValue()}, 
										order.getOrderState().getValue())){
							raisedTotalAmount+=order.getTotalAmount();
						}
					}else{
	
						//预购总金额
						if(order.getSubscribeType()==SubscribeType.PREBUY){
							raisedTotalAmount+=order.getTotalAmount();
						}
					}
				}
				
			}
		}
		
		//已预购或筹集到的资金，需要增加项目方投资金额
		raisedTotalAmount+=founderInvestAmount!=null?founderInvestAmount:0;
		
		DecimalFormat format=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String p=format.format(raisedTotalAmount);
		raisedTotalAmount=Float.parseFloat(p);
		
		return raisedTotalAmount;
	}

	public void setRaisedTotalAmount(Float raisedTotalAmount) {
		this.raisedTotalAmount = raisedTotalAmount;
	}
	
	public ProjectBonus getBonus() {
		return bonus;
	}

	public void setBonus(ProjectBonus bonus) {
		this.bonus = bonus;
	}

	public void setRaiseDays(Integer raiseDays) {
		this.raiseDays = raiseDays;
	}

	public String getProjectProfile() {
		return projectProfile;
	}

	public void setProjectProfile(String projectProfile) {
		this.projectProfile = projectProfile;
	}



	public void setPrebuyDays(Integer prebuyDays) {
		this.prebuyDays = prebuyDays;
	}



	/**
	 * 获取剩余天数
	 * @return
	 */
	public Integer getRemainingDays() {
		//当前项目状态为“预热上线”
		if(Constants.PROJECT_STATE_PREPARED.equals(projectState)){
			if(prebuyEndDate!=null)
				remainingDays=DateUtils.compareDate(DateUtils.getCurrentDate(), DateUtils.formatDate(prebuyEndDate,"yyyy-MM-dd"), 0);
		}
		//如果项目状态为"融资上线"
		else if(Constants.PROJECT_STATE_FINANCING.equals(projectState)){
			if(raiseEndDate!=null)
				remainingDays=DateUtils.compareDate(DateUtils.getCurrentDate(), DateUtils.formatDate(raiseEndDate,"yyyy-MM-dd"), 0);
		}

		return remainingDays;
	}

	public Date getTradeEndDate() {
		return tradeEndDate;
	}

	public void setTradeEndDate(Date tradeEndDate) {
		this.tradeEndDate = tradeEndDate;
	}

	
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public void setRaiseEndTime(Long raiseEndTime) {
		this.raiseEndTime = raiseEndTime;
	}

	public void setRemainingDays(Integer remainingDays) {
		this.remainingDays = remainingDays;
	}

	public void setFormatOnlineDate(String formatOnlineDate) {
		this.formatOnlineDate = formatOnlineDate;
	}

	public void setSubscribedTotalAmount(Float subscribedTotalAmount) {
		this.subscribedTotalAmount = subscribedTotalAmount;
	}

	public void setSubscribedTotalCopies(Integer subscribedTotalCopies) {
		this.subscribedTotalCopies = subscribedTotalCopies;
	}

	public void setSubscribedInverstorCount(Integer subscribedInverstorCount) {
		this.subscribedInverstorCount = subscribedInverstorCount;
	}

	/**
	 * 已订购总金额
	 * @deprecated 被raisedTotalAmount取代
	 * @return
	 */
	public Float getSubscribedTotalAmount() {
		subscribedTotalAmount=0F;
		if(getOrders()!=null){
			
			for(ProjectOrder order:orders){
				
				if("1".equals(order.getValid())){//只统计有效的订单
					//如果当前项目状态是“预热上线”，则统计预定总金额
					//如果当前项目状态是“上线融资”，则统计购买总金额
					if(Constants.PROJECT_STATE_PREPARED.equals(projectState) && 
							order.getSubscribeType()==SubscribeType.PREBUY){
						subscribedTotalAmount+=order.getTotalAmount();
					}
					else if (ArrayUtils.contains(new String[]{
							OrderState.PAY_SUCCESS.getValue(),
							OrderState.CONFIRM_SUCCESS.getValue(),
							OrderState.DEAL_FINISH.getValue()}, 
							order.getOrderState().getValue())){
						subscribedTotalAmount+=order.getTotalAmount();
					}
					
				}
			}
		}
		return subscribedTotalAmount;
	}

	/**
	 * 已订购总份数
	 * @return
	 */
	public Integer getSubscribedTotalCopies() {
		subscribedTotalCopies=0;
		if(getOrders()!=null){
			for(ProjectOrder order:orders){
				//只统计有效的订单
				if("1".equals(order.getValid())){
					//如果当前项目状态是“预热上线”，则统计预定份数
					//如果当前项目状态是“上线融资”，则统计购买份数
					if(Constants.PROJECT_STATE_PREPARED.equals(this.projectState) && 
							order.getSubscribeType()==SubscribeType.PREBUY){
						subscribedTotalCopies+=order.getNums();
					}
					else if (ArrayUtils.contains(new String[]{
							OrderState.PAY_SUCCESS.getValue(),
							OrderState.CONFIRM_SUCCESS.getValue(),
							OrderState.DEAL_FINISH.getValue()}, 
							order.getOrderState().getValue())){
						
						subscribedTotalCopies+=order.getNums();
					}
				}
			}
		}
		return subscribedTotalCopies;
	}

	/**
	 * 已订购投资者总数
	 * @return
	 */
	public Integer getSubscribedInverstorCount() {
		subscribedInverstorCount=1;//默认为项目方1个
		if(getOrders()!=null){
			for(ProjectOrder order:orders){
				//只统计有效的订单
				if("1".equals(order.getValid())){
					//如果当前项目状态是“预热上线”，则统计预定人数
					//如果当前项目状态是“上线融资”，则统计购买人数
					if(Constants.PROJECT_STATE_PREPARED.equals(this.projectState) && 
							order.getSubscribeType()==SubscribeType.PREBUY){
						subscribedInverstorCount++;
					}
					else if (ArrayUtils.contains(new String[]{
							OrderState.PAY_SUCCESS.getValue(),
							OrderState.CONFIRM_SUCCESS.getValue(),
							OrderState.DEAL_FINISH.getValue()}, 
							order.getOrderState().getValue())){
						
						subscribedInverstorCount++;
					}
				}
			}
			
		}
		return subscribedInverstorCount;
	}

	/**
	 * 获取融资上线时间格式化输出
	 * @return
	 */
	public String getFormatOnlineDate() {
		if(raiseBeginDate!=null){
			formatOnlineDate=DateUtils.formatDate(raiseBeginDate, "yyyy-MM-dd");
		}
		return formatOnlineDate;
	}

	public String getProvinceName() {
		provinceName= CityDictionaryFactory.getInstance().getCityName(province);
		return provinceName!=null?provinceName:"";
	}

	public String getCityName() {
		cityName=CityDictionaryFactory.getInstance().getCityName(city);
		return cityName!=null?cityName:"";
	}

	/**
	 * 获取筹集结束时间
	 * @return
	 */
	public Long getRaiseEndTime() {
		raiseEndTime=(raiseEndDate!=null)?raiseEndDate.getTime()/1000:0;
		return raiseEndTime;
	}

	/**
	 * 获取预购结束时间
	 * @return
	 */
	public Long getPrebuyEndTime() {
		prebuyEndTime=(prebuyEndDate!=null)?prebuyEndDate.getTime()/1000:0;
		return prebuyEndTime;
	}

	public void setPrebuyEndTime(Long prebuyEndTime) {
		this.prebuyEndTime = prebuyEndTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getProjectStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PROJECT_STATE, projectState);
	}

	public void setProjectStateName(String projectStateName) {
		this.projectStateName = projectStateName;
	}

	public String getIndustryCategoryName() {
		return ProjectCategoryDictionaryFactory.getInstance().getProjectCategoryName(industryCategory);
	}

	public void setIndustryCategoryName(String industryCategoryName) {
		this.industryCategoryName = industryCategoryName;
	}

	public List<ProjectProgress> getProjectProgresses() {
		return projectProgresses;
	}

	public void setProjectProgresses(List<ProjectProgress> projectProgresses) {
		this.projectProgresses = projectProgresses;
	}

	/**
	 * 获取投资人出资金额
	 * @return
	 */
	public Float getInvestorAmount() {
		return investorAmount;
	}

	public void setInvestorAmount(Float investorAmount) {
		this.investorAmount = investorAmount;
	}

	public List<ProjectOrder> getOrders() {
		return orders;
	}

	public void setOrders(List<ProjectOrder> orders) {
		this.orders = orders;
	}

	public Integer getRemainingCopies() {
		if(subscribeCount==null)
			return 0;
		
		remainingCopies=this.subscribeCount-getSubscribedTotalCopies();
		return remainingCopies;
	}

	public void setRemainingCopies(Integer remainingCopies) {
		this.remainingCopies = remainingCopies;
	}

	public String getTop() {
		return top;
	}

	public void setTop(String top) {
		this.top = top;
	}

	public String getSubscribeType() {
		return subscribeType;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public Integer getProjectNo() {
		return projectNo;
	}

	public void setProjectNo(Integer projectNo) {
		this.projectNo = projectNo;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public void setContactPhone(String contactPhone) {
		this.contactPhone = contactPhone;
	}

	/**
	 * 获取限购份数
	 * @return
	 */
	public Integer getLimitCount() {
		return limitCount;
	}

	/**
	 * 设置限购份数
	 * @param limitCount
	 */
	public void setLimitCount(Integer limitCount) {
		this.limitCount = limitCount;
	}
	
	/**
	 * 获取股东回报
	 * @return
	 */
	public String getStockholderRepay() {
		if(stockholderRepay!=null){
			stockholderRepay=ChangeUtils.changeHtmlStr(stockholderRepay);

		}
		return stockholderRepay;
	}

	/**
	 * 设置股东回报
	 * @param stockholderRepay
	 */
	public void setStockholderRepay(String stockholderRepay) {
		this.stockholderRepay = stockholderRepay;
	}

	public void setSubscribeType(String subscribeType) {
		this.subscribeType = subscribeType;
	}

	public Date getPrebuyBeginDate() {
		return prebuyBeginDate;
	}

	public void setPrebuyBeginDate(Date prebuyBeginDate) {
		this.prebuyBeginDate = prebuyBeginDate;
	}

	public Date getPrebuyEndDate() {
		return prebuyEndDate;
	}

	public void setPrebuyEndDate(Date prebuyEndDate) {
		this.prebuyEndDate = prebuyEndDate;
	}

	public String getStockholderRepayHtml() {
		if(stockholderRepay!=null){
			stockholderRepayHtml=stockholderRepay;
			stockholderRepayHtml = ChangeUtils.replaceString( " ", "&nbsp;", stockholderRepayHtml);
			stockholderRepayHtml = ChangeUtils.replaceString( "<","&lt;", stockholderRepayHtml);
			stockholderRepayHtml = ChangeUtils.replaceString( ">","&gt;", stockholderRepayHtml);
			stockholderRepayHtml = ChangeUtils.replaceString( "&","&amp;", stockholderRepayHtml);
			stockholderRepayHtml = ChangeUtils.replaceString( "\"","&quot;", stockholderRepayHtml);
			stockholderRepayHtml = ChangeUtils.replaceString( "\r\n", "<br>",stockholderRepayHtml);
		}
		return stockholderRepayHtml;
	}

	public void setStockholderRepayHtml(String stockholderRepayHtml) {
		this.stockholderRepayHtml = stockholderRepayHtml;
	}

	public String getOrderUnique() {
		return orderUnique;
	}

	public void setOrderUnique(String orderUnique) {
		this.orderUnique = orderUnique;
	}
	
	
	
}
