var calendar = (function(){
	var setMonthActiveDays = function(month) {
		$('.b-calendar_week_day').removeClass('b-calendar_week_day_other');
		$('.b-i-calendar').find('.b-calendar_week_day:not(.js-month_' + month + ', .b-calendar_week_day_inactive)').addClass('b-calendar_week_day_other');
		
		$('.b-calendar_week_day').unbind();
		
		$('.b-calendar_week:not(.b-calendar_week_header) .b-calendar_week_day:not(.b-calendar_week_day_inactive)').mouseenter(function () {
			var $caption = $('.b-calendar').find('.b-calendar_week_day_caption');
			$(this).addClass('b-calendar_week_day_hover').append($caption);
		}).mouseleave(function () {
			$(this).removeClass('b-calendar_week_day_hover');
		}).click(function () {
			var $caption = $('.b-calendar').find('.b-calendar_week_day_flight');
			$('.b-calendar_week_day_selected').removeClass('b-calendar_week_day_selected');
			$(this).addClass('b-calendar_week_day_selected').append($caption);
			
			$('.b-popup').fadeIn(333);
			var date = parseInt($(this).attr('timestamp'));
			$('.b-popup_content_date').text(new Date(date).format('d mmmmm yyyy'));
			$("#date-text").val(new Date(date).format('d mmmmm'));
			$("#date-before").val(new Date(date+3*24*3600*1000).format('dd.mm.yyyy'));
			$("#date-after").val(new Date(date-3*24*3600*1000).format('dd.mm.yyyy'));
		});
	}

	var prepareCalendar = function() {
		var date = new Date();
		date.setDate(1);
		for (var i = 0; i < 12; i++) {
			var month = document.createElement('LI');
			$(month).addClass('b-calendar_months_item');
			$(month).addClass('b-calendar_months_item_' + date.format('mm'));
			if (i == 11) {
				$(month).addClass('b-calendar_months_item_last');
			}
			$(month).attr('month', date.format('mm'));
			if (!i) {
				$(month).addClass('b-calendar_months_item_selected');
			}
			$(month).html('<a href="#">' + date.format('mmmm') + '</a>');
			$('.b-calendar_months').append(month);
			date.setMonth(date.getMonth() + 1);
		}
		
		var date = new Date();
		date.setHours(0);
		date.setMinutes(0);
		date.setSeconds(0);
		var yesterday = new Date(date.getTime() - 1000 * 3600 * 24);
		
		date.setDate(1);
		var before = new Date(date.getTime());
		before.setFullYear(before.getFullYear() + 1);
		
		if (parseInt(date.format('ddddd'))) {
			date.setDate(1 - parseInt(date.format('ddddd')));
		}
		
		var i = 0;
		while (date.getTime() < before.getTime()) {
			var week = document.createElement('UL');
			$(week).addClass('b-calendar_week');
			$(week).attr('week', i++);
			for (var j = 0; j < 7; j++) {
				var day = document.createElement('LI');
				$(day).addClass('b-calendar_week_day');
				if (j == 0) {
					$(day).addClass('b-calendar_week_day_first');
				}
				else if (j > 4) {
					$(day).addClass('b-calendar_week_day_holyday');
					if (j == 6) {
						$(day).addClass('b-calendar_week_day_last');
					}
				}
				$(day).addClass('js-month_' + date.format('mm'));
				$(day).addClass('js-day_' + date.format('dd'));
				$(day).text(date.format('d'));
				$(day).attr('timestamp', date.getTime());
				
				if (parseInt(date.format('d')) == 1) {
					$(week).addClass('js-week_' + date.format('mm'));
				}
				
				if (date.getTime() <= yesterday.getTime()) {
					$(day).addClass('b-calendar_week_day_inactive');
				}
				
				$(week).append(day);
				date.setDate(date.getDate() + 1);
			}
			$('.b-i-i-calendar').append(week);
		}
		
		setMonthActiveDays(new Date().format('mm'));
		
		$('.b-calendar_months_item').click(function () {
			var month = $(this).attr('month');
			var $week = $('.js-week_' + month);
			var offset = parseInt($week.height()) * parseInt($week.attr('week'));
			
			$('.b-i-i-calendar').animate({'top': '-' + offset + 'px'}, 500, 'easeInOutExpo', function () {
				setMonthActiveDays(month);
			});
			
			$('.b-calendar_months_item_selected').removeClass('b-calendar_months_item_selected');
			$(this).addClass('b-calendar_months_item_selected');
			return false;
		});
	}
	return {
		prepare: prepareCalendar
	}
})();

$(function(){
	calendar.prepare();

	//fotorama
	$('.b-about_fotorama').fotorama({
	  width: '100%',
	  height: 350,
	  arrows: false,
	  background: 'transparent',
	  minPadding: 0,
	  margin: 0,
	  cropToFit: true,
	  onShowImg: function(data) {
		  var thumb = $('.b-about_gallery_item').get(data.index);
		  $('.b-about_gallery').find('.b-about_gallery_item_selected').removeClass('b-about_gallery_item_selected');
		  $(thumb).addClass('b-about_gallery_item_selected');
	  }
	});

	$('.b-about_gallery').find('a').click(function () {
		var fotorama = $('.b-about_fotorama').fotorama();
		fotorama.trigger('showimg', [parseInt($(this).attr('rel')), 333]);
		return false;
	});
});