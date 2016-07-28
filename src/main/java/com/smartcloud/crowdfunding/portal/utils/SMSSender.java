package com.smartcloud.crowdfunding.portal.utils;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.smartcloud.crowdfunding.portal.model.SMSResult;

/**
 * 发送短信
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class SMSSender {

	private static final String SMS_GATWAY = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";
	
	private static final String ACCOUNT="cf_zhongtou";
	private static final String PASSWORD="123456";
	
	/**
	 * 发送短信
	 * @param mobile 手机号码
	 * @param content 短信内容
	 * @return
	 */
	public static SMSResult send(String mobile,String content) {

		Map<String,String> message=new HashMap<String,String>();
		message.put("account",ACCOUNT);
		message.put("password", PASSWORD);
		message.put("mobile", mobile);
		message.put("content",content);
		
		
		String response=HttpClientUtils.executeHttpPost(SMS_GATWAY,message);
		if(response!=null){
			SMSResult result=new SMSResult();
			result.setReturnCode(getMatchElementByRegx(response,"code"));
			result.setReturnMsg(getMatchElementByRegx(response,"msg"));
			result.setSmsId(getMatchElementByRegx(response,"smsid"));
			result.setMobileNo(mobile);
			
			return result;
		}
		else{
			
			return null;
		}
	}
	
	/**
	 * 采用正则表达式获取匹配的XML元素值
	 * @param xml XML字符串
	 * @param elementName 元素名称 
	 * @return
	 */
	private static String getMatchElementByRegx(String xml,String elementName){  
	    String result="";  
	    StringBuffer regx=new StringBuffer();  
	    regx.append("<");  
	    regx.append(elementName);  
	    regx.append(">");  
	    regx.append("(.*?)");  
	    regx.append("</");  
	    regx.append(elementName);  
	    regx.append(">");  
	    Pattern pattern=Pattern.compile(regx.toString());  
	    Matcher matcher=pattern.matcher(xml);  
	    if(matcher.find())  
	    {  
	        result=matcher.group(1);  
	        
	    }
	    if(result!=null){
	    	result=result.replace("<![CDATA[", "");
	    	result=result.replace("]]>", "");
	    }
	    return result;  
		
	}
	
	/**
	 * 短信随机数
	 * @param num 个数
	 * @return
	 */
	public static String smsRandom(int num){
		String value="";
		for(int i = 0; i < num;i++){
			int s = (int)(Math.random()*10);
			value = value + s;
		}	
		return value;
	}

}
