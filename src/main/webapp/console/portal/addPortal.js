//管理员管理portal
( function($) {
	$( function() {
		// $("#accessPermission").val([1151, 1201,
		// 1202]);//这种方式初始化选中，ie会先init原生select，再初始控件
		$("#accessPermission").multiselect({
			header : true,
			height : 200,
			minWidth : 350,
			noneSelectedText:"请配置访问权限",
			selectedText: '已选择#个角色',
			classes : '',
			selectedList : 2,
			position : {
				my : 'left bottom',
				at : 'center top'
			},
			click : function(event, ui) {
				var o_needNoAccess = $("option#needNoAccess_option"), o_others = $("option").not("#needNoAccess_option");
				if ($.trim(ui.value) === $.trim(o_needNoAccess.val())) {
					if (ui.checked) {
						o_needNoAccess.prop("selected", true);
						o_others.attr({
							"disabled" : "disabled"
						}).prop("selected", false);
						$("#accessPermission").multiselect('refresh');
					} else {
						o_needNoAccess.prop("selected", false);
						o_others.removeAttr("disabled");
						$("#accessPermission").multiselect('refresh');
					}
				} else {
					if (ui.checked) {
						o_needNoAccess.prop("selected", false);
						$("#accessPermission").multiselect('refresh');
						$("option[value='" + $(event.originalEvent.target).val() + "']").prop("selected", true);
						$("#accessPermission").multiselect('refresh');
					}
				}
			},
			checkAll : function() {
				// 全选:只选中角色
			var o_needNoAccess = $("option#needNoAccess_option"), o_others = $("option").not("#needNoAccess_option");
			o_others.attr("selected", "selected");
			o_needNoAccess.removeAttr("selected");
			initMulitiSelectState();
			$("#accessPermission").multiselect('refresh');
		},
		uncheckAll : function() {
			initMulitiSelectState();
		},
		optgrouptoggle : function(event, ui) {
			var og_noAccess = $("#needNoAccess_optionGroup"), og_needAccess = $("#needAccess_optionGroup");
			if (ui.label === og_noAccess.data("label")) {
				initMulitiSelectState();
			} else {
				initMulitiSelectState_byGroup(ui);
			}

			// var ids = $.map(ui.inputs, function(checkbox) {
			// return checkbox.value;
			// }).join(", ");
			// var names = $.map(ui.inputs, function(checkbox) {
			// return $.trim(checkbox.title);
			// }).join(", ");

		},
		beforeclose : function() {

			if ($("#accessPermission").val()) {
				if ($("#accessPermission").val().length == 1 && $("#accessPermission").val()[0] === "no") {
					$("[name='portal.catalogAccess']").val("0");
				} else {
					var selectedIds = $("#accessPermission").val();
					var selectedNames = $.map($("option:selected"), function(o, i) {
						return $.trim($(o).text());
					}).join(", ");
					$("[name='portal.catalogAccess']").val("1");

				}
			} else {
				$("[name='portal.catalogAccess']").val(null);
			}

			$("[name='portal.roleIds']").val(selectedIds);
			$("[name='portal.roleNames']").val(selectedNames);
		},
		close : function() {
			$("#accessPermission").blur();
		}

		});
		// 根据不需要权限的状态判断其他的状态
		function initMulitiSelectState() {
			var o_needNoAccess = $("option#needNoAccess_option"), o_others = $("option").not("#needNoAccess_option");
			if (o_needNoAccess.prop("selected")) {
				o_others.attr({
					"disabled" : "disabled"
				}).removeAttr("selected");
				$("#accessPermission").multiselect('refresh');
			} else {
				o_others.removeAttr("disabled");
				$("#accessPermission").multiselect('refresh');
			}

		}
		function initMulitiSelectState_byGroup(ui) {
			var o_needNoAccess = $("option#needNoAccess_option"), o_others = $("option").not("#needNoAccess_option");
			if (ui.checked) {
				o_needNoAccess.removeAttr("selected");
				o_others.removeAttr("disabled");
				o_others.attr("selected", "selected");
				$("#accessPermission").multiselect('refresh');
			}

		}

		// 定义校验规则
		var validateFormRule = {
			ignore : "",
			rules : {
				"portal.catalogCode" : {
					required : true
				},
				"portal.catalogTitle" : {
					required : true
				},
				"accessPermission" : {
					required : true
				}
			},
			messages : {
				"accessPermission" : {
					required : "需配置访问权限"
				}
			}
		};
		var vo = validateForm("#data_form", validateFormRule);

		// 提交按钮
		$("#submitBtn").click( function() {
			if (vo.form())
				$("#data_form").submit();
		});

		// 重置按钮
		$("#resetBtn").click( function() {
			vo.resetForm();
			// $("#accessPermission").val(2);//=初始值
				initMulitiSelectState();

			})

		// 返回按钮
		$("#backBtn").click( function() {
			window.location.href = servletPath+"/console/portal/index.action";
		});

	});
})(jQuery)