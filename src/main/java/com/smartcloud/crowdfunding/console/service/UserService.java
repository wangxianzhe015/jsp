/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/IUserService.java,v 1.1 2012/12/04 07:35:18 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:18 $
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

package com.smartcloud.crowdfunding.console.service;

import java.util.List;

import javax.jws.WebParam;
import javax.jws.WebService;

import com.smartcloud.crowdfunding.console.model.User;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
@WebService
public interface UserService {

	/**
	 * 添加用户
	 * 
	 * @param user
	 */
	public void addUser(@WebParam(name="user") User user);

	/**
	 * 修改用户
	 * 
	 * @param user
	 */
	public void updateUser(@WebParam(name="user")User user);

	/**
	 * 删除用户
	 * 
	 * @param user
	 */
	public void removeUser(@WebParam(name="user")User user);

	/**
	 * 获取用户信息
	 * 
	 * @param user
	 */
	public User getUser(@WebParam(name="user")User user);

	/**
	 * 分页查询用户
	 * 
	 * @param user
	 * @param page
	 */
	public List<User> findUsers(@WebParam(name="user")User user, @WebParam(name="page")Page page);

	/**
	 * 获得某个机构下的用户树
	 * 
	 * @param userId 初始化选中对象
	 * @param orgId 显示特定分组
	 * @return
	 */
	public List<TreeNodeBean> fetchUserWithOrgTree(@WebParam(name="userIds")String[] userId, @WebParam(name="orgId")String orgId);

}
