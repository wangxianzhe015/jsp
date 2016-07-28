package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.BankCard;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface BankCardService {

	/**
	 * 添加银行卡
	 * @param bankcard
	 */
	public void addBankCard(BankCard bankcard);
	
	/**
	 * 获取用户的银行卡
	 * @param userId
	 * @return
	 */
	public List<BankCard> getBankCards(String userId);
	
	/**
	 * 获取银行卡信息
	 * @param cardId
	 * @return
	 */
	public BankCard getBankCard(Long cardId);
	
	/**
	 * 删除银行卡
	 * @param card
	 */
	public void removeBankCard(Long cardId);
	
	/**
	 * 是否存在用户银行卡
	 * @param userId 用户名
	 * @param cardno 卡号
	 * @return
	 */
	public boolean existCard(String userId,String cardno);
	
}
