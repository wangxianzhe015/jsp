package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.Banner;
import com.smartcloud.crowdfunding.portal.service.BannerService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class BannerServiceImpl extends DAOSupport implements BannerService {
	
	@PersistenceUnit(name="default")
	private EntityManager em;

	
	public List<Banner> getAllBanners() {
		List<Banner> banners=this.findAll(Banner.class);
		Collections.sort(banners, new Comparator<Banner>(){

			public int compare(Banner o1, Banner o2) {
				return o1.getOrderNo()-o2.getOrderNo();
			}
			
		});
		return banners;
	}

	public List<Banner> findAllBanners(Banner banner, Page page) {
		
		return this.executeEntitiesPageQuery(banner, page);
	}

	public void removeBanner(Long bannerId) {
		Banner banner=new Banner();
		banner.setBannerId(bannerId);
		this.delete(banner);
		
	}

	public void addBanner(Banner banner) {
		this.insert(banner);
	}

	public void updateBanner(Banner banner) {
		this.update(banner);
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public Banner getBanner(Long bannerId) {
		Banner banner=new Banner();
		banner.setBannerId(bannerId);
		return (Banner)this.find(banner);
	}

}
