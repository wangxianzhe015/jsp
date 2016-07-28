/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/dao/UserDao.java,v 1.4 2012/12/31 02:37:06 supyuser Exp $
 * $Revision: 1.4 $
 * $Date: 2012/12/31 02:37:06 $
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

import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition;
import com.smartcloud.platform.component.persistence.support.sqlgen.Condition.OPERATOR;
import com.smartcloud.platform.component.persistence.support.sqlgen.SQLGenerator;
import com.smartcloud.platform.component.persistence.utils.PrimaryKeyUtils;

public class UserDao extends DAOSupport<User> {

	@PersistenceUnit(name = "default")
	private EntityManager em;
	
	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


	public User fetchUser(User user) {
		String sql = SQLGenerator.buildSelectByConditoinSQL(User.class, Condition.newCondition("USER_NAME", OPERATOR.EQUAL));
		user = (User) em.createNativeQuery(sql, User.class).setParameter("USER_NAME", user.getUserName()).getSingleResult();
		return user;
	}


	public List<User> findUsersWithPage(User user, Page page) {
		return this.executeEntitiesPageQuery(user, page);

	}


	public List<User> findAllUsers() {
		List<User> ulist = new ArrayList<User>();
		ulist = (List<User>) this.createNamedNativeQuery(User.QUERY_USER_WITH_ORGINFO).getResultList();
		return ulist;

	}


	public List<User> findAllUsers(String orgId) {

		List<User> ulist = new ArrayList<User>();

		Map<String, String> param = new HashMap<String, String>();
		param.put("orgId", orgId);
		ulist = this.executeNamedNativeQuery(User.QUERY_USER_WITH_ORGINFO_BY_ORG, param);
		return ulist;

	}


	public List<User> findAllUsersNoOrg() {

		List<User> ulist = new ArrayList<User>();

		ulist = (List<User>) this.createNamedNativeQuery(User.QUERY_USER_NO_ORG).getResultList();
		return ulist;

	}


	public User findUser(User user) {
		return em.find(User.class, user.getUserId());
	}


	public void addUser(User user) {
		user = PrimaryKeyUtils.getPrimaryKey(user);
		this.insert(user);

	}


	public User updateUser(User user) {
		this.update(user);
		return user;
	}


	public void removeUser(User user) {
		em.remove(user);
	}

}
