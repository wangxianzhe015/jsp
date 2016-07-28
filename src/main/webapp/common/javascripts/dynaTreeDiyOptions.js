function initTreeContainHeight() {
	var o_totalHeight = $("div.pop_tree", $(window.parent.document)).innerHeight();
	var i_headHeight = $("div.pop_head", $(window.parent.document)).outerHeight(true);
	var i_footHeight = $("div.pop_foot", $(window.parent.document)).outerHeight(true);
	var showHeight = o_totalHeight - i_footHeight - i_headHeight;
	$("div.pop_body", $(window.parent.document)).height(showHeight);
}
/**
 * 将字符串转为json对象
 * 
 * @param str
 * @return
 */
function strToJson(str) {
	var json = (new Function("return " + str))();
	return json;
}
// 根据传来的字符串判断树的显示方式
function fetchMethod(showTreeMethod) {
	switch (showTreeMethod) {
		// checkbox选择方式
		case 'singleNoCheck' :
			return singleCheckOptionsNoCheck;
		case 'singleWithCheck' :
			return singleCheckOptions;
		case 'multiNoChild' :
			return multiSelectOptionsN;
		case 'multiWithChild' :
			return multiSelectOptionsY;
			// 以下是点击node方式
		case 'selectNoExpand' :
			return selectNoExpand;
		case 'JustOpenFolder' :
			return JustOpenFolder;
		default :
			return singleCheckOptionsNoCheck;
	}
}
//带checkbox和不带checkbox
var singleCheck = ['singleNoCheck', 'selectNoExpand', 'JustOpenFolder'], multiCheck = ['singleWithCheck', 'multiNoChild', 'multiWithChild'];

/**
 * 重新加载树，适合重置的时候，树回到初始状态
 * 
 * @param treeid
 *            树的id
 * @param valueMethod
 *            获取值的方式，是selected还是active
 * @return
 */
function getTreeSelectedNodes(treeid, valueMethod) {
	var ttree = $(treeid).dynatree("getTree");
	var selNodes;
	if (ttree.options) {
		ttree.reload();
		if (valueMethod == 'select')
			selNodes = ttree.getSelectedNodes();
		if (valueMethod == 'active')
			selNodes = ttree.getActiveNode();
	}
	return selNodes;
}
/**
 * 初始化ajax树的配置
 * 
 * @param initId
 * @param groupId
 * @param showTreeMethod
 * @param showEl
 * @param url
 * @param memo
 * @return
 */
function initEntityTreeOptions(initId, groupId, showTreeMethod, showEl, url, memo) {
	return {
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
		timeout : 15000,
		error : function() {
			$.prompt("加载树出错或者长时间无响应.<br/>请检查生成树action!");
		},
		success : function(data) {
			var treeData = data.children;// 传过来就是json格式，树节点的key是children
		var treeDataNodes = {
			"children" : treeData
		};
		if (arguments[6]) {
			$.extend(treeDataNodes, menuOpt);
		}
		// 使用单选模式
		var settings = $.extend({}, fetchMethod(showTreeMethod), treeDataNodes);
		$(showEl).dynatree("destroy").dynatree(settings);
	}
	// testCase:测试tree or node 的visit回调方法和tree.redraw()和node.render()方法
		,
		complete : function() {
//			var tree = $(showEl).dynatree("getTree");
//			var selectNodes = tree.getSelectedNodes();
//			var activeNode = tree.getActiveNode();
//			if (selectNodes.length > 0) {
//				for ( var sl in selectNodes) {
//					sl.visitParents( function(node) {
//						node.expand(true);
//					}, false)
//				}
//			}
//			if (activeNode) {
//				activeNode.visitParents( function(node) {
//					alert(node.data.title);
//					node.expand(true);
//				}, false);
//			}

		}
	};
}

/**
 * @param initId
 *            初始化选中的item
 * @param groupId
 *            根据这个分组显示不同的结构的树
 * @param showTreeMethod
 *            树的check方式
 * @param showEl
 *            显示树的div元素
 * @param url
 *            ajax显示树的地址 memo是备注，显示这个是什么树 funcSetting是分配权限的click函数配置
 * @return
 */
function initEntityTree(initId, groupId, showTreeMethod, showEl, url, memo) {
	var options = initEntityTreeOptions(initId, groupId, showTreeMethod, showEl, url, memo);
	$.ajax(options);
}

var defaultOption = {
	// persist : true,//使用cookie缓存保存expand状态
	// autoCollapse:false,//自动关闭其他树节点
	// clickFolderMode : 1,// 1:activate, 2:expand, 3:activate and expand
	// minExpandLevel : 2,
	fx : {
		height : "toggle",
		duration : 200
	},
	// Override class name for checkbox icon:
	onActivate : function(node) {
		// item被选中(clicked)
	},
	// 选中才会触发事件，点击确定不太合理
	onSelect : function(select, node) {
		// var selNodes = node.tree.getSelectedNodes();
		//
		// var selKeys = $.map(selNodes, function(node) {
		// return node.data.key;
		// });
		// var selTitle = $.map(selNodes, function(node) {
		// return node.data.title;
		// });
		// var selAttrId = $.map(selNodes, function(node) {
		// return node.data.attrId;
		// });
		// $("#selectName").val(selTitle.join(", "));//选择的名称
		// $("#selectId").val(selAttrId.join(", "));//选择的ID
		// $("#selectPath").val(selKeys.join(", "));//选择的path
	},
	onDblClick : function(node, event) {
		node.toggleSelect();
	},
	onKeydown : function(node, event) {
		if (event.which == 32) {
			node.toggleSelect();
			return false;
		}
	},
	// dnd: {
	// onDragStart: function(node) {
	// /** This function MUST be defined to enable dragging for the tree.
	// * Return false to cancel dragging of node.
	// */
	// logMsg("tree.onDragStart(%o)", node);
	// return true;
	// },
	// onDragStop: function(node) {
	// // This function is optional.
	// logMsg("tree.onDragStop(%o)", node);
	// },
	// autoExpandMS: 1000,
	// preventVoidMoves: true, // Prevent dropping nodes 'before self', etc.
	// onDragEnter: function(node, sourceNode) {
	//			
	// logMsg("tree.onDragEnter(%o, %o)", node, sourceNode);
	// return true;
	// },
	// onDragOver: function(node, sourceNode, hitMode) {
	// /** Return false to disallow dropping this node.
	// *
	// */
	// logMsg("tree.onDragOver(%o, %o, %o)", node, sourceNode, hitMode);
	// // Prevent dropping a parent below it's own child
	// if(node.isDescendantOf(sourceNode)){
	// return false;
	// }
	// // Prohibit creating childs in non-folders (only sorting allowed)
	// // if( !node.isFolder && hitMode == "over" )
	// // return "after";
	// },
	// onDrop: function(node, sourceNode, hitMode, ui, draggable) {
	// /** This function MUST be defined to enable dropping of items on
	// * the tree.
	// */
	// logMsg("tree.onDrop(%o, %o, %s)", node, sourceNode, hitMode);
	// sourceNode.move(node, hitMode);
	// // expand the drop target
	// // sourceNode.expand(true);
	// },
	// onDragLeave: function(node, sourceNode) {
	// /** Always called if onDragEnter was called.
	// */
	// logMsg("tree.onDragLeave(%o, %o)", node, sourceNode);
	// }
	// },
	ajaxDefaults : { // Used by initAjax option
		cache : false, // false: Append random '_' argument to the request url
		// to prevent caching.
		timeout : 10000, // >0: Make sure we get an ajax error for invalid
		// URLs
		dataType : "json" // Expect json format and pass json object to
	// callbacks.
	},
	strings : {
		loading : "加载中…",
		loadError : "加载出错!"
	},
	cookieId : "dynatree-org",
	idPrefix : "dynatree-org-"
};
// 单选模式不带checkbox
var singleCheckOptionsNoCheck = $.extend({
	checkbox : false,
	selectMode : 1
}, defaultOption);
// 单选模式带checkbox
var singleCheckOptions = $.extend({
	// classNames: {checkbox: "dynatree-radio"},
	checkbox : true,
	// classNames: {checkbox: "dynatree-radio"},
	selectMode : 1
}, defaultOption);
// 多选模式
var multiSelectOptionsN = $.extend({
	checkbox : true,
	selectMode : 2
}, defaultOption);
// 多选模式，但支持选父节点子节点被全选
var multiSelectOptionsY = $.extend({
	checkbox : true,
	selectMode : 3
}, defaultOption);
// 分配权限独有的树
var selectNoExpand = $.extend({
	clickFolderMode : 1
}, defaultOption);
// 单击文件夹只展开，不选中
var JustOpenFolder = $.extend({
	clickFolderMode : 2
}, defaultOption);
