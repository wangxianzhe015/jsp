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

import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.platform.component.cache.CacheFactory;
import com.smartcloud.platform.component.cache.spi.Cache;

/**
 * 数据字典工厂类
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class ProjectCategoryDictionaryFactory {
	
	private static final String CACHE_NAME="ProjectCategoryDictionaryCache";
	
	private static ProjectCategoryDictionaryFactory INSTANCE;
	
	private Cache dictionaryCache;
	
	private ProjectCategoryDictionaryFactory(){
		dictionaryCache=CacheFactory.getInstance().findCache(CACHE_NAME);
	}
	
	
	public static ProjectCategoryDictionaryFactory getInstance(){
		if(INSTANCE==null){
			INSTANCE=new ProjectCategoryDictionaryFactory();
		}
		return INSTANCE;
	}
	

	/**
	 * 获取项目分类描述
	 * @param categoryId 项目分类ID
	 * @return
	 */
	public String getProjectCategoryName(String categoryId){
		ProjectCategory category=getProjectCategory(categoryId);
		if(category!=null){
			return category.getCategoryName();
		}
		return null;
	}

	
	/**
	 * 获取分类信息
	 * @param 
	 * @return
	 */
	public ProjectCategory getProjectCategory(String categoryId){
		return (ProjectCategory)dictionaryCache.get(ProjectCategoryCacheLoader.GET_CATEGORY+categoryId);
	}

	/**
	 * 获取指定分类下的所有子类别
	 * @param categoryId
	 * @return
	 */
	public List<ProjectCategory> getProjectCategories(String categoryId){
		return (List<ProjectCategory>)dictionaryCache.get(ProjectCategoryCacheLoader.GET_CATEGORY_LIST+categoryId);
	}
	
	/**
	 * 获取根分类列表
	 * @return
	 */
	public List<ProjectCategory> getProjectCategories(){
		return (List<ProjectCategory>)dictionaryCache.get(ProjectCategoryCacheLoader.GET_CATEGORY_LIST);
	}

	


}
