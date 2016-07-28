( function($) {
	$( function() {

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
		$(".projectAuditDialog").dialog({
			draggable : false,
			resizable : false,
			autoOpen : false,
			modal : true
		});
		
		$("[id='auditBtn']").click( function() {
					$("#projectAuditDialog").dialog({
						title : "审核项目",
						height:$.browser.msie?500:"auto",
						width : 620,
						minWidth : 620,
						buttons : {
							"确定" : function() {
								var validateFormRule = {
									rules : {
										"progress.dealResult" : {
											required : true
										},
										"progress.dealOpion" : {
											required : true
										}								
									}
								};
								
								var vo = validateForm("form[name='progressForm']", validateFormRule);
								if (vo.form()) {
									var options = {
										dataType : "json",
										error : function() {
											$.prompt('项目审核出错!');
										},
										success : function(data) {
											$.prompt('保存成功!');
											window.location.href=servletPath+"/portal/project/index.action";
										}
									};
									$("[name='progressForm']").ajaxSubmit(options);
									$(this).dialog("close");
								}
							},
							"关闭" : function() {
								$(this).dialog("close");
							}
						}
					}).dialog("open");
				
			});


	});
})(jQuery);