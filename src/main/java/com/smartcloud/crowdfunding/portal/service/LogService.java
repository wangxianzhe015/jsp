package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.LogonLog;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 日志服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface LogService {

	/**
	 * 获取最近一次登录信息
	 * @param userId
	 * @return
	 */
	public LogonLog getLastestLogon(String userId);
	/**
	 * 添加登录日志
	 * @param log
	 * @return 返回登录ID
	 */
	public Long addLogonLog(LogonLog log);
	
	
	/**
	 * 更新登录日志
	 * @param log
	 */
	public void updateLogonLog(LogonLog log);
	
	
	/**
	 * 删除登录日志
	 * @param log
	 */
	public void removeLogonLog(LogonLog log);
	
	/**
	 * 分页获取所有登录日志
	 * @param log
	 * @param page
	 * @return
	 */
	public List<LogonLog> getLogonLogs(LogonLog log,Page page);
	
}
