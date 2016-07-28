package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 项目分类服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectCategoryService {

	/**
	 * 获取项目主分类
	 * @return
	 */
	public List<ProjectCategory> getProjectCategories();
	
}
