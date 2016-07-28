package com.smartcloud.crowdfunding.mobile.web;

import java.util.List;

import com.smartcloud.crowdfunding.portal.dict.CityDictionaryFactory;
import com.smartcloud.crowdfunding.portal.model.ProjectCity;
import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;

@URI(description="城市信息管理",path="/mobile/city/*")
public class CityManager extends WebAction{
	

	@Action(description = "获取省份列表", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String getProvinces(){
		List<ProjectCity> provinces=CityDictionaryFactory.getInstance().getProvinces();
		response.addToRequest("provinces", provinces);
		return SUCCESS;
	}
	
	
	@Action(description = "获取城市列表", responses = { @Response(name = SUCCESS, json=@JSON) })
	public String getCitys(String provinceId){
		List<ProjectCity> citys=CityDictionaryFactory.getInstance().getCitys(provinceId);
		response.addToRequest("citys", citys);
		return SUCCESS;
	}
}
