package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.ProjectQuit;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目退出机制服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectQuitService {


	/**
	 * 获取项目退出解决方案
	 * @param projectId
	 * @return
	 */
	public ProjectQuit getProjectQuitSolution(Long projectId);
	
	/**
	 * 保存项目退出解决方案
	 * @param quit
	 */
	public void saveProjectQuitSolution(ProjectQuit quit);
	
	/**
	 * 删除项目退出解决方案
	 * @param quit
	 */
	public void deleteProjectQuitSolution(Long projectId);
}
