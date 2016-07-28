package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class AppDao extends DAOSupport<Application> {

	@PersistenceUnit(name = "default")
	private EntityManager em;


	protected Class<Application> getEntityClass() {
		return Application.class;
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public Application addApp(Application app) {
		app = PrimaryKeyUtils.getPrimaryKey(app);
		this.insert(app);
		return app;
	}


	public Application getApp(Application app) {
		app = this.em.find(Application.class, app.getAppId());
		return app;
	}


	public Application getAppByFunc(Function func) {
		Map<String, Long> param = new HashMap<String, Long>();
		param.put("moduleId", func.getModule().getModuleId());
		List<Application> apps = this.executeNamedNativeQuery(Application.QUERY_APP_BY_FUNC, param);
		return apps.size()>0?apps.get(0):new Application();
	}


	public List<Application> getAllApps() {
		List<Application> alist = new ArrayList<Application>();
		alist = this.findAll(Application.class);
		return alist;
	}


	public void deleteApp(Application app) {
		this.em.remove(app);
	}


	public Application updateApp(Application app) {
		this.em.merge(app);
		return app;
	}
	
	

	public List<Application> getUniqueApplicationsByModules(List<Module> modules) {
		if(modules==null || modules.size()==0)
			return new ArrayList<Application>();
		
		Map<String, Object> param = new HashMap<String, Object>();
		String[] tmps = new String[modules.size()];
		for (int i = 0; i < modules.size(); i++) {
			String cons =  String.valueOf(modules.get(i).getModuleId());
			tmps[i] = cons;
		}
		param.put("moduleIds", StringUtils.join(tmps, ","));
		return this.executeNamedNativeQuery(Application.GET_APP_BY_MODULE, param);

	}
}
