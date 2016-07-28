//设置快捷菜单的功能弹出窗
( function($) {
	$( function() {
		// 弹出设置快捷菜单的窗口
		$("#shortcutMenuSetting").on("click", function() {
			clearValidateInfo();
			var scMenuDia = $("#shortcutDialog"), cf = '<iframe scrolling="auto" frameborder="0" width="100%" height="99%" id="permissionTreeIframe" src="'+servletPath+'/console/login/entryShortcutPage.action"></iframe>';
			$(".dialogContent", scMenuDia).empty().html(cf);
			$("#justForValidate").show();
			scMenuDia.dialog({
				draggable : true,
				resizable : false,
				autoOpen : false,
				modal : true,
				title : "设置快捷菜单[" + $(this).data("user") + "的权限]",
				height : 500,
				width : 450,
				minWidth : 450,
				buttons : {
					"确定" : function() {
						var vo = getVO();
						if (vo.form()) {
							var userId = $("[id='shortcutMenuSetting']").data("userid");
							var cw = document.getElementById("permissionTreeIframe").contentWindow.PermissionTreeVar;
							cw.dynaCreateFormEl(userId, commonVanus, $(this));
						}
					},
					"重置" : function() {
						clearValidateInfo();
						var cw = document.getElementById("permissionTreeIframe").contentWindow.PermissionTreeVar;
						cw.reloadPermissionTree();
					},
					"关闭" : function() {
						var cw = document.getElementById("permissionTreeIframe").contentWindow.PermissionTreeVar;
						cw.ShowSelectedInfo();//没加参数
						$(this).dialog("close");
					}
				}
			}).dialog("open");
		})
	});
	// 清除校验信息
	function clearValidateInfo() {
		var vo = getVO();
		vo.resetForm();
	}
	// 获得校验对象
	function getVO() {
		// 调用校验方法
		var validateFormRule = {
			ignore : "",
			errorElement : "em",
			errorPlacement : function(error, element) {
				element.after(error);
			},
			rules : {
				"shortcutmenuError" : {
					range : [0, 9]
				}
			},
			messages : {
				"shortcutmenuError" : {
					range : '快捷菜单栏位最多 {1}'
				}
			}
		};
		return validateForm("#justForValidate", validateFormRule);
	}
	
	$("#logout").on("click", function() {
		window.location.href=servletPath+"/console/login/logout.action";
	});
	
})(jQuery)