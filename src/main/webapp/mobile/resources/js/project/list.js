$(document).ready(function(){
	$("#menu1").on("click",function(){
		$(".project-category").removeClass("active");
		$(this).addClass("active");
		$(".box").show();
	});
	$("#menu2").on("click",function(){
		$(".project-category").removeClass("active");
		$(this).addClass("active");
		$(".box").hide();
		$(".financing").show();
	});
	$("#menu3").on("click",function(){
		$(".project-category").removeClass("active");
		$(this).addClass("active");
		$(".box").hide();
		$(".prepared").show();
	});
	$("#menu4").on("click",function(){
		$(".project-category").removeClass("active");
		$(this).addClass("active");
		$(".box").hide();
		$(".successed").show();
	});
});