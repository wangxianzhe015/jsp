package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 城市信息服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface ProjectCityService {

	/**
	 * 获取所有省份
	 * @return
	 */
	public List<ProjectCity> getProvinces();
	
	/**
	 * 获取某一省份下所有城市
	 * @param id 省份ID
	 * @return
	 */
	public List<ProjectCity> getCitys(String id);
	
}
