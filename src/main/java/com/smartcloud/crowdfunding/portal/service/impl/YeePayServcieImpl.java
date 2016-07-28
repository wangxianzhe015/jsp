package com.smartcloud.crowdfunding.portal.service.impl;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.smartcloud.crowdfunding.portal.model.yeepay.BankCardCheckRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.BankCardCheckResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.BindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.CardBindInfo;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.ConfirmBindResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayClearDataRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayClearDataResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.PayOrderResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryBindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryBindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryDrawRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryDrawResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryOrderRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryOrderResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryRefundRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryRefundResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryTradeRecordRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.QueryTradeRecordResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.RefundResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSCodeResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.SMSConfirmPayResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.UnBindBankCardResponse;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawRequest;
import com.smartcloud.crowdfunding.portal.model.yeepay.WithdrawResponse;
import com.smartcloud.crowdfunding.portal.service.YeePayService;
import com.smartcloud.crowdfunding.portal.utils.AES;
import com.smartcloud.crowdfunding.portal.utils.EncryUtil;
import com.smartcloud.crowdfunding.portal.utils.HttpClientUtils;
import com.smartcloud.crowdfunding.portal.utils.RSA;
import com.smartcloud.crowdfunding.portal.utils.RandomUtil;
import com.smartcloud.platform.component.common.config.PropertyResourceConfigurer;
import com.smartcloud.platform.component.common.utils.Assert;
import com.smartcloud.platform.component.common.utils.StringUtils;

public class YeePayServcieImpl implements YeePayService{

    /** 
     * 将参数Map按键值字母进行排序
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static TreeMap<String,Object> sort(Map<String, Object> params) {
        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);
        
        TreeMap<String,Object> treeMap=new TreeMap<String,Object>();
        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            Object value = params.get(key);
            if(value!=null)
            	treeMap.put(key, value);
        }
      
        return treeMap;
    }
    
    
	/**
	 * 取得商户编号
	 */
	public static String getMerchantAccount() {
		return PropertyResourceConfigurer.getInstance().getProperty("merchantAccount");
	}
	
	/**
	 * 取得商户私钥
	 */
	public static String getMerchantPrivateKey() {
		return PropertyResourceConfigurer.getInstance().getProperty("merchantPrivateKey");
	}

	/**
	 * 取得商户AESKey
	 */
	public static String getMerchantAESKey() {
		return (RandomUtil.getRandom(16));
	}

	/**
	 * 取得易宝公玥
	 */
	public static String getYeepayPublicKey() {
		return PropertyResourceConfigurer.getInstance().getProperty("yeepayPublicKey");
	}

	/**
	 * 格式化字符串
	 */
	public static String formatString(String text) {
		return (text == null ? "" : text.trim());
	}

	/**
	 * String2Integer
	 */
	public static int String2Int(String text) throws NumberFormatException {
		return text == null ? 0 : Integer.valueOf(text);
	}

	/**
	 * 绑卡请求接口请求地址
	 */
	public static String getBindBankcardURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("bindBankcardURL");
	}

	/**
	 * 绑卡确认接口请求地址
	 */
	public static String getConfirmBindBankcardURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("confirmBindBankcardURL");
	}

	/**
	 * 支付接口请求地址
	 */
	public static String getDirectBindPayURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("directBindPayURL");
	}

	/**
	 * 订单查询请求地址
	 */
	public static String getPaymentQueryURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("paymentQueryURL");
	}

	/**
	 * 取现接口请求地址
	 */
	public static String getWithdrawURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("withdrawURL");
	}

	/**
	 * 取现查询请求地址
	 */
	public static String getQueryWithdrawURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("queryWithdrawURL");
	}

	/**
	 * 取现查询请求地址
	 */
	public static String getQueryAuthbindListURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("queryAuthbindListURL");
	}

	/**
	 * 银行卡信息查询请求地址 
	 */
	public static String getBankCardCheckURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("bankCardCheckURL");
	}

	/**
	 * 支付清算文件下载请求地址 
	 */
	public static String getPayClearDataURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("payClearDataURL");
	}

	/**
	 * 单笔退款请求地址 
	 */
	public static String getRefundURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("refundURL");
	}

	/**
	 * 退款查询请求地址 
	 */
	public static String getRefundQueryURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("refundQueryURL");
	}

	/**
	 * 退款清算文件请求地址 
	 */
	public static String getRefundClearDataURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("refundClearDataURL");
	}

	/**
	 * 银行卡解绑接口请求地址 
	 */
	public static String getUnbindBankcardURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("unbindBankcardURL");
	}

	/**
	 * 4.4 支付结果查询请求地址 
	 */
	public static String getPayapiQueryURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("payapiQueryURL");
	}

	/**
	 * 4.2.1 支付请求接口请求地址 
	 */
	public static String getPayNeedSmsURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("payNeedSmsURL");
	}

	/**
	 * 4.2.2 发送短信验证码接口请求地址 
	 */
	public static String getSmsSendURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("smsSendURL");
	}

	/**
	 * 4.2.3 确认支付请求地址 
	 */
	public static String getSmsConfirmURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("smsConfirmURL");
	}

	/**
	 * 余额查询接口请求地址 
	 */
	public static String getDrawValidAmountURL() {
		return PropertyResourceConfigurer.getInstance().getProperty("drawValidAmountURL");
	}
	
	private static Map<String,Object> toMap(Object request){
		try {
			Map<String,Object> result=new HashMap<String,Object>();
			
			Field[] fields=request.getClass().getDeclaredFields();
			for(Field f:fields){
				f.setAccessible(true);
				result.put(f.getName(),f.get(request));
			}

			return result;
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 解析http请求返回
	 */
	public static Map<String, String> parseHttpResponseBody(int statusCode, String responseBody) throws Exception {
		String merchantPrivateKey	= getMerchantPrivateKey();
		String yeepayPublicKey		= getYeepayPublicKey();

		Map<String, String> result	= new HashMap<String, String>();
		String customError			= "";

		if(statusCode != 200) {
			customError	= "Request failed, response code : " + statusCode;
			result.put("customError", customError);
			return (result);
		}

		Map<String, String> jsonMap	= JSON.parseObject(responseBody, new TypeReference<TreeMap<String, String>>() {});

		if(jsonMap.containsKey("error_code")) {
			result	= jsonMap;
			return (result);
		}

		String dataFromYeepay		= formatString(jsonMap.get("data"));
		String encryptkeyFromYeepay	= formatString(jsonMap.get("encryptkey"));

		boolean signMatch = EncryUtil.checkDecryptAndSign(dataFromYeepay, encryptkeyFromYeepay, yeepayPublicKey, merchantPrivateKey);
		if(!signMatch) {
			customError	= "Sign not match error";
			result.put("customError",	customError);
			return (result);
		}

		String yeepayAESKey		= RSA.decrypt(encryptkeyFromYeepay, merchantPrivateKey);
		String decryptData		= AES.decryptFromBase64(dataFromYeepay, yeepayAESKey);

		System.out.println(">decryptData:"+decryptData);
		result	= JSON.parseObject(decryptData, new TypeReference<TreeMap<String, String>>() {});

		return(result);
	}

    
	public BindBankCardResponse bindBankcard(BindBankCardRequest request) {
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount			= getMerchantAccount();
		String merchantPrivateKey		= getMerchantPrivateKey();
		String merchantAESKey			= getMerchantAESKey();
		String yeepayPublicKey			= getYeepayPublicKey();
		String bindBankcardURL			= getBindBankcardURL();
		
		try{
			
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			System.out.println(">bindBankcardURL : " + bindBankcardURL);
			System.out.println(">dataMap : " + dataMap);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			
			String responseBody=HttpClientUtils.executeHttpPost(bindBankcardURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			BindBankCardResponse response=new BindBankCardResponse();
			response.setCodesender(result.get("codesender"));
			response.setSmscode(result.get("smscode"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setRequestid(result.get("requestid"));
			
			return response;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	public ConfirmBindResponse confirmBindBankcard(ConfirmBindRequest request) {
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount			= getMerchantAccount();
		String merchantPrivateKey		= getMerchantPrivateKey();
		String merchantAESKey			= getMerchantAESKey();
		String yeepayPublicKey			= getYeepayPublicKey();
		String confirmBindBankcardURL	= getConfirmBindBankcardURL();
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			String responseBody=HttpClientUtils.executeHttpPost(confirmBindBankcardURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			ConfirmBindResponse response=new ConfirmBindResponse();
			response.setBankcode(result.get("bankcode"));
			response.setCardlast(result.get("card_last"));
			response.setCardtop(result.get("card_top"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setRequestid(result.get("requestid"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public QueryBindBankCardResponse queryBindBankcard(QueryBindBankCardRequest request) {
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String queryAuthbindListURL	= getQueryAuthbindListURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(queryAuthbindListURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			QueryBindBankCardResponse response=new QueryBindBankCardResponse();
			String cardlistJson=result.get("cardlist");
			List<CardBindInfo> cardInfos=JSON.parseArray(cardlistJson, CardBindInfo.class);
			
			response.setCardlist(result.get("cardlist"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setIdentityid(result.get("identityid"));
			response.setIdentitytype(result.get("identitytype"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setCardinfos(cardInfos);
			
			return response;
		}catch(Exception e){
			
		}
		
		return null;
	}

	public UnBindBankCardResponse unbindBankcard(UnBindBankCardRequest request) {

			Map<String,Object> beanMap=toMap(request);
			TreeMap<String,Object> dataMap=sort(beanMap);
			
			String merchantaccount				= getMerchantAccount();
			String merchantPrivateKey			= getMerchantPrivateKey();
			String merchantAESKey				= getMerchantAESKey();
			String yeepayPublicKey				= getYeepayPublicKey();
			String unbindBankcardUrl			= getUnbindBankcardURL();
			try{
				String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
				dataMap.put("sign", sign);
				
				String jsonStr	= JSON.toJSONString(dataMap);
				String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
				String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
				
				Map<String,String> paramMap=new HashMap<String,String>();
				paramMap.put("merchantaccount", merchantaccount);
				paramMap.put("data", data);
				paramMap.put("encryptkey", encryptkey);
				
				String responseBody=HttpClientUtils.executeHttpPost(unbindBankcardUrl, paramMap);
				Map<String,String> result=parseHttpResponseBody(200, responseBody);
				
				UnBindBankCardResponse response=new UnBindBankCardResponse();
				response.setBindid(result.get("bindid"));
				response.setErrorcode(result.get("error_code"));
				response.setErrormsg(result.get("error_msg"));
				response.setIdentityid(result.get("identityid"));
				response.setIdentitytype(result.get("identitytype"));
				response.setMerchantaccount(result.get(merchantaccount));
				
				return response;
				
			}catch(Exception e){
				
			}
			
			return null;
	}

	public PayOrderResponse payOrder(PayOrderRequest request) {
		Assert.notNull(request.getTranstime());
		Assert.notNull(request.getIdentitytype());
		Assert.notNull(request.getAmount());

		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String payNeedSmsURL				= getPayNeedSmsURL();
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			String responseBody=HttpClientUtils.executeHttpPost(payNeedSmsURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			PayOrderResponse response=new PayOrderResponse();
			response.setCodesender(result.get("codesender"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setOrderid(result.get("orderid"));
			response.setPhone(result.get("phone"));
			response.setSmsconfirm(result.get("smsconfirm"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public WithdrawResponse withdraw(WithdrawRequest request) {
		Assert.notNull(request.getIdentitytype());
		Assert.notNull(request.getAmount());
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String withdrawURL					= getWithdrawURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(withdrawURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			WithdrawResponse response=new WithdrawResponse();
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			
			response.setCard_last(result.get("card_last"));
			response.setCard_top(result.get("card_top"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setRequestid(result.get("requestid"));
			response.setStatus(result.get("status"));
			response.setYbdrawflowid(result.get("ybdrawflowid"));
			
			return response;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return null;
	}

	public RefundResponse refund(RefundRequest request) {
		Assert.notNull(request.getCurrency());
		Assert.notNull(request.getAmount());
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String refundURL					= getRefundURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpPost(refundURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			RefundResponse response=new RefundResponse();
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			if(StringUtils.isNullOrBlank(response.getErrormsg()))
				response.setErrormsg(result.get("error"));
			
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			if(StringUtils.isNotNullAndBlank(result.get("currency")))
				response.setCurrency(Integer.valueOf(result.get("currency")));

			if(StringUtils.isNotNullAndBlank(result.get("fee")))
				response.setFee(Integer.valueOf(result.get("fee")));
			
			if(StringUtils.isNotNullAndBlank(result.get("remain")))
				response.setRemain(Integer.valueOf(result.get("remain")));
			
			response.setYborderid(result.get("yborderid"));
			if(StringUtils.isNotNullAndBlank(result.get("timestamp")))
				response.setTimestamp(Integer.valueOf(result.get("timestamp")));
			
			
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setOrderid(result.get("orderid"));
			response.setOrigyborderid(result.get("origyborderid"));
			
			return response;
		}catch(Exception e){
			
		}
		
		return null;
	}

	public QueryDrawResponse queryWithdraw(QueryDrawRequest request) {
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String queryWithdrawURL		= getQueryWithdrawURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(queryWithdrawURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			QueryDrawResponse response=new QueryDrawResponse();
			
			response.setCard_last(result.get("card_last"));
			response.setCard_top(result.get("card_top"));
			response.setRequestid(result.get("requestid"));
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public QueryRefundResponse queryRefund(QueryRefundRequest request) {

		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String refundQueryURL				= getRefundQueryURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(refundQueryURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			QueryRefundResponse response=new QueryRefundResponse();
			if(StringUtils.isNotNullAndBlank(result.get("closetime")))
				response.setClosetime(Integer.valueOf(result.get("closetime")));
			if(StringUtils.isNotNullAndBlank(result.get("currency")))
				response.setCurrency(Integer.valueOf(result.get("currency")));
			if(StringUtils.isNotNullAndBlank(result.get("fee")))
				response.setFee(Integer.valueOf(result.get("fee")));
			if(StringUtils.isNotNullAndBlank(result.get("status")))
				response.setStatus(Integer.valueOf(result.get("status")));
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			if(StringUtils.isNotNullAndBlank(result.get("ordertime")))
				response.setOrdertime(Integer.valueOf(result.get("ordertime")));
			
			response.setCause(result.get("cause"));
			
			response.setOrigyborderid(result.get("origyborderid"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setOrderid(result.get("orderid"));
			response.setYborderid(result.get("yborderid"));
			response.setMerchantaccount(result.get("merchantaccount"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public QueryOrderResponse queryOrder(QueryOrderRequest request) {
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String payapiQueryURL				= getPayapiQueryURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(payapiQueryURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			QueryOrderResponse response=new QueryOrderResponse();
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			
			response.setBank(result.get("bank"));
			response.setBankcardtype(result.get("bankcardtype"));
			response.setBankcode(result.get("bankcode"));
			response.setBindid(result.get("bindid"));
			response.setBindvalidthru(result.get("bindvalidthru"));
			response.setClosetime(result.get("closetime"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setIdentityid(result.get("identityid"));
			response.setIdentitytype(result.get("identitytype"));
			response.setLastno(result.get("lastno"));
			response.setOrderid(result.get("orderid"));
			response.setStatus(result.get("status"));
			response.setYborderid(result.get("yborderid"));
			response.setMerchantaccount(result.get("merchantaccount"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public BankCardCheckResponse checkBankcard(BankCardCheckRequest request) {
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String bankCardCheckURL		= getBankCardCheckURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			String responseBody=HttpClientUtils.executeHttpPost(bankCardCheckURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			BankCardCheckResponse response=new BankCardCheckResponse();
			response.setBankname(result.get("bankname"));
			response.setCardno(result.get("cardno"));
			response.setCardtype(result.get("cardtype"));
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			if(StringUtils.isNotNullAndBlank(result.get("isvalid")))
				response.setIsvalid(Integer.valueOf(result.get("isvalid")));
			
			response.setMerchantaccount(result.get("merchantaccount"));
			
			return response;
			
		}catch(Exception e){
			
		}
		
		return null;
	}

	public PayClearDataResponse downloadClearData(PayClearDataRequest request) {
		// TODO Auto-generated method stub
		return null;
	}


	public SMSCodeResponse sendSmsCode(SMSCodeRequest request) {
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String smsSendURL			= getSmsSendURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			String responseBody=HttpClientUtils.executeHttpPost(smsSendURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			SMSCodeResponse response=new SMSCodeResponse();
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setOrderid(result.get("orderid"));
			response.setPhone(result.get("phone"));
			response.setSendtime(result.get("sendtime"));
			
			return response;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return null;
	}


	public SMSConfirmPayResponse smsConfirmPay(SMSConfirmPayRequest request) {
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String smsConfirmURL		= getSmsConfirmURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			String responseBody=HttpClientUtils.executeHttpPost(smsConfirmURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			SMSConfirmPayResponse response=new SMSConfirmPayResponse();
			if(StringUtils.isNotNullAndBlank(result.get("amount")))
				response.setAmount(Integer.valueOf(result.get("amount")));
			
			response.setErrorcode(result.get("error_code"));
			response.setErrormsg(result.get("error_msg"));
			response.setOrderid(result.get("orderid"));
			response.setMerchantaccount(result.get("merchantaccount"));
			response.setOrderid(result.get("orderid"));
			response.setYborderid(result.get("yborderid"));
			
			return response;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}


	public PayOrderResponse directPay(PayOrderRequest request) {
		Assert.notNull(request.getTranstime());
		Assert.notNull(request.getIdentitytype());
		Assert.notNull(request.getAmount());

		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount				= getMerchantAccount();
		String merchantPrivateKey			= getMerchantPrivateKey();
		String merchantAESKey				= getMerchantAESKey();
		String yeepayPublicKey				= getYeepayPublicKey();
		String directBindPayURL				= getDirectBindPayURL();
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
			
			String responseBody=HttpClientUtils.executeHttpPost(directBindPayURL, paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			
		}catch(Exception e){
			
		}
		
		return null;
	}


	public Map<String, String> decryptCallbackData(String data, String encryptkey) {

		String merchantPrivateKey	= getMerchantPrivateKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		
		System.out.println("data : " + data);
		System.out.println("encryptkey : " + encryptkey);
		
		Map<String, String> callbackResult	= new HashMap<String, String>();
		String customError	= "";
		
		try {
			boolean signMatch = EncryUtil.checkDecryptAndSign(data, encryptkey, yeepayPublicKey, merchantPrivateKey);

			if(!signMatch) {
				customError	= "Sign not match error";
				callbackResult.put("customError",	customError);
				return callbackResult;
			}

			String yeepayAESKey	= RSA.decrypt(encryptkey, merchantPrivateKey);
			String decryptData	= AES.decryptFromBase64(data, yeepayAESKey);
			callbackResult		= JSON.parseObject(decryptData, new TypeReference<TreeMap<String, String>>() {});

		} catch(Exception e) {
			customError		= "Caught an Exception. " + e.toString();
			callbackResult.put("customError", customError);
			e.printStackTrace();
		}

		System.out.println("callbackResult : " + callbackResult);

		return (callbackResult);
	}


	public QueryTradeRecordResponse queryTradeRecord(QueryTradeRecordRequest request) {
		
		Map<String,Object> beanMap=toMap(request);
		TreeMap<String,Object> dataMap=sort(beanMap);
		
		String merchantaccount		= getMerchantAccount();
		String merchantPrivateKey	= getMerchantPrivateKey();
		String merchantAESKey		= getMerchantAESKey();
		String yeepayPublicKey		= getYeepayPublicKey();
		String paymentQueryURL		= getPaymentQueryURL();
		
		try{
			String sign= EncryUtil.handleRSA(dataMap, merchantPrivateKey);
			dataMap.put("sign", sign);
			
			String jsonStr	= JSON.toJSONString(dataMap);
			String data	= AES.encryptToBase64(jsonStr, merchantAESKey);
			String encryptkey= RSA.encrypt(merchantAESKey, yeepayPublicKey);
			
			Map<String,String> paramMap=new HashMap<String,String>();
			paramMap.put("merchantaccount", merchantaccount);
			paramMap.put("data", data);
			paramMap.put("encryptkey", encryptkey);
		
			
			String responseBody=HttpClientUtils.executeHttpGet(paymentQueryURL,paramMap);
			Map<String,String> result=parseHttpResponseBody(200, responseBody);
			
			
		}catch(Exception e){
			
		}
		
		return null;

	}


}
