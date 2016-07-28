/*
	数组参数：
	[0]:链接地址
	[1]:背景色 未定义则无背景色
	[2]:背景图片
	[3]:连接打开方式
	[4]:title
*/
(function(){
	roll = function(o) {
		var _h = [],
		_p = [],
		pos = ggpic;
		for (var i = 0; i < pos.length; i++) {
			var elem = pos[i];
			_h.push('<li><a href="' + elem[0] + '" target="_' + elem[3] + '" title="' + elem[4] + '"><img src="' + elem[2] + '" alt="'+elem[4]+'" height="323"></a></li>');
			//_h.push('<div class="slider_item" style="background:' + elem[1] + ' url(' + elem[2] + ') no-repeat 50% 0;"><a href="' + elem[0] + '" target="_' + elem[3] + '" title="' + elem[4] + '"></a></div>');
			if(i==0){
				_p.push('<li class="on"></li>');
			}
			else{
				_p.push('<li></li>');
			}
			
		}
		
		var count = $('<ul class="num1">' + _p.join('') + '</ul>');
		$(o).html(count);
		
		var slideBox = $('<div class="slideBox1"><div class="bd"><div class="tempWrap"><ul class="clearfix">' + _h.join("") + '</ul></div></div></div>');
		$(o).append(slideBox);
		
		autoStart();
		
		function autoStart() {
			jQuery(".slider1").slide({mainCell:".bd ul",titCell:".num1 li",effect:"fold",prevCell:".prev",nextCell:".next",autoPlay:true,easing:"swing",delayTime:800,interTime:3800});	
			jQuery(".slider2").slide({mainCell:".bd ul",effect:"left",prevCell:".prev",nextCell:".next",autoPlay:false,easing:"swing",delayTime:500});
			jQuery(".slider3").slide({mainCell:".bd ul",effect:"left",prevCell:".prev",nextCell:".next",autoPlay:false,easing:"swing",delayTime:500});
			jQuery(".slider4").slide({mainCell:".bd ul",effect:"left",prevCell:".prev",nextCell:".next",autoPlay:false,easing:"swing",delayTime:500});
			$("div.case").bind("mouseover",function(){$(this).siblings().removeClass("on").end().addClass("on").parents(".slider3").next(".slider3-con").find("div").eq($(this).index()).show().siblings().hide();});
		}
	}
	roll('#slider');
})();