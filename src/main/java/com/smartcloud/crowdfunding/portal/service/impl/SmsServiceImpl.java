package com.smartcloud.crowdfunding.portal.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceUnit;

import com.smartcloud.crowdfunding.portal.model.SMSLog;
import com.smartcloud.crowdfunding.portal.model.SMSResult;
import com.smartcloud.crowdfunding.portal.model.SMSType;
import com.smartcloud.crowdfunding.portal.service.SmsService;
import com.smartcloud.crowdfunding.portal.utils.SMSSender;
import com.smartcloud.platform.component.common.utils.DateUtils;
import com.smartcloud.platform.component.persistence.query.Page;
import com.smartcloud.platform.component.persistence.support.dao.DAOSupport;

/**
 * 短信服务实现类
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SmsServiceImpl extends DAOSupport<SMSLog> implements SmsService{

	@PersistenceUnit(name="default")
	private EntityManager em;
	
	public void sendMessage(String mobileNo, String content, String verifyCode,SMSType type) {
		SMSResult result=SMSSender.send(mobileNo, content);
		if(result!=null){
			SMSLog log=new SMSLog();
			log.setMobileNo(mobileNo);
			log.setSendMessage(content);
			log.setSmsType(type.toString());
			log.setSendTime(DateUtils.getCurrentTime());
			log.setVerifyCode(verifyCode);
			log.setReturnCode(result.getReturnCode());
			log.setReturnMsg(result.getReturnMsg());
			
			this.insert(log);
		}
	}

	public List<SMSLog> getSMSMessages(String mobileNo,Page page) {
		SMSLog log=new SMSLog();
		log.setMobileNo(mobileNo);
		
		return this.executeEntitiesPageQuery(log, page);
	}

	public List<SMSLog> getAllMessages(SMSLog sms, Page page) {
		
		SMSLog log=new SMSLog();
		return this.executeEntitiesPageQuery(log, page);
	}

	public SMSLog getLastestSms(String mobileNo, SMSType type, int intervalMinute) {

		return (SMSLog)this.createUnnamedNativeQuery("select * from portal_sms_log where mobile_no=? and sms_type=? and ((UNIX_TIMESTAMP(NOW())-UNIX_TIMESTAMP(SEND_TIME))/60)< ? order by send_time desc" ,SMSLog.class).
				setParameter(1, mobileNo).
				setParameter(2, type.toString()).
				setParameter(3, intervalMinute).getSingleResult();
	}

	@Override
	protected EntityManager getEntityManager() {
		return em;
	}


}
