var PermissionTreeVar = {};
( function($) {
	$( function() {
		initPermissionTree();
	});
	function initPermissionTree() {
		var funcSwtich;// 设置按钮默认的是关闭funcs的显示
		if (arguments.length > 0) {
			funcSwtich = arguments[0];
		} else {
			funcSwtich = $("[id='shortcutMenuSetting']", $(window.parent.document)).data("switch");// 既然没有分组，就拿这个分组位置的参数作为函数是否显示开关
		}

		$("#permissionTree").dynatree("destroy");
		var paramId = $("#shortcutMenuForm").data("olddata");
		var showTreeMethod = $("[id='shortcutMenuSetting']", $(window.parent.document)).data("method");
		initEntityTreeForPermission(paramId, funcSwtich, showTreeMethod, "#permissionTree", servletPath+"/console/function/initPermissionTree.action", "权限树");
	}
	PermissionTreeVar.initPermissionTree = initPermissionTree;
	// 重新刷新树（父页面重置用）
	PermissionTreeVar.reloadPermissionTree = function() {
		$("#permissionTree").dynatree("getTree").reload();
		validateAndShowSelectedInfo("#permissionTree");
	}

	function initEntityTreeForPermission(initId, funcSwtich, showTreeMethod, showEl, url, memo) {
		$.ajax({
			url : url,
			data : {
				"initId" : initId,
				"funcSwtich" : funcSwtich
			},
			type : 'POST',
			dataType : 'json',
			beforeSend : function() {
				$(showEl).html(memo + '加载中...');
			},
			global : false,
			// timeout : 15000,
			error : function() {
				$.prompt("加载树出错或者长时间无响应.<br/>请检查生成树action!");
			},
			success : function(data) {
				var treeData = data.children;// 传过来就是json格式，树节点的key是children
			var treeDataNodes = {
				"children" : treeData,
				onSelect : function(isSelected, operateNode) {
					validateAndShowSelectedInfo(showEl);
				}
			};
			if (arguments[6]) {
				$.extend(treeDataNodes, menuOpt);
			}
			// 使用单选模式
			var settings = $.extend({}, fetchMethod(showTreeMethod), treeDataNodes);
			$(showEl).dynatree("destroy").dynatree(settings);// 树初始化之后再显示选择栏位信息
			validateAndShowSelectedInfo(showEl);
			var selectedNodes = $("#permissionTree").dynatree("getSelectedNodes");
			var sIds = $.map(selectedNodes, function(node) {
				return node.data.attrId;
			});
		},
		complete : function() {

		}
		});
	}
	/**
	 * 校验和显示已选择的信息
	 * 
	 * @param showEl
	 * @return
	 */
	function validateAndShowSelectedInfo(showEl) {
		var pdom = $(window.parent.document);
		var showErrEl = $("span#permissionTreeSelectInfo", pdom);
		var selNodes = $(showEl).dynatree("getSelectedNodes");// 获得指定参数showEL的包含的选中的树节点
		var totalLength = selNodes.length;
		var nodeInfos = $.map(selNodes, function(node) {
			return {
				"path" : node.data.key,
				"status" : "handed"
			};// 状态detached:减过~~handed:占用
			});

		var nodePaths = $.map(nodeInfos, function(n) {
			return n["path"];
		});
		var validLength = dovalidate(nodeInfos, nodePaths);// 有效长度
		$("font", showErrEl).empty().html(validLength);
		$("#shortcutmenuError", pdom).val(validLength);
		return validLength;
	}

	PermissionTreeVar.ShowSelectedInfo = validateAndShowSelectedInfo;
	/**
	 * 执行校验
	 * 
	 * @param totalLength
	 * @param nodeInfos
	 * @return
	 */
	function dovalidate(nodeInfos, nodePaths) {
		for ( var i = 0; i < nodeInfos.length; i++) {
			var moduleInfo = nodeInfos[i];
			countValidNodeInfo(moduleInfo, nodeInfos, nodePaths);
		}
		var newReturnInfo = $.grep(nodeInfos, function(nd, i) {
			return nd["status"] !== "detached";
		});
		return newReturnInfo.length;

	}
	/**
	 * 获取计算占栏位的模块信息
	 * 
	 * @param moduleInfo
	 * @param nodeInfos
	 * @param nodePaths
	 * @return
	 */
	function countValidNodeInfo(moduleInfo, nodeInfos, nodePaths) {
		var modulePath = moduleInfo["path"], status = moduleInfo["status"];
		if (modulePath.contains(",")) {
			var parentNodeInfo = findTheParentModulepathInTheArray(modulePath, nodeInfos, nodePaths);
			if (parentNodeInfo) {
				$.map(nodeInfos, function(ni) {
					if (ni["path"] === modulePath) {
						ni["status"] = "detached";
					}
					return ni;
				});
			}
		}
	}
	/**
	 * 向上取存在于集合中的父节点
	 * 
	 * @param modulePath
	 * @param nodeInfos
	 * @param nodePaths
	 * @return
	 */
	function findTheParentModulepathInTheArray(modulePath, nodeInfos, nodePaths) {
		var parentNodeInfo;
		if (modulePath.contains(",")) {
			var parentPath = modulePath.substringBeforeLast(",");
			var flag = $.inArray(parentPath, nodePaths);
			if (flag === -1) {
				parentNodeInfo = findTheParentModulepathInTheArray(parentPath, nodeInfos, nodePaths);
			} else {
				parentNodeInfo = $.grep(nodeInfos, function(n) {
					return n["path"] == parentPath;
				})[0];
			}
		}
		return parentNodeInfo;
	}

	/**
	 * 父页面确定按钮调用
	 * 
	 * 动态创建需要提交的表单元素(shortMenuPo)
	 * 
	 * 算出需要新增的和删除的，然后拼接html串
	 * 
	 * @return
	 */
	PermissionTreeVar.dynaCreateFormEl = function(userId, commonVanus, dia) {
		if ($.trim(userId) === "" || userId === null || userId === undefined) {
			alert('尚未登录');
		} else {
			
			var form = $("#shortcutMenuForm");
			var oldNodeIds = [], olddata = String(form.data("olddata"));// 库中已存的数据
			if (olddata) {
				if (olddata.contains(",")) {
					oldNodeIds = olddata.split(",");
				} else {
					oldNodeIds = [olddata];
				}
			}
			var selectedNodes = $("#permissionTree").dynatree("getSelectedNodes");
			var selectedNodeIds = $.map(selectedNodes, function(node) {
				return node.data.attrId;
			});
			var noChangeNodes = [], needDeleteNodes = [], needAddNodes = []; // 数据库中已存在的数据
			var nc = [];
			$.each(selectedNodes, function(i, node) {
				if (node.data.attrId) {
					if ($.inArray(node.data.attrId, oldNodeIds) !== -1) {
						noChangeNodes.push(node.data.attrId);
					}

					// if (node.data.persistState) {
					// noChangeNodes.push(node.data.attrId);
					// }

				}
			});
			needAddNodes = $.map(selectedNodes, function(d) {
				if (d.data.attrId) {
					return $.inArray(d.data.attrId, oldNodeIds) !== -1 ? null : d.data.attrId
					// return d.data.persistState ? null :d.data.attrId
				}
			});
			needDeleteNodes = $.map(oldNodeIds, function(oId) {
				return $.inArray(oId, noChangeNodes) >= 0 ? null : oId;
			});
			// alert('没变化的个数:' + noChangeNodes.length + ";需要删除的个数:" +
			// needDeleteNodes + ";需要新增的个数:" + needAddNodes + ";userId:" +
			// userId);
			var addhtml = "", deleteHtml = "";
			$.each(needAddNodes, function(i, mId) {
				addhtml += '<input type="hidden" name="addShortcutMenu.userId" value="' + userId + '" /><input type="hidden" name="addShortcutMenu.moduleId" value="' + mId + '" />';
			});
			$.each(needDeleteNodes, function(i, mid) {
				deleteHtml += '<input type="hidden" name="deleteShortcutMenu.userId" value="' + userId + '" /><input type="hidden" name="deleteShortcutMenu.moduleId" value="' + mid + '" />';
			});
			
			$("#formElArea", form).empty().html(addhtml + deleteHtml);
			form.attr("action", servletPath+"/console/login/operateShortcutMenus.action");
			submitShortcutMenuSettings(form, commonVanus, dia, selectedNodeIds);
		}
	}

	function submitShortcutMenuSettings(form, commonVanus, dia, selectedNodeIds) {
		var options = {
			dataType : "json",
			error : function() {
				$.prompt('快捷菜单配置出错', {
					callback : function(v, m) {
					}
				});
			},
			success : function(data) {
				$.prompt('快捷菜单配置完成!', {
					callback : function(v, m) {
						// 方式一：关闭窗口
						// commonVanus.initShortcutMenus();// 这是一个ajax请求
						// dia.dialog("close");
						// 方式二:不关闭窗口，可以重复修改，需要保留data以及修改过的哪些字段，还需要刷新节点的库存状态
						commonVanus.initShortcutMenus();
						form.data("olddata", selectedNodeIds.join(","));// 后台初始化参数
					}
				});

			},
			complete : function(xhr, textStatus) {
			}

		};
		form.ajaxSubmit(options);

	}

	String.prototype.substringBeforeLast = function(sepr) {
		var str = $.trim(this);
		if (str === "" || sepr === "")
			return str;
		var pos = str.lastIndexOf(sepr);
		if (pos === -1)
			return str;
		else
			return str.substring(0, pos);
	}
	String.prototype.contains = function(searchStr) {
		var str = $.trim(this);
		if (str === "" || str === null || str === undefined)
			return false;
		else
			return str.indexOf(searchStr) >= 0;
	}

})(jQuery)