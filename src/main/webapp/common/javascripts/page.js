//分页函数
//beginPage = 0;//从第几条开始
//pageSize = 10;//每页显示多少条
//totalCount = -1;//总数
//totalPage = -1;//一共多少页
//currentPage = 1;//当前第几页
//count = false;//是否统计出总量
//first = true;//是否第一页
//last = true;//是否最后一页
//当前使用寻找表单的函数式formObj = beginPageEl.parents("form");，查找所有的parent，知道根父亲，过滤出表单，所以不能出现嵌套表单，不能同一页面出现多个分页标签
//换成closest可以避免
$( function() {
	var totalPageEl = $("[name$='.totalPage']");
	if (totalPageEl.size() ==0) {
		return;
	}
	var totalPage = totalPageEl.val();
	// 初始化option选项
	var selectGotoPage = $("select.gotoPage");
	if (selectGotoPage.size() > 0) {
		var currentPageEl = $("[name$='.currentPage']");
		var currentPage = currentPageEl.size() > 0 ? currentPageEl.val() : 1;
		var option = "";
		for ( var i = 1; i <= Number(totalPage / 1); i++) {
			if (i == currentPage) {
				// 初始化select当前第几页
				option += "<option value='" + i + "' selected='selected'>" + i + "</option>";
			} else {
				option += "<option value='" + i + "'>" + i + "</option>";
			}
		}
		selectGotoPage.append(option);
	}
});

/**
 * 跳转到第几页
 * 
 * @param pno
 * @param formAction
 * @param method
 * @param formId
 * @return
 */
function gotoPage(pno, formAction, method, formId) {

	var formObj;
	if (formId) {
		formObj = $("[id='" + formId + "']") || $("[name='" + formId + "']");// 获得form的jquery对象
	}
	var beginPageEl;
	var pageSizeEl;
	var totalCountEl;
	if (formObj) {
		beginPageEl = $("[name$='.beginPage']", formObj);
		pageSizeEl = $("[name$='.pageSize']", formObj);
		totalCountEl = $("[name$='.totalCount']", formObj);
	} else {
		beginPageEl = $("[name$='.beginPage']");
		pageSizeEl = $("[name$='.pageSize']");
		totalCountEl = $("[name$='.totalCount']");
		formObj = beginPageEl.closest("form");
	}
	var offset = 0;
	var pno = !pno ? 1 : Number(pno);

	pno = parseInt(pno / 1);
	pno = isNaN(pno) || pno < 1 ? 1 : pno;

	var nn = offset / 1 + pageSizeEl.val() / 1 * (pno - 1) / 1;

	beginPageEl.val(nn < 0 ? 0 : nn);
	submitFormBy(formObj, formAction, method);
}
/**
 * 首页
 * 
 * @param pageEntity是page实体的名称，此处可以设为null，因为取对象是根据以某属性结尾而取
 * @param formAction
 * @param method
 *            ajax还是正常的action提交
 * @param formId
 *            可写可不写，写的话就写form的id或者name
 * @return
 */
function firstPage(formAction, method, formId) {

	var formObj;
	if (formId) {
		formObj = $("[id='" + formId + "']") || $("[name='" + formId + "']");
	}
	var beginPageEl;
	if (formObj) {
		beginPageEl = $(":hidden[name$='.beginPage']", formObj);
	} else {
		beginPageEl = $(":hidden[name$='.beginPage']");
		formObj = beginPageEl.closest("form");
	}
	beginPageEl.val(0);

	submitFormBy(formObj, formAction, method);

}
/**
 * 上一页 *
 * 
 * @param formAction
 * @param method
 * @param formId
 * @return
 */
function prevPage(formAction, method, formId) {

	var formObj;
	if (formId) {
		formObj = $("[id='" + formId + "']") || $("[name='" + formId + "']");
	}
	var beginPageEl;
	var pageSizeEl;
	var totalCountEl;
	if (formObj) {
		beginPageEl = $("[name$='.beginPage']", formObj);
		pageSizeEl = $("[name$='.pageSize']", formObj);
	} else {
		beginPageEl = $("[name$='.beginPage']");
		pageSizeEl = $("[name$='.pageSize']");
		formObj = pageSizeEl.closest("form");
	}
	var length = pageSizeEl && pageSizeEl.val() ? pageSizeEl.val() : 0;

	var nn = Number(beginPageEl.val()) - Number(pageSizeEl.val());
	beginPageEl.val(nn < 0 ? 0 : nn);

	submitFormBy(formObj, formAction, method);
}
/**
 * 下一页
 * 
 * 
 * @param formAction
 * @param method
 * @param formId
 * @return
 */
function nextPage(formAction, method, formId) {
	var formObj;

	if (formId) {
		formObj = $("[id='" + formId + "']") || $("[name='" + formId + "']");
	}
	var beginPageEl;
	var pageSizeEl;
	var totalCountEl;
	if (formObj) {
		beginPageEl = $("[name$='.beginPage']", formObj);
		pageSizeEl = $("[name$='.pageSize']", formObj);
	} else {
		beginPageEl = $("[name$='.beginPage']");
		pageSizeEl = $("[name$='.pageSize']");
		formObj = beginPageEl.closest("form");
	}
	var length = pageSizeEl && pageSizeEl.val() ? pageSizeEl.val() : 0;
	beginPageEl.val(Number(beginPageEl.val()) + Number(pageSizeEl.val()));
	submitFormBy(formObj, formAction, method);
}
/**
 * 最后一页
 * 
 * 
 * @param formAction
 * @param method
 * @param formId
 * @return
 */
function lastPage(formAction, method, formId) {
	var formObj;
	if (formId) {
		formObj = $("[id='" + formId + "']") || $("[name='" + formId + "']");
	}
	var beginPageEl;
	var pageSizeEl;
	var totalCountEl;
	if (formObj) {
		beginPageEl = $("[name$='.beginPage']", formObj);
		pageSizeEl = $("[name$='.pageSize']", formObj);
		totalCountEl = $("[name$='.totalCount']", formObj);
	} else {
		beginPageEl = $("[name$='.beginPage']");
		pageSizeEl = $("[name$='.pageSize']");
		totalCountEl = $("[name$='.totalCount']");
		formObj = beginPageEl.closest("form");
	}
	var totalPage = Math.floor(((totalCountEl.val() / 1) + (pageSizeEl.val() / 1) - 1) / (pageSizeEl.val() / 1));
	beginPageEl.val((totalPage - 1) * (pageSizeEl.val() / 1));

	submitFormBy(formObj, formAction, method);
}
/**
 * 提交表单
 * 
 * @param formObj
 * @param formAction
 * @param method
 * @return
 */
function submitFormBy(formObj, formAction, method) {
	/**
	 * 分页参数里面的action，form要么写正确，要么不写，但是分页的bean，肯定要写的，隐藏域
	 */
	formObj.submit();
}
