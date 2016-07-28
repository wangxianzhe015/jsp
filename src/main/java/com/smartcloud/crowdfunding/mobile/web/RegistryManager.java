package com.smartcloud.crowdfunding.mobile.web;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smartcloud.crowdfunding.portal.Constants;
import com.smartcloud.crowdfunding.portal.model.MessageTips;
import com.smartcloud.crowdfunding.portal.model.PortalUser;
import com.smartcloud.crowdfunding.portal.model.SMSLog;
import com.smartcloud.crowdfunding.portal.model.SMSType;
import com.smartcloud.crowdfunding.portal.service.PortalUserService;
import com.smartcloud.crowdfunding.portal.service.SmsService;
import com.smartcloud.crowdfunding.portal.utils.SMSSender;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.mail.MailSender;
import com.smartcloud.platform.component.mail.internal.SimpleMailMessage;
import com.smartcloud.platform.component.mail.support.MailSenderService;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.rpc.annotation.Reference;

@URI(description="注册管理",portal=true,path="/mobile/registry/*")
public class RegistryManager extends WebAction {
	
	private static Logger logger=LoggerFactory.getLogger(RegistryManager.class);
	
	@Reference
	private PortalUserService userService;
	
	@Reference
	private SmsService smsService;
	
	private Integer code;
	
	private String message;
	
	private static final String RESET_PASSWORD_VERIFY_CODE="_password_reset_verifycode";
	
	@Action(description = "检查手机号码", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String checkMobile(String mobile){
		if(mobile==null)
			mobile=(String)request.getRequestParameter("myModa_header_box_register_form_mobile");
		PortalUser user=userService.getUserByMobile(mobile);
		if(user!=null){
			code=1;
		}else{
			code=-1;
		}
		return SUCCESS;
	}
	
	@Action(description = "添加注册用户", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String add(){
		return SUCCESS;
	}
	
	@Action(description = "Ajax添加注册用户", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String ajaxAdd(String mobile,String password,String mobilecode){
		SMSLog log=smsService.getLastestSms(mobile, SMSType.REGISTRY, 10);
		if(log==null){
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("RegistryManager_mobilecode_timeout");
		}else{
			if(StringUtils.equals(log.getMobileNo(), mobile) &&StringUtils.equals(log.getVerifyCode(), mobilecode)){
				PortalUser user=new PortalUser();
				user.setMobileNo(mobile);
				user.setUserName(mobile);
				user.setPassword(password);
				user.setMobileAuth("1");
				
				userService.registry(user);
				
				this.response.addToSession(com.smartcloud.platform.component.mvc.User.KEY_IN_SESSION, user);// webuser信息保存在session中
				
				this.code=1;
				this.message=ResourceMessages.getI18nMessage("RegistryManager_registry_success");
			}else{
				this.code=-1;
				this.message=ResourceMessages.getI18nMessage("RegistryManager_adduser_error");
			}

			
		}
		return SUCCESS;
	}
	
	@Action(description = "发送手机验证码", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String sendMobileCode(String mobile,String verfiyCode){
		if("voice".equals(request.getRequestParameter("msg_type"))){
			this.code=-1;
			this.message="invalid request!";
			logger.error("IP:"+request.getRemoteAddress()+",URL:"+request.getRequestURL());
			return SUCCESS;
		}
		
		String sessionVerifyCode=(String)this.request.getSessionContext().get(Constants.KEY_IMAGE_VERIFY_CODE);
		if(StringUtils.equals(verfiyCode,sessionVerifyCode)){
			String smsVerfiyCode=SMSSender.smsRandom(6);
			String content="亲爱的众投客用户您好！你的手机号为"+mobile+",验证码为"+smsVerfiyCode;
			smsService.sendMessage(mobile, content, smsVerfiyCode, SMSType.REGISTRY);
			this.code=1;
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("RegistryManager_verifycode_error");
		}
		return SUCCESS;
	}

	public Integer getCode() {
		return code;
	}

	public String getMessage() {
		return message;
	}
	
	@Action(description = "检查邮箱地址或手机号码是否存在", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String checkEmailOrMobile(String name){
		boolean exist=userService.existEmailOrMobile(name);
		if(exist){
			this.code=1;
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("RegistryManager_not_exist_emailormobile");
		}
		return SUCCESS;
	}
	
	@Action(description = "检查验证码是否正确", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String checkVerifyCode(String code){
		String sessionVerifyCode=(String)this.request.getSessionContext().get(Constants.KEY_IMAGE_VERIFY_CODE);
		if(StringUtils.equals(code,sessionVerifyCode)){
			this.code=1;
		}else{
			this.code=-1;
			this.message=ResourceMessages.getI18nMessage("RegistryManager_verifycode_error");
		}
		return SUCCESS;
	}
	
	@Action(description = "密码找回", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/password/passwordfind.jsp")) })
	public String findPassword(){
		return SUCCESS;
	}
	
	/**
	 * 重置密码，发送手机或邮件的验证码
	 * @param name
	 * @param code
	 * @return
	 */
	@Action(description = "重置密码", responses = { 
			@Response(name = SUCCESS, forward=@Forward(url="/mobile/password/passwordreset.jsp")),
			@Response(name = FAILURE, forward=@Forward(url="/mobile/password/passwordfind.jsp")),
			})
	public String passwordReset(String name,String code){
		if(StringUtils.isBlank(name) || StringUtils.isBlank(code)){
			return FAILURE;
		}
		
		if(name.indexOf("@")==-1){
			String mobileCode=SMSSender.smsRandom(6);
			String content="亲爱的众投客用户您好！你的手机号为"+name+",验证码为"+mobileCode;
			smsService.sendMessage(name, content, mobileCode, SMSType.RESET_PASSWORD);
			this.request.getSessionContext().add(RESET_PASSWORD_VERIFY_CODE, mobileCode);
			
			this.code=1;
		}else{
			MailSender mailSender=new MailSenderService();
			SimpleMailMessage message=new SimpleMailMessage();
			message.setTo(name);
			message.setSubject("众投客邮箱注册验证码");
			String emailCode=SMSSender.smsRandom(6);
			message.setText("尊敬的众投客用户您好!您的验证码是:"+emailCode+"，工作人员不会向您索取，请勿泄漏。如非本人操作，请忽略本消息欢迎您邮箱注册");
			mailSender.sendMail(message);
			
			this.request.getSessionContext().add(RESET_PASSWORD_VERIFY_CODE, emailCode);
			this.code=1;
			this.message=ResourceMessages.getI18nMessage("UserCenterManager_email_sendsuccess");
		}
		this.request.getSessionContext().add("_mobileOrEmail", name);
		return SUCCESS;
	}
	
	@Action(description = "密码重置成功", responses = { @Response(name = SUCCESS,forward=@Forward(url="/mobile/common/message_tips.jsp")) })
	public String passwordSuccess(String code,String newPassword){
		
		String resetPasswordVerifyCode=(String)this.request.getSessionContext().get(RESET_PASSWORD_VERIFY_CODE);
		String name=(String)this.request.getSessionContext().get("_mobileOrEmail");
		if(StringUtils.equals(code,resetPasswordVerifyCode)){
			PortalUser user=userService.getUserByMobile(name);
			if(user!=null){
				userService.updatePassword(user.getUserId(), newPassword);
			}else{
				user=userService.getUserByEmail(name);
				if(user!=null){
					userService.updatePassword(user.getUserId(), newPassword);
				}
			}
			
			MessageTips tips=new MessageTips();
			tips.setMessage("密码重置成功,请使用新密码登录!");
			tips.setWaitSecond(3);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/login/login.action");
			
			response.addToRequest("tips", tips);
		}else{
			MessageTips tips=new MessageTips();
			tips.setMessage("验证码错误，请重新设置密码!");
			tips.setWaitSecond(3);
			tips.setBackUrl(request.getContextPath()+"/platform/mobile/registry/findPassword.action");
			
			response.addToRequest("tips", tips);
		}
		return SUCCESS;
	}
	
	@Action(description = "注册", responses = { @Response(name = SUCCESS, forward=@Forward(url="/mobile/index/register.jsp")) })
	public String registry(){
		return SUCCESS;
	}
}
