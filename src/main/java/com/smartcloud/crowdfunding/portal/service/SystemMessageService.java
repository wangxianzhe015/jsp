package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.SystemMessage;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 系统消息服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface SystemMessageService {

	/**
	 * 发送系统消息
	 * @param message
	 */
	public void sendMessage(SystemMessage message);
	
	/**
	 * 获取最新的几条消息
	 * @param userId 用户ID
	 * @param lastestNum 消息数量
	 * @return
	 */
	public List<SystemMessage> findReceiveMessages(String userId,Integer lastestNum);
	
	/**
	 * 获取接收到的消息
	 * @param userId 用户ID
	 * @param page 分页对象
	 * @return
	 */
	public List<SystemMessage> findReceiveMessages(String userId,Page page);
	
	/**
	 * 获取发送的消息
	 * @param userId 用户ID
	 * @param page 分页对象
	 * @return
	 */
	public List<SystemMessage> findSendMessages(String userId,Page page);
}
