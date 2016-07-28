/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/dao/FunctionDao.java,v 1.1 2012/12/07 02:30:13 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/07 02:30:13 $
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
 * Created on 2012-5-28
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.model.Function;
import com.smartcloud.crowdfunding.console.model.Module;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;


public class FunctionDao extends DAOSupport<Function> {

	@PersistenceUnit(name = "default")
	private EntityManager em;


	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public void updateFunction(Function function) {
		this.update(function);

	}


	public void deleteFunc(Function func) {
		this.em.remove(func);
	}


	public void addFunc(Function func) {
		func = PrimaryKeyUtils.getPrimaryKey(func);
		func.setModulePath(func.getModule().getModulePath());
		em.persist(func);
	}

	public List<Function> getFunctionByRoles(String[] roleIds) {
		// return
		// em.createNamedQuery("GET_FUNCTION_BY_ROLE").setParameter("ROLEIDS",
		// roleIds).getResultList();
		return null;
	}


	public List<Function> fetchAllFunctionsWithPage(Function function, Page page) {
		List<Function> flist = new ArrayList<Function>();
		flist = this.executeEntitiesPageQuery(function, page);
		return flist;

	}


	public Function getFunctionById(Function function) {
		function = em.find(Function.class, function.getFunctionId());
		return function;
	}


	public List<Function> fetchFuncsByRole(String roleId) {
		List<Function> flist = new ArrayList<Function>();
		return flist;
	}


	public List<Function> fetchFuncsByModule(String moduleId) {
		List<Function> flist = new ArrayList<Function>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("moduleId", moduleId);
		flist = this.executeNamedNativeQuery(Function.QUERY_FUNCS_BY_MODULE, paramMap);
		return flist;
	}


	public List<Function> fetchFuncsByRoles(String[] roleIds) {
		List<Function> flist = new ArrayList<Function>();
		Map<String, Object> param = new HashMap<String, Object>();
		String[] tmps = new String[roleIds.length];
		if (tmps.length > 0) {
			for (int i = 0; i < roleIds.length; i++) {
				String cons = "'" + roleIds[i] + "'";
				tmps[i] = cons;
			}
			param.put("roleIds", StringUtils.join(tmps, ","));
			flist = this.executeNamedNativeQuery(Function.QUERY_FUNCS_IN_ROLEIDS, param);
		}
		return flist;
	}

	public List<Function> fetchFuncsByRolesAndModule(String[] roleIds, Module module) {
		List<Function> flist = new ArrayList<Function>();
		Map<String, Object> param = new HashMap<String, Object>();
		String[] tmps = new String[roleIds.length];
		if (tmps.length > 0) {
			for (int i = 0; i < roleIds.length; i++) {
				String cons = "'" + roleIds[i] + "'";
				tmps[i] = cons;
			}
			param.put("roleIds", StringUtils.join(tmps, ","));
			param.put("moduleId", module.getModuleId());
			flist = this.executeNamedNativeQuery(Function.QUERY_FUNCS_IN_ROLEIDS_AND_MODULE, param);
		}
		return flist;
	}


	public List<Function> fetchFuncsNoPermission() {
		return this.executeNamedNativeQuery(Function.QUERY_FUNCS_NO_ACCESS,new HashMap<String,String>());

	}
	
}
