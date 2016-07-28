/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/service/IOrgService.java,v 1.1 2012/12/04 07:35:18 supyuser Exp $
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

import com.smartcloud.crowdfunding.console.model.Org;
import com.smartcloud.crowdfunding.console.model.bean.TreeNodeBean;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

@Service
public interface OrgService {
	/**
	 * 更新部门信息
	 * 
	 * @param org
	 * 
	 * @created at 2012-10-11下午01:19:21
	 */
	public void updateOrgInfo(Org org);

	/**
	 * 删除此机构
	 * 
	 * @param org
	 * 
	 * @created at 2012-10-11下午01:19:37
	 */
	public void deleteOrg(Org org);
	/**
	 * 删除多个机构
	 * @param orgs
	 *
	 * @created at 2012-10-11下午01:34:41
	 */
	public void deleteOrgs(Org[] orgs);

	/**
	 * 新增机构
	 * 
	 * @param org
	 * 
	 * @created at 2012-10-11下午01:19:48
	 */
	public void addOrg(Org org);

	/**
	 * 分页查询符合条件的部门信息
	 * 
	 * @param org
	 * @param page
	 * @return
	 */
	public List<Org> fetchOrgsWithPage(Org org, Page page);

	/**
	 * 获得部门信息
	 * 
	 * @param org
	 * @return
	 * 
	 * @created at 2012-9-24下午01:56:10
	 */
	public Org fetchSingleOrgInfo(Org org);

	/**
	 * 获得所有的部门信息，方便生成树
	 * 
	 * @return
	 */
	public List<Org> fetchAllOrg();

	/**
	 * 初始化机构树
	 * 
	 * @param orgId
	 *            组织机构id,初始化哪些选中
	 * @param porgId
	 *            上级机构ID，初始化显示哪些分组
	 * @return
	 */
	public List<TreeNodeBean> fetchOrgTreeNodes(String orgId, String porgId);

}
