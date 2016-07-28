/*******************************************************************************
 * $Header: /cvslv/source/eos/java/ff-core/src/cn/chinaclear/sh/tp/core/web/dict/DictionaryLoaderFactory.java,v 1.7 2012/10/15 09:07:02 supyuser Exp $
 * $Revision: 1.7 $
 * $Date: 2012/10/15 09:07:02 $
 *
 *==============================================================================
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License. 
 * 
 * Created on 2012-7-23
 *******************************************************************************/


package com.smartcloud.crowdfunding.portal.dict;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.platform.component.cache.CacheFactory;
import com.smartcloud.platform.component.cache.spi.Cache;

/**
 * 数据字典工厂类
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class CityDictionaryFactory {
	
	private static final String CACHE_NAME="CityDictionaryCache";
	
	private static CityDictionaryFactory INSTANCE;
	
	private Cache dictionaryCache;
	
	private CityDictionaryFactory(){
		dictionaryCache=CacheFactory.getInstance().findCache(CACHE_NAME);
	}
	
	
	public static CityDictionaryFactory getInstance(){
		if(INSTANCE==null){
			INSTANCE=new CityDictionaryFactory();
		}
		return INSTANCE;
	}
	

	/**
	 * 获取城市名
	 * @param cityId
	 * @return
	 */
	public String getCityName(String cityId){
		ProjectCity city=getCity(cityId);
		if(city!=null){
			return city.getName();
		}
		return null;
	}
	/**
	 * 获取省份+城市名
	 * @param 
	 * @return
	 */
	public String getProvinceAndCityName(String cityId){
		ProjectCity province=null;
		ProjectCity city=getCity(cityId);
		if(city!=null){
			String provinceId=city.getParentId().toString();
			if(provinceId!=null){
				province=getCity(provinceId);
			}
		}
		
		if(province!=null)
			return province.getName()+((city!=null)?city.getName():"");
		else
			return (city!=null)?city.getName():null;
	}
	
	/**
	 * 获取城市名称
	 * @param 
	 * @return
	 */
	public ProjectCity getCity(String cityId){
		return (ProjectCity)dictionaryCache.get(CityDictionaryCacheLoader.GET_CITY+cityId);
	}

	/**
	 * 获取省份下的所有城市
	 * @param provinceId
	 * @return
	 */
	public List<ProjectCity> getCitys(String provinceId){
		return (List<ProjectCity>)dictionaryCache.get(CityDictionaryCacheLoader.GET_CITY_LIST+provinceId);
	}
	
	/**
	 * 获取所有省份
	 * @return
	 */
	public List<ProjectCity> getProvinces(){
		return (List<ProjectCity>)dictionaryCache.get(CityDictionaryCacheLoader.GET_PROVINCE_LIST);
	}

	


}
