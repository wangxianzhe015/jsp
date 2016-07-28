( function($) {
	$( function() {
		// 禁默认右键
		document.oncontextmenu = showNone;
		function showNone() {
			event.returnValue = false;
		}

		$("#selectedNodeInfo").on({
			"click" : function(event) {
				var nodekey = $(this).data("nodekey");
				if (nodekey) {
					node = $("#showMdTree").dynatree("getTree").getNodeByKey(nodekey);
					node.expand();
					node.activate();
				}

			},
			"mouseenter" : function(event) {
				$(this).css({
					"cursor" : "default"
				});
			}
		})

		// 此div必须存在height=一个值
		$("div.a_container_left").resizable({
			minHeight : 200,
			minWidth : 300,
			maxWidth : 400,
			maxHeight : 550
		});

		/**
		 * 初始化弹出窗口
		 */
		$(".funcDialog").dialog({
			draggable : false,
			resizable : false,
			autoOpen : false,
			modal : true
		});

	
		ajaxFetchModuleTree();
		moduleAjaxFetchFunclist();
		$("[id='_GridAddBtn']").click( function() {
			$("#addFuncDialog #hiddenArea").empty();

			// 新增
				var moduleId = $("[name='function.module.moduleId']").val();
				if (moduleId) {
					fetchActionMethodsByModule(moduleId);
					$("#addFuncDialog").dialog({
						title : "新增功能",
						height : 500,
						width : 620,
						minWidth : 620,
						buttons : {
						    "添加":function(){
						        var len=$("tr",$("#addFuncDialog .content table tbody")).length+1;
								var html = $("#addFuncDialog .content table tbody").html();
								html += "<tr><td width='50px' align='center'><input type='checkbox' name='funcIds' id='checkMethod"+len+"' title='checkMethod"+len+"' data-url='' data-name='' data-desc=''"
										+ "' /></td><td><input type='text' name='funcName' /></td><td><input type='text' name='funcUrl'/></td><td><input type='text' name='funcDesc'/></td></tr>";
				  
								$("#addFuncDialog .content table tbody").empty().html(html);
								var _tb = $("#addFuncDialog .dialog_s table");						
								$(":checkbox", _tb).bind("click", function() {
									rescs = fetchAllSelectedRescs();
									$("[name='hasSelectedResc']").data('rescs', rescs);
					
								});
							},
							"确定" : function() {
								// 执行入库
							var moduleId = $("#addFuncDialog [name='moduleId']").val();
							if ($("form[name='addFuncsForm'] table tbody :checked").length > 0) {
								var options = {
									dataType : "json",
									error : function() {
										alert('添加功能出错!');
									},
									success : function(data) {
										$.prompt(" 成功添加" + data.lent + "个功能资源！", {
											callback : function(v, m) {
												fetchFuncslistByModuleId(moduleId);
											}
										})
									}
								};
								$("form[name='addFuncsForm']").ajaxSubmit(options);
							}
							$(this).dialog("close");
						},
						"关闭" : function() {
							$(this).dialog("close");
						}
						}
					}).dialog("open");
				} else {
					$.prompt("尚未选择左侧系统模块!");
				}

			});
		$("[name='funcName']").live("blur",function(){
			var ck=$(this).closest("tr").find("[name='funcIds']:checkbox");
			ck.data("name",$(this).val());
			
		});
		$("[name='funcDesc']").live("blur",function(){
			var ck=$(this).closest("tr").find("[name='funcIds']:checkbox");
			ck.data("desc",$(this).val());

		});
		$("[name='funcUrl']").live("blur",function(){
			
			var ck=$(this).closest("tr").find("[name='funcIds']:checkbox");
			ck.data("url",$(this).val());
			
		});	
		
		$("[id='_GridUpdateBtn']").click( function() {
			// 检测有没有选择
				var _checked = $("[name='function.functionId']:checked");
				if (_checked.length > 1) {
					$.prompt("只能选择一个!")
				} else if (_checked.length == 0) {
					$.prompt("请选择一个模块!")
				} else {
					// 调出弹出窗，执行修改
					var moduleId = $("[name='function.module.moduleId']").val();
					var funcId = _checked.val();
					getFuncDataFromDb(funcId);

					$("#updateFuncDialog").dialog({
						title : "修改功能",
						height:$.browser.msie?500:"auto",
						width : 620,
						minWidth : 620,
						buttons : {
							"确定" : function() {
								var validateFormRule = {
									rules : {
										"function.description" : {
											required : false
										},
										"function.functionUrl" : {
											required : true
										}								
									}
								};
								var vo = validateForm("form[name='updateFuncForm']", validateFormRule);
								if (vo.form()) {

									var options = {
										dataType : "json",
										error : function() {
											alert('修改功能出错!');
										},
										success : function(data) {
											fetchFuncslistByModuleId(moduleId);
										}
									};
									$("[name='updateFuncForm']").ajaxSubmit(options);
									$(this).dialog("close");
								}
							},
							"关闭" : function() {
								$(this).dialog("close");
							}
						}
					}).dialog("open");
				}
			});
		$("[id='_GridDeleteBtn']").click( function() {
			var delBtn = $(this);
			var _checked = $("[name='function.functionId']:checked");
			if (_checked.length <= 0) {
				$.prompt('尚未选择!');
			} else {
				var yesorno = $.prompt('删除资源也将删除权限的对应关系!<br/>确定删除?', {
					buttons : {
						"确定" : true,
						"取消" : false
					},
					focus : 1,
					submit : function(v) {
						if (v) {
							// 执行删除
					var moduleId = $("[name='function.module.moduleId']").val();
					var functionIds = [];
					$.each(_checked, function(i, va) {
						functionIds.push($(va).val());
					});
					$.ajax({
						url : servletPath+"/console/function/delete.action",
						data : {
							"functionId" : functionIds
						},
						type : 'POST',
						dataType : 'json',
						beforeSend : function() {
						},
						global : false,
						timeout : 10000,
						error : function() {
						},
						success : function(data) {
							fetchFuncslistByModuleId(moduleId);
						},
						complete : function(XHR, textStatus) {
						}
					});

				}
			}
				});
			}
		});
		// action的funclist的选中
		$("#checkAllMethods").click( function(event) {
			$("[id^='checkMethod']").prop("checked", $(this).prop("checked"));

		});
		// 树的右键
		$("#showMdTree").jeegoocontext('treeMenu', {
			onSelect : function(e, context) {
				switch ($(this).attr("id")) {
					case 'refresh' :
						// var tree = $("#showMdTree").dynatree("getTree");
				// tree.reload();

				var paramId = $("#selectedNodeInfo").data("nodeAttrId");
				ajaxFetchModuleTree(paramId);
				break;
			case 'add' :
				var scop = $("#addAppDialog");
				doAddApp(scop, '新增应用');
				break;
			default :
				break;
		}

	}

}		);

	});
	/**
	 * 点击模块树的节点获得函数list
	 */
	function moduleAjaxFetchFunclist() {
		$("#showMdTree a").live("click", function(event) {
			var node = $.ui.dynatree.getNode(event.target);
			if (!$(node.span).hasClass('dynatree-folder')) {
				setCurrentSelectedModule(node);
				fetchFuncslistByModuleId(node.data.attrId);
			}
		});
	}
	/**
	 * 右侧标题栏设置当前选中的node
	 * 
	 * @param node
	 * @return
	 */
	function setCurrentSelectedModule(node) {
		if (node) {
			$("[name='function.module.moduleId']").val(node.data.attrId);
			$("#addFuncDialog [name='moduleId']").val(node.data.attrId);
			$("#addFuncDialog [name='modulePath']").val(node.data.key);
			$(".a_container_right .ac_head span#selectedNodeInfo").html('当前模块:' + node.data.title).data({
				"nodekey" : node.data.key,
				"nodeAttrId" : node.data.attrId
			});
		} else {
			$("[name='function.module.moduleId']").val('');
			$("#addFuncDialog [name='moduleId']").val('');
			$("#addFuncDialog [name='modulePath']").val('');
			$(".a_container_right .ac_head span#selectedNodeInfo").empty().removeData();
		}

	};
	function fetchFuncslistByModuleId(moduleId) {
		var html = "";
		if (moduleId) {
			$.ajax({
				url : servletPath+"/console/function/initFunclistByModuleId.action",
				data : {
					"moduleId" : moduleId
				},
				type : 'POST',
				dataType : 'json',
				beforeSend : function() {
					$("table#funclistTable tbody").html('<tr><td colspan="4">功能列表加载中...</td></tr>');
				},
				global : false,
				timeout : 20000,
				error : function() {
					$("table#funclistTable tbody").html('<tr><td colspan="4">加载列表出错或超时!</td></tr>');
				},
				success : function(data) {
					var flist = data.flist;

					if (flist.length > 0) {
						$.each(flist, function(i, v) {
							var tr = "";
							tr += "<tr><td align='center' width='50px'><input type='checkbox' name='function.functionId' id='checkthis" + (i + 1) + "' title='select " + (i + 1) + "' value='" + v.functionId + "'/></td><td>" + v.functionName
									+ "</td><td>" + v.functionUrl+ "</td><td>" + v.description + "</td></tr>";
							html += tr;
						});
					} else {
						html = "<tr><td colspan='3'>暂无数据</td></tr>";
					}
					$("table#funclistTable tbody").empty().html(html);
				},
				complete : function(XHR, textStatus) {
					var _tb = $(".grid_body table");
					$(":checkbox", _tb).prop("checked", false);
				}
			});
		} else {
			html = "<tr><td colspan='3'>请选择模块</td></tr>";
			$("table#funclistTable tbody").empty().html(html);
		}

	}
	/**
	 * 初始化模块树
	 * 
	 * @param paramId
	 * @param moduleId
	 * @return
	 */
	function ajaxFetchModuleTree(paramId, moduleId) {
		$("#showMdTree").dynatree("destroy");
		// 初始化机构树选中是后台根据orgId进行判断的
		// paramId = 2;
		var showTreeMethod = "JustOpenFolder";
		//
		var menuOpt = $("#moduleMenu");
		initEntityTreeWithRightMenu(paramId, moduleId, showTreeMethod, "#showMdTree", servletPath+"/console/resource/initModuleTree.action", "模块视图");
	}

	function initEntityTreeWithRightMenu(initId, groupId, showTreeMethod, showEl, url, memo) {
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
			timeout : 20000,
			error : function() {
				$.prompt("加载树出错或超时.<br/>请检查生成树action!");
			},
			success : function(data) {
				var treeData = data.children;
				// 传过来就是json格式，树节点的key是children
				var treeDataNodes = {
					"children" : treeData,
					"onCreate" : function(node, nodespan) {
						/* 在树节点渲染的时候触发的事件 */
						bindContextMenu(nodespan);
					}
				};
			// 使用单选模式
			var settings = $.extend({}, fetchMethod(showTreeMethod), treeDataNodes);
			$(showEl).dynatree(settings);
		}
		});
	}
	// 绑定右键
	function bindContextMenu(span) {
		//dynatree-node dynatree-has-children dynatree-lastsib dynatree-active dynatree-exp-cl dynatree-ico-c active
		var folderSpan = $(span).filter('.dynatree-folder');
		var leafSpan = $(span).not('.dynatree-folder');
		
		folderSpan.jeegoocontext('folderMenu', {
			onSelect : function(e, context) {
				var node = $.ui.dynatree.getNode(context);
				var selectModuleId = node.data.attrId;
				var selectModuleTitle = node.data.title;
				var nodeType = node.data.nodeType;
				
				switch ($(this).attr("id")) {
					case "delete" :
						confirmDeleteModule(node);
						break;
					case "edit" :
						if (nodeType == "app") {
							doUpdateApp(selectModuleId, selectModuleTitle);
						} else {
							doUpdateModule(selectModuleId, selectModuleTitle, node)
						}
						break;
					case "add" :
						var scop = $("#addModuleDialog");
						doAddModule(scop, selectModuleId, selectModuleTitle, node);
						break;
					default :
						alert($(this).attr("id"));
						break;
				}
			}

		});
		// 叶子节点不能新增节点，除非将是否叶子设为false
		leafSpan.jeegoocontext('leafMenu', {
			// e是发生右击事件click的对象，context是调用右击的对象
			onSelect : function(e, context) {
				// 校验updateModuleForm
				var node = $.ui.dynatree.getNode(context);
				var selectModuleId = node.data.attrId;
				var selectModuleTitle = node.data.title;
				if ($(this).hasClass("disabled")) {
					return false; // 不关闭右键菜单
				} else {
					switch ($(this).attr("id")) {

						case "delete" :
							confirmDeleteModule(node);
							break;
						case "edit" :
							doUpdateModule(selectModuleId, selectModuleTitle, node);
							break;
						case "add" :
							var scop = $("#addModuleDialog");
							doAddModule(scop, selectModuleId, selectModuleTitle, node);
							break;

						default :
							break;
					}
				}

			},
			onShow : function(e, context) {

			}

		});

	};

	// ================右键方法==============
	function confirmDeleteModule(node) {
		var selectedId = node.data.attrId;
		var moduleMemo = node.data.title;
		var keyFlag = node.data.key;
		if (node.hasChildren()) {
			$.prompt(moduleMemo + ' 包含子节点,不能被删除！<br/>先删除所有子节点');
		} else {

			var yesorno = $.prompt('确定删除[' + moduleMemo + ']模块?', {
				buttons : {
					"确定" : true,
					"取消" : false
				},
				focus : 1,
				submit : function(v) {
					if (v) {
						doDeleteNode(node);
					}
				}
			});

		}

	}
	// 删除树节点方法
	function doDeleteNode(node) {
		var data = new Object();
		var actionUrl = "";
		var nodeType = node.data.nodeType;
		if (nodeType == 'app') {
			data["appId"] = node.data.attrId;
			actionUrl = servletPath+"/console/application/deleteApp.action";
		} else {
			data["moduleId"] = node.data.attrId;
			actionUrl = servletPath+"/console/resource/delete.action";
		}
		$.ajax({
			url : actionUrl,
			data : data,
			type : 'POST',
			dataType : 'json',
			global : false,
			timeout : 5000,
			error : function() {
				alert('删除节点失败');
			},
			beforeSend : function() {
				// $.blockUI({
			// message : '删除中...'
			// });
		},
		success : function(data) {
			$.prompt("删除成功!", {
				callback : function(v, m) {
					ajaxFetchModuleTree();
					if (nodeType != 'app') {
						setCurrentSelectedModule();
						fetchFuncslistByModuleId();
					}
				}
			});

		},
		complete : function(XHR, textStatus) {
			// $.unblockUI();
		}

		});
	}

	function doUpdateModule(selectModuleId, selectModuleTitle, node) {
		var validateUpdateModuleFormRule = {
			rules : {
				"module.moduleName" : {
					required : true
				},
				"module.moduleDesc" : {
					required : true

				},
				"module.accessFlag" : {
					required : true
				},
				"module.isMenu" : {
					required : true
				},
				"module.isLeaf" : {
					required : true
				}
			}
		};
		var voUpdateModule = validateForm("form[name='updateModuleForm']", validateUpdateModuleFormRule);

		getModuleFromDb(selectModuleId);
		$("#updateModuleDialog").dialog({
			title : "修改模块 - " + selectModuleTitle,
			height:550,
			width : 550,
			minWidth : 550,
			buttons : {
				"确定" : function() {
					if (voUpdateModule.form()) {
						var options = {
							dataType : "json",
							error : function() {
								alert('修改模块出错!');
							},
							success : function(data) {
								ajaxFetchModuleTree(selectModuleId, null);

							}
						};
						$("[name='updateModuleForm']").ajaxSubmit(options);
						$(this).dialog("close");
					}
				},
				"重置" : function() {
					voUpdateModule.resetForm();
				},
				"关闭" : function() {
					voUpdateModule.resetForm();
					$("[name='updateModuleForm']").clearForm();
					$(this).dialog("close");

				}
			}
		}).dialog("open");

	}

	/**
	 * 修改应用
	 * 
	 * @param selectModuleId
	 * @param selectModuleTitle
	 * @return
	 */
	function doUpdateApp(selectModuleId, selectModuleTitle) {
		var validateAppFormRule = {
			rules : {
				"app.appName" : {
					required : true
				},
				"app.appDesc" : {
					required : true
				},
				"app.appContext" : {
					required : true
				},
				"app.protocol" : {
					required : true
				},
				"app.appIp" : {
					required : true
				},
				"app.appPort" : {
					required : true
				}
			}
		};

		var voUpdateApp = validateForm("form[name='updateAppForm']", validateAppFormRule);
		getAppFromDb(selectModuleId);
		$("#updateAppDialog").dialog({
			title : "修改应用 - " + selectModuleTitle,
			height:550,
			width : 550,
			minWidth : 550,
			buttons : {
				"确定" : function() {
					if (voUpdateApp.form()) {
						var options = {
							dataType : "json",
							error : function() {
								alert('修改应用出错!');
							},
							success : function(data) {
								ajaxFetchModuleTree();
							}
						};
						$("form[name='updateAppForm']").ajaxSubmit(options);
						$(this).dialog("close");

					}
				},
				"重置" : function() {
					voUpdateApp.resetForm();
				},
				"关闭" : function() {
					voUpdateApp.resetForm();
					$("form[name='updateAppForm']").clearForm();
					$(this).dialog("close");

				}
			}
		}).dialog("open");

	}
	function doAddApp(scop, title) {
		var validateAppFormRule = {
			rules : {
				"app.appName" : {
					required : true
				},
				"app.appDesc" : {
					required : true
				},
				"app.appContext" : {
					required : true
				},
				"app.protocol" : {
					required : true
				},
				"app.appIp" : {
					required : true
				},
				"app.appPort" : {
					required : true
				}
			}
		};

		var voAddApp = validateForm("form[name='addAppForm']", validateAppFormRule);
		voAddApp.resetForm();
		$("form[name='addAppForm']").clearForm();

		$("#addAppDialog").dialog({
			height:550,
			title : title,
			width : 550,
			minWidth : 550,
			buttons : {
				"确定" : function() {
					if (voAddApp.form()) {
						var options = {
							dataType : "json",
							error : function() {
								alert('添加应用出错!');
							},
							success : function(data) {
								ajaxFetchModuleTree();

							}
						};
						$("[name='addAppForm']").ajaxSubmit(options);
						voAddApp.resetForm();
						$("form[name='addAppForm']").clearForm();
						$(this).dialog("close");

					}
				},
				"重置" : function() {
					voAddApp.resetForm();
				},
				"关闭" : function() {
					voAddApp.resetForm();
					$("form[name='addAppForm']").clearForm();
					$(this).dialog("close");

				}
			}
		}).dialog("open");

	}

	function doAddModule(scop, selectModuleId, selectModuleTitle, node) {

		var validateUpdateModuleFormRule = {
			rules : {
				"module.moduleName" : {
					required : true
				},
				"module.moduleDesc" : {
					required : true

				},
				"module.accessFlag" : {
					required : true
				},
				"module.isMenu" : {
					required : true
				},
				"module.isLeaf" : {
					required : true
				}
			}
		};

		var voAddModule = validateForm("form[name='addModuleForm']", validateUpdateModuleFormRule);
		voAddModule.resetForm();
		$("[name='addModuleForm']").clearForm();
		// 先清空所有，再重新赋值
		if (node.data.nodeType == 'app') {
			$("form[name='addModuleForm'] [name='module.parentModuleId']").replaceWith('<input type="hidden" name="module.parentModuleId" value="0"/>');

		} else {
			$("form[name='addModuleForm'] [name='module.parentModuleId']").replaceWith('<input type="hidden" name="module.parentModuleId" value="' + selectModuleId + '"/>');
			$("form[name='addModuleForm'] [name='module.modulePath']").replaceWith('<input type="hidden" name="module.modulePath" value="' + node.data.key + '"/>');
		}

		$("form[name='addModuleForm'] [name='module.app.appId']").replaceWith('<input type="hidden" name="module.app.appId" value="' + node.data.appId + '"/>');

		// 根据所选择的节点的不同，初始化一下表单的数据
		$("#addModuleDialog").dialog({
			title : selectModuleTitle + " - 新增模块",
			height:550,
			width : 550,
			minWidth : 550,
			buttons : {
				"确定" : function() {
					if (voAddModule.form()) {
						var options = {
							dataType : "json",
							error : function() {
								alert('添加模块出错!');
							},
							success : function(data) {
								ajaxFetchModuleTree(data.moduleId, null);
							},
							complete : function() {
							}
						};
						$("[name='addModuleForm']").ajaxSubmit(options);
						voAddModule.resetForm();
						$("[name='addModuleForm']").clearForm();
						$(this).dialog("close");

					}
				},
				"重置" : function() {
					voAddModule.resetForm();
				},
				"关闭" : function() {
					voAddModule.resetForm();
					$("[name='addModuleForm']").clearForm(); //
				$(this).dialog("close");
			}
			}
		}).dialog("open");
	}

	/**
	 * 根据moduleId获得methods
	 */
	function fetchActionMethodsByModule(moduleId) {
		$.ajax({
			url : servletPath+"/console/function/fetchFunclistByModuleId.action",
			data : {
				"moduleId" : moduleId
			},
			type : 'POST',
			dataType : 'json',
			beforeSend : function() {
				$("#addFuncDialog .content table tbody").empty().html('<tr><td colspan="3">正在加载...</td></tr>	');
			},
			global : false,
			timeout : 5000,
			error : function() {

				$("#addFuncDialog .content table tbody").empty().html('<tr><td colspan="3">加载出错！</td></tr>	');
			},
			success : function(data) {
				var fclist = data.fclist;
				var html = "";
				if (fclist) {
					if (fclist.length > 0) {
						$.each(fclist, function(i, v) {
							var tr = "";
							tr += "<tr><td width='50px' align='center'><input type='checkbox' name='funcIds' id='checkMethod" + (i + 1) + "' title='checkMethod" + (i + 1)+ "' data-url='" + v.actionUrl  + "' data-name='" + v.actionName + "' data-desc='" + v.actionDesc
									+ "' /></td><td>" + v.actionName+ "</td><td>" +v.actionUrl + "</td><td>" + v.actionDesc + "</td></tr>";
							if (v.actionStatus == 'exist') {
								tr = "<tr><td width='50px' align='center' class='ico_right_black' title='已添加过'></td><td>" + v.actionName + "</td><td>"+v.actionUrl + "</td><td>"  + v.actionDesc + "</td></tr>";
							}
							html += tr;
						});
					} else {
						html = '<tr><td colspan="3">结果集为空!</td></tr>';
					}

				} else {
					html = '<tr><td colspan="3">获取方法失败！检查模块路径@URI是否正确。</td></tr>';
				}
				$("#addFuncDialog .content table tbody").empty().html(html);

			},
			complete : function(XHR, textStatus) {
				var _tb = $("#addFuncDialog .dialog_s table");
				$(":checkbox", _tb).prop("checked", false);
				// table中的:check绑定click事件，单击的时候获取所有tbody中被选中的check的值
				var rescs = [];
				$(":checkbox", _tb).bind("click", function() {
					rescs = fetchAllSelectedRescs();
					$("[name='hasSelectedResc']").data('rescs', rescs);
	
				});

		}

		});

	}

	function fetchAllSelectedRescs() {
		var _scope = $("#addFuncDialog .dialog_s table tbody");
		var _hiddenArea = $("#addFuncDialog #hiddenArea");

		var field = "";
		var rescs = [];

		if ($(":checked", _scope).length > 0) {
			$(":checked", _scope).each( function(i, v) {
				var resc = {};
				var name = $(this).data('name');
				var desc = $(this).data('desc');
				var url =  $(this).data('url');
				
				var moduleId = $("#addFuncDialog [name='moduleId']").val();
				var modulePath = $("#addFuncDialog [name='modulePath']").val();
				resc = {
					"funcName" : name,
					"funcDesc" : desc,
					"funcUrl"  : url
				};
				rescs.push(resc);
				field += '<input type="hidden" name="funcs.functionName" value=' + name + '></input>';
				field += '<input type="hidden" name="funcs.description" value=' + desc + '></input>';
				field += '<input type="hidden" name="funcs.functionUrl" value=' + url + '></input>';
				field += '<input type="hidden" name="funcs.module.moduleId" value=' + moduleId + '></input>';
				field += '<input type="hidden" name="funcs.module.modulePath" value=' + modulePath + '></input>';

			});
		}
		_hiddenArea.html(field);
		return rescs;

	}
	/**
	 * 根据moduleId获得模块实体
	 */
	function getModuleFromDb(moduleId) {
		$.ajax({
			url : servletPath+"/console/resource/fetchModuleByModuleId.action",
			data : {
				"moduleId" : moduleId
			},
			type : 'POST',
			dataType : 'json',
			global : false,
			timeout : 5000,
			error : function() {

			},
			beforeSend : function() {
				// $.blockUI({ message: '加载中...', css: { width: '275px' } });
		},
		success : function(data) {
			var module = data.module;
			var scop = $("#updateModuleDialog");
			$("table [name='module.moduleId']", scop).replaceWith('<input type="hidden" name="module.moduleId" value="' + module.moduleId + '"/>');
			$("table [name='module.app.appId']", scop).replaceWith('<input type="hidden" name="module.app.appId" value="' + module.app.appId + '"/>');
			$("table tbody tr:nth-child(1) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + module.moduleName + '" name="module.moduleName"/>');
			$("table tbody tr:nth-child(2) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + module.moduleDesc + '" name="module.moduleDesc"/>');
			$("table tbody tr:nth-child(3) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + module.moduleNo + '" name="module.moduleNo"/>');
			$("table tbody tr:nth-child(4) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + module.entryUrl + '" name="module.entryUrl"/>');
			$("[name='module.accessFlag']", scop).val(module.accessFlag);
			$("input:radio[name='module.isMenu'][value=" + module.isMenu + "]", scop).prop("checked", true);
			$("input:radio[name='module.isLeaf'][value='" + module.isLeaf + "']", scop).prop("checked", true);

		},
		complete : function(XHR, textStatus) {
			// $.unblockUI();
		}

		});
	}
	/**
	 * 获得需要修改的应用的数据
	 * 
	 * @param selectModuleId
	 * @return
	 */
	function getAppFromDb(appId) {
		$.ajax({
			url : servletPath+"/console/application/getApp.action",
			data : {
				"appId" : appId
			},
			type : 'POST',
			dataType : 'json',
			beforeSend : function() {

			},
			global : false,
			timeout : 5000,
			error : function() {

			},
			success : function(data) {
				var app = data.app;
				var scop = $("#updateAppDialog");
				$("table [name='app.appId']", scop).replaceWith('<input type="hidden" name="app.appId" value="' + app.appId + '"/>');
				$("table tbody tr:nth-child(1) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + app.appName + '" name="app.appName"/>');
				$("table tbody tr:nth-child(2) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + app.appDesc + '" name="app.appDesc"/>');
				$("table tbody tr:nth-child(3) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + app.appContext + '" name="app.appContext"/>');
				$("table tbody tr:nth-child(5) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + app.appIp + '" name="app.appIp"/>');
				$("table tbody tr:nth-child(6) td:nth-child(2) input", scop).replaceWith('<input type="text" value="' + app.appPort + '" name="app.appPort"/>');

				$("[name='app.protocol']", scop).val(app.protocol);

			},
			complete : function(XHR, textStatus) {

			}

		});

	}

	/**
	 * 根据funcId获得资源数据
	 */
	function getFuncDataFromDb(funcId) {
		$.ajax({
			url : servletPath+"/console/function/fetchFuncByFuncId.action",
			data : {
				"funcId" : funcId
			},
			type : 'POST',
			dataType : 'json',
			beforeSend : function() {

			},
			global : false,
			timeout : 5000,
			error : function() {
			},
			success : function(data) {
				var func = data.func;
				var scop = $("#updateFuncDialog");
				$('table [name="function.module.moduleId"]', scop).val(func.module.moduleId);
				$("table tr:nth-child(1) td:nth-child(2)", scop).text(func.functionName);
				$("[name='function.functionId']", scop).val(func.functionId);
				$("[name='function.description']", scop).val(func.description);
				$("[name='function.functionUrl']", scop).val(func.functionUrl);
			},
			complete : function(XHR, textStatus) {

			}

		});
	}
	Array.prototype.contains = function(arr) {
		for ( var i = 0; i < this.length; i++) { // this指向调用这个方法的数组对象
			if (this[i] == arr) {
				return i;
			}
		}
		return -1;
	}
})(jQuery);