var freshMan=(function($){
    return function (obj){
        var l,num=0;
        var _this=$(obj).eq(0),
            $wrap=_this.parents('.f-n-wrap').eq(0),
            $parent=_this.parent().eq(0),
            $btns=$wrap.find('.page-btn'),
            $tabs=$wrap.find('.u-slider-btn'),
            _size=_this.find('img').size(),
            _wth=$parent.width();
        /*width*/
        _this.width(_wth*_size);

        $tabs.click(function(event) {
            var idx=$tabs.index($(this));
            num=idx;
            move();
            thisAddClass('cur');
        });
        $btns.click(function(e) {
            var $target=$(e.target);
            if ($target.is('.prev-btn')) {
                if (num==0) {return};
                num--
                move();
                thisAddClass('cur');
            }else if ($target.is('.next-btn')) {
                if (num==_size-1) {return};
                num++
                move();
                thisAddClass('cur');
            }; ;
           
            /* Act on the event */
        });
        
        function move(){
            l=_wth*num;
            _this.stop().animate({'left' : -l + 'px'}, 600);
        }
        function thisAddClass(cls){
            $tabs.eq(num).addClass(cls).siblings().removeClass(cls);
        }
    }
})(jQuery);