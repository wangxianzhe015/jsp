( function($) {
	$( function() {
		$("map#m_set_skin>area").each( function(i) {

			$(this).click( function() {
				alert($(this).data("key"));
			});
		});
	});
})(jQuery)
