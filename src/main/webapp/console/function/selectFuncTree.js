    $( function() {
	initTreeContainHeight();
	// 初始化机构树选中是后台根据orgId进行判断的
	var paramId = $(":hidden.initFuncTree", $(window.parent.document))
		.val();
	var showTreeMethod = $("[id='selectFunc']", $(window.parent.document))
		.data("method");
	initEntityTree(
		paramId,
		"",
		showTreeMethod,
		"#funcTree",
		servletPath+"/console/function/initFuncTree.action",
		"功能树");
	// initState();
    });
    // 原生的取得节点的方法
    function selectNodeNative() {
	var vs = [];
	// var tree = $("#orgTree").dynatree("getTree");
	// no checkbox,active只有一个
	// var selectedItems = $("#orgTree").dynatree("getActiveNode");
	// if (selectedItems) {
	// v = selectedItems.data;
	// vs.push(v);
	// }
	// checkbox
	var selectedItems = $("#funcTree").dynatree("getSelectedNodes");
	// TODO 排除分组的选项
	for (i = 0; i < selectedItems.length; i++) {
	    var v = selectedItems[i].data;
	    // 模块的attrId以m开头
	    if (v.attrId.charAt(0) != "m") {
		vs.push(v);
	    }
	}
	return vs;
    }
    // 初始化选中项,每个树都对应自己的js，比如初始化orgTree，去org的js里写
    function initState() {
	// 获得orgpath和userPath
	var path = $(".initFuncTree", $(window.parent.document)).val();
	var tree = $("#funcTree").dynatree("getTree");
	// tree.getNodeByKey(userPath).select();
	tree.selectKey(path);
    }