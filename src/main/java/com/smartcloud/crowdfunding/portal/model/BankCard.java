package com.smartcloud.crowdfunding.portal.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 银行卡信息
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Entity
@Table(name="PORTAL_BANKCARD")
public class BankCard implements java.io.Serializable{

	//银行卡号
	@Id
	@Column(name="CARD_ID")
	private Long cardId;
	
	//卡号前6位
	@Column(name="CARD_TOP")
	private String cardTop;

	//卡号后4位
	@Column(name="CARD_LAST")
	private String cardLast;
	
	//卡名称
	@Column(name="CARD_NAME")
	private String cardName;
	
	//银行代码(如,ICBC)
	@Column(name="BANK_CODE")
	private String bankCode;
	
	//银行名称
	@Column(name="BANK_NAME")
	private String bankName;
	
	//银行预留手机号
	@Column(name="PHONE")
	private String phone;
	
	//YeePay绑定银行卡ID
	@Column(name="BIND_ID")
	private String bindId;
	
	//绑有效日期
	@Column(name="BIND_VALID_THRU")
	private Timestamp bindValidThru;
	
	//用户ID
	@Column(name="USER_ID")
	private String userId;
	
	//银行卡卡号
	@Column(name="CARD_NO")
	private String cardNo;
	
	//身份证号码
	@Column(name="IDENTITYID")
	private String identityid;
	
	//持卡人姓名
	@Column(name="USER_NAME")
	private String userName;
	
	
	public Long getCardId() {
		return cardId;
	}

	public void setCardId(Long cardId) {
		this.cardId = cardId;
	}

	public String getCardTop() {
		return cardTop;
	}

	public void setCardTop(String cardTop) {
		this.cardTop = cardTop;
	}

	public String getCardLast() {
		return cardLast;
	}

	public void setCardLast(String cardLast) {
		this.cardLast = cardLast;
	}

	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBindId() {
		return bindId;
	}

	public void setBindId(String bindId) {
		this.bindId = bindId;
	}

	public Timestamp getBindValidThru() {
		return bindValidThru;
	}

	public void setBindValidThru(Timestamp bindValidThru) {
		this.bindValidThru = bindValidThru;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getIdentityid() {
		return identityid;
	}

	public void setIdentityid(String identityCard) {
		this.identityid = identityCard;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	
}
