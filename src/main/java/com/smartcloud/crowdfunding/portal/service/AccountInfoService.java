package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.AccountInfo;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 账户信息服务
 * 
 * @author wengzr(mailto:zrweng@163.com)
 * 
 */
@Service
public interface AccountInfoService {

	/**
	 * 保存账户信息
	 * @param account
	 */
	public void saveAccount(AccountInfo account);
	
	/**
	 * 获取账户信息
	 * @param userid
	 * @return
	 */
	public AccountInfo getAccountInfo(String userid);
}
