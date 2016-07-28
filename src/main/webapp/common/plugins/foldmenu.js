//凌伟峰的菜单
;
( function($) {
	$.fn.extend({
		"foldmenu" : function(options) {
			options = $.extend({
				speed : 200, // 菜单弹出的速度，值越小下拉效果越不明显
				closePop : true, // 是否点击页面上菜单区外关闭弹出菜单，默认为true，否需设置为false
				menuId : "fMenu" // 菜单外围容器ID
			}, options);
			return this.each( function() {
				var $that = $(this)
				$("dl>dt", this).bind(
						"click",
						function() {
							$(document).find(".fpop dd:visible").not("#" + options.menuId + " dd:visible").hide().siblings("dt").removeClass("on");
							if (!$(this).siblings().is("dd")) {
								$("#" + options.menuId + " .fpop dd:visible").hide().siblings("dt").removeClass("on");
							}

							if ($(this).siblings("dd").is(":hidden")) {
								if (!$that.find("dd").is(":animated")) {
									if ($(this).parent("dl").hasClass("fpop")) {
										var ww = $(window).width();
										var wh = $(window).height();
										var pw = $(this).width();
										var pl = $(this).offset().left;
										if (ww - pl - pw < pw) {
											$(this).parent("dl").find("dd").css("left", -pw + 2)
										} else if (pl < pw) {
											$(this).parent("dl").find("dd").css("left", pw - 2)
										}
									}
									$(this).addClass("on").siblings("dd").slideDown(options.speed).closest("li").siblings("li").children("dl").children("dt").removeClass("on").siblings("dd").slideUp(options.speed).find("dd").slideUp(options.speed)
											.siblings("dt").removeClass("on");
								}
							} else {
								$(this).removeClass("on").siblings("dd").slideUp(options.speed).find("dd").slideUp(options.speed).siblings("dt").removeClass("on");
							}
							return false;
						})
				if (options.closePop) {
					$(document).click( function() {
						$that.find("dl.fpop dd:visible").hide().siblings("dt").removeClass("on")
					})
				}
			})
		}
	})
})(jQuery);