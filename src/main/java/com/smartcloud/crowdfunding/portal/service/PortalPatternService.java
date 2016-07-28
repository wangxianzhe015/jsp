package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.PortalPattern;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 合作伙伴服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface PortalPatternService {

	/**
	 * 获取所有合作伙伴
	 * @return
	 */
	public List<PortalPattern> getAllPortalPatterns();
	
	/**
	 * 分页获取所有合作伙伴
	 * @param PortalPattern 查询条件
	 * @param page 分页对象
	 * @return
	 */
	public List<PortalPattern> findAllPortalPatterns(PortalPattern portalPattern,Page page);
	
	/**
	 * 获取合作伙伴信息
	 * @param patternId
	 * @return
	 */
	public PortalPattern getPortalPattern(Long patternId);
	/**
	 * 删除合作伙伴
	 * @param patternId
	 */
	public void removePortalPattern(Long patternId);
	
	/**
	 * 添加合作伙伴
	 * @param PortalPattern
	 */
	public void addPortalPattern(PortalPattern portalPattern);
	
	/**
	 * 修改合作伙伴
	 * @param PortalPattern
	 */
	public void updatePortalPattern(PortalPattern portalPattern);
}
