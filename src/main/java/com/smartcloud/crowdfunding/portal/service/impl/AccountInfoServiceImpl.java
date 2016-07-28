package com.smartcloud.crowdfunding.portal.service.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.crowdfunding.portal.service.AccountInfoService;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class AccountInfoServiceImpl extends DAOSupport<AccountInfo> implements AccountInfoService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	@Override
	protected EntityManager getEntityManager() {
		// TODO Auto-generated method stub
		return em;
	}
	

	public void saveAccount(AccountInfo account) {
		AccountInfo query=new AccountInfo();
		query.setUserId(account.getUserId());
		
		AccountInfo result=this.find(query);
		if(result==null){
			this.insert(account);
		}else{
			this.update(account);
		}
	}


	public AccountInfo getAccountInfo(String userid) {
		AccountInfo account=new AccountInfo();
		account.setUserId(userid);
		return this.find(account);
	}

}
