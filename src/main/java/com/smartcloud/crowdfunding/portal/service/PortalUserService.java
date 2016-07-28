package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 注册用户服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface PortalUserService {

	/**
	 * 分页查询用户
	 * @param user
	 * @param page
	 * @return
	 */
	public List<PortalUser> findUsers(PortalUser user,Page page);
	
	/**
	 * 删除用户
	 * @param user
	 */
	public void removeUser(PortalUser user);
	
	/**
	 * 添加用户
	 * @param user
	 */
	public void addUser(PortalUser user);
	

	/**
	 * 根据用户信息
	 * @param userId 用户ID
	 * @return
	 */
	public PortalUser getUserById(String userId);
	
	/**
	 * 根据手机号码获取用户信息
	 * @param mobileNo
	 * @return
	 */
	public PortalUser getUserByMobile(String mobileNo);
	
	/**
	 * 根据邮件地址获取用户
	 * @param email
	 * @return
	 */
	public PortalUser getUserByEmail(String email);
	
	/**
	 * 修改用户名
	 * @param userId
	 * @param userName
	 * @return
	 */
	public int updateUsername(String userId,String userName);
	/**
	 * 修改邮箱验证
	 * @param status
	 */
	public int updateEmail(String userId,String email,String status);
	
	/**
	 * 修改手机号
	 * @param mobile
	 * @param status
	 */
	public int updateMobile(String userId,String mobile,String status);
	
	/**
	 * 修改用户实名
	 * @param userId
	 * @param realName
	 * @param identityCode
	 * @return
	 */
	public int updateRealName(String userId,String realName,String identityCode);
	
	
	/**
	 * 修改密码
	 * @param userId
	 * @param password
	 */
	public int updatePassword(String userId,String password);
	/**
	 * 注册用户
	 * @param user
	 */
	public void registry(PortalUser user);
	
	/**
	 * 修改用户
	 * @param user
	 */
	public void updateUser(PortalUser user);
	
	/**
	 * 检查邮件或手机号码是否存在
	 * @param mobileOrEmail
	 * @return 存在返回true,不存在返回false
	 */
	public boolean existEmailOrMobile(String mobileOrEmail);
	

}
