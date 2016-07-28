package com.smartcloud.crowdfunding.console.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.smartcloud.platform.component.mvc.annotation.Action;
import com.smartcloud.platform.component.mvc.annotation.Response;
import com.smartcloud.platform.component.mvc.annotation.URI;
import com.smartcloud.platform.component.mvc.annotation.response.Forward;
import com.smartcloud.platform.component.mvc.annotation.response.JSON;
import com.smartcloud.platform.component.mvc.framework.WebAction;
import com.smartcloud.platform.component.scheduler.SchedulerConfigUtil;
import com.smartcloud.platform.component.scheduler.config.TaskConfig;
import com.smartcloud.platform.component.scheduler.config.TriggerConfig;

@URI(path="/console/schedule/*",portal=true)
public class ScheduleManager extends WebAction{
	
	@Action(description = "首页", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/schedule/listTask.jsp")) })
	public String index(){
		List<Map<String,Object>> taskList=SchedulerConfigUtil.getAllTaskDetail("default");
		response.addToRequest("taskList", taskList);
		
		
		return SUCCESS;
	}

	@Action(description = "新增调度器", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/schedule/index.action")) })
	public String addScheduler() {
	
		return SUCCESS;
	}
	
	@Action(description = "修改调度器", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/schedule/index.action")) })
	public String updateScheduler() {
	
		return SUCCESS;
	}
	
	
	@Action(description="检查任务名称是否已经存在",responses={@Response(name=SUCCESS,json=@JSON())})
	public String isTaskAlreadyExisted(String ip,int port,String appName,String schedulerName,String taskName){
		List<Map<String,Object>> taskList=SchedulerConfigUtil.getAllTaskDetail(schedulerName);
		boolean exist=false;
		for(Map<String,Object> task:taskList){
			if(task.containsKey(taskName)){
				exist=true;
				break;
			}
		}
		response.addToRequest("result", exist);
		return SUCCESS;
	}
	
	@Action(description="校验触发器是否有效",responses={@Response(name=SUCCESS,json=@JSON())})
	public String validateTrigger(String ip,int port,String appName,TriggerConfig trigger){
		boolean result=SchedulerConfigUtil.validateTrigger(trigger);
		this.response.addToRequest("result", result);
		return SUCCESS;
	}
	
	
	@Action(description = "进入添加任务", responses = { @Response( name = SUCCESS,forward=@Forward(url = "/console/schedule/addTask.jsp")) })
	public String entryAddTask(String ip,int port,String appName,String schedulerName) {
		response.addToRequest("ip", ip);
		response.addToRequest("port", port);
		response.addToRequest("appName",appName);
		response.addToRequest("schedulerName",schedulerName);
		
		return SUCCESS;
	}
	
	
	@Action(description = "进入添加任务", responses = { @Response( name = SUCCESS,forward=@Forward(url = "/console/schedule/updateTask.jsp")) })
	public String entryUpdateTask(String schedulerName,String taskName) {
		
		Map<String,Object> taskInfo=SchedulerConfigUtil.getTaskDetail(schedulerName, taskName);
		Map<String,Object> triggerInfo=new HashMap<String,Object>();
		if(taskInfo!=null){
			if(taskInfo.get("triggerList")!=null){
				List<Map<String,Object>> triggerList=(List<Map<String,Object>>)taskInfo.get("triggerList");
				if(triggerList!=null && triggerList.size()>0)
					triggerInfo=triggerList.get(0);
			}
		}
		response.addToRequest("schedulerName",schedulerName);
		response.addToRequest("task", taskInfo);
		response.addToRequest("trigger", triggerInfo);
		return SUCCESS;
	}
	
	
	@Action(description = "添加任务", responses = { @Response( name = SUCCESS, forward=@Forward(url = "/console/schedule/index.action")) })
	public String addTask(String schedulerName,TaskConfig task,TriggerConfig trigger) {

//		TaskConfig taskBean=new TaskConfig();
//		TriggerConfig triggerBean=new TriggerConfig();
//		taskBean.setTaskName("TestTask");
//		taskBean.setClassName(TaskExecutor.class.getName());
//		taskBean.setMethodName("execute");
//		taskBean.setStateful(false);
//		taskBean.setTaskType(1);
//		triggerBean.setBeginTime("2013-11-07 11:40:00");
//		triggerBean.setEndTime("2013-11-07 11:50:00");
//		triggerBean.setTriggerType(TriggerConfig.TRIGGER_TYPE_CRON);
//		//触发时间间隔
//		triggerBean.setIncrementSeconds(30);
//		triggerBean.setRepeatCount(5);
		SchedulerConfigUtil.addTask(schedulerName, task, trigger);
		
		return SUCCESS;
	}
	
	
	@Action(description = "修改任务", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/schedule/index.action")) })
	public String updateTask(String ip,int port,String appName,String schedulerName,TaskConfig task,TriggerConfig trigger) {
		SchedulerConfigUtil.updateTask(schedulerName, task, trigger);
		return SUCCESS;
	}
	
	@Action(description = "暂停任务", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/schedule/index.action")) })
	public String pauseTask(String ip,int port,String appName,String schedulerName,String taskName) {
		SchedulerConfigUtil.pauseTask(schedulerName, taskName);
		return SUCCESS;
	}
	
	@Action(description = "继续任务", responses = { @Response(name = SUCCESS,forward=@Forward(url = "/console/schedule/index.action")) })
	public String resumeTask(String schedulerName,String taskName) {
		SchedulerConfigUtil.resumeTask(schedulerName, taskName);
		return SUCCESS;
	}
	
	@Action(description = "删除任务", responses = { @Response(name = SUCCESS, forward=@Forward(url = "/console/schedule/index.action")) })
	public String deleteTask(String schedulerName,String taskName) {
		SchedulerConfigUtil.deleteTask(schedulerName, taskName);
		return SUCCESS;
	}
	
}
