package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.SystemNotice;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface SystemNoticeService {

	/**
	 * 获取最新的系统公告
	 * @param top
	 * @return
	 */
	public List<SystemNotice> queryLastestNotices(int top);
	/**
	 * 分页显示系统公告
	 * @param notice
	 * @param page
	 * @return
	 */
	public List<SystemNotice> findSystemNotices(SystemNotice notice,Page page);
	
	
	/**
	 * 添加系统公告
	 * @param notice
	 */
	public void addSystemNotice(SystemNotice notice);
	
	
	/**
	 * 更新系统公告
	 * @param notice
	 */
	public void updateSystemNotice(SystemNotice notice);
	
	/**
	 * 删除系统公告
	 * @param noticeId
	 */
	public void removeSystemNotice(Long noticeId);
	
	/**
	 * 获取系统公告
	 * @param noticeId
	 * @return
	 */
	public SystemNotice getSystemNotice(Long noticeId);
	
}
