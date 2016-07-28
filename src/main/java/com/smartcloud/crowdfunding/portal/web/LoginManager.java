package com.smartcloud.crowdfunding.portal.web;

import java.util.concurrent.atomic.AtomicInteger;

import com.smartcloud.crowdfunding.console.util.DigestMessage;
import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.model.LogonLog;
import com.smartcloud.crowdfunding.portal.model.MessageTips;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.service.LogService;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

/**
 * 登录管理
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@URI(description="登录管理",path="/portal/login/*",portal=true)
public class LoginManager extends WebAction{

	@Reference
	private PortalUserService userService;
	
	@Reference
	private LogService logService;
		
	
	private Integer code;
	
	private String message;
	
	private AtomicInteger retryNum = new AtomicInteger(0);
	
	
	@Action(description = "Ajax登录", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxLogin(String mobile,String password){
		PortalUser user=userService.getUserByMobile(mobile);
		if(user!=null){
			try {
				// 用户密码加密
				DigestMessage dm = new DigestMessage(DigestMessage.ALG_MD5);
				boolean right = dm.checkPassword(password, user.getPassword());
				if (right){
					LogonLog log=new LogonLog();
					log.setLogonTime(DateUtils.getCurrentTime());
					log.setMobileNo(mobile);
					log.setRemoteIp(this.request.getRemoteAddress());
					log.setUserId(user.getUserId());
					log.setUserName(user.getUserName());
					
					Long logonId=logService.addLogonLog(log);
					user.setLogonId(logonId);
					
					this.response.addToSession(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION, user);// webuser信息保存在session中
					this.code=1;
					this.message=ResourceMessages.getI18nMessage("LoginManager_login_success");
				}else{
					this.code=-1;
					this.message=ResourceMessages.getI18nMessage("LoginManager_login_password_error");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("LoginManager_login_no_user");
		}
		
		return SUCCESS;
	}
	
	
	@Action(description = "登录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/index/login.jsp")) })
	public String login(String mobile,String password,String code){
		
		return SUCCESS;
	}
	
	@Action(description = "表单登录", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/common/message_tips.jsp")) })
	public String formLogin(String mobile,String password,String verifyCode){
		String sessionCode=(String)this.request.getSessionContext().get(Constants.KEY_IMAGE_VERIFY_CODE);
		if(!sessionCode.equals(verifyCode)){
			MessageTips tips=new MessageTips();
			tips.setMessage(ResourceMessages.getI18nMessage("RegistryManager_verifycode_error"));
			tips.setWaitSecond(3);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/login/login.action");
			
			response.addToRequest("tips", tips);
			return SUCCESS;
		}
		
		PortalUser user=userService.getUserByMobile(mobile);
		if(user!=null){
			try {
				// 用户密码加密
				DigestMessage dm = new DigestMessage(DigestMessage.ALG_MD5);
				boolean right = dm.checkPassword(password, user.getPassword());
				if (right){
					LogonLog log=new LogonLog();
					log.setLogonTime(DateUtils.getCurrentTime());
					log.setMobileNo(mobile);
					log.setRemoteIp(this.request.getRemoteAddress());
					log.setUserId(user.getUserId());
					log.setUserName(user.getUserName());
					
					Long logonId=logService.addLogonLog(log);
					user.setLogonId(logonId);
					
					this.response.addToSession(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION, user);// webuser信息保存在session中
				
					MessageTips tips=new MessageTips();
					tips.setMessage(ResourceMessages.getI18nMessage("LoginManager_login_success"));
					tips.setWaitSecond(3);
					tips.setBackUrl(request.getContextPath()+"/platform/portal/main/index.action");
					
					response.addToRequest("tips", tips);
				}else{
					MessageTips tips=new MessageTips();
					tips.setMessage(ResourceMessages.getI18nMessage("LoginManager_login_password_error"));
					tips.setWaitSecond(3);
					tips.setBackUrl(request.getContextPath()+"/platform/portal/login/login.action");
					
					response.addToRequest("tips", tips);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			MessageTips tips=new MessageTips();
			tips.setMessage(ResourceMessages.getI18nMessage("LoginManager_login_no_user"));
			tips.setWaitSecond(3);
			tips.setBackUrl(request.getContextPath()+"/platform/portal/login/login.action");
			
			response.addToRequest("tips", tips);
		}
		
		return SUCCESS;
	}
	
	@Action(description = "注销", responses = { @Response(name = SUCCESS, forward=@Forward(url="/portal/main/index.action")) })
	public String logout(){
		PortalUser user=(PortalUser)this.request.getSessionContext().getUser();
		LogonLog logon=new LogonLog();
		logon.setLogId(user.getLogonId());
		logon.setLogoutTime(DateUtils.getCurrentTime());
		
		logService.updateLogonLog(logon);
		this.request.getSessionContext().destory();
		return SUCCESS;
	}
	

	public Integer getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
	
	
	
}
