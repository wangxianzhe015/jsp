package com.smartcloud.crowdfunding.console.model.bean;

/**
 * 前台js中根据方法状态进行样式的显示，方法状态赋值在数据库表数据和action获得方法数据比对获得
 * 
 * 
 */
public class FunctionBean {
	public static final String NEED_DELETE = "delete";
	public static final String NEED_ADD = "add";
	public static final String NEED_MERGE = "merge";
	public static final String IS_EXIST = "exist";

	private String funcId;// 方法的id
	private String funcName;// 方法名称
	private String funcDesc;// 方法描述
	private String funcUrl;// action的路径
	private String funcStatus;// 方法状态

	public String getFuncId() {
		return funcId;
	}

	public void setFuncId(String funcId) {
		this.funcId = funcId;
	}

	public String getFuncStatus() {
		return funcStatus;
	}

	public void setFuncStatus(String funcStatus) {
		this.funcStatus = funcStatus;
	}

	public String getFuncName() {
		return funcName;
	}

	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}

	public String getFuncDesc() {
		return funcDesc;
	}

	public void setFuncDesc(String funcDesc) {
		this.funcDesc = funcDesc;
	}

	public String getFuncUrl() {
		return funcUrl;
	}

	public void setFuncUrl(String funcUrl) {
		this.funcUrl = funcUrl;
	}

}
