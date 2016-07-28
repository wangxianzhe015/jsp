package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.ProjectPlan;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface ProjectPlanService {

	/**
	 * 获取项目计划
	 * @param projectId
	 * @return
	 */
	public ProjectPlan getProjectPlan(Long projectId);
	
	/**
	 * 保存项目计划
	 * @param plan
	 */
	public void saveProjectPlan(ProjectPlan plan);
	
	/**
	 * 删除项目计划
	 * @param plan
	 */
	public void deleteProjectPlan(Long projectId);
}
