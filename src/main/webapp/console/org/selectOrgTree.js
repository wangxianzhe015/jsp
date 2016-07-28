$( function() {
	initTreeContainHeight();
	// 初始化机构树选中是后台根据orgId进行判断的
	var paramId = $(".initOrgTree", $(window.parent.document)).val();// 后台初始化选中项的参数

	var showTreeMethod = $("[id='selectOrg']", $(window.parent.document)).data("method");

	// 调用原生的initAjax.action返回值不支持，不好用
	// $("#orgTree")
	// .dynatree(
	// {
	// initAjax : {
	// url : "gas/org.venus.iplatform.gas.web.OrgManager.initOrgTree.action",
	// // 参数
	// data : {
	// "employee.org.orgId" : paramId
	//
	// }
	//
	// },
	// rootVisible: false,
	// checkbox : false,
	// selectMode : 1,
	// fx : {
	// height : "toggle",
	// duration : 200
	// }
	//
	// });

	initEntityTree(paramId, "", showTreeMethod, "#orgTree", servletPath+"/console/org/initOrgTree.action", "机构树");

	// initState();

});

/**
 * 
 * @return
 */
function selectNodeNative(keyWord) {
	var vs = [];
	if ($.inArray(keyWord, singleCheck) >= 0) {
		// no checkbox,active只有一个
		var selectedItems = $("#orgTree").dynatree("getActiveNode");
		if (selectedItems) {
			v = selectedItems.data;
			vs.push(v);
		}
	} else if ($.inArray(keyWord, multiCheck) >= 0) {
		// checkbox
		var selectedItems = $("#orgTree").dynatree("getSelectedNodes");
		for (i = 0; i < selectedItems.length; i++) {
			var v = selectedItems[i].data;
			vs.push(v);
		}
	}
	return vs;
}

// 初始化选中项
function initState() {

	// 获得orgpath和userPath
	var path = $(".initOrgTree", $(window.parent.document)).val();

	var tree = $("#orgTree").dynatree("getTree");

	// tree.getNodeByKey(userPath).select();
	tree.activateKey(path);
}