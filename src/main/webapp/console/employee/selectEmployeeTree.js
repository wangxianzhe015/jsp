/**机构职员树*/
$( function() {
	initTreeContainHeight();
	// 初始化机构树选中是后台根据orgId进行判断的
	var paramId = $(".initEmployeeTree", $(window.parent.document)).val();
	var orgId = "";// 当前登录用户的部门
	var showTreeMethod = $("[id='selectEmployee']", $(window.parent.document)).data("method");
	initEntityTree(paramId, orgId, showTreeMethod, "#employeeTree", servletPath+"/console/employee/initEmployeeTree.action", "机构树");
	// initState();
});
// 原生的取得节点的方法
function selectNodeNative(keyWord) {
	var vs = [];
	// var tree = $("#orgTree").dynatree("getTree");
	// no checkbox,active只有一个
	// var selectedItems = $("#orgTree").dynatree("getActiveNode");
	// if (selectedItems) {
	// v = selectedItems.data;
	// vs.push(v);
	// }
	// checkbox
	var selectedItems = $("#employeeTree").dynatree("getSelectedNodes");
	for (i = 0; i < selectedItems.length; i++) {
		var v = selectedItems[i].data;
		// 只取以u开头的节点或者nodeType=“user”的
		if (v.nodeType == "employee") {
			vs.push(v);
		}
	}
	return vs;
}

function selectParentNodeNative(keyWord) {
	var parent_vs = [];
	// var tree = $("#orgTree").dynatree("getTree");
	// no checkbox,active只有一个
	// var selectedItems = $("#orgTree").dynatree("getActiveNode");
	// if (selectedItems) {
	// v = selectedItems.data;
	// vs.push(v);
	// }
	// checkbox
	var selectedItems = $("#employeeTree").dynatree("getSelectedNodes");
	for (i = 0; i < selectedItems.length; i++) {
		var pv = selectedItems[i].getParent().data;
		if (pv.nodeType == "org") {
			parent_vs.push(pv);
		}
	}
	return parent_vs;
}

// 初始化选中项,每个树都对应自己的js，比如初始化orgTree，去org的js里写
function initState() {
	// 获得orgpath和userPath
	var userPath = $(".initEmployeeTree", $(window.parent.document)).val();
	var tree = $("#employeeTree").dynatree("getTree");
	// tree.getNodeByKey(userPath).select();
	tree.selectKey(userPath);
}