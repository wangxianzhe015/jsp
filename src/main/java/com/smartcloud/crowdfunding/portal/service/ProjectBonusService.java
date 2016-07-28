package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.ProjectBonus;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface ProjectBonusService {

	/**
	 * 保存分红信息
	 * @param bonus
	 */
	public void saveProjectBonus(ProjectBonus bonus);
	
	/**
	 * 获取项目分红
	 * @param projectId
	 * @return
	 */
	public ProjectBonus getProjectBonus(Long projectId);
	
	/**
	 * 删除分红信息
	 * @param projectId
	 */
	public void removeProjectBonus(Long projectId);
	
}
