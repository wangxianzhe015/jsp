package com.smartcloud.crowdfunding.portal.service.impl;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.console.util.DigestMessage;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

public class PortalUserServiceImpl extends DAOSupport<PortalUser> implements PortalUserService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public PortalUser getUserByMobile(String mobileNo) {
		PortalUser user=(PortalUser)this.em.createNativeQuery("SELECT * FROM PORTAL_USER WHERE MOBILE_NO=?", PortalUser.class).
				setParameter(1, mobileNo).getSingleResult();
		return user;
	}

	public void registry(PortalUser user) {
		DigestMessage dm;
		try {
			dm = new DigestMessage(DigestMessage.ALG_MD5);
			user.setPassword(dm.cryptPassword(user.getPassword()));
		} catch (NoSuchAlgorithmException e) {
		}
		user.setCreateTime(DateUtils.getCurrentTime());
		this.insert(user);
		
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}

	public int updateEmail(String userId, String email, String status) {
		return this.em.createNativeQuery("UPDATE PORTAL_USER SET EMAIL=? ,EMAIL_AUTH=? WHERE USER_ID=?", PortalUser.class).
		setParameter(1, email).setParameter(2, status).setParameter(3, userId).executeUpdate();
		
	}

	public int updateMobile(String userId, String mobile, String status) {
		return this.em.createNativeQuery("UPDATE PORTAL_USER SET MOBILE_NO=? ,MOBILE_AUTH=? WHERE USER_ID=?", PortalUser.class).
		setParameter(1, mobile).setParameter(2, status).setParameter(3, userId).executeUpdate();
		
	}

	public int updatePassword(String userId, String password) {
		DigestMessage dm;
		try {
			dm = new DigestMessage(DigestMessage.ALG_MD5);
			String cryptPassword=dm.cryptPassword(password);
			return this.em.createNativeQuery("UPDATE PORTAL_USER SET PASSWORD=? WHERE USER_ID=?", PortalUser.class).
					setParameter(1, cryptPassword).setParameter(2, userId).executeUpdate();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return -1;
		}
		

	}

	public int updateUsername(String userId, String userName) {
		return this.em.createNativeQuery("UPDATE PORTAL_USER SET USER_NAME=?,NAME_CHANGED=? WHERE USER_ID=?", PortalUser.class).
		setParameter(1, userName).setParameter(2,"1").setParameter(3, userId).executeUpdate();
	}

	public void updateUser(PortalUser user) {
		this.update(user);
	}

	public PortalUser getUserById(String userId) {
		PortalUser user=new PortalUser();
		user.setUserId(userId);
		
		return find(user);
	}

	public boolean existEmailOrMobile(String mobileOrEmail) {
		PortalUser user=(PortalUser)em.createNativeQuery("SELECT * FROM PORTAL_USER WHERE MOBILE_NO=? OR EMAIL=?", PortalUser.class).setParameter(1,mobileOrEmail).setParameter(2, mobileOrEmail).getSingleResult();
		
		return user!=null?true:false;
	}

	public PortalUser getUserByEmail(String email) {
		PortalUser user=(PortalUser)em.createNativeQuery("SELECT * FROM PORTAL_USER WHERE  EMAIL=?", PortalUser.class).setParameter(1,email).getSingleResult();
		return user;
	}

	public int updateRealName(String userId, String realName, String identityCode) {
		return this.em.createNativeQuery("UPDATE PORTAL_USER SET REAL_NAME=? ,IDENTITY_CARD=?, REAL_NAME_AUTH=? WHERE USER_ID=?", PortalUser.class).
		setParameter(1, realName).setParameter(2, identityCode).setParameter(3, "1").setParameter(4, userId).executeUpdate();

	}

	public List<PortalUser> findUsers(PortalUser user, Page page) {
		
		return this.executeEntitiesPageQuery(user, page);
	}

	public void removeUser(PortalUser user) {
		this.delete(user);
	}

	public void addUser(PortalUser user) {
		registry(user);
		//this.insert(user);
	}

	
}
