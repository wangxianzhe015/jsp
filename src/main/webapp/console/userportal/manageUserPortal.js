//用户端新增portlets

$( function() {
	$("#addUserPortalForm [name='userPortal.portal.catalogId']").multiselect({
		header : '已添加入库的不可选',
		height : 150,
		minWidth : 210,
		noneSelectedText : "请选择需添加的portlet",
		selectedText : '已添加#个portlet',
		classes : '',
		selectedList : 1,
		multiple : true,
		click : function(e) {
			if ($(this).multiselect("widget").find("input:checked").length > 1) {
				alert('只能选一个');
				return false;
			}
		},
		close : function() {
			$(this).blur();
		}
	});
});
/**
 * 获得修改UserPortal时的校验对象
 * 
 * @return
 */
function getUpdateUPVO() {
	var validateFormRule = {
		ignore : "",
		rules : {
			"userPortal.portal.catalogId" : {
				required : true
			},
			"userPortal.portalTitleSelf" : {
				required : true
			},
			"userPortal.portalHeight" : {
				required : true
			}
		},
		messages : {
			"userPortal.portal.catalogId" : {
				required : "没有关联portal!"
			}
		}
	};
	var vo = validateForm("#updateUserPortalForm", validateFormRule);
	return vo;
}

/**
 * 获得添加userPortal时的校验对象
 * 
 * @return
 */
function getAddUPVO() {
	var validateFormRule = {
		ignore : "",
		rules : {
			"userPortal.portal.catalogId" : {
				required : true,
				maxlength : 1
			},
			"userPortal.portalTitleSelf" : {
				required : true
			},
			"userPortal.portalHeight" : {
				required : true
			},
			"userPortal.portalX" : {
				required : true
			},
			"userPortal.portalY" : {
				required : true,
				number : true,
				min : 1
			}
		},
		messages : {
			"userPortal.portal.catalogId" : {
				required : '请选择',
				maxlength : '只能选择{0}个'
			},
			"userPortal.portalX" : {
				required : '请选择显示在第几列'
			},
			"userPortal.portalY" : {
				min : "最小是{0}"
			}
		}
	};
	var vo = validateForm("#addUserPortalForm", validateFormRule);
	return vo;
}
/**
 * 从缓存加载内容，以备更新
 * 
 * @param _userPortal
 * @return
 */
function buildUpdateUPHtml(_userPortal) {
	var $frm = $("#updateUserPortalForm");
	$frm.clearForm();
	$("[name='userPortal.userPortalId']", $frm).val(_userPortal.userPortalId);
	$("[name='userPortal.portalTitleSelf']", $frm).val(_userPortal.portalTitleSelf);
	$('td[data-po="userPortal.portal.catalogTitle"] span', $frm).empty().text(_userPortal.portal.catalogTitle);
	$('[name="userPortal.portal.catalogId"]', $frm).val(_userPortal.portal.catalogId);
	$("[name='userPortal.portalHeight']", $frm).val(_userPortal.portalHeight);
}

// 加载select的内容
function buildPortletSelectHtml() {
	$.ajax({
		url : servletPath+"/console/userportal/initPortletsCanBeSelected.action",
		data : {},
		type : 'POST',
		dataType : 'json',
		global : false,
		// async : false,
		// timeout : 5000,
		error : function() {
		},
		beforeSend : function() {
		},
		success : function(data) {
			var ups = data.pllist;
			ups.sort( function(a, b) {
				return (a.persistState!=null && b.persistState!=null) && (a.persistState.length > b.persistState.length) ? 1 : -1;
			});
			
			var notSelects = $.map(ups, function(up) {
				return up.persistState ? null : up;

			});
			
			if (notSelects.length == 0) {
				$("#addUserPortalForm [name='userPortal.portal.catalogId']").empty().multiselect("refresh").multiselect("option", {
					noneSelectedText : "已全部添加,或无可用选择项"
				});

			} else {
				var html = "";
				$.each(ups, function(i, up) {
					var persist = up.persistState, portal = up.portal;
					html += '<option value="' + portal.catalogId + '" ' + (persist ? "disabled='disabled'" : "") + '>' + portal.catalogTitle + '</option>';

				});
				$("#addUserPortalForm [name='userPortal.portal.catalogId']").empty().html(html).multiselect("option", {
					noneSelectedText : "请选择需添加的portlet"
				}).multiselect("refresh");
			}

		},
		complete : function(XHR, textStatus) {
		}
	});

}

// 加载选布局
function buildPortalLayoutSelectHtml(columnLength) {
	var radio = '';
	for ( var i = 1; i <= columnLength; i++) {
		radio += '<input type="radio" id="portalLayoutSelect_radio' + i + '" name="userPortal.portalX"  value="' + i + '"/>';
		radio += '<label for="portalLayoutSelect_radio' + i + '">' + i + '</label>';
	}
	$("#portalLayoutSelect").empty().html(radio).buttonset();
}
