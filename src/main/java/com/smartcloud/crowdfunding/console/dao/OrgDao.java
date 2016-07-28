/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/dao/OrgDao.java,v 1.2 2012/12/31 07:49:10 supyuser Exp $
 * $Revision: 1.2 $
 * $Date: 2012/12/31 07:49:10 $
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
 * Created on 2012-5-10
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.util.Constants;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class OrgDao extends DAOSupport<Org> {

	@PersistenceUnit(name = "default")
	private EntityManager em;


	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public Org addOrg(Org org) {
		org = PrimaryKeyUtils.getPrimaryKey(org);
		if ("".equals(org.getParentOrgId()) || org.getParentOrgId() == null) {
			org.setParentOrgId(null);// �մ���תΪ0
			org.setOrgPath(new StringBuilder(Constants.PATH_FLAG).append(org.getOrgId()).toString());
		} else {
			org.setOrgPath(new StringBuilder(org.getParentOrgPath()).append(Constants.PATH_FLAG).append(org.getOrgId()).toString());
		}
		this.em.persist(org);
		return org;
	}


	public Org updateOrg(Org org) {
		this.update(org);
		return org;
	}


	public int deleteOrg(Org org) {
		this.em.remove(org);
		return 0;
	}


	public Org findOrgInfo(Org org) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("orgId", org.getOrgId().toString());
		List<Org> result = this.executeNamedNativeQuery(Org.QUERY_ORGINFO_WITH_PARENT, param);
		return result.size()>0?result.get(0):new Org();
	}

	// public


	public Org findOrgInfo(String orgId) {
		return em.find(Org.class, orgId);
	}


	public List<Org> fetchAllOrgInfos() {
		return this.findAll(Org.class);
	}


	public List<Org> fetchAllOrgWithPage(Org org, Page page) {
		List<Org> olist = new ArrayList<Org>();
		olist = this.executeNamedNativePageQuery(Org.QUERY_ORGINFO_WITH_PARENT, org, page);

		return olist;
	}


	public List<Org> fetchRootOrgs() {
		List<Org> olist = new ArrayList<Org>();
		olist = (List<Org>) this.createNamedNativeQuery(Org.QUERY_ROOT_ORGINFO).getResultList();
		return olist;
	}
	

	public List<Org> getAllOrgs(){
		return (List<Org>) this.createNamedNativeQuery(Org.GET_ALL_ORG).getResultList();
	}
	

	public List<Org> getChildrenOrgs(String orgPath){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orgPath","'"+orgPath+"%'");
		return this.executeNamedNativeQuery(Org.GET_CHILDREN_ORG,paramMap);
	}
	

	public List<Org> fetchChildrenOrgInfos(String orgId, Boolean deeply) {

		List<Org> olist = new ArrayList<Org>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (deeply) {
			Org tmpOrg = findOrgInfo(orgId);
			paramMap.put("parentOrgId", tmpOrg.getOrgPath());
			olist = this.executeNamedNativeQuery(Org.QUERY_CHILDREN_ORGINFO_DEEPLY, paramMap);
		} else {
			paramMap.put("parentOrgId", orgId);
			olist = this.executeNamedNativeQuery(Org.QUERY_CHILDREN_ORGINFO, paramMap);
		}
		return olist;
	}

}
