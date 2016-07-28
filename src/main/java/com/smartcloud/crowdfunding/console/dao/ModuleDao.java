package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.Application;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.crowdfunding.console.model.Role;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.query.QueryExt;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class ModuleDao extends DAOSupport<Module> {
	@PersistenceUnit(name = "default")
	private EntityManager em;



	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public void addModule(Module module) {

		module = PrimaryKeyUtils.getPrimaryKey(module);
		if (module.getModulePath() == null || "".equals(module.getModulePath())) {
			module.setModulePath(new StringBuilder("|").append(module.getModuleId()).toString());
		} else {
			module.setModulePath(new StringBuilder(module.getModulePath()).append( "|").append(module.getModuleId()).toString());
		}
		
		if (module.getParentModuleId() == 0) {
			module.setParentModuleId(null);
		}
		em.persist(module);
	}

	public Module updateModule(Module module) {
		this.update(module);
		return module;
	}

	public void deleteModule(Module module) {
		em.remove(module);
	}


	public Module fecthModule(Module module) {
		return em.find(Module.class, module.getModuleId());
	}


	public List<Module> fetchAllModulesWithPage(Module module, Page page) {
		return this.executeEntitiesPageQuery(module, page);// ��ҳ��ѯ
	}


	public List<Module> fetchModuleByRole(Role role) {
		// // this.createNamedNativeQuery("").getResultList();
		// // this.createNamedNativeQuery("").executeUpdate();

		List<Module> mlist = (List<Module>) this.createNamedNativeQuery("QUERY_TEST").getResultList();

		for (Module module : mlist) {
			System.out.println(module.getClass());

		}

		return null;
	}


	public List<Module> fetchRootModule() {
		QueryExt qt = this.createNamedNativeQuery(Module.QUERY_ROOT_MODULE);
		return (List<Module>) qt.getResultList();
	}


	public List<Module> fetchRootModule(Application app) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("appId", app.getAppId().toString());
		return this.executeNamedNativeQuery(Module.QUERY_ROOT_MODULE, paramMap);

	}


	public List<Module> fetchRootModuleByApp(Application app) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("appId", app.getAppId().toString());
		return this.executeNamedNativeQuery(Module.QUERY_ROOT_MODULE, paramMap);
	}


	public List<Module> fetchAllModules() {
		return this.findAll(Module.class);
	}


	public List<Module> fetchModulesbyApp(Application app) {
		QueryExt qt = this.createNamedNativeQuery(Module.QUERY_MODULES_BY_APP);
		qt.setParameter("appId", app.getAppId());
		return (List<Module>) qt.getResultList();

	}


	public List<Module> fetchModulesByPModule(String parentModuleId) {
		QueryExt qt = this.createNamedNativeQuery(Module.QUERY_MODULES_BY_MODULE);
		qt.setParameter("parentModuleId", parentModuleId);
		return (List<Module>) qt.getResultList();

	}


	public Module fetchModuleOfFunc(String funcId) {
		Module module = new Module();
		return module;

	}
	
	

	public List<Module> getUniqueModulesByRoles(String[] roleIds) {
		if(roleIds==null || roleIds.length==0)
			return new ArrayList<Module>();
		
		Map<String, Object> param = new HashMap<String, Object>();
		String[] tmps = new String[roleIds.length];
		for (int i = 0; i < roleIds.length; i++) {
			String cons = "'" + roleIds[i] + "'";
			tmps[i] = cons;
		}
		param.put("roleIds", StringUtils.join(tmps, ","));
		return this.executeNamedNativeQuery(Module.GET_MODULE_BY_ROLE, param);
		
	}

}
