$(function() {
    initTreeContainHeight();
    // 初始化机构树选中是后台根据orgId进行判断的
    var paramId = $(":hidden.initModuleTree", $(window.parent.document)).val();
    var moduleId = "";

    var showTreeMethod = $("[id='selectModule']", $(window.parent.document)).data("method");

    initEntityTree(paramId, moduleId, showTreeMethod, "#moduleTree", servletPath+"/console/resource/initModuleTree.action", "模块树");

    // initState();
});

// 原生的取得节点的方法
function selectNodeNative() {
    var vs = [];
    // var tree = $("#orgTree").dynatree("getTree");
    // no checkbox,active只有一个
    var selectedItems = $("#moduleTree").dynatree("getActiveNode");
    if (selectedItems) {
        v = selectedItems.data;
        vs.push(v);
    }

    // checkbox
    // var selectedItems = $("#moduleTree").dynatree("getSelectedNodes");
    // for (i = 0; i < selectedItems.length; i++) {
    // var v = selectedItems[i].data;
    // vs.push(v);
    // }
    return vs;

}
// 初始化选中项,每个树都对应自己的js，比如初始化orgTree，去org的js里写
function initState() {
    // 获得orgpath和userPath
    var path = $(".initModuleTree", $(window.parent.document)).val();

    var tree = $("#moduleTree").dynatree("getTree");

    // tree.getNodeByKey(userPath).select();
    tree.selectKey(path);

}