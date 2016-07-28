// 使用iframe显示需要加载的内容，iframe外层pop_body的高度是320px;超出部分会显示滚动条
// showPopWindowBySelf("测试focus弹出:","gas/org.venus.iplatform.gas.web.OrgManager.entryOrgTree.action","[name='employee.address']",
// "[id='_PopCloseBtn']","[id='_PopSubBtn']");
/**
 * 自己触发事件调出弹出窗
 * 
 * url是弹出div的地址，PopEl是调出弹出窗的元素，CloseEl是关闭按钮
 * 
 * @param url
 * @param PopEl
 * @param CloseEl
 * @return
 */
function showPopWindowBySelf(event, title, url, Pop, Close, Sub, ia, name, path) {
	var PopEl = $(Pop);
	var CloseEl = $(Close);
	var SubEl = $(Sub);
	PopEl.on("focus", function() {
		showPop(event, title, url, PopEl, CloseEl, SubEl, id, name, path);
	});
	CloseEl.on("click", function() {
		CloseEl.closest("div.pop_tree").fadeOut(100);
	});
}
$( function() {
	$("div.pop_tree").resizable({
		maxHeight : 400,
		maxWidth : 500,
		minHeight : 200,
		minWidth : 300,
		stop : function(event, ui) {
		},
		resize : function(event, ui) {
			var o_totalHeight = $("div.pop_tree").innerHeight();
			var i_headHeight = $("div.pop_head").outerHeight(true);
			var i_footHeight = $("div.pop_foot").outerHeight(true);
			var showHeight = o_totalHeight - i_footHeight - i_headHeight;
			$("div.pop_body").height(showHeight);
		}
	});
	$("div.pop_tree").draggable({
		start : function(event, ui) {
		},
		containment : "parent"
	// opacity : 0.7,
			// helper : "original"
			})
	// // 空白处单击关闭范围太大
	// $(document).click( function(event) {
	// // $("div.pop_tree").fadeOut(100);
	// });
	// $("div.pop_tree").click( function(event) {
	// // $("div.pop_tree").fadeOut(100);
	// });
});
/**
 * *
 * 
 * @param event
 *            其他方式调出弹出窗的事件
 * @param title
 *            弹出窗需要设置的名称
 * @param url
 *            弹出窗的URL
 * @param Pop
 *            弹出窗需要直接赋值的元素
 * @param Close
 *            关闭按钮
 * @param Sub
 *            确定按钮
 * @param id
 *            弹出窗需要赋值的树节点的id
 * @param name
 *            弹出窗需要赋值的树节点的name
 * @param path
 *            弹出窗需要赋值的树节点的path
 * @param OpenEl
 *            打开弹出窗的btn
 * @return
 */
function showPopWindow(event, title, url, Pop, Close, Sub, id, name, path, OpenEl, callbacks) {
	var PopEl = $(Pop);
	var CloseEl = $(Close);
	var SubEl = $(Sub);
	//新增清空功能
	if ($('[id="_PopClearBtn"]').length <= 0) {
		CloseEl.after(' <a href="javascript:void(0);" id="_PopClearBtn" class="button">清空</a>');
	}

	var keyWord = $(OpenEl).data("method");
	showPop(event, title, url, PopEl, CloseEl, SubEl, id, name, path, keyWord, callbacks);
	CloseEl.on("click", function() {
		CloseEl.closest("div.pop_tree").fadeOut(100);
	});

	$('[id="_PopClearBtn"]').click( function() {

		$(id).val(null);
		$(name).val(null);
		$(path).val(null);
		CloseEl.closest("div.pop_tree").fadeOut(100);
		PopEl.blur();
	});

}
/**
 * 调出弹出窗common
 * 
 * @param event
 * @param title
 * @param url
 * @param PopEl
 * @param CloseEl
 * @param SubEl
 * @param id
 * @param name
 * @param path
 * @return
 */
function showPop(event, title, url, PopEl, CloseEl, SubEl, id, name, path, keyWord, callbacks) {
	event.stopPropagation();
	// 每次弹出的时候只确定一个PopEl
	SubEl.data("popel", PopEl);
	SubEl.data("vel", [id, name, path]);// 需要赋值的几个input:hidden
	SubEl.data("keyWord", keyWord);

	$(".pop_head").empty().html(title);// 设置标题给弹出窗
	var left = PopEl.offset().left;
	var top = PopEl.offset().top;
	var height = PopEl.outerHeight();
	var html = "";
	html += "<iframe src='" + url + "' frameborder='0' id='_pop_iframe'></iframe>";
	// 先清空再加载内容
	$(".pop_body").empty().html(html);
	$(".pop_tree").fadeIn(100).offset({
		top : top + height + 3,
		left : left
	});
	SubEl.data("callbacks", callbacks);
	getPopValue(SubEl);

}
/**
 * 参数是确定按钮，获得弹出窗的值，并返给调出元素
 * 
 * @param SubEl
 * @return
 */
function getPopValue(SubEl) {
	$(SubEl).live("click", function() {
		var PopEl = $(SubEl).data("popel");// 取得调出元素,即nameEL,也就是需要直接赋值的显示给用户的元素
			var vel = $(SubEl).data("vel");
			var keyWord = $(SubEl).data("keyWord");
			var idEL = vel[0];
			var nameEL = vel[1];
			var pathEL = vel[2];
			var cd = document.getElementById("_pop_iframe").contentWindow.document;// iframe的dom
			var cw = document.getElementById("_pop_iframe").contentWindow;// iframe的window
			// 自带的方法(data的格式:key,title,attrId),应该加上是按照什么方式取值，active||selected
			var vs = cw.selectNodeNative(keyWord);
			var ids = [], names = [], paths = [];
			ids = $.map(vs, function(v) {
				return v.attrId;
			});
			names = $.map(vs, function(v) {
				return v.title;// 用自带的方法时,
				});
			paths = $.map(vs, function(v) {
				return v.key;// 自带的方法
				});

			$(idEL).val(ids);
			$(nameEL).val(names);
			$(pathEL).val(paths.join(";"));// path是";"分割
			// //////////////////////////////////////////////为了验证效果////////////////////
			PopEl.blur();
			$(this).closest("div.pop_tree").fadeOut(100);

			// //////////////////////////////////////////////有回调就调用回调////////////////////
			var callbacks = SubEl.data("callbacks");
			// 所选择的人的部门(父节点)
			if (callbacks) {
				var parent_vs = cw.selectParentNodeNative(keyWord);
				var p_names = $.map(parent_vs, function(v) {
					return v.title;
				});

				var p_ids = $.map(parent_vs, function(v) {
					return v.attrId;
				});
				callbacks["beforeClose"].call(this, {
					"name" : names,
					"orgName" : p_names,
					"orgId" : p_ids
				});
			}
			SubEl.removeData("callbacks");
		})
}
