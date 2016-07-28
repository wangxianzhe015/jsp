package com.smartcloud.crowdfunding.portal.utils;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;

/**
 * The Class HttpClientUtils.
 * @author hli
 */
public abstract class HttpClientUtils {

    /** The logger. */
    private static Logger logger = LoggerFactory.getLogger(HttpClientUtils.class);

    /**
     * Execute http get.
     *
     * @param url the url
     * @param paramMap the param map
     * @return the string
     */
    public static String executeHttpGet(String url, Map<String, String> paramMap) {
        HttpClient httpclient=createHttpClient();

        StringBuffer buf = new StringBuffer(url);
        if (paramMap != null) {
            for (String key : paramMap.keySet()) {
                if (buf.toString().contains("?")) {
                    buf.append("&");
                }
                else {
                    buf.append("?");
                }
                buf.append(key).append("=").append(encodeUrl(paramMap.get(key)));
            }
        }
        HttpGet httpGet = new HttpGet(buf.toString());

        try {
            HttpResponse response = httpclient.execute(httpGet);

            HttpEntity entity = response.getEntity();
            String content = EntityUtils.toString(entity, "utf-8");
            EntityUtils.consume(entity);
            return content;
        } catch (Exception e) {
            logger.error("http get error, ", e);
            return null;
        } finally {
            httpGet.releaseConnection();
        }
    }

    /**
     * Execute http post.
     *
     * @param url the url
     * @param paramMap the param map
     * @return the string
     */
    public static String executeHttpPost(String url, Map<String, String> paramMap) {
        HttpClient httpclient=createHttpClient();
        
        HttpPost httpPost = new HttpPost(url);
        List<NameValuePair> nvps = new ArrayList<NameValuePair>();
        Set<String> keySet = paramMap.keySet();
        for (String key : keySet) {
            nvps.add(new BasicNameValuePair(key, paramMap.get(key)));
        }

        try {
            httpPost.setEntity(new UrlEncodedFormEntity(nvps, HTTP.UTF_8));
            HttpResponse response = httpclient.execute(httpPost);

            HttpEntity entity = response.getEntity();
            String content = EntityUtils.toString(entity, "utf-8");
            EntityUtils.consume(entity);
            return content;
        } catch (Exception e) {
            logger.error("Execute http post error, ", e);
            return null;
        } finally {
            httpPost.releaseConnection();
        }
    }

    /**
     * Execute http post.
     *
     * @param url the url
     * @param paramMap the param map
     * @return the string
     */
    public static String executeHttpPostXML(String url, Map<String, String> paramMap) {
        HttpClient httpclient=createHttpClient();
        
        HttpPost httpPost = new HttpPost(url);
        StringBuilder xml = new StringBuilder("<xml>");
        for (String key : paramMap.keySet()) {
            xml.append("<").append(key).append(">").append(paramMap.get(key)).append("</").append(key).append(">");
        }
        xml.append("</xml>");

        try {
            httpPost.setHeader("Content-type", "text/xml; charset=utf-8");
            // List<NameValuePair> params = new ArrayList<NameValuePair>();
            // params.add(new BasicNameValuePair("$xmldata", xml.toString()));
            // httpPost.setEntity(new UrlEncodedFormEntity(params, HTTP.UTF_8));

            StringEntity entity1 = new StringEntity(xml.toString(), "UTF-8");
            entity1.setContentType("text/xml;charset=UTF-8");
            entity1.setContentEncoding("UTF-8");
            httpPost.setEntity(entity1);

            HttpResponse response = httpclient.execute(httpPost);

            HttpEntity entity = response.getEntity();
            String content = EntityUtils.toString(entity, "utf-8");
            EntityUtils.consume(entity);
            return content;
        } catch (Exception e) {
            logger.error("Execute http post error, ", e);
            return null;
        } finally {
            httpPost.releaseConnection();
        }
    }

    public static String executeHttpPostJson(String url, Map<String, String> paramMap) {
        HttpClient httpclient=createHttpClient();
        
        HttpPost httpPost = new HttpPost(url);
        try {

            String jsonString = JSON.toJSONString(paramMap);

            httpPost.setHeader("Content-type", "application/json; charset=utf-8");

            StringEntity entity1 = new StringEntity(jsonString, "UTF-8");
            entity1.setContentType("application/json;charset=UTF-8");
            entity1.setContentEncoding("UTF-8");
            httpPost.setEntity(entity1);

            HttpResponse response = httpclient.execute(httpPost);
            
            HttpEntity entity = response.getEntity();
            String content = EntityUtils.toString(entity, "utf-8");
            EntityUtils.consume(entity);
            return content;
        } catch (Exception e) {
            logger.error("Execute http post error, ", e);
            return null;
        } finally {
            httpPost.releaseConnection();
        }
    }

    /**
     * Encode url.
     *
     * @param param the param
     * @return the string
     */
    private static String encodeUrl(String param) {
        try {
            return URLEncoder.encode(param, "utf-8");
        } catch (Exception e) {
            return param;
        }
    }


    /**
     * 创建默认HTTP CLIENT对象
     * @return
     */
    private static HttpClient createHttpClient() {
        HttpClientBuilder clientBuilder = HttpClientBuilder.create();
        System.setProperty("https.protocols", "TLSv1");
        clientBuilder.useSystemProperties();
        return clientBuilder.build();
    }

    public static void main(String[] args) {
        Map<String, String> paramMap = new HashMap<String, String>();
        String executeHttpGet = HttpClientUtils.executeHttpGet("https://graph.qq.com/user/get_user_info", paramMap);
        System.out.println(executeHttpGet);
    }
}
