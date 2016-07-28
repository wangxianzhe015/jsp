package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectSubscribe;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目订购服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectSubscribeService {

	/**
	 * 添加订购项目
	 * @param subscribe
	 */
	public void addSubscribe(ProjectSubscribe subscribe);
	
	/**
	 * 修改订购项目
	 * @param subscribe
	 */
	public void updateSubscribe(ProjectSubscribe subscribe);
	
	/**
	 * 删除订购项目
	 * @param subscribeId
	 */
	public int removeSubscribe(Long subscribeId);
	

	/**
	 * 查询项目的认购列表
	 * @param projectId 项目ID
	 * @return
	 */
	public List<ProjectSubscribe> findSubscribes(Long projectId);
	
	
	/**
	 * 获取用户认购的项目
	 * @param userId
	 * @param projectId
	 * @return
	 */
	public ProjectSubscribe getSubscribe(String userId,Long projectId);
	
	/**
	 * 分页查询所有订购的项目,查询条件：项目状态，项目名称
	 * @param projectState
	 * @param projectName
	 * @param page
	 * @return
	 */
	public List<ProjectSubscribe> queryAllSubscribes(String projectState,String projectName,Page page);
	
}
