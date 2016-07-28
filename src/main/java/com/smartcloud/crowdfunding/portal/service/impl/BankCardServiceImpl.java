package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.BankCard;
import com.smartcloud.crowdfunding.portal.service.BankCardService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class BankCardServiceImpl extends DAOSupport<BankCard> implements BankCardService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public void addBankCard(BankCard bankcard) {
		this.insert(bankcard);
	}

	public List<BankCard> getBankCards(String userId) {

		return em.createNativeQuery("select * from portal_bankcard where user_id=?", BankCard.class).setParameter(1, userId).getResultList();
	}

	public void removeBankCard(Long cardId) {
		BankCard card=new BankCard();
		card.setCardId(cardId);
		this.delete(card);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public boolean existCard(String userId, String cardno) {
		BankCard card=(BankCard)em.createNativeQuery("select * from portal_bankcard where user_id=? and card_no=?", BankCard.class).setParameter(1, userId).setParameter(2, cardno).getSingleResult();
		return card!=null?true:false;
	}

	public BankCard getBankCard(Long cardId) {
		BankCard bankcard=new BankCard();
		bankcard.setCardId(cardId);
		return this.find(bankcard);
	}



}
