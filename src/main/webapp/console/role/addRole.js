$( function() {
	// 定义校验规则
	var validateFormRule = {
		rules : {
			"role.roleName" : {
				required : true
			},
			"role.roleState" : {
				required : true
			},
			"role.roleType" : {
				required : true
			}
		}
	};
	var vo = validateForm("#data_form", validateFormRule);
	// 提交按钮
	$("#submitBtn").bind("click", function(e) {
		
		if (vo.form()) {
			
			var operate_flag = $(this).data("operate");
			switch (operate_flag) {
				case "add" :
					submitAddRoleAction(e.target);
					break;
				case "update" :
					submitUpdateRoleAction();
					break;
				default :
					break;
			}
		}
	});
	// 重置按钮
	$("#resetBtn").click( function() {
		vo.resetForm();
		var selNodes = getTreeSelectedNodes('#selectFuncTree', 'select');
		initFuncSelectInfo(selNodes);
	})
	// 返回按钮
	$("#backBtn").bind("click", function() {
		window.location.href = servletPath+"/console/role/index.action";
	});
	// 选择机构
	$("#selectOrg").click(
			function(event) {
				showPopWindow(event, "组织树", servletPath+"/console/org/entryOrgTree.action", $("[name='initOrgName']"), $("[id='_PopCloseBtn']"), "[id='_PopSubBtn']", "[name='initOrgId']", "[name='initOrgName']", null,
						"[id='selectOrg']");
			});

	var paramId = $("#initFuncTree").val();
	var showTreeMethod = "multiWithChild";
	initBascFuncTree(paramId, "", showTreeMethod, "#selectFuncTree", servletPath+"/console/function/initFuncTree.action", "功能树");
	showSelectedNodesInfo();
	$("div.a_container_left").resizable({
		minWidth : 400,
		maxWidth : 500,
		maxHeight : 450
	});
});
/**
 * 新增角色
 * 
 * @return
 */
function submitAddRoleAction(subBtn) {
	// $(subBtn).unbind('click');// 禁用click，防止多次提交
	// 初始化动态表单
	var addOrgRoleHtml = "", addRoleFuncHtml = "", orgRoleIds = [], functionIds = [];
	var orgRoleIdstr = $("[name='initOrgId']").val();
	orgRoleIds = $.trim(orgRoleIdstr) == '' ? [] : orgRoleIdstr.split(",");// 防止生成数组，值为""的
	$.each(orgRoleIds, function(i, v) {
		addOrgRoleHtml += "<input type='hidden' name='addOrgRole.orgId' value='" + v + "'/>";
	});
	$("#addOrgRoleDiv").html(addOrgRoleHtml);// 角色部门
	var selectedNodes = $("#selectFuncTree").dynatree("getSelectedNodes");// 需新增的角色资源从树的实际选择项取值
	functionIds = convertSelectedToStr(selectedNodes);
	$.each(functionIds, function(i, v) {
		addRoleFuncHtml += "<input type='hidden' name='roleFunction.functionId' value='" + v + "'/>";
	});
	$("#addRoleFuncDiv").html(addRoleFuncHtml);

	var options = {
		dataType : "json",
		error : function() {
			$.prop('新增角色出错!');
		},
		success : function(data) {
			$.prompt('新增"' + data.role.roleName + '"角色成功', {
				buttons : {
					"添加" : 'add',
					"更改" : 'update',
					"返回" : 'back'
				},
				focus : 2,
				submit : function(v) {
					switch (v) {
						case 'add' :
							$("#data_form").clearForm(true);// 加参数true情况隐藏域
				$("#selectFuncTree").dynatree("getTree").visit( function(node) {
					node.select(false);
				}, true)
				// $(subBtn).bind('click');

				break;
			case 'update' :
				// 获得新增后返回的id，按钮method改为update
				$(":hidden[name='role.roleId']").length == 0 ? $("[name='role.roleName']").before('<input type="hidden" name="role.roleId" value="' + data.role.roleId + '" />') : $(":hidden[name='role.roleId']").val(data.role.roleId);

				$(subBtn).text('更新').data("operate", "update");
				$(subBtn).closest("form").attr("action", servletPath+"/console/role/updateRole.action").find("div.a_container_top").text('更新角色');
				var initOrgTreeEl = $("[name='initOrgId']"), initFuncTreeEl = $("[name='functionIds']");
				var selectOrgIdStr = initOrgTreeEl.val();

				initOrgTreeEl.data("persistorg", selectOrgIdStr);
				initFuncTreeEl.data("persistfunc", initFuncTreeEl.val());

				break;

			default :
				$("#backBtn").trigger("click");// 触发返回按钮事件
				break;
		}
	}
			});

		}
	};
	$("form[id='data_form']").ajaxSubmit(options);
}
/**
 * 更新角色
 * 
 * @return
 */
function submitUpdateRoleAction() {

	var initOrgTreeEl = $("[name='initOrgId']"), initFuncTreeEl = $("[name='functionIds']"), persistOrgIds = [], persistFuncIds = [];// 两个初始化树的元素

	var persistOrgId = initOrgTreeEl.data("persistorg").toString();

	persistOrgIds = persistOrgId.indexOf(",") < 0 ? [persistOrgId] : persistOrgId.split(",");// 库存的orgId数组
	var persistFuncId = initFuncTreeEl.data("persistfunc").toString();
	persistFuncIds = persistFuncId.indexOf(",") < 0 ? [persistFuncId] : persistFuncId.split(",");// 库存的funcId
	var roleId = $("[name='role.roleId']").val();

	var selectOrgIdStr = initOrgTreeEl.val();
	var selectOrgIds = selectOrgIdStr.split(",");
	// 改动的部门角色的部门的ID
	var addOrgRoleIds = [], deleteOrgRoleIds = [], nochangeOrgRoleIds = [];
	addOrgRoleIds = $.grep(selectOrgIds, function(v, i) {
		if ($.inArray(v, persistOrgIds) < 0) {
			return v;
		}
	});
	nochangeOrgRoleIds = $.grep(selectOrgIds, function(v, i) {
		if ($.inArray(v, persistOrgIds) >= 0) {
			return v;
		}
	});
	deleteOrgRoleIds = $.grep(persistOrgIds, function(v, i) {
		if ($.inArray(v, nochangeOrgRoleIds) < 0) {
			return v;
		}
	});
	var updateOrgRoleHtml = "", updateRoleFuncHtml = "";
	$.each(addOrgRoleIds, function(i, v) {
		updateOrgRoleHtml += '<input type="hidden" name="addOrgRole.orgId" value="' + v + '" /><input type="hidden" name="addOrgRole.roleId" value="' + roleId + '" />';

	});
	$.each(deleteOrgRoleIds, function(i, v) {
		updateOrgRoleHtml += '<input type="hidden" name="deleteOrgRole.orgId" value="' + v + '" /><input type="hidden" name="deleteOrgRole.roleId" value="' + roleId + '" />';
	});
	$(".orgRoleSelectedDiv").html(updateOrgRoleHtml);

	// 改动的资源
	var addRoleFuncIds = [], deleteRoleFuncIds = [], nochangeRoleFuncIds = [];
	var selectFuncIds = convertSelectedToStr($("#selectFuncTree").dynatree("getSelectedNodes"));// 选中的资源是以树节点selected状态为准

	addRoleFuncIds = $.grep(selectFuncIds, function(v, i) {
		if ($.inArray(v, persistFuncIds) < 0) {
			return v;
		}
	});
	nochangeRoleFuncIds = $.grep(selectFuncIds, function(v, i) {
		if ($.inArray(v, persistFuncIds) >= 0) {
			return v;
		}
	});
	deleteRoleFuncIds = $.grep(persistFuncIds, function(v, i) {
		if ($.inArray(v, nochangeRoleFuncIds) < 0) {
			return v;
		}
	});

	$.each(addRoleFuncIds, function(i, v) {
		updateRoleFuncHtml += '<input type="hidden" name="addRoleFunction.functionId" value="' + v + '" /><input type="hidden" name="addRoleFunction.roleId" value="' + roleId + '" />';

	});
	$.each(deleteRoleFuncIds, function(i, v) {
		updateRoleFuncHtml += '<input type="hidden" name="deleteRoleFunction.functionId" value="' + v + '" /><input type="hidden" name="deleteRoleFunction.roleId" value="' + roleId + '" />';
	});
	$(".roleFuncSelectedDiv").html(updateRoleFuncHtml);

	var options = {
		dataType : "json",
		error : function() {
			$.prop('更新角色出错!');
		},
		success : function(data) {
			$.prompt("更新成功!", {
				callback : function(v, m) {
					initOrgTreeEl.data("persistorg", selectOrgIdStr);
					initFuncTreeEl.data("persistfunc", initFuncTreeEl.val());

				}
			})

		}
	};
	$("form[id='data_form']").ajaxSubmit(options);

}
/**
 * 初始化函数功能树
 * 
 * @param initId
 * @param groupId
 * @param showTreeMethod
 * @param showEl
 * @param url
 * @param memo
 * @return
 */
function initBascFuncTree(initId, groupId, showTreeMethod, showEl, url, memo) {
	$.ajax({
		url : url,
		data : {
			"initId" : initId,
			"groupId" : groupId
		},
		type : 'POST',
		dataType : 'json',
		beforeSend : function() {
			$(showEl).html(memo + '加载中...');
		},
		global : false,
		timeout : 15000,// 15s响应超时
		error : function() {
			$.prompt("加载树出错.<br/>请检查生成树action!");
		},
		success : function(data) {
			var treeData = data.children;// 传过来就是json格式，树节点的key是children
		var treeDataNodes = {
			"children" : treeData,
			onSelect : function(flag, node) {
				var selectedNodes = $("#selectFuncTree").dynatree("getSelectedNodes");
				initFuncSelectInfo(selectedNodes);
			}
		};
		// 使用单选模式
		var settings = $.extend({}, fetchMethod(showTreeMethod), treeDataNodes);
		$(showEl).dynatree(settings);
	}
	});
}
/**
 * 选中多少个函数
 * 
 * @param selectedNodes
 * @return
 */
function initFuncSelectInfo(selectedNodes) {
	var vs = convertSelectedToStr(selectedNodes);
	showSelectedNodesInfo(vs);
}
/**
 * 转换选中的节点To字符串
 * 
 * @return
 */
function convertSelectedToStr(selectedNodes) {
	var vs = [];
	for (i = 0; i < selectedNodes.length; i++) {
		var v = selectedNodes[i].data;
		if (v.nodeType == "function") {
			vs.push(v.attrId);
		}
	}
	$("#initFuncTree").val(vs);
	return vs;

}
/**
 * 显示已选择的资源信息
 * 
 * @param vs
 * @return
 */
function showSelectedNodesInfo(vs) {

	if (!vs) {
		var selectedStr = $("#initFuncTree").val();
		if ($.trim(selectedStr).length > 0) {
			vs = selectedStr.split(",");
			$("span#showdselectInfo").html('已选择<font color="red">' + vs.length + "</font>项");
		}
	} else {
		$("span#showdselectInfo").html('已选择<font color="red">' + vs.length + "</font>项");
	}

}
