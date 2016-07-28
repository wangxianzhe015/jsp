( function($) {
	/**
	 * 查看某个机构或者默认的角色的时候，会有初始化的paramId值，配置权限的时候不需要有初始化的paramId和paramName
	 */
	$( function() {
		var showWhich = $("[name='showWhich']").val();
		var paramId, paramName; // 后台初始化选中项的参数
		switch (showWhich) {
			case "org" :
				paramId = $("[name='paramId']").val();
				var orgId = ""; // TODO 这个是supadmin用到的，现在没有用到,加分组显示功能
				var showTreeMethod = "selectNoExpand"; // 
				initPermissionTree(paramId, orgId, showTreeMethod, "#showTree", servletPath+"/console/org/initOrgTree.action", "机构树", showWhich);
				submitTheForm(showWhich);
				break;
			case "userOnly" :
				$("span.memo").empty().html("选择用户，分配角色给选中用户");
				paramId = $("[name='paramId']").val();
				var orgId = ""; // 当前机构负责人所在的机构
				var showTreeMethod = "JustOpenFolder"; // 单击文件夹只展开，不选中
				initPermissionTree(paramId, orgId, showTreeMethod, "#showTree", servletPath+"/console/user/initUserTree.action", "用户树", showWhich);
				submitTheForm(showWhich);
				break;
			case "userWithOrg" :
				$("span.memo").empty().html("选择系统用户或者机构");
				var showTreeMethod = "selectNoExpand"; // 选中不展开
				initPermissionTree(paramId, orgId, showTreeMethod, "#showTree", servletPath+"/console/user/initUserTree.action", "机构用户树", showWhich);
				submitTheForm(showWhich);
				break;
			default :
				break;
		}

		// 此div必须存在height=一个值
		$("div.a_container_left").resizable({
			minHeight : 200,
			minWidth : 300,
			maxWidth : 500,
			maxHeight : 450
		});
		// 点击左侧树，获得右侧的角色树
		$("#showTree a").live("click", function(event) {
			// 每次单击清空表单，重新赋值
				var node = $.ui.dynatree.getNode(event.target);
				doajaxFetchList(node, showWhich);
			});
		$("#selectInfo").live({
			"mouseenter" : function(e) {
				$("#showHasSelected").width(150).fadeIn(200).offset({
					left : e.pageX - 150,
					top : e.pageY
				})
			},
			"mouseleave" : function(e) {
				$("#showHasSelected").fadeOut(100);
			}
		});
	});

	function doajaxFetchList(node, showWhich) {
		doValidate(showWhich).resetForm();
		if (node) {
			var attrId = node.data.attrId;
			var nodeType = node.data.nodeType;
			switch (showWhich) {
				case "org" :
					fetchRoleList(node, servletPath+"/console/permission/fetchRolesOfOrgCond.action", showWhich);
					$("[name='lorgId']").val(node.data.attrId); // 赋值机构
					break;
				case "userOnly" :
					if (nodeType != "user")
						return false;
					fetchRoleList(node, servletPath+"/console/permission/fetchRolesOfUserCond.action", showWhich);
					$("[name='luserId']").val(node.data.attrId);
					break;
				case "userWithOrg" :
					if (nodeType == "user") {
						fetchRoleList(node, servletPath+"/console/permission/fetchRolesOfUserCond.action", showWhich);
						$("[name='luserId']").val(node.data.attrId);
					}
					if (nodeType == "org") {
						fetchRoleList(node, servletPath+"/console/permission/fetchRolesOfOrgCond.action", showWhich);
						$("[name='lorgId']").val(node.data.attrId);
					}
					break;

				default :
					break;
			}

		}
	}
	/**
	 * 根据左侧单击的机构或者user获取角色树
	 * 
	 * @param node
	 * @param url
	 * @param showWhich
	 * @return
	 */
	function fetchRoleList(lftnode, url, showWhich) {
		$.ajax({
			url : url,
			data : {
				"condition" : lftnode.data.attrId
			},
			beforeSend : function(XHR) {
				$("#showRlist").siblings(".memo").children("#load").html('【' + lftnode.data.title + '】' + '_角色列表加载中...');
			},
			type : 'POST',
			global : false,
			dataType : 'json',
			timeout : 50000,
			error : function() {
				$.prompt("加载树出错.<br/>请检查生成树action!");
			},
			success : function(data) {
				var treeData = data.children; // 传过来就是json格式，树节点的key是children
			var treeDataNodes = {
				"children" : treeData,
				onSelect : function(select, nd) {
					// 将角色树注入select
				var selNodes = nd.tree.getSelectedNodes();
				showHasSelectedItems(lftnode, selNodes, showWhich); // 注册角色树的点击事件
			}
			};
			var settings = $.extend({}, multiSelectOptionsY, treeDataNodes);
			$("#showRlist").dynatree("destroy").dynatree(settings); // 生成角色树
		},
		complete : function(XHR, textStatus) {
			$("#showRlist").siblings(".memo").children("#load").html('【' + lftnode.data.title + '】' + '_角色列表加载完毕!');
			var selNodes = $("#showRlist").dynatree("getSelectedNodes");
			initHasSelectInfo(lftnode, selNodes, showWhich); // 树初始化之后把选择信息显示出来
		}
		});
	}

	function initHasSelectInfo(lftnode, selNodes, showWhich) {

		if (!selNodes)
			return;
		// 所有被选中的
		var selTitles = $.map(selNodes, function(d) {
			if (d.data.attrId) {
				return d.data.title;
			}
		});
		var selIds = $.map(selNodes, function(d) {
			if (d.data.attrId) {
				return d.data.attrId;
			}
		});

		$("[name='ouRoleId']").val(selIds.join(","));

		var nodeType = lftnode.data.nodeType;

		// 将nodeType保存在提交按钮上
		$("#submitBtn").data("lftNodeType", nodeType);
		$("#submitBtn").data('lftNode', lftnode);
		if (selNodes.length > 0) {
			$("[name='ouRoleId']").data("oldData", $("[name='ouRoleId']").val()); // 将初始进来的值保存在oldData数据区里面
		} else {
			$("[name='ouRoleId']").removeData("oldData");
		}

		$("#showRlist").siblings(".memo").children("#selectInfo").html('已选择<span style="color:red" >[' + selTitles.length + ']</span>项');
		var html = "已选择的角色:";
		if (selTitles.length > 0) {
			$.each(selTitles, function(i, v) {
				html += "<li>" + selTitles[i] + "</li>"
			})
		} else {
			html += '尚未选择!';
		}
		$("#showRlist").siblings("#showHasSelected").html(html);
	}

	/**
	 * 右侧角色树在选择的时候，初始化计算已选择项和div的detail信息
	 * 
	 * @param selNodes
	 * @param showWhich
	 * @return
	 */
	function showHasSelectedItems(lftnode, selNodes, showWhich) {

		if (!selNodes)
			return;
		var oldRoleIds = [], noChangeRoleIds = [], needDeleteRoleIds = [], needAddRoleIds = []; // 数据库中已存在的数据
		var ostr = $("[name='ouRoleId']").data("oldData");
		if (ostr) {
			oldRoleIds = ostr.split(",");
		}
		// 所有被选中的
		var selTitles = $.map(selNodes, function(d) {
			if (d.data.attrId) {
				return d.data.title;
			}
		});
		var selIds = $.map(selNodes, function(d) {
			if (d.data.attrId) {
				if (d.data.persistState) {
					noChangeRoleIds.push(d.data.attrId);
				}
				return d.data.attrId;
			}
		});

		$("[name='ouRoleId']").val(selIds.join(","));
		needAddRoleIds = $.map(selNodes, function(d) {
			if (d.data.attrId) {
				return d.data.persistState ? null : d.data.attrId
			}
		});

		needDeleteRoleIds = $.map(oldRoleIds, function(oid) {
			return $.inArray(oid, noChangeRoleIds) >= 0 ? null : oid;
		});

		var nodeType = lftnode.data.nodeType;

		// 将nodeType保存在提交按钮上
		$("#submitBtn").data("lftNodeType", nodeType);

		$("#submitBtn").data("needDeleteRoleIds", needDeleteRoleIds.length == 0 ? null : needDeleteRoleIds);
		$("#submitBtn").data("needAddRoleIds", needAddRoleIds == 0 ? null : needAddRoleIds);

		$("#showRlist").siblings(".memo").children("#selectInfo").html('已选择<span style="color:red" >[' + selTitles.length + ']</span>项');
		var html = "已选择的角色:";
		if (selTitles.length > 0) {
			$.each(selTitles, function(i, v) {
				html += "<li>" + selTitles[i] + "</li>"
			})
		} else {
			html += '尚未选择!';
		}
		$("#showRlist").siblings("#showHasSelected").html(html);
	}
	/**
	 * 校验表单
	 * 
	 * @param showWhich
	 * @return
	 */
	function doValidate(showWhich) {
		var validateFormRule = {};
		switch (showWhich) {
			case "org" :
				validateFormRule = {
					ignore : "",
					errorElement : "em",
					rules : {
						"lorgId" : {
							required : true
						},
						"ouRoleId" : {
							required : true
						}
					},
					messages : {
						"lorgId" : "尚未选择机构",
						"ouRoleId" : "机构下的角色未选"
					}
				};
				break;
			case "userOnly" :
				validateFormRule = {
					ignore : "",
					errorElement : "em",
					rules : {
						"luserId" : {
							required : true
						},
						"ouRoleId" : {
							required : true
						}
					},
					messages : {
						"luserId" : "尚未选择人员",
						"ouRoleId" : "人员角色未选"
					}
				};
				break;
			case "userWithOrg" :
				validateFormRule = {
					ignore : "",
					errorElement : "em",
					rules : {
						"luserId" : {
							required : function() {
								if ($("[name='lorgId']").val()) {
									return false;
								}
								return true;
							}
						},
						"lorgId" : {
							required : function() {
								if ($("[name='luserId']").val()) {
									return false;
								}
								return true;
							}
						},
						"ouRoleId" : {
							required : true
						}
					},
					messages : {
						"luserId" : "尚未选择人员",
						"lorgId" : "尚未选择机构",
						"ouRoleId" : "角色未选"
					}
				};

				break;

			default :
				break;
		}

		var vo = validateForm("#data_form", validateFormRule);
		return vo;

	}
	/**
	 * 校验表单并生成需提交项
	 * 
	 * @param showWhich
	 * @return
	 */
	function submitTheForm(showWhich) {

		var vo = doValidate(showWhich); // 加载校验规则，尚未执行校验
		$("#submitBtn").on("click", function() {
			var SubBtn = $(this);
			var pform = $("#data_form");
			var containerDomain = $("#_formHiddenArea", pform);
			var ostr = $("[name='ouRoleId']").data("oldData"); // 初始化的数据
				if (ostr) {
					doSubmitForm(SubBtn, containerDomain, pform);
				} else {
					var valid = vo.form(); // 校验表单
				if (valid) {
					doSubmitForm(SubBtn, containerDomain, pform);
				}
			}

		});

		function doSubmitForm(SubBtn, containerDomain, pform) {

			var needAddRoleIds = SubBtn.data("needAddRoleIds");
			var needDeleteRoleIds = SubBtn.data("needDeleteRoleIds");
			var nodeType = SubBtn.data("lftNodeType");
			var lftNode = SubBtn.data("lftNode");
			switch (nodeType) {
				case "org" :
					var lorgId = $("[name='lorgId']").val();
					createFormItems(containerDomain, nodeType, lorgId, needAddRoleIds, needDeleteRoleIds);
					pform.attr("action", servletPath+"/console/permission/allotPToOrg.action");
					break;
				case "user" :
					var luserId = $("[name='luserId']").val();
					createFormItems(containerDomain, nodeType, luserId, needAddRoleIds, needDeleteRoleIds);
					pform.attr("action", servletPath+"/console/permission/allotPToUser.action");
					break;
				default :
					break;
			}
			var options = {
				dataType : "json",
				error : function() {
					$.prompt('分配出错...', {
						callback : function(v, m) {
							SubBtn.removeData(); // 清空提交的属性
							doajaxFetchList(lftNode, showWhich);
						}
					});

				},
				success : function(data) {
					$.prompt('分配完成!', {
						callback : function(v, m) {
							SubBtn.removeData(); // 清空提交的属性
							doajaxFetchList(lftNode, showWhich);
						}
					});
				},
				complete : function(xhr, textStatus) {
				}
			};
			pform.ajaxSubmit(options);

		}

		/**
		 * 根据选中项生成表单的Items
		 * 
		 * @param type
		 * @param orgIdOruserId
		 * @param attr2s
		 * @return
		 */
		function createFormItems(containerDomain, type, orgIdOruserId, needAddRoleIds, needDeleteRoleIds) {
			var html = "";
			switch (type) {
				case "org" :
					if (needAddRoleIds)
						$.each(needAddRoleIds, function(i, v) {
							html += '<input type="hidden" name="addOrgRole.roleId" value="' + v + '" /><input type="hidden" name="addOrgRole.orgId" value="' + orgIdOruserId + '"/>';
						});
					if (needDeleteRoleIds)
						$.each(needDeleteRoleIds, function(i, v) {
							html += '<input type="hidden" name="deleteOrgRole.roleId" value="' + v + '" /><input type="hidden" name="deleteOrgRole.orgId" value="' + orgIdOruserId + '"/>';
						});
					break;
				case "user" :
					if (needAddRoleIds)
						$.each(needAddRoleIds, function(i, v) {
							html += '<input type="hidden" name="addUserRole.roleId" value="' + v + '" /><input type="hidden" name="addUserRole.userId" value="' + orgIdOruserId + '" />';
						});

					if (needDeleteRoleIds)
						$.each(needDeleteRoleIds, function(i, v) {
							html += '<input type="hidden" name="deleteUserRole.roleId" value="' + v + '" /><input type="hidden" name="deleteUserRole.userId" value="' + orgIdOruserId + '" />';
						});
					break;
				default :
					break;
			}

			containerDomain.html(html);

		}

		// 重置按钮
		$("#resetBtn").click( function() {
			vo.resetForm();
			var lftTree = $("#showTree").dynatree("getTree");
			var lftNode = lftTree.getActiveNode();
			if (lftNode) {
				var node = lftTree.getActiveNode();
				var attrId = node.data.attrId;
				var nodeType = node.data.nodeType;
				switch (showWhich) {
					case "org" :
						$("[name='lorgId']").val(node.data.attrId); // 赋值机构
				break;
			case "userOnly" :
				if (nodeType != "org")
					$("[name='luserId']").val(node.data.attrId); // 赋值用户
				break;
			case "userWithOrg" :
				if (nodeType === "org")
					$("[name='lorgId']").val(node.data.attrId); // 赋值机构
				else if (nodeType === "user")
					$("[name='luserId']").val(node.data.attrId); // 赋值用户
				break;
			default :
				break;
		}
	}
	var selectRoleNodes = getTreeSelectedNodes('#showRlist', 'select');
	showHasSelectedItems(lftNode, selectRoleNodes, showWhich);
}		);
	}
	function initPermissionTree(initId, groupId, showTreeMethod, showEl, url, memo, showWhich) {
		var baseOptions = initEntityTreeOptions(initId, groupId, showTreeMethod, showEl, url, memo);
		var permissionOptions = $.extend(baseOptions, {
			complete : function() {
				// 如果有初始化数据paramId，才会执行complete的回调
				if (initId) {
					var selNode = $("#showTree").dynatree("getActiveNode");
					initRightTree(selNode, showWhich);
				}
			}
		});
		$.ajax(permissionOptions);
	}

	/**
	 * 初始化进来的时候，如果左侧有默认选中的，则右侧树也需要初始化，另一入口用
	 * 
	 * @return
	 */
	function initRightTree(selNode, showWhich) {
		doajaxFetchList(selNode, showWhich);
	}

})(jQuery);