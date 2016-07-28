/*******************************************************************************
 * $Header: /cvslv/source/eos/java/iplatform2/web/WEB-INF/MODULES/gas/src/org/venus/iplatform/gas/model/bean/MenuBean.java,v 1.1 2012/12/04 07:35:16 supyuser Exp $
 * $Revision: 1.1 $
 * $Date: 2012/12/04 07:35:16 $
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

package com.smartcloud.crowdfunding.console.model.bean;

import java.util.ArrayList;
import java.util.List;

import com.smartcloud.crowdfunding.console.model.Module;


/**
 * 封装菜单使用；主菜单bean(封装module)
 * 
 * @author fred_2012-10-12上午10:14:03
 * 
 */
public class MenuBean {
	
	private String contextPath;
	private String port;
	private String protocol;
	private String ip;

	private Module module;//TODO *待更新,将属性合并成module实体...
	private String menuId;// 菜单属性，唯一标识区分节点
	private String menuName;
	private String parentMenuId;// 上级菜单的标识
	private String iconPath;// icon路径，此属性应当来自于module表，暂时无此属性
	private String menuUrl;// 菜单路径，只有模块入口才有值
	private int displayNo;
	
	private boolean leaf;
	
	private Boolean hasChildren;// 是否有子菜单
	private List<MenuBean> children;// 子模块

	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(String parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	public List<MenuBean> getChildren() {
		if(children==null)
			children=new ArrayList<MenuBean>();
		
		return children;
	}

	public void setChildren(List<MenuBean> children) {
		this.children = children;
	}

	public String getIconPath() {
		return iconPath;
	}

	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}

	public String getMenuUrl() {
		StringBuilder url=new StringBuilder().append(protocol).append("://").append(ip);
		if(port!=null && port.length()>0){
			url.append(":").append(port);
		}
		
		return url.append(contextPath).append(menuUrl).toString();
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public Boolean getHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(Boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public String getContextPath() {
		return contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getProtocol() {
		return protocol;
	}

	public void setProtocol(String protocol) {
		this.protocol = protocol;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getDisplayNo() {
		return displayNo;
	}

	public void setDisplayNo(int displayNo) {
		this.displayNo = displayNo;
	}

	public boolean isLeaf() {
		return leaf;
	}

	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	

	
}
