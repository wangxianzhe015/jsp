package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.ProjectExistingProfile;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 现有店铺概要服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectExistingService {

	/**
	 * 获取现有店铺概要介绍
	 * @param projectId
	 * @return
	 */
	public ProjectExistingProfile getExistingProfile(Long projectId);
	
	/**
	 * 保存现有店铺概要介绍
	 * @param plan
	 */
	public void saveExistingProfile(ProjectExistingProfile profile);
	
	
	/**
	 * 删除店铺概要介绍
	 * @param profile
	 */
	public void deleteExistingProfile(Long projectId);

}
