package com.smartcloud.crowdfunding.portal.interceptor;

import com.smartcloud.crowdfunding.portal.model.MessageTips;
import com.smartcloud.platform.component.common.i18n.ResourceMessages;
import com.smartcloud.platform.component.mvc.User;
import com.smartcloud.platform.component.mvc.context.WebRequestContext;
import com.smartcloud.platform.component.mvc.context.WebResponseContext;
import com.smartcloud.platform.component.mvc.interceptor.ActionInterceptor;

public class SecurityAccessInterceptor implements ActionInterceptor{
	private static String[] interceptorUrls=new String[]{
		"/portal/uc/",
		"/portal/order/",
		"/mobile/uc/",
		"/mobile/order/"
	};
	public void afterAction(WebRequestContext request, WebResponseContext response) {

	}

	public void beforeAction(WebRequestContext request, WebResponseContext response) {
		String requestURL = request.getRequestURL();
		String redirectURL = "";
		String responseURL = "";
		System.out.println(requestURL);
		if (requestURL.contains("/mobile/")){
			redirectURL = "/platform/mobile/login/login.action";
			responseURL = "/mobile/common/message_tips.jsp";
		} else {
			redirectURL = "/platform/portal/login/login.action";
			responseURL = "/portal/common/message_tips.jsp";
		}
		User user=request.getSessionContext().getUser();
		if(user==null){
			MessageTips tips=new MessageTips();
			tips.setMessage(ResourceMessages.getI18nMessage("UserCenterManager_user_nologin"));
			tips.setWaitSecond(3);
			tips.setBackUrl(request.getContextPath()+redirectURL);
			response.addToRequest("tips", tips);
			response.setResponseURL(responseURL);
			try {
				response.navigate();
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}

	public int getPriority() {
		return 0;
	}

	public boolean isAccept(String uri) {
		
		for(String s:interceptorUrls){
			if(uri.startsWith(s)){
				return true;
			}
		}
		return false;
	}



}
