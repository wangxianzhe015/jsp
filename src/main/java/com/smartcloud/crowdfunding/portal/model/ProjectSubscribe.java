package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.platform.component.mvc.web.dict.support.DictionaryFactory;

/**
 * 项目认购
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_PROJECT_SUBSCRIBE")
public class ProjectSubscribe implements java.io.Serializable{

	private static final long serialVersionUID = 1L;

	//认购ID
	@Id
	@Column(name="SUBSCRIBE_ID")
	private Long subscribeId;
	
	//项目ID
	@Column(name="PROJECT_ID")
	private Long projectId;
	
	//用户ID
	@Column(name="USER_ID")
	private String userId;
	
	//用户名称
	@Column(name="USER_NAME")
	private String userName;
	
	//认购份数
	@Column(name="SUBSCRIBE_COUNT")
	private Integer subscribeCount;
	
	//最低认购金额
	@Column(name="LEST_AMOUNT")
	private Float lestAmount;
	
	//总金额
	@Column(name="TOTAL_AMOUNT")
	private Float totalAmount;
	
	//认购时间
	@Column(name="SUBSCRIBE_TIME")
	private Timestamp subscribeTime;
	
	//认购方式(预购/已购)
	@Column(name="SUBSCRIBE_TYPE")
	private String subscribeType;
	
	
	//订购的项目名称
	private String projectName;
	
	//订购项目状态
	private String projectState;

	//项目状态名称
	private String projectStateName;
	
	
	public Long getSubscribeId() {
		return subscribeId;
	}

	public void setSubscribeId(Long subscribeId) {
		this.subscribeId = subscribeId;
	}


	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getSubscribeCount() {
		return subscribeCount;
	}

	public void setSubscribeCount(Integer subscribeCount) {
		this.subscribeCount = subscribeCount;
	}

	public Float getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Timestamp getSubscribeTime() {
		return subscribeTime;
	}

	public void setSubscribeTime(Timestamp subscribeTime) {
		this.subscribeTime = subscribeTime;
	}

	public Float getLestAmount() {
		return lestAmount;
	}

	public void setLestAmount(Float lestAmount) {
		this.lestAmount = lestAmount;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getProjectState() {
		return projectState;
	}

	public void setProjectState(String projectState) {
		this.projectState = projectState;
	}

	public String getProjectStateName() {
		return DictionaryFactory.getInstance().getDictName(Constants.DICT_TYPE_PROJECT_STATE, projectState);
	}

	public void setProjectStateName(String projectStateName) {
		this.projectStateName = projectStateName;
	}

	public String getSubscribeType() {
		return subscribeType;
	}

	public void setSubscribeType(String subscribeType) {
		this.subscribeType = subscribeType;
	}
	
}
