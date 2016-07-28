package com.smartcloud.crowdfunding.portal.service;

import java.util.List;

import com.smartcloud.crowdfunding.portal.model.SMSLog;
import com.smartcloud.crowdfunding.portal.model.SMSType;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.rpc.annotation.Service;

/**
 * 短信服务
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
@Service
public interface SmsService {

	/**
	 * 发送短信
	 * @param mobileNo 手机号
	 * @param content 内容
	 * @param verifyCode 验证码
	 * @param type 短信类型
	 */
	public void sendMessage(String mobileNo,String content,String verifyCode,SMSType type );
	
	/**
	 * 获取指定手机号的所有短信日志
	 * @param mobileNo 手机号码
	 * @param page 分页对象
	 * @return
	 */
	public List<SMSLog> getSMSMessages(String mobileNo,Page page);
	

	/**
	 * 获取所有短信
	 * @param sms 短信查询对象
	 * @param page 分页对象
	 * @return
	 */
	public List<SMSLog> getAllMessages(SMSLog sms,Page page);
	
	
	/**
	 * 获取指定间隔时间内的最新短信
	 * @param mobileNo 手机号码
	 * @param type 短信类型
	 * @param intervalMinute 间隔时间(分钟)
	 * @return
	 */
	public SMSLog getLastestSms(String mobileNo,SMSType type,int intervalMinute);
}
