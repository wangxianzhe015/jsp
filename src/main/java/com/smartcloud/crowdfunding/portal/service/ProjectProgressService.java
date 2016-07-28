package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectProgress;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目进度服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectProgressService {

	/**
	 * 获取项目进度列表
	 * @param projectId
	 * @return
	 */
	public List<ProjectProgress> getProjectProgresses(Long projectId);
	
	
	/**
	 * 添加进度
	 * @param progress
	 */
	public void addProjectProgress(ProjectProgress progress);
	
	/**
	 * 删除进度
	 * @param progress
	 * @return
	 */
	public int removeProjectProgress(ProjectProgress progress);
	
	/**
	 * 删除项目进度
	 * @param projectId
	 */
	public void deleteProjectProgress(Long projectId);
	
	/**
	 * 修改进度
	 * @param progress
	 * @return
	 */
	public int updateProjectProgress(ProjectProgress progress);
	
	/**
	 * 获取项目进度
	 * @param projectId 项目ID
	 * @param projectState 项目状态
	 * @return 
	 */
	public ProjectProgress getProgress(Long projectId,String projectState);
	
}
