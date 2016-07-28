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

import com.smartcloud.platform.component.cache.CacheFactory;
import com.smartcloud.platform.component.cache.spi.Cache;

/**
 * 数据字典工厂类
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SystemConfigurationFactory {
	
	/**
	 * 文件上传根路径，如果不设置则存储WEBAPPS下相对路径
	 */
	public static final String KEY_FILEUPLOAD_ROOT_PATH="file.upload.root.path";
	/**
	 * 文件访问URL前缀,如果不设置则为当前应用上下文
	 */
	public static final String KEY_FILE_ACCESS_PREFIX="file.access.prefix";
	
	
	private static final String CACHE_NAME="SystemConfigurationDictionaryCache";
	
	private static SystemConfigurationFactory INSTANCE;
	
	private Cache dictionaryCache;
	
	private SystemConfigurationFactory(){
		dictionaryCache=CacheFactory.getInstance().findCache(CACHE_NAME);
	}
	
	public static SystemConfigurationFactory getInstance(){
		if(INSTANCE==null){
			INSTANCE=new SystemConfigurationFactory();
		}
		return INSTANCE;
	}
	

	/**
	 * 获取配置值
	 * @param configKey
	 * @return
	 */
	public String getConfigValue(String configKey){
		String configValue=(String)dictionaryCache.get(configKey);

		return configValue;
	}

	


}
