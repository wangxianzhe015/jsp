$( function() {
	initTreeContainHeight();
	// 初始化机构树选中是后台根据orgId进行判断的
	var paramId = $(".initUserTree", $(window.parent.document)).val();
	var orgId = "";// 当前登录用户的部门
	var showTreeMethod = $("[id='selectUser']", $(window.parent.document)).data("method");
	initEntityTree(paramId, orgId, showTreeMethod, "#userTree", servletPath+"/console/user/initUserTree.action", "系统用户树");
	// initState();
});
// 原生的取得节点的方法
function selectNodeNative(keyWord) {
	var vs = [];
	var selectedItems = $("#userTree").dynatree("getSelectedNodes");
	for (i = 0; i < selectedItems.length; i++) {
		var v = selectedItems[i].data;
		if (v.nodeType == "user") {
			vs.push(v);
		}
	}
	return vs;
}
// 初始化选中项,每个树都对应自己的js，比如初始化orgTree，去org的js里写
function initState() {
	// 获得orgpath和userPath
	var userPath = $(".initUserTree", $(window.parent.document)).val();
	var tree = $("#userTree").dynatree("getTree");
	// tree.getNodeByKey(userPath).select();
	tree.selectKey(userPath);
}