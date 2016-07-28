//tab页的函数
$(function() {
	$(".module_tabs>a").each(function(i, v) {
		$(this).click(function() {

			$(this).addClass("current").siblings().removeClass("current");
			//多个div
			$(this).parent().next(".module_tabs_cons").children(".tabs_con").eq(i).show().siblings().hide();
			//ajax方式.一个div
			//$(this).parent().next(".module_tabs_cons").children(".tabs_con").text($(this).text());
		})
	})
});
