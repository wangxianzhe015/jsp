var portalVanus = {};
( function($) {
	var cvs = window.parent.commonVanus;
	var _cache_data = {};
	var user_id = $.cookies.get('_user_id');// cookie中的用户id
	var _portlet_option = {
		"add" : "waitSave",
		"update" : "waitUpdate"
	};
	var persistState_exist = "exist";// 库存状态
	$( function() {
		if (JSON.parse(store.get('_cache_data_userPortal' + user_id))) {
			_cache_data = JSON.parse(store.get('_cache_data_userPortal' + user_id));
		}
		initUserPortal();
		$("#portal_layout_setting li a").on("click", function() {
			var pl = $(this).data("val");
			$(this).addClass("current");
			$(this).closest("li").siblings().find(".current").removeClass("current");
			changePortalLayout(pl);
		});

		$("[id='_addUserPortal']").on("click", function(e) {
			var cur_pl_str = $("#portal_layout_setting>li a.current").text(), cur_pl_val = _cache_data["currentLayoutVal"]["current"];
			buildPortletSelectHtml();
			buildPortalLayoutSelectHtml(_cache_data["columnLength"]);
			var vo = getAddUPVO();
			vo.resetForm();
			$("[name='userPortal.portalLayout']").val(cur_pl_val);
			var addUserPortalDialog = $("#addUserPortalDialog"), $addUPfrm = $("form[name='addUserPortalForm']");
			addUserPortalDialog.dialog({
				draggable : false,
				resizable : false,
				autoOpen : false,
				modal : true,
				title : "新增Portlet[当前布局" + cur_pl_str + "]",
				height : 500,
				width : 450,
				minWidth : 450,
				buttons : {
					"暂不入库" : function() {
						if (vo.form()) {
							$.ajax({
								url : servletPath+"/console/userportal/getSelectedPortal.action",
								data : {
									"portal.catalogId" : $("select[name='userPortal.portal.catalogId']", $addUPfrm).val()[0]
								},
								type : 'POST',
								dataType : 'json',
								global : false,
								// timeout : 5000,
								error : function() {
									$.prompt('获得所选portal信息出错!');
								},
								beforeSend : function() {
								},
								success : function(data) {
									var portal = data.portal;
									var userPortal = {
										"portalTitleSelf" : $('[name="userPortal.portalTitleSelf"]', $addUPfrm).val(),
										"portalX" : $('[name="userPortal.portalX"]:checked', $addUPfrm).val(),
										"portalY" : $('[name="userPortal.portalY"]', $addUPfrm).val(),
										"portalHeight" : $('[name="userPortal.portalHeight"]', $addUPfrm).val(),
										"portalLayout" : $('[name="userPortal.portalLayout"]', $addUPfrm).val(),
										"portal" : portal
									};
									var isAdded = cacheGetByPortal(portal.catalogId);// 得到x坐标和y的坐标，y是排序后的y‘
								if (isAdded) {
									var p = $(".portlet[data-cataid='" + portal.catalogId + "']");
									portalVanus.deletePortlet(p);
								}
								var waitAddUd = {
									"persistState" : '',
									"_portlet_option" : _portlet_option["add"],
									"userPortal" : userPortal
								};
								portalVanus.addPortlet(userPortal.portalX, userPortal.portalY, waitAddUd);
								addUserPortalDialog.dialog("close");
							}
							});
						}

					},
					"确定" : function() {
						if (vo.form()) {
							var x = $('[name="userPortal.portalX"]:checked', $addUPfrm).val();
							var y = $('[name="userPortal.portalY"]', $addUPfrm).val();
							var options = {
								dataType : "json",
								error : function() {
									$.prompt('添加出错!');
								},
								clearForm : true,
								success : function(data) {
									var userPortal = data.userPortal;
									var waitAddUd = {
										"persistState" : persistState_exist,
										userPortal : userPortal
									};
									portalVanus.addPortlet(userPortal.portalX, userPortal.portalY, waitAddUd);
									delete _cache_data["content"][x][y]["_portlet_option"];
									addUserPortalDialog.dialog("close");
								}
							};
							$addUPfrm.ajaxSubmit(options);

						}
					},
					"重置" : function() {
						vo.resetForm();

					},

					"取消" : function() {
						$(this).dialog("close");
					}
				}
			}).dialog("open");

		});
		$("[id='_cache_reload']").on("click", function() {
			cacheReload();
		});

		$("[id='_server_reload']").on("click", function(e) {
			if (confirm("刷新会重新读取，当前没有保存的模块和布局配置将会丢失，确定?")) {
				fetchUserPortalsAndInit();
			}
		});
		$("[id='_savePortalSettings']").on("click", function(e) {
			var needAdd = [], needDelete = [], needUpdate = [];
			var updata = _cache_data["content"];
			needDelete = _cache_data["waitDelete"];
			var currentPL = _cache_data["currentLayoutVal"]["current"], serverPL = _cache_data["currentLayoutVal"]["server"];
			if (currentPL !== serverPL) {
				// alert('布局改变，全部更新');
				$.each(updata, function(cindex, ud) {
					$.each(ud, function(yindex, upd) {
						switch (upd["_portlet_option"]) {
							case _portlet_option["add"] :
								needAdd.push(updata[cindex][yindex]);
								break;
							case _portlet_option["update"] :
							default :
								needUpdate.push(updata[cindex][yindex]);
								break;
						}
					});
				});

			} else {
				// alert('布局未变，局部更新');
				$.each(updata, function(cindex, ud) {
					$.each(ud, function(yindex, upd) {
						// 使用localstorage的时候校验哪些portlet已不具权限和已删除,目前使用sessionStorage
							switch (upd["_portlet_option"]) {
								case _portlet_option["add"] :
									needAdd.push(updata[cindex][yindex]);
									break;
								case _portlet_option["update"] :
									needUpdate.push(updata[cindex][yindex]);
									break;
								default :
									break;
							}
						});
				});
			}

			if (currentPL === serverPL && (needAdd.length === 0 && needUpdate.length === 0 && needDelete.length === 0)) {
				alert('布局或数据未发生改变!');

			} else {
				var upfrm = $("form[name='upform_temp']"), html = "";
				$.each(needAdd, function(i, av) {
					var aup = av.userPortal;
					html += '<input type="text" name="addUserPortal.userId" value="' + user_id + '" />';
					html += '<input type="text" name="addUserPortal.portal.catalogId" value="' + aup.portal.catalogId + '" /><input type="text" name="addUserPortal.portalTitleSelf" value="' + aup.portalTitleSelf + '" />';
					html += '<input type="text" name="addUserPortal.portalHeight" value="' + aup.portalHeight + '" /><input type="text" name="addUserPortal.portalX" value="' + aup.portalX + '" />';
					html += '<input type="text" name="addUserPortal.portalY" value="' + aup.portalY + '" /><input type="text" name="addUserPortal.portalLayout" value="' + currentPL + '" />';
				});
				$.each(needDelete, function(i, dv) {
					var dup = dv.userPortal;
					html += '<input type="text" name="deleteUserPortal.userPortalId" value="' + dup.userPortalId + '" />';
				});
				$.each(needUpdate, function(i, uv) {
					var uup = uv.userPortal;
					html += '<input type="text" name="updateUserPortal.userPortalId" value="' + uup.userPortalId + '" /><input type="text" name="updateUserPortal.portalTitleSelf" value="' + uup.portalTitleSelf + '" />';
					html += '<input type="text" name="updateUserPortal.portalHeight" value="' + uup.portalHeight + '" /><input type="text" name="updateUserPortal.portalX" value="' + uup.portalX
							+ '" /><input type="text" name="updateUserPortal.portalY" value="' + uup.portalY + '" />';
					html += '<input type="text" name="updateUserPortal.portalLayout" value="' + currentPL + '" />';
				});

				upfrm.empty().html(html);
				var options = {
					url : servletPath+"/console/userportal/savaUserPortalSettings.action",
					dataType : "json",
					error : function() {
						$.prompt('保存布局出错!');
					},
					clearForm : true,
					success : function(data) {
						$.prompt("保存布局成功!<br/>新增的:" + needAdd.length + ";<br/>删除的:" + needDelete.length + ";<br/>执行update的:" + needUpdate.length + ";<br/>当前布局:" + _cache_data["currentLayoutVal"]["current"] + ";数据库布局:"
								+ _cache_data["currentLayoutVal"]["server"], {
							callback : function(v, m) {
								refreshCacheAndReload();
								_cache_data["currentLayoutVal"]["server"] = currentPL;
								// fetchUserPortalsAndInit();
							}
						});
					}

				};
				upfrm.ajaxSubmit(options);
			}

		});

		registPortletBtnEvent();
	});
	/**
	 * 刷新掉缓存中的状态，并重新reload
	 * 
	 * @return
	 */
	function refreshCacheAndReload() {
		$.each(_cache_data["content"], function(cindex, v) {
			$.each(v, function(yindex, updata) {
				_cache_data["content"][cindex][yindex]["persistState"] = persistState_exist;
				delete _cache_data["content"][cindex][yindex]["_portlet_option"];

			});
		});
		cacheReload();
	}

	function initAndClearGlobalCache() {
		_cache_data = {
			"inited" : false,// 是否初始化存在缓存
			"content" : {},// 布局以及每列存放的元素
			"layout" : {},// 布局存放信息，列以及存放的的userPortal的Id和y（非y的坐标，而是y上的排序）信息
			"layoutStr" : {},// 布局信息，列和列宽
			"columnLength" : 0,// 列的个数
			"waitDelete" : [], // 待删除的userPortalData
			"currentLayoutVal" : {}// 当前布局的value值
		};
	}
	/**
	 * 修改布局
	 * 
	 * @param pl(布局简写)
	 * @return
	 */
	function changePortalLayout(pl) {
		// 判断是否已被初始化
		if (_cache_data["inited"]) {
			// 算出列信息
			var columnWithWidth = countColNumsAndWidth(String(pl));
			initUserPortal(columnWithWidth);
		} else {
			$.prompt('初始化未完成，不能重新布局');
		}

	}

	/**
	 * 根据布局设置，返回所占的第几列和占的列宽
	 * 
	 * @param _portalLayout
	 *            对应数据字典的dict_id
	 * @return
	 */
	function countColNumsAndWidth(_portalLayout) {
		var columnWithWidth = {};
		if (Number(_portalLayout)) {
			var columnCount = _portalLayout.length;
			_cache_data["columnLength"] = columnCount;// 将列数保存
			_cache_data["currentLayoutVal"]["current"] = _portalLayout;
			var tcount = 0;
			for ( var i = 0; i < columnCount; i++) {
				tcount += Number(_portalLayout.charAt(i));
			}
			for ( var i = 0; i < columnCount; i++) {
				columnWithWidth[i + 1] = 99 / tcount * Number(_portalLayout.charAt(i));// 列所占宽度
			}
		}
		return columnWithWidth;
	}

	/**
	 * 根据布局设置算出的列信息进行初始化
	 * 
	 * @param columnWithWidth
	 *            注意来源
	 * @param uplist
	 *            注意来源
	 * @return
	 */
	function initUserPortletsl(columnWithWidth, uplist) {
		var html = buildPortalHtmlByDBData(columnWithWidth, uplist);
		$("div.catalog_content").empty().html(html);
		registColumnEvent();
	}

	/**
	 * 根据列的html和用户的portalets组装HTML
	 * 
	 * @param columnHtml
	 * @param uplist
	 * @return
	 */
	function buildPortalHtmlByDBData(columnWithWidth, uplist) {
		var html = "", columnHtml = {};
		$.each(columnWithWidth, function(columnIndex, width) {
			columnHtml[columnIndex] = '<div class="column" data-columnindex="' + columnIndex + '" style="width:' + width + '%" >';
		});

		$.each(columnHtml, function(cIndex, cDom) {
			var userPortalBeans_column = [];
			for ( var i = 0; i < uplist.length; i++) {
				var _portlet = uplist[i];
				// 如果x轴存在相等
				if (String(_portlet.userPortal.portalX) === String(cIndex)) {
					userPortalBeans_column.push(_portlet);
				} else {
					// TODO 如果列都不存在，应当放在第一列,当前因为没有操作，超出column的给默认隐藏了
			}
		}
		// 从小到达排列
		userPortalBeans_column.sort( function(a, b) {
			return a.userPortal.portalY > b.userPortal.portalY ? 1 : -1;
		});
		( function(columns_y, ci) {
			_cache_data["content"][ci] = {}, _cache_data["layout"][ci] = [];
			$.each(columns_y, function(i, userPortalBean) {
				var up = userPortalBean.userPortal;
				cDom += '<div class="portlet" data-cataid="' + up.portal.catalogId + '" data-persiststate="' + persistState_exist + '" data-extlink="' + up.portal.catalogUrl + '" data-upid="' + up.userPortalId + '" data-yindex="' + (i + 1)
						+ '" data-xindex="' + ci + '"><div class="portlet-header"><div title="原标题:' + up.portal.catalogTitle + '" class="portlet-header-left">' + up.portalTitleSelf + '</div></div><div class="portlet-content" style="height: '
						+ up.portalHeight + 'px;"><iframe frameborder="0"  src="' + up.portal.catalogContent + '" ></iframe></div></div>';

				_cache_data["content"][ci][i + 1] = userPortalBean;// 缓存存入信息,在某列排序第几个key是自然数(i+1)1开始，不是portalY
					var tmp = {};
					tmp["userPortalId"] = up.userPortalId;
					tmp["y"] = up.portalY;
					_cache_data["layout"][ci].push(tmp);
				});
		})(userPortalBeans_column, cIndex);
		cDom += "</div>";
		html += cDom;
	}	);
		_cache_data["inited"] = true;
		_cache_data["layoutStr"] = columnWithWidth;
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
		return html;
	}

	/**
	 * 从缓存数据重建html,暂时没使用，更改布局的操作再更改cache的时候完成了
	 * 
	 * @param newColumnHtml
	 * @param _cache_data
	 * @return
	 */
	function rebuildPortalHtmlByCacheData(newColumnWithWidth, _cache_data) {
		var html = "", columnHtml = {};
		$.each(newColumnWithWidth, function(columnIndex, width) {
			columnHtml[columnIndex] = '<div class="column" data-columnindex="' + columnIndex + '" style="width:' + width + '%" >';
			// 注意没闭合
			});
		$.each(columnHtml, function(cIndex, cDom) {
			var updatasWithY = _cache_data["content"][cIndex];
			var i = 1;
			( function(tmp) {
				$.each(updatasWithY, function(y, updata) {
					var up = updata.userPortal;
					if (updata.persistState) {
						cDom += '<div class="portlet" ';
					} else {
						cDom += '<div class="portlet portlet-not-persist" ';// 尚未保存到库的
					}
					cDom += 'data-persiststate="' + updata.persistState + '" data-cataid="' + up.portal.catalogId + '"  data-extlink="' + up.portal.catalogUrl + '" data-upid="' + up.userPortalId + '" data-yindex="' + tmp + '" data-xindex="' + cIndex
							+ '"><div class="portlet-header"><div title="原标题:' + up.portal.catalogTitle + '" class="portlet-header-left">' + up.portalTitleSelf + '</div></div><div class="portlet-content" style="height: ' + up.portalHeight
							+ 'px;"><iframe frameborder="0"  src="' + up.portal.catalogContent + '" ></iframe></div></div>';
					tmp++;

				});
			})(i);

			cDom += "</div>";
			html += cDom;
		});
		return html;
	}
	// 重画某portalet
	portalVanus.repaintPortlet = function(ax, ay, optionsData) {

		cacheUpdate(ax, ay, optionsData);
		var updata = _cache_data["content"][ax][ay];
		if (updata) {
			var up = updata.userPortal;
			var html = '<div class="portlet ' + (updata.persistState ? "" : "portlet-not-persist") + '" dara-cataid="' + up.portal.catalogId + '" data-persiststate="' + updata.persistState + '" data-extlink="' + up.portal.catalogUrl
					+ '" data-upid="' + up.userPortalId + '" data-yindex="' + ay + '" data-xindex="' + ax + '"><div class="portlet-header"><div title="原标题:' + up.portal.catalogTitle + '" class="portlet-header-left">'
					+ (updata["_portlet_option"] === _portlet_option["update"] ? " * " : "") + up.portalTitleSelf + '</div></div><div class="portlet-content" style="height: ' + up.portalHeight + 'px;"><iframe frameborder="0"  src="'
					+ up.portal.catalogContent + '" ></iframe></div></div>';
			if ($('.portlet[data-yindex="' + ay + '"][data-xindex="' + ax + '"]').length) {
				$('.portlet[data-yindex="' + ay + '"][data-xindex="' + ax + '"]').replaceWith(html);
			} else {
				alert('修改的portlet在dom结构上不存在');
			}
			addNewBtnToPortlet();
		}
	}
	portalVanus.addPortlet = function(ax, ay, waitAddUd) {
		if (_cache_data["content"][ax]) {
			// 如果ax列当前存在portlet，则插入
			if (_cache_data["layout"][ax].length === 0) {
				ay = 1;
			}
			var waitAddLayout = {};
			cacheAdd(waitAddUd, waitAddLayout, ax, ay);
			var updata = _cache_data["content"][ax][ay];
			if (updata) {
				var up = updata.userPortal;
				var html = '<div class="portlet ' + (updata.persistState ? "" : "portlet-not-persist") + '" data-cataid="' + up.portal.catalogId + '" data-persiststate="' + updata.persistState + '" data-extlink="' + up.portal.catalogUrl
						+ '" data-upid="' + up.userPortalId + '" data-yindex="' + ay + '" data-xindex="' + ax + '"><div class="portlet-header"><div title="原标题:' + up.portal.catalogTitle + '" class="portlet-header-left">' + up.portalTitleSelf
						+ '</div></div><div class="portlet-content" style="height: ' + up.portalHeight + 'px;"><iframe frameborder="0"  src="' + up.portal.catalogContent + '" ></iframe></div></div>';
				if ($('.portlet[data-yindex="' + ay + '"][data-xindex="' + ax + '"]').length) {
					$('.portlet[data-yindex="' + ay + '"][data-xindex="' + ax + '"]').before(html);
					resetIndexOnportlet(ax);
				} else {
					$(".column[data-columnindex='" + ax + "']").append(html);

				}
				addNewBtnToPortlet();
			}

		} else {
			$.prompt(ax + "列不存在");
		}

	}
	/**
	 * 添加注册事件
	 * 
	 * @return
	 */
	function registColumnEvent() {
		$(".column").sortable({
			cursor : 'move',
			tolerance : 'pointer',
			connectWith : ".column",
			stop : function(event, ui) {
				var $el = ui.item;
				var parentColumn = $el.closest(".column");
				var ox = $el.attr("data-xindex"), oy = $el.attr("data-yindex");
				cacheMove(Number(ox), Number(oy), Number(parentColumn.data("columnindex")), Number(parentColumn.find(".portlet").index($el) + 1));
				// 重排两列的div上的坐标索引
			$('.column[data-columnindex="' + ox + '"]').find(".portlet").each( function(i, v) {
				$(v).attr({
					"data-xindex" : ox,
					"data-yindex" : i + 1
				});
			});
			parentColumn.find(".portlet").each( function(i, v) {
				$(v).attr({
					"data-xindex" : parentColumn.data("columnindex"),
					"data-yindex" : i + 1
				});
			});

		}
		}).disableSelection();
		addNewBtnToPortlet();

	}

	function addNewBtnToPortlet() {

		$(".portlet")
				.addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
				.find(".portlet-header")
				.addClass("ui-widget-header ui-corner-all")
				.prepend(
						"<div class='portlet-header-right'><span class='ui-icon ui-icon-refresh' title='刷新'/><span class='ui-icon ui-icon-carat-1-n' title='折叠'/><span class='ui-icon ui-icon-gear' title='配置'/><span class='ui-icon ui-icon-trash' title='删除'/><span class='ui-icon ui-icon-newwin' title='放大'/><span class='ui-icon ui-icon-extlink' title='跳转'/></div>");

	}

	/**
	 * 给portal的功能按钮增加事件
	 */
	function registPortletBtnEvent() {

		$(".portlet").live({
			" mouseover" : function() {
				$(this).find(".portlet-header-right").show();
			},
			"mouseout" : function() {
				$(this).find(".portlet-header-right").hide();
			}
		});
		// 跳转
		$(".portlet-header .ui-icon-extlink").live("click", function() {
			var p = $(this).closest(".portlet");
			var url = p.data("extlink"), title = $(".portlet-header .portlet-header-left", p).text(), frm = $("iframe", $(".iframe_wrap", $(window.parent.document)));
			cvs.sendForwardAndSetTitle(title, url, frm);
			// $.prompt('布局是否已保存?', {
				// callback : function(v, m) {
				// cvs.sendForwardAndSetTitle(title, url, frm);
				// }
				// });

			});
		// 放大缩小折叠
		$(".portlet-header .ui-icon-carat-1-n").live("click", function() {
			$(this).toggleClass("ui-icon-caray-1-n").toggleClass("ui-icon-carat-1-s");
			// $(this).parents(".portlet:first").find(".portlet-content").toggle();
				$(this).closest(".portlet").find(".portlet-content").toggle();
			});
		// 放大
		$(".portlet-header .ui-icon-newwin").live("click", function() {
			var p = $(this).closest(".portlet");
			var pc = p.clone(true);
			pc.find(".portlet-content").show();//克隆的时候打开内容
			pc.attr({
				"id" : p.attr("data-xindex") + p.attr("data-yindex")
			}).css({
				"position" : "absolute",
				"left" : " -10px",
				"right" : "10px",
				"top" : "5px",
				"bottom" : "0",
				"background" : "#fff",
				"z-index" : 999,
				"opacity" : .9,
				"height" : $("body").height() - 10,
				"width" : $.browser.msie ? $("body").width() - 5 : $("body").width() - 5,
				"border" : "1px solid #666 "
			}).appendTo($(".catalog"));
			var con_height = pc.height() - $(".portlet-header", pc).height() - 30;
			pc.find(".portlet-content").css({
				"height" : con_height,
				"width" : pc.width()
			});
			pc.find(".portlet-header-right").empty().html("<span class='ui-icon ui-icon-refresh' title='刷新'/><span class='ui-icon ui-icon-gear' title='配置' data-ismax='max' /><span class='ui-icon ui-icon-close' title='关闭大窗口'/>");
		});
		// 关闭
		$(".portlet-header .ui-icon-close").live("click", function() {
			var pTmp = $(this).closest(".portlet");
			var ax = pTmp.attr("data-xindex"), ay = pTmp.attr("data-yindex");
			pTmp.remove();
			portalVanus.repaintPortlet(ax, ay);
		});
		// 刷新
		$(".portlet-header .ui-icon-refresh").live("click", function() {
			var p = $(this).closest(".portlet");
			var iframe = $("iframe", p)[0];
			// 刷新
				iframe.contentWindow.document.location.reload();
				// 重新加载
				// var iframe = $("iframe", p);
				// iframe.attr("src",iframe.attr("src"));

			});
		// 修改配置
		$(".portlet-header .ui-icon-gear").live(
				"click",
				function() {
					var isMax = $(this).attr('data-ismax') || $.trim(String($(this).attr('data-ismax'))) === 'max' ? true : false;
					var vo = getUpdateUPVO();
					vo.resetForm();
					var p = $(this).closest(".portlet");
					var ax = p.attr("data-xindex"), ay = p.attr("data-yindex");
					var userPortalbean = _cache_data["content"][ax][ay];
					var _this_persistState = userPortalbean['persistState'];
					buildUpdateUPHtml(userPortalbean.userPortal);
					var updateUPDialog = $("#updateUserPortalDialog");
					updateUPDialog.dialog(
							{
								draggable : true,
								resizable : false,
								autoOpen : false,
								modal : true,
								title : "修改_" + userPortalbean.userPortal.portalTitleSelf + "[" + (userPortalbean.persistState ? "已入库" : "尚未入库") + "]",
								height :450,
								width : 450,
								minWidth : 450,
								buttons : {
									"暂不入库" : function() {
										var userPortal = {
											"portalTitleSelf" : $("[name='updateUserPortalForm'] [name='userPortal.portalTitleSelf']").val(),
											"portalHeight" : Number($('[name="updateUserPortalForm"] [name="userPortal.portalHeight"]').val())
										};
										var waitUpdateUd = _this_persistState ? {
											"_portlet_option" : _portlet_option["update"],
											"userPortal" : userPortal
										} : {
											"userPortal" : userPortal
										};
										if (_this_persistState && vo.form()) {
											isMax ? cacheUpdate(ax, ay, waitUpdateUd) : portalVanus.repaintPortlet(ax, ay, waitUpdateUd);
											updateUPDialog.dialog("close");
										} else {
											isMax ? cacheUpdate(ax, ay, waitUpdateUd) : portalVanus.repaintPortlet(ax, ay, waitUpdateUd);
											updateUPDialog.dialog("close");
										}
										//TODO 修改克隆的title

									},
									"确定" : function() {

										if (vo.form()) {
											if (_this_persistState) {
												var options = {
													dataType : "json",
													error : function() {
														$.prompt('更改出错!');
													},
													clearForm : true,
													success : function(data) {
														var userPortal = data.userPortal;
														var waitUpdateUd = {
															userPortal : userPortal
														};
														delete _cache_data['content'][ax][ay]['_portlet_option'];
														if (isMax) {
															cacheUpdate(ax, ay, waitUpdateUd);
														} else {
															portalVanus.repaintPortlet(ax, ay, waitUpdateUd);
														}
														updateUPDialog.dialog("close");
													}

												};
												$("[name='updateUserPortalForm']").ajaxSubmit(options);
											} else {
												var _addUPdata = _cache_data["content"][ax][ay];
												var current_layout = _cache_data["currentLayoutVal"]["current"];
												_addUPdata["userPortal"]["portalLayout"] = current_layout;
												var frmClone = $("[name='updateUserPortalForm']").clone().attr({
													"id" : "_clone_updateForm"
												});

												var elHtml = "";
												$("[name='userPortal.userPortalId']", frmClone).remove();
												elHtml += '<input type="text" value="' + _addUPdata.userPortal.portalX + '" name="userPortal.portalX" /><input type="text" value="' + _addUPdata.userPortal.portalY
														+ '" name="userPortal.portalY" /><input type="text" value="' + _addUPdata.userPortal.portalLayout + '" name="userPortal.portalLayout" />';
												frmClone.find("div[id='_wait_add_up_div']").empty().html(elHtml);
												var options = {
													url : servletPath+"/console/userportal/addUserPortal.action",
													dataType : "json",
													error : function() {
														$.prompt('添加出错!');
													},
													clearForm : true,
													success : function(data) {
														var userPortal = data.userPortal;
														var waitUpdateUd = {
															"persistState" : persistState_exist,
															userPortal : userPortal
														};
														delete _cache_data["content"][ax][ay]["_portlet_option"];
														if (isMax) {
															cacheUpdate(ax, ay, waitUpdateUd);
														} else {
															portalVanus.repaintPortlet(ax, ay, waitUpdateUd);
														}

														frmClone.remove();
														updateUPDialog.dialog("close");
													}
												};
												frmClone.ajaxSubmit(options);
											}
										}
									},
									"关闭" : function() {
										$(this).dialog("close");
									}
								}
							}).dialog("open");

				});
		// 删除当前模块
		$(".portlet-header .ui-icon-trash").live("click", function() {
			var p = $(this).closest(".portlet");
			var persistState = p.data("persiststate");
			if (String(persistState) === persistState_exist) {
				if (confirm('是否在服务器上也删除此portlet?')) {
					var upid = p.attr("data-upid");
					deleteUserPortal_Ajax(upid);
					portalVanus.deletePortlet(p, true);
				} else {
					portalVanus.deletePortlet(p, false);
				}
			} else {
				portalVanus.deletePortlet(p, true);
			}

		});
	}
	/**
	 * 删除portal
	 * 
	 */
	portalVanus.deletePortlet = function(p, isReally) {
		var ax = p.attr("data-xindex"), ay = p.attr("data-yindex");
		if (isReally === false) {
			_cache_data["waitDelete"].push(_cache_data["content"][ax][ay]);
		}
		cacheDelete(ax, ay);
		p.remove();
		resetIndexOnportlet(ax);

	}

	/**
	 * 重置绑定在portlet上的坐标索引
	 */
	function resetIndexOnportlet(ax) {
		$(".portlet[data-xindex='" + ax + "']").each( function(i, v) {
			$(v).attr({
				"data-yindex" : i + 1
			});
		});
	}

	/**
	 * 初始化用户portals
	 * 
	 * @return
	 */
	function initUserPortal() {
		if (_cache_data["inited"]) {
			var newColumnWithWidth;
			if (arguments.length) {
				newColumnWithWidth = arguments[0];
				initUserPortalByCache(newColumnWithWidth);// 切换布局
			} else {
				cacheReload();// 直接缓存加载
			}
			//从缓存初始化选中哪项布局
			var pl=_cache_data["currentLayoutVal"]["current"];
			$("#portal_layout_setting>li").siblings().find("a.current").removeClass("current");
			$("#portal_layout_setting>li a[data-val='" + pl + "']").addClass("current");
			
			
		} else {
			fetchUserPortalsAndInit();// 打开浏览器初始化
		}
	}

	/**
	 * 刷新缓存重建整个portal
	 * 
	 * @return
	 */
	function cacheReload() {
		$("div.catalog_content").empty();
		var columnWithWidth = _cache_data["layoutStr"];
		// 算出列信息
		var html = rebuildPortalHtmlByCacheData(columnWithWidth, _cache_data);
		$("div.catalog_content").html(html);
		registColumnEvent();
	}

	/**
	 * 从缓存加载,动态改变DOM
	 * 
	 * @return
	 */
	function initUserPortalByCache(newColumnWithWidth) {
		// 新布局的columns
		var newColumnArrays = $.map(newColumnWithWidth, function(width, columnIndex) {
			return columnIndex;
		});
		// 缓存中布局的columns
		var cacheColumns = $.map(_cache_data["content"], function(obj, columnIndex) {
			return columnIndex;
		});
		// 需要删除的column
		var needDeleteColumns = $.map(_cache_data["content"], function(obj, columnIndex) {
			if ($.inArray(columnIndex, newColumnArrays) < 0) {
				return columnIndex;
			}
		});
		// 需要更改宽度的
		var needUpdateColumns = $.map(_cache_data["content"], function(obj, columnIndex) {
			if ($.inArray(columnIndex, newColumnArrays) >= 0) {
				return columnIndex;
			}
		});
		// 需要新增column的
		var needAddColumns = $.map(newColumnWithWidth, function(width, columnIndex) {
			if ($.inArray(columnIndex, cacheColumns) < 0) {
				return columnIndex;
			}
		});
		needAddColumns.sort( function(a, b) {
			return a > b ? 1 : -1;
		});

		// 从某列 删除(移动操作)
		$.each(_cache_data["content"], function(cIndex, upBeanDatasWithY) {
			if ($.inArray(cIndex, needDeleteColumns) > -1) {
				var waitDeleteColumn = $('.column[data-columnindex="' + cIndex + '"]');
				var toX = 1;
				// 全部移动到第1列去
				var toColDiv = $('.column[data-columnindex="' + toX + '"]');
				var _index = toColDiv.children(".portlet").length + 1;
				var waitMovePortlets = $(".portlet", waitDeleteColumn);
				$.each(waitMovePortlets, function(i, v) {
					$(v).attr({
						"data-yindex" : _index + i,
						"data-xindex" : toX
					}).appendTo(toColDiv);
				});
				cacheMove(cIndex, null, toX)
				$('.column[data-columnindex="' + cIndex + '"]').remove();
			}
		});
		// 修改
		$.each(_cache_data["content"], function(cIndex, upBeanDatasWithY) {
			if ($.inArray(cIndex, needUpdateColumns) > -1) {
				var waitUpdateColumn = $('.column[data-columnindex="' + cIndex + '"]');
				waitUpdateColumn.css({
					width : newColumnWithWidth[cIndex] + "%"
				});
			}
		});
		// 新增的column
		$.each(needAddColumns, function(arrayIndex, columnIndex) {
			var waitAddColumn = '<div class="column" data-columnindex="' + columnIndex + '" style="width:' + newColumnWithWidth[columnIndex] + '%" ></div>';
			$("div.catalog_content").append(waitAddColumn);
			registColumnEvent();
			_cache_data["content"][columnIndex] = {};
			_cache_data["layout"][columnIndex] = [];
		});
		_cache_data["layoutStr"] = newColumnWithWidth;
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
	}

	/**
	 * 更新某portalet的时候更新缓存，因为newUserPortalData={persistState:,userPortal:{}},所有要递归合并子属性
	 * 
	 * @param ax
	 * @param ay
	 * @param newUserPortalData
	 * @return
	 */
	function cacheUpdate(ax, ay, newUserPortalData) {
		$.extend(true, _cache_data["content"][ax][ay], newUserPortalData);
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
	}

	/**
	 * 移动portlet的时候更改缓存
	 * 
	 * @param fromX
	 * @param fromY
	 * @param toX
	 * @param toY
	 * @return
	 */
	function cacheMove(fromX, fromY, toX, toY) {
		fromX = Number(fromX), fromY = Number(fromY), toX = Number(toX), toY = Number(toY);
		if (fromX !== toX || fromY !== toY) {
			if (toY) {
				var waitAdd_UserPortalData = _cache_data["content"][fromX][fromY];
				var waitAdd_layout = _cache_data["layout"][fromX][fromY - 1];
				if (fromX === toX) {
					if (fromY > toY) {
						cacheAdd(waitAdd_UserPortalData, waitAdd_layout, toX, toY);
						// 向上移动
						cacheDelete(fromX, fromY + 1);
					} else {
						cacheAdd(waitAdd_UserPortalData, waitAdd_layout, toX, toY + 1);
						// 向下移动
						cacheDelete(fromX, fromY);
					}
				} else {
					cacheAdd(waitAdd_UserPortalData, waitAdd_layout, toX, toY);
					cacheDelete(fromX, fromY);
				}
			} else {
				// 没有toY就是移动到toX的最后去
				if (fromY) {
					// 只移动一个
					var tLength = _cache_data["layout"][toX].length;
					toY = tLength + 1;
					var tmp_layout = _cache_data["layout"][toX][tLength - 1];
					// 最后一个
					var _y = tmp_layout["y"];
					var waitMove_UserPortalData = _cache_data["content"][fromX][fromY];
					waitMove_UserPortalData.userPortal.portalX = toX;
					// 第一列
					waitMove_UserPortalData.userPortal.portalY = Number(_y) + 1;
					var waitMove_layout = {};
					waitMove_layout["y"] = Number(_y) + 1;
					cacheAdd(waitMove_UserPortalData, waitMove_layout, toX, toY);

				} else {
					// 全部移过去
					$.each(_cache_data["content"][fromX], function(y, upData) {
						var tLength = _cache_data["layout"][toX].length;
						toY = tLength + 1;
						var tmp_layout = _cache_data["layout"][toX][tLength - 1];
						var _y = tmp_layout ? tmp_layout["y"] : "1";
						var waitMove_UserPortalData = _cache_data["content"][fromX][y];
						waitMove_UserPortalData.userPortal.portalX = toX;
						waitMove_UserPortalData.userPortal.portalY = Number(_y) + 1;
						var waitMove_layout = {};
						waitMove_layout["y"] = Number(_y) + 1;
						cacheAdd(waitMove_UserPortalData, waitMove_layout, toX, toY);
					});
				}
				cacheDelete(fromX, fromY);
			}
		}
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
	}

	/**
	 * 移除某portlet的时候删除缓存
	 * 
	 * @param fromX
	 * @param fromY
	 * @return
	 */
	function cacheDelete(fromX, fromY) {
		fromX = Number(fromX), fromY = Number(fromY);
		if (fromY) {
			var tLength = _cache_data["layout"][fromX].length;
			var waitDelete_content = _cache_data["content"][fromX][fromY];
			var waitDelete_layout = _cache_data["layout"][fromX][fromY - 1];
			for ( var col_y_up = fromY + 1; col_y_up <= tLength; col_y_up++) {// 往上移动，从小往下替换
				var waitChangeUp_UserPortalData = _cache_data["content"][fromX][col_y_up];
				if (!waitChangeUp_UserPortalData["_portlet_option"]) {
					waitChangeUp_UserPortalData["_portlet_option"] = _portlet_option["update"];
				}
				_cache_data["content"][fromX][col_y_up - 1] = waitChangeUp_UserPortalData;
			}
			delete _cache_data["content"][fromX][tLength];
			// 删除第几列的数据
			delete _cache_data["layout"][fromX][fromY - 1];
			// 删除那列的布局属性，布局是数组，0开始
			_cache_data["layout"][fromX].splice(fromY - 1, 1);
		} else {
			delete _cache_data["content"][fromX];
			delete _cache_data["layout"][fromX];
		}
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
	};
	/**
	 * 增加某portlet的时候增加缓存
	 * 
	 * @param waitAdd_UserPortalData
	 *            需增加的数据
	 * @param waitAdd_layout
	 *            需增加的布局
	 * @param toX
	 * @param toY
	 * @return
	 */
	function cacheAdd(waitAdd_UserPortalData, waitAdd_layout, toX, toY) {
		toX = Number(toX), toY = Number(toY);
		var tLength = _cache_data["layout"][toX].length;
		for ( var col_y_down = tLength; col_y_down >= toY; col_y_down--) {// 往下移动，从大的开始替换
			var waitChangeDown_UserPortalData = _cache_data["content"][toX][col_y_down];
			var cur_y = waitChangeDown_UserPortalData.userPortal.portalY;
			waitChangeDown_UserPortalData.userPortal.portalY = cur_y + 1;
			// 如果当前不存在状态，则是修改，防止新增的和待删除的
			if (!waitChangeDown_UserPortalData["_portlet_option"]) {
				waitChangeDown_UserPortalData["_portlet_option"] = _portlet_option["update"];
			}
			// 下移的Y都在原来基础上+1
			_cache_data["content"][toX][col_y_down + 1] = waitChangeDown_UserPortalData;
			var tmp = _cache_data["layout"][toX][col_y_down - 1];
			tmp["y"] = cur_y + 1;
			_cache_data["layout"][toX][col_y_down] = tmp;
		}
		waitAdd_UserPortalData.userPortal.portalY = _cache_data["layout"][toX][toY - 2] ? _cache_data["layout"][toX][toY - 2]["y"] + 1 : 1;
		waitAdd_UserPortalData.userPortal.portalX = toX;
		waitAdd_layout["y"] = waitAdd_UserPortalData.userPortal.portalY;
		if (!waitAdd_UserPortalData["_portlet_option"]) {
			waitAdd_UserPortalData["_portlet_option"] = _portlet_option["update"];
		}
		_cache_data["content"][toX][toY] = waitAdd_UserPortalData;
		_cache_data["layout"][toX][toY - 1] = waitAdd_layout;
		store.set('_cache_data_userPortal' + user_id, JSON.stringify(_cache_data));
	}
	/**
	 * 根据portal的ID获得缓存中的位置
	 * 
	 * @param pId
	 * @return
	 */
	function cacheGetByPortal(pId) {
		var _ax, _ay, returnValue;
		$.each(_cache_data['content'], function(columnIndex, v1) {
			( function(_v1) {
				$.each(_v1, function(yIndex, v2) {
					var up = v2.userPortal;
					if (up.portal.catalogId === pId) {
						_ay = yIndex;
						_ax = columnIndex;
						returnValue = {
							"x" : columnIndex,
							"y" : yIndex
						}
					}
				});
			})(v1)
		});
		return returnValue;
	}

	/**
	 * 获得数据库中用户保存的portal信息，执行初始化
	 * 
	 * 有参数的话就是布局id
	 * 
	 * @return
	 */
	function fetchUserPortalsAndInit() {
		$.ajax({
			url : servletPath+"/console/userportal/initPortal.action",
			data : {},
			type : 'POST',
			dataType : 'json',
			global : false,
			// timeout : 5000,
			error : function() {
				$.prompt('初始化出错!');
			},
			beforeSend : function() {
			},
			success : function(data) {
				var uplist = data.uplist;
				var _portalLayout = data.portalLayout;
				initAndClearGlobalCache();
				if (!_portalLayout) {
					_portalLayout = $("#portal_layout_setting>li a.current").attr("data-val");
				} else {
					$("#portal_layout_setting>li").siblings().find("a.current").removeClass("current");
					$("#portal_layout_setting>li a[data-val='" + _portalLayout + "']").addClass("current");
				}
				_cache_data["currentLayoutVal"]["server"] = _portalLayout;
				var columnWithWidth = countColNumsAndWidth(_portalLayout);
				initUserPortletsl(columnWithWidth, uplist);
			},
			complete : function(XHR, textStatus) {
			}
		});
	}
	/**
	 * ajax根据userPortalId删除表中内容
	 * 
	 * @param upid
	 * @return
	 */
	function deleteUserPortal_Ajax(upid) {
		var upform = $("form[name='upform_temp']");
		var html = '<input type="text" name="userPortal.userPortalId" value="' + upid + '"/>';
		upform.empty().html(html);
		var options = {
			url : servletPath+"/console/userportal/deleteUserPortal.action",
			dataType : "json",
			error : function() {
				alert('删除出错!');
			},
			success : function(data) {
			}
		};
		upform.ajaxSubmit(options);
	}
})(jQuery);
