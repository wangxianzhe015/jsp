/******************************
 * 
 ******************************/
package com.smartcloud.crowdfunding.console.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import com.smartcloud.crowdfunding.console.dao.PortalDao;
import com.smartcloud.crowdfunding.console.dao.UserPortalDao;
import com.smartcloud.crowdfunding.console.model.Portal;
import com.smartcloud.crowdfunding.console.model.UserPortal;
import com.smartcloud.crowdfunding.console.model.bean.PortalBean;
import com.smartcloud.crowdfunding.console.model.bean.UserPortalBean;
import com.smartcloud.crowdfunding.console.service.PortalService;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Reference;


/**
 * @author fred_2012-11-28上午09:03:10
 * 
 */

public class PortalServiceImpl implements PortalService {
	@Reference
	private PortalDao portalDao;
	@Reference
	private UserPortalDao userPortalDao;


	public void addPortal(Portal portal) {
		portalDao.addPortal(portal);
	}


	public void deletePortal(Portal[] portals) {
		for (Portal portal : portals) {
			portalDao.deletePortal(portal);
			portalDao.deleteUserPortalsByPortal(portal);

		}
	}

	public List<Portal> fetchPortalsWithPage(Portal portal, Page page) {
		List<Portal> plist = new ArrayList<Portal>();
		plist = portalDao.fetchPortalsWithPage(portal, page);
		return plist;
	}


	public Portal updatePortal(Portal portal) {
		portalDao.updatePortal(portal);
		return portal;
	}


	public UserPortal addUserPortal(UserPortal userPortal) {
		userPortalDao.addUserPortal(userPortal);
		userPortalDao.changeUserPortalLayout(userPortal);
		userPortal = getUserPortalInfo(userPortal);
		return userPortal;
	}


	public int addUserPortals(UserPortal[] adduserPortals) {
		int i = 0;
		for (UserPortal userPortal : adduserPortals) {
			addUserPortal(userPortal);
			i++;
		}
		return i;
	}

	public void deleteuserPortals(UserPortal[] deleteUserPortals) {
		for (UserPortal userPortal : deleteUserPortals) {
			deleteuserPortal(userPortal);
		}

	}
	
	

	public void deleteuserPortal(UserPortal userPortal) {
		userPortalDao.deleteUserPortal(userPortal);
	}

	public List<Portal> fetchAllPortalsByRoles(String[] roleIds) {
		List<Portal> totalPlist = new ArrayList<Portal>();
		totalPlist = portalDao.fetchAllPortals();
		List<Portal> returnList = new ArrayList<Portal>();
		for (Portal portal : totalPlist) {
			String roleIdsStr = portal.getRoleIds();
			// 使用中的
			if (UserPortal.CATALOG_STAUS_IN_USE.equals(portal.getCatalogStaus())) {
				// 需要权限访问的,只要俩属性都为空，不需要权限，否则就需要
				if (StringUtils.isNotEmpty(roleIdsStr) || "1".equals(portal.getCatalogAccess())) {
					String[] temps = roleIdsStr.split(",");
					List<String> userRoleList = Arrays.asList(roleIds);
					List<String> portalRoleList = Arrays.asList(temps);
					Collection<String> ci = CollectionUtils.intersection(userRoleList, portalRoleList);// 判断是否有交集
					if (CollectionUtils.isNotEmpty(ci)) {
						returnList.add(portal);
					}
				} else {
					returnList.add(portal);
				}
			}

		}
		return returnList;
	}

	public List<PortalBean> fetchAllPortalsByUser(com.smartcloud.platform.component.mvc.User webUser) {
		String[] roleIds = webUser.getRoleIds();
		
		List<Portal> totalPlist = fetchAllPortalsByRoles(roleIds);
		Map<String, PortalBean> tpmap = new HashMap<String, PortalBean>();
		for (Portal portal : totalPlist) {
			PortalBean tmpBean = new PortalBean();
			tmpBean.setPortal(portal);
			tpmap.put(portal.getCatalogId().toString(), tmpBean);
		}
	
		
		List<UserPortal> uplist = fetchUserPortalsOfCurrentUser(webUser);
		for (UserPortal userPortal : uplist) {
			if (userPortal.getPortal() != null) {
				String catalogId = userPortal.getPortal().getCatalogId().toString();
				if (tpmap.containsKey(catalogId)) {
					tpmap.get(catalogId).setPersistState(PortalBean.PERSIST_STATE_EXIST);// 赋值已选择状态
				}
			}
		}
		List<PortalBean> pblist = new ArrayList<PortalBean>();
		Collection<PortalBean> cl = tpmap.values();
		for (PortalBean portalBean : cl) {
			pblist.add(portalBean);
		}
		return pblist;
	}


	public List<UserPortal> fetchUserPortalsOfCurrentUser(com.smartcloud.platform.component.mvc.User webUser) {
		String userId = webUser.getUserId();
		UserPortal userPortal = new UserPortal();
		userPortal.setUserId(Long.parseLong(userId));
		List<UserPortal> uplist = new ArrayList<UserPortal>();
		uplist = userPortalDao.fetchUserPortalsByCon(userPortal);
		return uplist;
	}


	public List<UserPortalBean> fetchUserPortalsOfCurrentUser_withStatus(com.smartcloud.platform.component.mvc.User webUser) {
		List<UserPortalBean> returnList = new ArrayList<UserPortalBean>();
		String userId = webUser.getUserId();
		UserPortal userPortal = new UserPortal();
		userPortal.setUserId(Long.parseLong(userId));
		List<UserPortal> uplist = new ArrayList<UserPortal>();
		uplist = userPortalDao.fetchUserPortalsByCon(userPortal);
		for (UserPortal tmp : uplist) {
			if (tmp.getPortal() != null) {
				UserPortalBean upBean = new UserPortalBean();
				upBean.setUserPortal(tmp);
				upBean.setPersistState(UserPortalBean.PERSIST_STATE_EXIST);
				returnList.add(upBean);
			}
		}
		return returnList;
	}

	public UserPortal getUserPortalInfo(UserPortal userPortal) {
		userPortal = userPortalDao.getSingleUserPortalInfo(userPortal);
		return userPortal;
	}


	public void manageUserPortals(UserPortal[] addUserPortals, UserPortal[] deleteUserPortals) {
		addUserPortals(addUserPortals);
		deleteuserPortals(deleteUserPortals);
	}

	public UserPortal updateUserPortal(UserPortal userPortal) {
		userPortalDao.updateUserPortal(userPortal);
		userPortal = getUserPortalInfo(userPortal);
		return userPortal;
	}


	public void saveUserPortalsSettings(UserPortal[] addUserPortals, UserPortal[] deleteUserPortals, UserPortal[] updateUserPortals) {
		addUserPortals(addUserPortals);
		deleteuserPortals(deleteUserPortals);
		for (UserPortal updateUp : updateUserPortals) {
			updateUserPortal(updateUp);
		}
	}

	public Portal getSinglePortalInfo(Portal portal) {
		portal = portalDao.getPortalInfo(portal);
		return portal;
	}

}
