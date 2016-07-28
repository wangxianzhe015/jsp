// 定义一个全局变量，有此变量的域都可以使用该变量的属性
var commonVanus = {};
$( function() {
	var userId = $("#shortcutMenuSetting").data("userid");
	$.cookies.set("_user_id", userId);
	// 初始化左侧主目录
	commonVanus.initLeftMainMenus();
	// 初始化快捷菜单
	commonVanus.initShortcutMenus();
	// 初始化iframe

	var url = servletPath+'/console/login/index.action', title = "当前位置:首页", frm = $("iframe", ".iframe_wrap");
	commonVanus.sendForwardAndSetTitle(title, url, frm);

	// 权限树设置快捷菜单的函数显示开关
	$(".funcSwitch").each( function(i, v) {
		$(this).on("click", function() {
			var id = $(this).attr("id");
			var ciframe = document.getElementById("permissionTreeIframe").contentWindow;
			var iframeContent = ciframe.PermissionTreeVar, iframeDom = ciframe.document;
			if ($(".dynatree-container", $(iframeDom)).length > 0) {
				switch (id) {
					case "funcSwitchOpen" :
						iframeContent.initPermissionTree("open");
						break;
					case "funcSwitchClose" :
						iframeContent.initPermissionTree("close");
						break;
					default :
						iframeContent.initPermissionTree("close");
						break;
				}
			} else {
				alert('权限树尚未加载完成');
			}
		});
	});
});

// 初始化左侧主目录
commonVanus.initLeftMainMenus = function() {
	$.ajax({
		url : servletPath+"/console/login/getMainMenus.action",
		data : {},
		type : 'POST',
		async : false,
		dataType : 'json',
		beforeSend : function() {
		},
		global : false,
		// timeout : 20000,// 不加超时
		error : function() {
			alert('主菜单加载超时或出错');
		},
		success : function(data) {
			var mdata = data.menus, mcount = data.menusCount, mhtml = "";
			var i = 0;
			mhtml += "<ul>";
			$.each(mdata, function(k, v) {
				switch (i) {
					case 0 :
						mhtml += '<li><dl><dt class="first"><a href="javascript:void(0);">' + k + '</a><i></i><b></b></dt>';
						break;
					case mcount - 1 :
						mhtml += '<li><dl><dt class="last"><a href="javascript:void(0);">' + k + '</a><i></i><b></b></dt>';
						break;
					default :
						mhtml += '<li><dl><dt><a href="javascript:void(0);">' + k + '</a><i></i><b></b></dt>';
						break;
				}
				mhtml += "<dd>";
				mhtml += getMenuChildren(v);
				mhtml += "</dd>";
				mhtml += '</dl></li>';
				i++;
			});
			mhtml += "</ul>";
			$(".fmain").append(mhtml);

			$("#fMenu a[data-url]").closest("dt").bind("click", function() {
				var urltarget = $(this).find("a[data-url]");
				var url = urltarget.data("url"), title = urltarget.data("title"), frm = $("iframe", ".iframe_wrap");
				commonVanus.sendForwardAndSetTitle(title, url, frm);
			});

			$("#fMenu").foldmenu();
		}
	});
}
// 初始化快捷菜单
commonVanus.initShortcutMenus = function() {
	$.ajax({
		url : servletPath+"/console/login/getShortcutMenus.action",
		data : {},
		type : 'POST',
		async : false,
		dataType : 'json',
		beforeSend : function() {
			$(".tmenu").html("快捷菜单加载中...");
		},
		global : false,
		// timeout : 20000,//不加超时
		error : function() {
			alert('快捷菜单加载超时或出错');
		},
		success : function(data) {
			var scdata = data.smlist, schtml = "";
			schtml += "<ul>";

			$.each(scdata, function(i, v) {
				var scMenu = v.shortcutMenu, scMenusChildren = v.children, childrensLength = scMenusChildren.length;
				if (childrensLength > 0) {
					schtml += '<li class="select">';
					schtml += '<dl class="fpop">';
					schtml += '<dt><a href="javascript:void(0);" title="' + scMenu.shortcutMenuName + '">' + scMenu.shortcutMenuName + '</a><i></i></dt><dd>';
					schtml += getShortcutMenuChildren(scMenusChildren);
					schtml += "</dd>";
				} else {
					// 链接加在最后一级上的
					schtml += '<li><dl><dt><a href="javascript:void(0);" title="' + scMenu.shortcutMenuName + '" data-url="' + scMenu.shortcutMenuUrl + '" data-title="' + scMenu.shortcutMenuName + '">' + scMenu.shortcutMenuName + '</a></dt>';
				}
				schtml += "</dl></li>";
			});
			schtml += "</ul>";

			$(".tmenu").html(schtml);

			// 整个快捷菜单栏都触发
		$("#main a[data-url]").bind("click", function() {
			var urltarget = $(this);// 这个单击a才行
				var url = urltarget.data("url"), title = urltarget.data("title"), frm = $("iframe", ".iframe_wrap");
				commonVanus.sendForwardAndSetTitle(title, url, frm);
			});

		$("#tMenu").foldmenu({
			menuId : "tMenu"
		});
	}
	});

}
// 取得快捷菜单的children
function getShortcutMenuChildren(sclist) {
	var tmp = "";
	tmp += "<ul>";
	$.each(sclist, function(i, v) {
		var scMenu = v.shortcutMenu, scMenusChildren = v.children, childrensLength = scMenusChildren.length;
		if (childrensLength > 0) {
			tmp += '<li>';
			tmp += '<dl class="fpop">';
			tmp += '<dt><a href="javascript:void(0);">' + scMenu.shortcutMenuName + '</a><i></i></dt><dd>';
			tmp += getShortcutMenuChildren(scMenusChildren);
			tmp += "</dd>";
		} else {
			tmp += '<li><dl><dt><a href="javascript:void(0);" data-url="' + scMenu.shortcutMenuUrl + '" data-title="' + scMenu.shortcutMenuName + '">' + scMenu.shortcutMenuName + '</a></dt>';
		}
		tmp += "</dl></li>";
	});
	tmp += "</ul>";
	return tmp;
}
// 取得主菜单的children
function getMenuChildren(mlist) {
	var tmp = "";
	$.each(mlist, function(i, v) {
		tmp += '<li><dl class="fpop">';
		if (v.children && v.children.length > 0) {
			tmp += '<dt><a href="javascript:void(0);">' + v.menuName + '</a><i></i></dt><dd><b class="b1"></b><b class="b2"></b><div class="fmain"><ul>';
			$.each(v.children, function(ii, vv) {
				tmp += '<li><dl class="fpop">';
				if (vv.children && vv.children.length > 0) {
					tmp += '<dt><a href="javascript:void(0);">' + vv.menuName + '</a><i></i></dt>';
					tmp += '<dd><b class="b1"></b><b class="b2"></b><div class="fmain"><ul>';
					tmp += getMenuChildren(vv.children);
					tmp += '</ul></div><b class="b3"></b><b class="b4"></b></dd>';
				} else {
					// 链接也是加在最后一级
					tmp += '<dt><a href="javascript:void(0);" data-url="' +vv.menuUrl + '" data-title="' + vv.menuName + ' ">' + vv.menuName + '</a></dt>';
				}
				tmp += '</dl></li>';
			});
			tmp += '</ul></div><b class="b3"></b><b class="b4"></b></dd>';
		} else {
			tmp += '<dt><a href="javascript:void(0);" data-url="' + v.menuUrl + '" data-title="' + v.menuName + '">' + v.menuName + '</a></dt>';
		}
		tmp += '</dl></li>';
	});

	return tmp;
}

commonVanus.sendForwardAndSetTitle = function(title, url, frm) {
	if (title) {
		setCurrentText(title);
	}
	directToURL(url, frm);
}
/**
 * 设置标题
 */
function setCurrentText(title) {
	$(".submain #currentLocation").text(title);
}
/**
 * 设置frame跳转
 */
function directToURL(url, frm) {
	frm.attr("src", url);
}
