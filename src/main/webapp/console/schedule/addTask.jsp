<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<%@include file="/common/common.jsp"%>
<%@include file="/common/jqueryUI.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/console/schedule/schedule.js"></script>
<script>
	(function($) {
		$(function() {
			// 定义校验规则
			var validateFormRule = {
				rules : {
					"task.taskName" : {
						required : true
					},
					"task.className" : {
						required : true
					},
					"task.methodName" : {
						required : true
					},
					"trigger.beginTime" : {
						required : true
					},
					"trigger.endTime" : {
						required : true
					}
				},
				messages : {
					"task.taskName" : {
						required : "请输入任务名称"
					},
					"task.className" : {
						required : "请输入类名"

					},
					"task.methodName" : {
						required : "请输入方法名"
					}

				}
			};

			var vo = validateForm("#action", validateFormRule);
			// 重置按钮
			$("#saveBtn").click(function() {
				if (vo.form()) {
					var fm = document.getElementById("action");
					var types = document.getElementsByName("trigger.triggerType");
					var triggerType = getCheckedValue(types);

					//固定时间触发
					if (triggerType == "1") {
						var beginTime = document.getElementById("trigger.beginTime").value;
						var endTime = document.getElementById("trigger.endTime").value;
						if (!document.getElementById("clearup").checked && (endTime <= beginTime)) {
							alert("结束日期不能小于等于开始日期");
							return;
						}
						if (document.getElementById("trigger.repeatCount").value == "0") {
							f_alert("循环次数不能为0!");
							return;
						}
						if (document.getElementById("trigger.incrementSeconds").value == "0" && document.getElementById("trigger.repeatCount").value != "1") {
							f_alert("时间间隔不能为0!");
							return;
						}
					}
					//日历周期触发
					if (triggerType == "2") {
						var beginTime = document.getElementById("trigger.beginTime").value;
						var endTime = document.getElementById("trigger.endTime").value;
						if (!document.getElementById("clearup").checked && (endTime <= beginTime)) {
							alert("结束时间不能小于等于开始时间");
							return;
						}
						buildCron();
					}

					var tmpFlag = false;
					if ((document.getElementById("circleRadio").checked == true) && (document.getElementById("action_week").checked == true)) {
						for ( var i = 1; i <= 7; i++) {
							if (eval("document.getElementById('week[" + i + "]').checked==true")) {
								tmpFlag = true;
								break;
							}
						}
						if (!tmpFlag) {
							alert("请选择第几周");
							return;
						}
					}

					if (!checkTaskAleadyExist(document.getElementById("task.taskName").value) && validateTrigger()) {
						if (confirm("确定添加任务?")) fm.submit();
					}

				}
			});

			// 返回按钮
			$("#backBtn").click(function() {
				window.location.href = servletPath + "/console/schedule/index.action";
			});

			$("#clearup").click(function() {
				var endTime = document.getElementById("trigger.endTime");
				if (this.checked) {
					$("[name='trigger.endTime']").datepicker("disable");
				} else {
					$("[name='trigger.endTime']").datepicker("enable");
				}
			});

			$("#action_week").click(function() {
				changeType("week");
			});
			$("#action_day").click(function() {
				changeType("day");
			});
			$("#action_month").click(function() {
				changeType("month");
			});
			$("#action_year").click(function() {
				changeType("year");
			});

			$("[name='paramCount']").blur(function() {
				var params = document.getElementById("params");
				var count = parseInt(document.getElementById("paramCount").value, 10);
				var inputHTML = "<table>";
				for ( var i = 0; i < count; i++) {
					if ((i + 1) % 4 == 1)
						inputHTML += "<tr>";
					inputHTML += "<td>&nbsp;参数" + (i + 1) + ": <input size='5' name='params[" + i+ "]'" + "></td>";
					if ((i + 1) % 4 == 0 || (i + 1) == count)
						inputHTML += "</tr>";
				}
				params.innerHTML = inputHTML + "</table>";
			});

			// 调用日期控件
			$("[name='trigger.beginTime']").datetimepicker({
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy-mm-dd",
				timeFormat : "HH:mm:ss",
				timeText : "时间",
				hourText : "时",
				minuteText : "分",
				secondText : "秒",
				currentText : "现在",
				closeText : "确定",
				showSecond : true,
				regional : "zh-CN"
			// ,defaultDate:"2011-11-11"
			});
			$("[name='trigger.endTime']").datetimepicker({
				changeMonth : true,
				changeYear : true,
				dateFormat : "yy-mm-dd",
				timeFormat : "HH:mm:ss",
				timeText : "时间",
				hourText : "时",
				minuteText : "分",
				secondText : "秒",
				currentText : "现在",
				closeText : "确定",
				showSecond : true,
				regional : "zh-CN"
			// ,defaultDate:"2011-11-11"
			});

			$("[name='triggerTime']").timepicker({
				timeOnlyTitle : "选择时间",
				timeFormat : "HH:mm:ss",
				timeText : "时间",
				hourText : "时",
				minuteText : "分",
				secondText : "秒",
				currentText : "现在",
				closeText : "确定"
			});

			$("#cronRadio").click(function() {
				triggerChanged(this);
			});

			$("#circleRadio").click(function() {
				triggerChanged(this);
			});

			initTaskSchedule();

		});

		function changeType(action) {
			disableContainer("day_type");
			disableContainer("week_type");
			disableContainer("month_type");
			disableContainer("year_type");
			enableContainer(action + "_type");
		}

		function disableContainer(id) {
			var elem = document.getElementById(id);
			if (elem) {
				var inputs = elem.getElementsByTagName("input");
				for ( var i = 0; i < inputs.length; i++) {
					inputs[i].disabled = true;
				}
				var selects = elem.getElementsByTagName("select");
				for ( var i = 0; i < selects.length; i++) {
					selects[i].disabled = true;
				}
			}
			elem.disabled = true;
		}

		function enableContainer(id) {
			var elem = document.getElementById(id);
			if (elem) {
				var inputs = elem.getElementsByTagName("input");
				for ( var i = 0; i < inputs.length; i++) {
					inputs[i].disabled = false;
				}
				var selects = elem.getElementsByTagName("select");
				for ( var i = 0; i < selects.length; i++) {
					selects[i].disabled = false;
				}
			}
			elem.disabled = false;
		}

		function getCheckedValue(selObj) {
			var result = null;
			for ( var i = 0; i < selObj.length; i++) {
				if (selObj[i].checked)
					result = selObj[i].value;
			}
			return result;
		}

		function checkMisIntructionStatus() {
			if (document.getElementById("circleRadio").checked == true) {
				document.getElementById("mistruct").style.display = "";
			} else {
				document.getElementById("mistruct").style.display = "none";
			}
		}

		function setDisabled(flag) {
			document.getElementById("trigger.repeatCount").disabled = flag;
			document.getElementById("trigger.incrementSeconds").disabled = flag;
		}

		function triggerChanged(obj) {
			var trTime = document.getElementById("trTime");
			var trCircle = document.getElementById("trCircle");
			var trCron = document.getElementById("trCron");
			switch (obj.value) {
			case "1":
				if (trTime.style.display != "") {
					setDisabled(false);
					trTime.style.display = "";
				}
				trCircle.style.display = "none";
				trCron.style.display = "none";
				break;
			case "2":
				trTime.style.display = "none";
				trCron.style.display = "none";
				if (trCircle.style.display != "") {
					setDisabled(true);
					trCircle.style.display = "";
				}

				break;
			case "3":
				trTime.style.display = "none";
				trCircle.style.display = "none";
				if (trCron.style.display != "") {
					setDisabled(true);
					trCron.style.display = "";
				}
				break;
			}
			checkMisIntructionStatus();
		}

		function checkTaskAleadyExist(taskName) {
			$.ajax({
				url : servletPath + "/console/schedule/isTaskAlreadyExisted.action",
				data : {
					"ip" : document.getElementById("ip").value,
					"port" : document.getElementById("port").value,
					"appName" : document.getElementById("appName").value,
					"schedulerName" : "default",
					"taskName" : taskName
				},
				type : 'POST',
				global : false,
				dataType : 'json',
				success : function(data) {
					if (data.result == true) {
						alert("任务名[" + taskName + "]已经存在，请重新输入任务名称!");
						return true;
					}
				},
				complete : function(XHR, textStatus) {

				}
			});
			return false;
		}

		function validateTrigger() {
			var types = document.getElementsByName("trigger.triggerType");
			var triggerType = getCheckedValue(types);
			$.ajax({
				url : servletPath + "/console/schedule/validateTrigger.action",
				data : {
					"ip" : document.getElementById("ip").value,
					"port" : document.getElementById("port").value,
					"appName" : document.getElementById("appName").value,
					"trigger.triggerType" : triggerType,
					"trigger.beginTime" : document.getElementById("trigger.beginTime").value,
					"trigger.endTime" : document.getElementById("trigger.endTime").value,
					"trigger.incrementSeconds" : document.getElementById("trigger.incrementSeconds").value,
					"trigger.repeatCount" : document.getElementById("trigger.repeatCount").value,
					"trigger.cronExpression" : document.getElementById("trigger.cronExpression").value
				},
				type : 'POST',
				global : false,
				dataType : 'json',
				success : function(data) {
					if (data.result == false) {
						alert("无效的触发器时间");
						return false;
					}
				}
			});
			return true;
		}

		function buildCron() {
			var action_day = document.getElementById("action_day");
			if (action_day.checked) {
				buildDay();
			}
			var action_week = document.getElementById("action_week");
			if (action_week.checked) {
				buildWeek();
			}
			var action_month = document.getElementById("action_month");
			if (action_month.checked) {
				buildMonth();
			}
			var action_year = document.getElementById("action_year");
			if (action_year.checked) {
				buildYear();
			}
		}

		function buildDay() {
			document.getElementById("trigger.cronExpression").value = getTaskTime().toText();
		}

		function buildWeek() {
			var schedule = getTaskTime();
			schedule.week.parse(getWeek());
			document.getElementById("trigger.cronExpression").value = schedule.toText();
		}

		function buildMonth() {
			var schedule = getTaskTime();
			if (document.getElementById("month1").checked) {
				schedule.day.parse(document.getElementById("month_day").value);
			}
			if (document.getElementById("month2").checked) {
				var weekOrder = document.getElementById("month_weekOrder").value;
				var weekValue = document.getElementById("month_week").value;
				if (order != -1) {
					schedule.week.parse(weekValue + "#" + weekOrder);
				} else {
					schedule.week.parse(weekValue + "L");
				}
			}
			document.getElementById("trigger.cronExpression").value = schedule.toText();
		}
		function buildYear() {
			var schedule = getTaskTime();
			if (document.getElementById("year1").checked) {
				var month = document.getElementById("year_month1").value;
				var day = document.getElementById("year_day").value;
				schedule.month.parse(month);
				schedule.day.parse(day);
			}
			if (document.getElementById("year2").checked) {
				var month = document.getElementById("year_month2").value;
				var order = document.getElementById("year_weekOrder").value;
				var week = document.getElementById("year_week").value;
				schedule.month.parse(month);
				if (order != -1) {
					schedule.week.parse(week + "#" + order);
				} else {
					schedule.week.parse(week + "L");
				}
			}
			document.getElementById("trigger.cronExpression").value = schedule.toText();
		}
		function getTaskTime() {
			var time = document.getElementById("triggerTime").value;
			var arr = time.split(":");
			for ( var i = 0; i < arr.length; i++) {
				arr[i] = parseInt(arr[i], 10);
			}
			arr.reverse();
			var cron = arr.join(" ") + " * * ? *";
			return new Schedule(cron);

		}
		function initTaskSchedule() {
			var value = document.getElementById("trigger.cronExpression").value;
			var schedule = new Schedule(value);
			initTime(schedule);
			var day = schedule.day.toText();
			var month = schedule.month.toText();
			var week = schedule.week.toText();
			var year = schedule.year.toText();
			if (day == "*" && month == "*" && week == "?") {
				initDay(schedule);
			}
			if (day == "?" && week != "*" && month == "*") {
				if (week.indexOf("#") > 0 || week.indexOf("L") > 0) {
					initMonth(schedule);
				} else {
					initWeek(schedule);
				}
			}
			if (day != "*" && week == "?" && month == "*") {
				initMonth(schedule);
			}
			if (month != "*") {
				initYear(schedule);
			}

			checkMisIntructionStatus();
		}
		function initTime(schedule) {
			document.getElementById("triggerTime").value = schedule.hour.toText() + ":" + schedule.minute.toText() + ":" + schedule.second.toText();
		}

		function initDay(schedule) {
			document.getElementById("action_day").click();

		}

		function initWeek(schedule) {
			document.getElementById("action_week").click();
			setWeek(schedule.week.toText());
		}

		function initMonth(schedule) {
			document.getElementById("action_month").click();
			var day = schedule.day.toText();
			var week = schedule.week.toText();
			if (day == "?") {
				document.getElementById("month2").click();
				if (schedule.week.hasLast) {
					document.getElementById("month_weekOrder").value = "-1";
					document.getElementById("month_week").value = week.regText.replace("L", "");
				}
				if (week.indexOf("#") > 0) {
					document.getElementById("month_weekOrder").value = schedule.week.weekOrder;
					document.getElementById("month_week").value = schedule.week.dayOrder;
				}
			}
			if (week == "?") {
				document.getElementById("month1").click();
				document.getElementById("month_day").value = day;
			}
		}

		function initYear(schedule) {
			document.getElementById("action_year").click();
			var day = schedule.day.toText();
			var week = schedule.week.toText();
			var month = schedule.month.toText();
			if (week == "?") {
				document.getElementById("year1").click();
				document.getElementById("year_month1").value = month;
				document.getElementById("year_day").value = day;
			}
			if (day == "?") {
				document.getElementById("year2").click();
				document.getElementById("year_month2").value = month;
				document.getElementById("year_weekOrder").value = schedule.week.weekOrder;
				document.getElementById("year_week").value = schedule.week.dayOrder;
			}
		}

		function getWeek() {
			var arr = [];
			for ( var i = 1; i < 8; i++) {
				if (document.getElementById("week[" + i + "]").checked) {
					arr.push(i);
				}
			}
			return arr.join(",");
		}

		function setWeek(weekText) {
			for ( var i = 1; i < 8; i++) {
				if (weekText.indexOf(i) >= 0) {
					document.getElementById("week[" + i + "]").checked = true;
				} else {
					document.getElementById("week[" + i + "]").checked = false;
				}
			}
		}
	})(jQuery)
</script>
</head>
<body style="margin:0px">
	<div class="grid_body">
		<table class="content" border="0" width="100%">
			<thead>
				<tr>
					<th colspan="2">添加任务</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td width="100%">
						<form method="post" id="action" action="<%=servletPath%>/console/schedule/addTask.action">
							<input type="hidden" name="ip" id="ip" value="${ip}" />
							<input type="hidden" name="port" id="port" value="${port}" />
							<input type="hidden" name="appName" id="appName" value="${appName}" />						
							<table width="100%" class="form_table">
								<tr>
									<td width="10%" class="title">任务类型</td>
									<td width="30%"><select name="task.taskType">
											<option value="1">Java方法</option>
									</select></td>
									<td width="10%" class="title">任务名称</td>
									<td width="30%"><input type="text" name="task.taskName" id="task.taskName" size="30"  maxlength="50" /></td>
									<td width="20%">
									<input type="radio" name="task.stateful" value="false" checked/>无状态 
									<input type="radio" name="task.stateful" value="true"/>有状态
									</td>
								</tr>

								<tr>
									<td class="title"><span id="captionPanel">类名</td>
									<td colspan="4"><input tye="text" name="task.className" id="task.className" size="80" /></td>
								</tr>
								<tr>
									<td class="title">方法名</td>
									<td><input type="text" id="task.methodName" name="task.methodName" size="30" /></td>
									<td class="title">输入参数个数</td>
									<td colspan="2"><input type="text" id="paramCount" name="paramCount" size="3" /></td>
								</tr>
								<tr>
									<td class="title">输入参数值</td>
									<td colspan="4"><span id="params"></span></td>
								</tr>
								<tr>
									<td class="title">开始时间:</td>
									<td><input type="text" id="trigger.beginTime" name="trigger.beginTime" readOnly /></td>
									<td class="title">结束时间</td>
									<td><input type="text" id="trigger.endTime" name="trigger.endTime" readOnly />
									<td><input id="clearup" name="clearup" type="checkbox">&nbsp;无结束时间</td>
								</tr>
								<tr>
									<td class="title">触发模式</td>
									<td colspan="4">
										<input type="radio" name="trigger.triggerType" id="cronRadio" value="1" checked="checked"/>固定时间触发
										 <input type="radio" name="trigger.triggerType" id="circleRadio" value="2"/>日历周期触发 
										 <!-- input name="trigger/type" type="radio" value="3" onclick="triggerChanged(this)">自定义Cron表达式 --> 
										 <span id="mistruct" style="display:none"> 
										 <input type="checkbox" id="trigger.misfireInstruction" name="trigger.misfireInstruction" value="0"/> 应用或调度器启动后自动触发上次应用或调度器停止期间该触发而未触发的定时任务
										</span>
									</td>
								</tr>
								<tr id="trTime">
									<td colspan="5">
										<table width="100%" class="form_table">
											<tr>
												<td width="10%" class="title">间隔时间:</td>
												<td colspan="2"><input type="text" name="trigger.incrementSeconds" id="trigger.incrementSeconds" maxlength="9" value="0" /> &nbsp;(单位:秒)</td>
											</tr>
											<tr>
												<td width="10%" class="title">执行次数:</td>
												<td colspan="2"><input type="text" name="trigger.repeatCount" id="trigger.repeatCount" maxlength="4" value="1" /> &nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="trCron" style="display:none;">
									<td colspan="5">
										<table width="100%" class="form_table">
											<tr>
												<td width="10%" class="title">触发表达式</td>
												<td><input type="text" id="trigger.cronExpression" name="trigger.cronExpression" /></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="trCircle" style="display:none">
									<td colspan="5">
										<table id="table1" width="100%" class="form_table">
											<tr>
												<td width="10%" class="title">触发时间</td>
												<td colspan="2"><input type="text" name="triggerTime" id="triggerTime" /></td>
											</tr>
											<tr>
												<td width="10%" class="title" rowspan="4">循环模式</td>
												<td width="80"><input type="radio" id="action_day" name="triggerType">每天</td>
												<td width="479">
													<div>
														<div id="day_type" disabled=true></div>
													</div>
												</td>
											</tr>
											<tr>
												<td width="80"><input type="radio" id="action_week" name="triggerType">每周</td>
												<td width="479">
													<div id="week_type" disabled=true>
														<table border="0" width="100%" id="table6" cellspacing="0" cellpadding="0" style="border: #F0F9FE solid 1px">
															<tr style="border: #F0F9FE solid 1px">
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[1]" value="1">星期日</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[2]" value="1">星期一</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[3]" value="1">星期二</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[4]" value="1">星期三</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[5]" value="1">星期四</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[6]" value="1">星期五</td>
																<td style="border: #F0F9FE solid 1px"><input type="checkbox" id="week[7]" value="1">星期六</td>
															</tr>
														</table>
													</div>
												</td>
											</tr>
											<tr>
												<td width="80"><input type="radio" id="action_month" name="triggerType">每月</td>
												<td width="479">
													<div id="month_type" disabled=true>
														<table border="0" width="100%" id="table7" cellspacing="0" cellpadding="0" style="border: #F0F9FE solid 1px">
															<tr style="border: #F0F9FE solid 1px">
																<td style="border: #F0F9FE solid 1px"><input type="radio" name="month" id="month1"> <select size="1" id="month_day" name="month_day">
																		<option value="1">1日</option>
																		<option value="2">2日</option>
																		<option value="3">3日</option>
																		<option value="4">4日</option>
																		<option value="5">5日</option>
																		<option value="6">6日</option>
																		<option value="7">7日</option>
																		<option value="8">8日</option>
																		<option value="9">9日</option>
																		<option value="10">10日</option>
																		<option value="11">11日</option>
																		<option value="12">12日</option>
																		<option value="13">13日</option>
																		<option value="14">14日</option>
																		<option value="15">15日</option>
																		<option value="16">16日</option>
																		<option value="17">17日</option>
																		<option value="18">18日</option>
																		<option value="19">19日</option>
																		<option value="20">20日</option>
																		<option value="21">21日</option>
																		<option value="22">22日</option>
																		<option value="23">23日</option>
																		<option value="24">24日</option>
																		<option value="25">25日</option>
																		<option value="26">26日</option>
																		<option value="27">27日</option>
																		<option value="28">28日</option>
																		<option value="29">29日</option>
																		<option value="30">30日</option>
																		<option value="31">31日</option>
																</select></td>
															</tr>
															<tr style="border: #F0F9FE solid 1px">
																<td style="border: #F0F9FE solid 1px"><input type="radio" checked name="month" id="month2"> <select size="1" id="month_weekOrder">
																		<option value="1">第一周</option>
																		<option value="2">第二周</option>
																		<option value="3">第三周</option>
																		<option value="4">第四周</option>
																		<option value="-1">最后一周</option>
																</select> <select size="1" id="month_week">
																		<option value="2">星期日</option>
																		<option value="3">星期一</option>
																		<option value="4">星期二</option>
																		<option value="5">星期三</option>
																		<option value="6">星期四</option>
																		<option value="7">星期五</option>
																		<option value="1">星期六</option>
																</select></td>
															</tr>
														</table>
													</div>
												</td>
											</tr>
											<tr>
												<td width="80"><input type="radio" id="action_year" name="triggerType">每年</td>
												<td width="479">
													<div id="year_type" disabled=true>
														<table border="0" width="110%" id="table8" cellspacing="0" cellpadding="0" style="border: #F0F9FE solid 1px">
															<tr style="border: #F0F9FE solid 1px">
																<td style="border: #F0F9FE solid 1px"><input type="radio" checked name="year" id="year1"> <span id="everyYear1"> <select size="1"
																		id="year_month1"
																	>
																			<option value="1">一月</option>
																			<option value="2">二月</option>
																			<option value="3">三月</option>
																			<option value="4">四月</option>
																			<option value="5">五月</option>
																			<option value="6">六月</option>
																			<option value="7">七月</option>
																			<option value="8">八月</option>
																			<option value="9">九月</option>
																			<option value="10">十月</option>
																			<option value="11">十一月</option>
																			<option value="12">十二月</option>
																	</select> <select size="1" id="year_day">
																			<option value="1">1日</option>
																			<option value="2">2日</option>
																			<option value="3">3日</option>
																			<option value="4">4日</option>
																			<option value="5">5日</option>
																			<option value="6">6日</option>
																			<option value="7">7日</option>
																			<option value="8">8日</option>
																			<option value="9">9日</option>
																			<option value="10">10日</option>
																			<option value="11">11日</option>
																			<option value="12">12日</option>
																			<option value="13">13日</option>
																			<option value="14">14日</option>
																			<option value="15">15日</option>
																			<option value="16">16日</option>
																			<option value="17">17日</option>
																			<option value="18">18日</option>
																			<option value="19">19日</option>
																			<option value="20">20日</option>
																			<option value="21">21日</option>
																			<option value="22">22日</option>
																			<option value="23">23日</option>
																			<option value="24">24日</option>
																			<option value="25">25日</option>
																			<option value="26">26日</option>
																			<option value="27">27日</option>
																			<option value="28">28日</option>
																			<option value="29">29日</option>
																			<option value="30">30日</option>
																			<option value="31">31日</option>
																	</select></span></td>
															</tr>

															<tr style="border: #F0F9FE solid 1px">
																<td style="border: #F0F9FE solid 1px"><input type="radio" name="year" id="year2"> <span id="everyYear2"> <select size="1" id="year_month2">
																			<option value="1">一月</option>
																			<option value="2">二月</option>
																			<option value="3">三月</option>
																			<option value="4">四月</option>
																			<option value="5">五月</option>
																			<option value="6">六月</option>
																			<option value="7">七月</option>
																			<option value="8">八月</option>
																			<option value="9">九月</option>
																			<option value="10">十月</option>
																			<option value="11">十一月</option>
																			<option value="12">十二月</option>
																	</select> <select size="1" id="year_weekOrder">
																			<option value="1">第一周</option>
																			<option value="2">第二周</option>
																			<option value="3">第三周</option>
																			<option value="4">第四周</option>
																			<option value="-1">最后一周</option>
																	</select> <select size="1" id="year_week">
																			<option value="2">星期日</option>
																			<option value="3">星期一</option>
																			<option value="4">星期二</option>
																			<option value="5">星期三</option>
																			<option value="6">星期四</option>
																			<option value="7">星期五</option>
																			<option value="1">星期六</option>
																	</select></span></td>
															</tr>
														</table>
													</div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2"><input type="button" id="saveBtn" value="保存" class="sub" />&nbsp; <input type="button" id="backBtn" value="返回" class="sub"></td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
</html>
