package com.smartcloud.crowdfunding.portal.model;

import com.smartcloud.crowdfunding.portal.Constants;
/**
 * 项目状态
 * @author wengzr(mailto:zrweng@163.com)
 *
 */
public class ProjectState {

	/**
	 * 所有项目状态
	 */
	public static final String[] projectStates=new String[]{
		Constants.PROJECT_STATE_PUBLISHED,
		Constants.PROJECT_STATE_ACCEPTED,
		Constants.PROJECT_STATE_AUDITING,
		Constants.PROJECT_STATE_PREPARED,
		Constants.PROJECT_STATE_FINANCING,
		Constants.PROJECT_STATE_SUCCESSED,
		Constants.PROJECT_STATE_OPERATING,
		Constants.PROJECT_STATE_DIVIDENDS};
	
	/**
	 * 项目处理中的状态
	 */
	public static final String[] processingStates=new String[]{
		Constants.PROJECT_STATE_ACCEPTED,
		Constants.PROJECT_STATE_AUDITING,
		Constants.PROJECT_STATE_PREPARED,
		Constants.PROJECT_STATE_FINANCING,
		Constants.PROJECT_STATE_SUCCESSED,
		Constants.PROJECT_STATE_OPERATING,
		Constants.PROJECT_STATE_DIVIDENDS};
	
	
	/**
	 * 获取进度顺序号,如果没有找到则返回-1;
	 * @param projectState
	 * @return
	 */
	public static int getStateNo(String projectState){
		for(int i=0;i<projectStates.length;i++){
			if(projectStates[i].equals(projectState)){
				return i+1;
			}
		}
		return -1;
	}
	
	public static String nextState(String currentState){
		for(int i=0;i<projectStates.length;i++){
			if(projectStates[i].equals(currentState)){
				if(i==projectStates.length-1){
					return "";
				}else{
					return projectStates[i+1];
				}
			}
		}
		return null;
	}

}
