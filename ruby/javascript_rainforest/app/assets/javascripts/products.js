$(document).on("ready page:load", function() {

	// Search as you type
	$("#search").keyup(function(event) {
		var searchValue = $("#search").val();
		$.getScript('/products?&typed=true&search=' + searchValue);
	});

	// Infinite scroll
	if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination span.next').children().attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Fetching more products...");
        return $.getScript(url);
      }
    });
  }
});