$(document).ready(function() {
	$(".right-menu").height(Math.max($(".right-menu").height(),window.innerHeight-$(".navbar-wrapper").height()-$(".footer").height()));
    $(".toggle-rightmenu").on("click", function(){
    	$(".right-menu").show().toggleClass("slideInRight").toggleClass("slideOutRight");
    });
	$(window).scroll(function() {
		if($(window).scrollTop() > 60) {
			$('.scrollTop').fadeIn();
		} else {
			$('.scrollTop').fadeOut();
		}
	});		    	
});		    	
function showConfirmModal(msg) {
	$('#confirm_msg').html(msg);
	$("#confirm_dialog").modal('show');
}
