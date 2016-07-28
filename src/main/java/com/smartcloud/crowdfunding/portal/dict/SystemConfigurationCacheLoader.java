package com.smartcloud.crowdfunding.portal.dict;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Persistence;

import com.smartcloud.crowdfunding.portal.model.SystemConfiguration;
import com.smartcloud.platform.component.cache.spi.CacheLoader;

public class SystemConfigurationCacheLoader implements CacheLoader{

	private EntityManager em;
	
	public SystemConfigurationCacheLoader(){
		
		em=Persistence.createEntityManagerFactory("default").createEntityManager();
	}
	
	public Serializable get(Serializable key) {
		String configKey=(String)key;
		SystemConfiguration sc=(SystemConfiguration)em.createNativeQuery("select * from PORTAL_SYSTEM_CONFIG where CONFIG_KEY=? ",SystemConfiguration.class).setParameter(1, configKey).getSingleResult();
		if(sc!=null)
			return sc.getConfigValue();
		return null;

	}

	public Map<Serializable, Serializable> preLoad() {
		List<SystemConfiguration> scs=em.createNativeQuery("select * from PORTAL_SYSTEM_CONFIG",SystemConfiguration.class).getResultList();
		
		if(scs!=null){
			Map<Serializable,Serializable> result=new HashMap<Serializable,Serializable>();
			for(SystemConfiguration sc:scs){
				result.put(sc.getConfigKey(), sc.getConfigValue());
			}
			return result;
		}
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

