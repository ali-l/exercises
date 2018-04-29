$(document).ready(function() {

	$(".reward").on("click", function(){
		event.preventDefault();
		$("#pledge-form").show();
	});

	// $('#pledge-form').on('submit', function(data) {
	// 	event.preventDefault();
	// 	var self = $(this), 
	// 		href = self.attr('action');
	// 	$.ajax({
	// 		url: href,
	// 		type: 'POST',
	// 		data: data,
	// 		dataType: 'html',
	// 	}).done(function(){
	// 		$("#pledge-form").text('Pledge successful!');
	// 	});

	// });


	// $('.submit-button :first-child').on('click', function(){
	// 	event.preventDefault();
	// 	var self = $(this), 
	// 		href = $('.new_pledge').attr('action');
		
	// 	$.ajax({
	// 		url: href,
	// 		type: 'POST',
	// 		dataType: 'html',
	// 	}).done(function(){
	// 		$("#pledge-form").text('Pledge successful!');

	// 	});

	// });
	
});