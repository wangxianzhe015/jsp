//grid_table的全选，add,update,delete操作
$( function() {
	initGridTable();
	var hasSelectArry = [];// 页面加载完成的时候，初始化好数组,非局部变量
	// 全选操作
	var _table = $(".grid_body table");
	$("#checkAll", _table).click( function() {

		$("[id^='checkthis']", _table).prop("checked", $(this).prop("checked"));

	});
	$("[id^='checkthis']", _table).each( function(i, v) {

		$(this).on("click", function() {

			var cur = $(this).val();
			if ($(this).prop("checked")) {

				// 选中的话检查数组中是否存在,存在则不加，不存在则数组新增
				var ifexisit = hasSelectArry.contains(cur);
				if (ifexisit >= 0) {
					// 此元素如果存在不做任何操作
			} else {
				hasSelectArry.push(cur);
			}
		} else {
			// 从数组中移除此元素
			var i = hasSelectArry.contains(cur);
			hasSelectArry.splice(i, 1);

		}
		$("[name='hasSelected']").val(hasSelectArry);

	}	)
	});

	/**
	 * 封装的简单ajax操作，返回responseText(json类型，key为request的name，值为value)
	 */
	function ajaxSub(action, param, error) {

		var ResponseText;
		$.ajax({
			url : action,
			data : param,
			type : 'POST',
			dataType : 'json',
			timeout : 1000,
			error : error,
			success : function(data) {
				ResponseText = data;
			}

		});
		return ResponseText;
	}

	$("#_GridUpdateBtn").on("click", function() {

		// var action = $(this).data("url");
			// var param = $(this).data("param");
			// param.employeeId = null;
			// var error = function() {
			//
			// alert('ajax访问出错');
			// }
			// ajaxSub(action, param, error);

		})
	$("#_GridDeleteBtn").on("click", function() {

		// var hasSelected = $("[name='hasSelected']").val();
			// if (hasSelected) {
			// alert('调用后台删除employeeId为' + hasSelected + "的这几位！");
			//
			// } else {
			// alert('尚未选择');
			// }
		});
	$("select.gotoPage").live("change", function() {
		var pageno = $(this).val();
		var formAction = $(this).data("formAction");
		var formId = $(this).data("formId");
		// 调用gotoPage函数
			gotoPage(pageno, formAction, null, formId);

		});

});
/**
 * 初始化grid_table
 * 
 * @return
 */
function initGridTable() {
	$("tbody tr:odd").addClass("odd");
	$("tbody tr").hover( function() {
		$(this).addClass("hover");

	}, function() {
		$(this).removeClass("hover");
	});
	// cosplanTable("cosplanTable", 7);
	cosplanTable("cosplanTable");
}

/**
 * 参数【table（表名），cols(需要合并的前几列)】
 * 
 * @return
 */
var cosplanTable = function() {
	var table, col;
	// 必须有1或者2个参数
	if (arguments.length == 0)
		return;
	if (arguments.length > 2)
		return;
	if (arguments.length == 1) {
		table = arguments[0];
		var tab = document.getElementById(table);
		// 要合并的tableID
		var val, count, start;
		// maxCol：合并单元格作用到多少列
		var indexs = [];
		$("th.cosplan", $(tab)).each( function() {
			var ind = $("th", $(tab)).index($(this));
			indexs.push(ind);
		})
		if (tab != null) {
			for ( var index = 0; index < indexs.length; index++) {
				col = indexs[index];
				count = 1;
				val = "";
				for ( var i = 1; i < tab.rows.length; i++) {
					if ((val == tab.rows[i].cells[col].innerHTML) && ($.trim($(tab.rows[i].cells[col]).text()) != "")) {
						count++;
					} else {
						if (count > 1) {// 合并
							start = i - count;
							tab.rows[start].cells[col].rowSpan = count;
							for ( var j = start + 1; j < i; j++) {
								tab.rows[j].cells[col].style.display = "none";
							}
							count = 1;
						}
						val = tab.rows[i].cells[col].innerHTML;
					}
				}
				if (count > 1) {// 合并，最后几行相同的情况下
					start = i - count;
					tab.rows[start].cells[col].rowSpan = count;
					for ( var j = start + 1; j < i; j++) {
						tab.rows[j].cells[col].style.display = "none";
					}
				}

			}
		}
	}
	if (arguments.length == 2) {
		table = arguments[0];
		col = arguments[1];
		var tab = document.getElementById(table);
		// 要合并的tableID
		var maxCol = col, val, count, start;
		// maxCol：合并单元格作用到多少列
		if (tab != null) {
			for ( var col = maxCol - 1; col >= 0; col--) {
				count = 1;
				val = "";
				for ( var i = 1; i < tab.rows.length; i++) {
					if ((val == tab.rows[i].cells[col].innerHTML) && ($.trim($(tab.rows[i].cells[col]).text()) != "")) {
						count++;
					} else {
						if (count > 1) {// 合并
							start = i - count;
							tab.rows[start].cells[col].rowSpan = count;
							for ( var j = start + 1; j < i; j++) {
								tab.rows[j].cells[col].style.display = "none";
								// tab.rows[j].removeChild(tab.rows[j].cells[col]);
							}
							count = 1;
						}
						val = tab.rows[i].cells[col].innerHTML;
					}
				}
				if (count > 1) {// 合并，最后几行相同的情况下
					start = i - count;
					tab.rows[start].cells[col].rowSpan = count;
					for ( var j = start + 1; j < i; j++) {
						tab.rows[j].cells[col].style.display = "none";
						// tab.rows[j].removeChild(tab.rows[j].cells[col]);
					}
				}
			}
		}
	}

}

// 检验table的完整性+
function checkTable(table) {
	if (table.rows.length == 0)
		return false;
	if (table.rows[0].cells.length == 0)
		return false;
	for (i = 0; i < table.rows.length; i++) {
		if (table.rows[0].cells.length != table.rows[i].cells.length)
			return false;
	}
	return true;
}

/**
 * 重写是否存在,返回元素在数组的位置i
 * 
 * @param arr
 * @return
 */
Array.prototype.contains = function(arr) {
	for ( var i = 0; i < this.length; i++) {
		if (this[i] == arr) {
			return i;
		}
	}
	return -1;
}
