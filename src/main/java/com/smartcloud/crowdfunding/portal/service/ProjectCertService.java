package com.smartcloud.crowdfunding.portal.service;

import com.smartcloud.crowdfunding.portal.model.ProjectCert;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目证书服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectCertService {

	/**
	 * 获取项目资料证书
	 * @param projectId
	 * @return
	 */
	public ProjectCert getProjectCert(Long projectId);
	
	
	/**
	 * 更新项目资料证书
	 * @param cert
	 * @return
	 */
	public int saveProjectCert(ProjectCert cert);
	
	/**
	 * 删除项目资料证书
	 * @param cert
	 */
	public void deleteProjectCert(Long projectId);
}
