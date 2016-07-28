( function($) {
	$( function() {

		initAuthrity();

	});

	/**
	 * 初始化带有action链接或者包含data-need-authority的按钮，设置hidden或者disabled
	 */
	function initAuthrity() {
		/**
		 * 每个页面引入，获得当前页面需要权限的控件，按钮或者超链接，带有超链属性action的
		 * 
		 * 获得authStrs(权限标识字串)，遍历控件的action是否包含在内，包含则有权限，按钮或超链显示，否则隐藏
		 * 
		 * authStrs数据来自数据库，资源管理设置的funcs
		 * 
		 * 
		 * 问题：入口的action和查询的action属于同已action，在资源管理的时候需要默认选择？
		 * 
		 * 后台也需要对权限判断
		 * 
		 * 
		 * 
		 * 
		 */

	}
})(jQuery)