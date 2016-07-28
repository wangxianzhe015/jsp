package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.Banner;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 横幅服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface BannerService {

	/**
	 * 获取所有横幅
	 * @return
	 */
	public List<Banner> getAllBanners();
	
	/**
	 * 分页获取所有横幅
	 * @param banner 查询条件
	 * @param page 分页对象
	 * @return
	 */
	public List<Banner> findAllBanners(Banner banner,Page page);
	
	/**
	 * 获取横幅信息
	 * @param bannerId
	 * @return
	 */
	public Banner getBanner(Long bannerId);
	/**
	 * 删除横幅
	 * @param bannerId
	 */
	public void removeBanner(Long bannerId);
	
	/**
	 * 添加横幅
	 * @param banner
	 */
	public void addBanner(Banner banner);
	
	/**
	 * 修改横幅
	 * @param banner
	 */
	public void updateBanner(Banner banner);
}
