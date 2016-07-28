package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.platform.component.mvc.User;
import com.smartcloud.platform.component.persistence.annotation.Order;

/**
 * 网站用户
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_USER")
public class PortalUser implements User{
	private static final long serialVersionUID = 1L;
	
	private String orgId;
	
	private String[] roleIds;
	
	@Id
	@Column(name="USER_ID")
	private String userId;
	
	@Column(name="USER_NAME")
	private String userName;
	
	@Column(name="PASSWORD")
	private String password;
	
	@Column(name="MOBILE_NO")
	private String mobileNo;
	
	@Column(name="USER_IMAGE")
	private String userImage;
	
	@Column(name="EMAIL")
	private String email;
	
	@Column(name="NICK_NAME")
	private String nickName;
	
	//身份证号码
	@Column(name="IDENTITY_CARD")
	private String identityCard;
	//真实姓名
	@Column(name="REAL_NAME")
	private String realName;
	//是否实名认证
	@Column(name="REAL_NAME_AUTH")
	private String realNameAuth;
	
	//邮箱认证
	@Column(name="EMAIL_AUTH")
	private String emailAuth;
	
	//手机认证
	@Column(name="MOBILE_AUTH")
	private String mobileAuth;
	
	//第三方支付认证
	@Column(name="THIRD_PAY_AUTH")
	private String thirdPayAuth;
	
	//个人简介
	@Column(name="PROFILE")
	private String profile;
	
	//省份
	@Column(name="PROVINCE")
	private String province;
	
	//城市
	@Column(name="CITY")
	private String city;
	
	//性别
	@Column(name="GENDER")
	private String gender;
	
	//收货联系方式
	@Column(name="CONTACT_MOBILE")
	private String contactMobile;
	
	//收货省份
	@Column(name="CONTACT_PROVINCE")
	private String contactProvince;
	
	//收货城市
	@Column(name="CONTACT_CITY")
	private String contactCity;
	
	//收货邮编
	@Column(name="CONTACT_ZIP")
	private String contactZip;
	//收货详细地址
	@Column(name="CONTACT_ADDRESS")
	private String contactAddress;
	
	//用户账户信息
	@JoinColumn(name="accountInfo")
	@OneToOne
	private AccountInfo accountInfo;
	
	//登录ID
	private Long logonId;
	
	//创建时间
	@Order(sort="DESC")
	@Column(name="CREATE_TIME")
	private Timestamp createTime;
	
	//名字是否变更过
	@Column(name="NAME_CHANGED")
	private String nameChanged;
	
	private String contactProvinceName;
	
	private String contactCityName;
	
	
	public String getOrgId() {
		// TODO Auto-generated method stub
		return orgId;
	}

	public String[] getRoleIds() {
		return roleIds;
	}

	public String getUserId() {
		return userId;
	}

	public String getUserName() {
		return userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getUserImage() {
		return userImage;
	}

	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getIdentityCard() {
		return identityCard;
	}

	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmailAuth() {
		return emailAuth;
	}

	public void setEmailAuth(String emailAuth) {
		this.emailAuth = emailAuth;
	}

	public String getMobileAuth() {
		return mobileAuth;
	}

	public void setMobileAuth(String mobileAuth) {
		this.mobileAuth = mobileAuth;
	}

	public String getThirdPayAuth() {
		return thirdPayAuth;
	}

	public void setThirdPayAuth(String thirdPayAuth) {
		this.thirdPayAuth = thirdPayAuth;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public void setRoleIds(String[] roleIds) {
		this.roleIds = roleIds;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getContactMobile() {
		return contactMobile;
	}

	public void setContactMobile(String contactMobile) {
		this.contactMobile = contactMobile;
	}

	public String getContactProvince() {
		return contactProvince;
	}

	public void setContactProvince(String contactProvince) {
		this.contactProvince = contactProvince;
	}

	public String getContactCity() {
		return contactCity;
	}

	public void setContactCity(String contactCity) {
		this.contactCity = contactCity;
	}

	public String getContactZip() {
		return contactZip;
	}

	public void setContactZip(String contactZip) {
		this.contactZip = contactZip;
	}

	public String getContactAddress() {
		return contactAddress;
	}

	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	public AccountInfo getAccountInfo() {
		return accountInfo;
	}

	public void setAccountInfo(AccountInfo accountInfo) {
		this.accountInfo = accountInfo;
	}

	public Long getLogonId() {
		return logonId;
	}

	public void setLogonId(Long logonId) {
		this.logonId = logonId;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getNameChanged() {
		return nameChanged;
	}

	public void setNameChanged(String nameChanged) {
		this.nameChanged = nameChanged;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getRealNameAuth() {
		return realNameAuth;
	}

	public void setRealNameAuth(String realNameAuth) {
		this.realNameAuth = realNameAuth;
	}

	public String getContactProvinceName() {
		return CityDictionaryFactory.getInstance().getCityName(this.contactProvince);
	}

	public String getContactCityName() {
		return  CityDictionaryFactory.getInstance().getCityName(contactCity);
	}

	public void setContactProvinceName(String contactProvinceName) {
		this.contactProvinceName = contactProvinceName;
	}

	public void setContactCityName(String contactCityName) {
		this.contactCityName = contactCityName;
	}

	
	
}
