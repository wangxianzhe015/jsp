package com.smartcloud.crowdfunding.portal.dict;

import java.io.Serializable;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.portal.model.ProjectCategory;
import com.smartcloud.platform.component.cache.spi.CacheLoader;

/**
 * 项目分类数据字典加载器
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class ProjectCategoryCacheLoader implements CacheLoader {

	private EntityManager em;

	/**
	 * 获取项目行业分类列表
	 */
	public static final String GET_CATEGORY_LIST="_get_category_list:";

	/**
	 * 获取项目行业分类信息
	 */
	public static final String GET_CATEGORY="_get_category:";
	
	public ProjectCategoryCacheLoader(){
		em=Persistence.createEntityManagerFactory("default").createEntityManager();
	}
	
	public Serializable get(Serializable key) {
		String categoryId=(String)key;
		
		if(categoryId.startsWith(GET_CATEGORY_LIST)){
			categoryId=categoryId.substring(GET_CATEGORY_LIST.length());
			StringBuilder sql=new StringBuilder("SELECT * FROM PORTAL_PROJECT_CATEGORY");
			if(StringUtils.isBlank(categoryId)){
				sql.append(" WHERE PARENT_CATEGORY_ID IS NULL ");
			}else{
				sql.append(" WHERE PARENT_CATEGORY_ID="+categoryId);
			}
			
			return (Serializable)em.createNativeQuery(sql.toString(), ProjectCategory.class).getResultList();
		}
		else if(categoryId.startsWith( GET_CATEGORY)){
			categoryId=categoryId.substring( GET_CATEGORY.length());
			ProjectCategory category=(ProjectCategory)em.createNativeQuery("SELECT * FROM PORTAL_PROJECT_CATEGORY WHERE CATEGORY_ID=?", ProjectCategory.class).setParameter(1, categoryId).getSingleResult();
			return category;
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
