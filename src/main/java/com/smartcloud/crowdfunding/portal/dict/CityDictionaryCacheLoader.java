package com.smartcloud.crowdfunding.portal.dict;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.platform.component.cache.spi.CacheLoader;

public class CityDictionaryCacheLoader implements CacheLoader{

	private EntityManager em;

	/**
	 * 获取省份列表
	 */
	public static final String GET_PROVINCE_LIST="_get_province_list:";
	/**
	 * 获取城市列表
	 */
	public static final String GET_CITY_LIST="_get_city_list:";
	
	/**
	 * 获取城市
	 */
	public static final String GET_CITY="_get_city:";
	
	public CityDictionaryCacheLoader(){
		em=Persistence.createEntityManagerFactory("default").createEntityManager();
	}
	
	public Serializable get(Serializable key) {
		String cityId=(String)key;
		
		if(cityId.startsWith(GET_CITY_LIST)){
			String provinceId=cityId.substring(GET_CITY_LIST.length());
			return (Serializable)em.createNativeQuery("select * from PORTAL_PROJECT_CITY where parent_id=? ", ProjectCity.class).setParameter(1, provinceId).getResultList();
		}
		else if(cityId.startsWith(GET_PROVINCE_LIST)){
			return (Serializable)em.createNativeQuery("select * from PORTAL_PROJECT_CITY where (parent_id='' or parent_id is null) ", ProjectCity.class).getResultList();
		}
		else if(cityId.startsWith(GET_CITY)){
			cityId=cityId.substring(GET_CITY.length());
			ProjectCity city=(ProjectCity)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_CITY WHERE ID=?", ProjectCity.class).setParameter(1, cityId).getSingleResult();
			return city;
		}
		return null;
	}

	public Map<Serializable, Serializable> preLoad() {
		// TODO Auto-generated method stub
		return null;
	}

	public void put(Serializable arg0, Serializable arg1) {
		// TODO Auto-generated method stub
		
	}

	public Serializable remove(Serializable arg0) {
		// TODO Auto-generated method stub
		return null;
	}



}
