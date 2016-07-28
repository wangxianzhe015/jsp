/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/IPortalService.java,v 1.8 2012/12/27 06:50:26 supyuser Exp $
 * $Revision: 1.8 $
 * $Date: 2012/12/27 06:50:26 $
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
 * Created on 2012-6-8
 *******************************************************************************/

package com.smartcloud.crowdfunding.console.service;

import java.util.List;

import com.smartcloud.crowdfunding.console.model.Portal;
import com.smartcloud.crowdfunding.console.model.UserPortal;
import com.smartcloud.crowdfunding.console.model.bean.PortalBean;
import com.smartcloud.crowdfunding.console.model.bean.UserPortalBean;
import com.smartcloud.platform.component.mvc.User;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;


/**
 * 管理员配置portalCatalog和用户定制portal的service
 * 
 * @author fred_2012-11-29下午02:13:34
 * 
 */
@Service
public interface PortalService {

	/**
	 * 管理员新增portalCatalog
	 * 
	 * @param portal
	 * 
	 * @created at 2012-11-29下午01:46:30
	 */
	public void addPortal(Portal portal);

	/**
	 * 获取一个选择的portal的信息
	 * 
	 * @param portal
	 * @return
	 * 
	 * @created at 2012-11-30下午01:10:35
	 */
	public Portal getSinglePortalInfo(Portal portal);

	/**
	 * 更新portal
	 * 
	 * @param portal
	 * @return
	 * 
	 * @created at 2012-11-29下午01:48:03
	 */
	public Portal updatePortal(Portal portal);

	/**
	 * 删除portals
	 * 
	 * @param portals
	 * 
	 * @created at 2012-11-29下午01:48:36
	 */
	public void deletePortal(Portal[] portals);

	/**
	 * 管理员分页查询portals
	 * 
	 * @param portal
	 * @param page
	 * @return
	 * 
	 * @created at 2012-11-29下午01:50:45
	 */
	public List<Portal> fetchPortalsWithPage(Portal portal, Page page);

	/**
	 * 查询某角色拥有的可选portals
	 * 
	 * @param roleIds
	 * @return
	 * 
	 * @created at 2012-11-29下午01:56:56
	 */
	public List<Portal> fetchAllPortalsByRoles(String[] roleIds);

	/**
	 * 初始化当前登录用户的可选PortalCata列表，并初始化选中已有portal
	 * 
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-11-29下午01:57:21
	 */
	public List<PortalBean> fetchAllPortalsByUser(User webUser);

	/**
	 * 保存用户portal的配置
	 * 
	 * @param addUserPortals
	 * @param deleteUserPortals
	 * @param updateUserPortals
	 * 
	 * @created at 2012-11-29下午04:50:22
	 */
	public void saveUserPortalsSettings(UserPortal[] addUserPortals, UserPortal[] deleteUserPortals, UserPortal[] updateUserPortals);

	/**
	 * 用户更改portal信息（自定义定制标题，坐标等）
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-11-29下午02:04:15
	 */
	public UserPortal updateUserPortal(UserPortal userPortal);

	/**
	 * 获得某个选定的userportal信息
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-11-29下午02:05:16
	 */
	public UserPortal getUserPortalInfo(UserPortal userPortal);

	/**
	 * 获得用户定制的portal列表进行初始化
	 * 
	 * 获得每个portal所在的坐标和标题。高度等信息初始化
	 * 
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-11-29下午02:00:15
	 */
	public List<UserPortal> fetchUserPortalsOfCurrentUser(User webUser);

	/**
	 * *获得用户定制的portal列表进行初始化【数据库userPortal中的，在用状态】
	 * 
	 * 获得每个portal所在的坐标和标题。高度等信息初始化
	 * 
	 * @param webUser
	 * @return
	 * 
	 * @created at 2012-12-10下午01:20:10
	 */
	public List<UserPortalBean> fetchUserPortalsOfCurrentUser_withStatus(User webUser);

	/**
	 * 保存用户选择portal:添加模块功能
	 * 
	 * @param addUserPortals
	 * @param deleteUserPortals
	 * 
	 * @created at 2012-11-29下午02:03:08
	 */
	public void manageUserPortals(UserPortal[] addUserPortals, UserPortal[] deleteUserPortals);

	/**
	 * 批量增加用户选中的portal
	 * 
	 * @param adduserPortals
	 * @return
	 * 
	 * @created at 2012-11-29下午02:06:07
	 */
	public int addUserPortals(UserPortal[] adduserPortals);

	/**
	 * 用户新增自定义模块
	 * 
	 * @param userPortal
	 * @return
	 * 
	 * @created at 2012-11-29下午01:54:20
	 */
	public UserPortal addUserPortal(UserPortal userPortal);

	/**
	 * 批量删除用户选择的自定义portal
	 * 
	 * @param deleteUserPortals
	 * 
	 * @created at 2012-11-29下午02:09:12
	 */
	public void deleteuserPortals(UserPortal[] deleteUserPortals);

	/**
	 * 删除某userPortal
	 * 
	 * @param userPortal
	 * 
	 * @created at 2012-12-6下午02:58:14
	 */
	public void deleteuserPortal(UserPortal userPortal);

}
