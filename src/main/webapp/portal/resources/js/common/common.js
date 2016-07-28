/**
 * 弹窗提示
 * @param msg 提示内容
 * @param type 提示类型(success,error,info)
 * @param time_num 倒计时关闭
 * @param call_fun 回调函数
 */
 var callfun = null;
function popBox(msg,type,time_num,call_fun,is_static){
	callfun = call_fun; // 直接使用在页面中多个弹出框的时候会出现回调函数无法正确调用的情况 modify by quanzhijie at 2015/4/27 21:07
    is_static = is_static||false;
	if(!msg) return false;
	if(!time_num) time_num = 3;
	var _match = /^[0-9]+.?[0-9]*$/;
	var _str = '';
	_str = '<div class="modal fade" id="popBox" tabindex="-1" role="dialog" aria-hidden="true">';
	_str += '<div class="modal-dialog modal-alert">';
	_str += '<div class="modal-content">';
	_str += '<div class="modal-body">';
	_str += '<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
	_str += '<table>';
	_str += '<tr id="popBoxContent">';
	_str += '</tr>';
	_str += '</table>';
	_str += '</div>';
	_str += '</div>';
	_str += '</div>';
	_str += '</div>';
	if($('#popBox').is('#popBox') == false){
		$('body').append(_str);
        if(is_static){
            $("#popBox").modal({
                keyboard: false,
                backdrop: 'static',
                show: false
            });
        }
		if(typeof(callfun) == 'function'){
			$('#popBox').on('hidden.bs.modal', function (e) {callfun();});
		}
	}

	var _tips,_tips2;
	_tips2 = '<p>'+ msg +'</p>';
	if(_match.test(time_num)){
		_tips2 += '<p class="text-muted">消息将在 <span id="popTimeNum">'+time_num+'</span> 秒后消失。</p>';
	}
	if(type == 'error'){
		_tips = '<td width="80" class="pop-error">&nbsp;</td><td><h2>失败</h2>'+ _tips2 +'</td>';
	}else if(type == 'info'){
		_tips = '<td width="80" class="pop-info">&nbsp;</td><td><h2>提示</h2>'+ _tips2 +'</td>';
	}else{
		_tips = '<td width="80" class="pop-success">&nbsp;</td><td><h2>成功</h2>'+ _tips2 +'</td>';
	}
	$('#popBoxContent').html(_tips);
	$('#popBox').modal('toggle');
	if(_match.test(time_num)){
		var timer = '';
		$("#popTimeNum").html(time_num);
		timer = setInterval(function(){
			var count = parseInt(parseInt($("#popTimeNum").html()) - 1);
			if(count > 0){
				$("#popTimeNum").html(count);
			}else{
				clearInterval(timer);
				$('#popBox').modal('hide');
			}
		},1000);
	}else{
		
	}

}

function appPopBox(msg,type){
    var is_static = false;
    var _str = '';
    _str = '<div class="modal fade" id="popBox" tabindex="-1" role="dialog" aria-hidden="true">';
    _str += '<div class="modal-dialog modal-alert">';
    _str += '<div class="modal-content">';
    _str += '<div class="modal-body">';
    //_str += '<button type="button" class="modal-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
    _str += '<table>';
    _str += '<tr id="popBoxContent">';
    _str += '</tr>';
    _str += '</table>';
    _str += '</div>';
    _str += '</div>';
    _str += '</div>';
    _str += '</div>';
    if($('#popBox').is('#popBox') == false){
        $('body').append(_str);
        if(is_static){
            $("#popBox").modal({
                keyboard: false,
                backdrop: 'static',
                show: false
            });
        }
        if(typeof(callfun) == 'function'){
            $('#popBox').on('hidden.bs.modal', function (e) {callfun();});
        }
    }
    var _tips,_tips2;
    _tips2 = '<p>'+ msg +'</p>';
    if(type == 'error'){
        _tips = '<td width="80" class="pop-error">&nbsp;</td><td><h2>失败</h2>'+ _tips2 +'</td>';
    }else if(type == 'info'){
        _tips = '<td width="80" class="pop-info">&nbsp;</td><td><h2>提示</h2>'+ _tips2 +'</td>';
    }else{
        _tips = '<td width="80" class="pop-success">&nbsp;</td><td><h2>成功</h2>'+ _tips2 +'</td>';
    }
    $('#popBoxContent').html(_tips);
    $('#popBox').modal('toggle');
}

/*tab切换插件*/
TabClass=function(a){this.tabName=a.tabName;this.cntName=a.cntName;this.number=a.number;this.tabShowCls=a.tabShowCls;if(a.tabHiddenCls){this.tabHiddenCls=a.tabHiddenCls}else{this.tabHiddenCls=""}if(a.cntShowCss){this.cntShowCss=a.cntShowCss}else{this.cntShowCss="block"}this.show=function(b){for(var c=0;c<this.number;c++){if(c!=b){$("#"+this.tabName+"_"+c).removeClass(this.tabShowCls);if(this.tabHiddenCls){$("#"+this.tabName+"_"+c).addClass(this.tabHiddenCls)}$("#"+this.cntName+"_"+c).css("display","none")}else{if(this.tabHiddenCls){$("#"+this.tabName+"_"+c).removeClass(this.tabHiddenCls)}$("#"+this.tabName+"_"+c).addClass(this.tabShowCls);$("#"+this.cntName+"_"+c).css("display",this.cntShowCss)}}}};


/*pc_v3.0登录后*/
$(function(){
	$('.after-landing-ul li').hover(function(){
		$(this).addClass('on').siblings().removeClass('on');
	});
});
$(function(){
	$('.after-landing-list').hover(function(){
		$('.after-landing-ul').toggle();
	});
});

/*pc_v3.0底部友情链接*/
$(function(){ 
	$(".footer-list-b span").toggle(function(){ 
	    $(this).addClass('on');
	    $('.links-list').show(); 
	    var t = $(window).scrollTop();
        $('body,html').animate({'scrollTop':t+200},100);
	},function(){ 
	    $(this).removeClass('on');
	    $('.links-list').hide(); 
	}); 
}); 




//pc_v3.0返回顶部
$(function(){  
   //当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失  
   $(function () {  
		$(window).scroll(function(){  
			if ($(window).scrollTop()>100){  
				$("#top-btn-li").fadeIn(1500);  
			}  
			else  
			{  
				$("#top-btn-li").fadeOut(1500);  
			}  
		});  
		//当点击跳转链接后，回到页面顶部位置  
		$("#top-btn-li").click(function(){ 
			$('body,html').animate({scrollTop:0},500);  
			return false;  
		});  
	});  
});  
//pc_v3.0右侧导航
$(".right-nav-list li").live('mouseover', function() {	
	    $(this).addClass('on');
		$('.nav-content').eq($(this).index()).show();
	}).live("mouseleave",function() {
		$(this).removeClass('on');
		$('.nav-content').eq($(this).index()).hide();
});	
/*pc_v3.0右侧导航*/
$(".right-top-ul li").live('mouseover', function() {	
	    $(this).addClass('on');
		$('.right-show').eq($(this).index()).show();
	}).live("mouseleave",function() {
		$(this).removeClass('on');
		$('.right-show').eq($(this).index()).hide();
});	
$(".right-top-ul2 li").live('mouseover', function() {	
	    $(this).addClass('on');
		$('.right-show2').eq($(this).index()).show();
	}).live("mouseleave",function() {
		$(this).removeClass('on');
		$('.right-show2').eq($(this).index()).hide();
});	


/*wap_v2.0头部*/
$(function(){
	$('.header-r p').click(function(){
		  $('.header-nav').toggle();
	});
});

/*wap_v2.0底部*/
$(function(){
	$('.footer-ul li').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
	});
});




