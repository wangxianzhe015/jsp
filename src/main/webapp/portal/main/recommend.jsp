<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>推荐项目</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>

body {
    font: 12px/1.5 microsoft yahei,tahoma,arial,'Hiragino Sans GB',\5b8b\4f53,sans-serif;
}

.s-order {
    width: 100%;
    clear: both;
}

.s-order .weekly-top-content {
    width: 100%;
    height: 310px;
    margin-top: 20px;
}
.s-order .weekly-top-content .content-wrap {
    width: 1190px;
    margin: 0 auto;
}
.s-order .weekly-top-content .content-wrap .item-detail {
    float: left;
    width: 890px;
    height: 310px;
    position: relative;
    background-color: #ececec;
}
.s-order .weekly-top-content .content-wrap .item-detail .indicate {
    -webkit-transition: top .2s;
    -moz-transition: top .2s;
    -ms-transition: top .2s;
    -o-transition: top .2s;
    transition: top .2s;
    position: absolute;
    top: 20px;
    right: 0;
    font-size: 0;
    width: 0;
    height: 0;
    display: block;
    border-color: transparent #ff6458 transparent transparent;
    border-style: solid;
    border-width: 15px;
}
.s-order .weekly-top-content .content-wrap .item-detail a {
    text-decoration: none;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box {
    width: 850px;
    height: 270px;
    background: #fafafa;
    display: none;
    margin: 20px;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .item-image {
    display: block;
    float: left;
    width: 410px;
    height: 270px;
    overflow: hidden;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .item-image img {
    max-width: 410px;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .item-info {
    float: left;
    width: 420px;
    padding-left: 20px;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .title {
    display: block;
    font-family: "Microsoft YaHei",sans-serif;
    width: 370px;
    height: 24px;
    padding: 15px 0 20px;
    font-size: 16px;
    font-weight: 700;
    color: #666;
    overflow: hidden;
    white-space: nowrap;
    word-break: break-all;
    word-wrap: break-word;
    text-overflow: ellipsis;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .money-title {
    display: block;
    font-weight: 400;
    font-size: 14px;
    color: #666;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .current-money {
    display: block;
    font-size: 25px;
    color: #00cccf;
    font-family: impact,sans-serif;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .current-money .yen {
    font-family: arial;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail {
    display: block;
    width: 385px;
    height: 40px;
    padding: 20px 0;
}
a:-webkit-any-link {
    color: -webkit-link;
    text-decoration: underline;
    cursor: auto;
}
a {
    text-decoration: none;
}

.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .schedule-bar {
    float: left;
    display: block;
    width: 325px;
    height: 10px;
    margin-bottom: 15px;
    background: #e5e5e5;
    box-shadow: 0 1px 0 rgba(200,200,200,.8) inset;
    border-radius: 5px;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .schedule-current {
    background: url(//gtms03.alicdn.com/tps/i3/TB1d_hTFVXXXXbsXXXXD7xMFXXX-17-9.gif) repeat-x 0 1px;
    height: 10px;
    display: block;
    background-image: -webkit-gradient(linear,0 100%,100% 0,from(transparent),color-stop(0.25,transparent),color-stop(0.25,rgba(255,255,255,.3)),color-stop(0.5,rgba(255,255,255,.3)),color-stop(0.5,transparent),color-stop(0.75,transparent),color-stop(0.75,rgba(255,255,255,.3)),to(rgba(255,255,255,.3))),-webkit-gradient(linear,0 100%,0 0,from(#00ccce),to(#5ededf));
    background-size: 20px 20px,100% 100%;
    -webkit-animation: progress .8s linear infinite;
    border-radius: 5px;
}
i, cite, em, var, address, dfn {
    font-style: italic;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .percentage {
    margin-top: -6px;
    font-size: 14px;
    float: left;
    display: block;
    padding-left: 10px;
    color: #666;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data {
    width: 100%;
    clear: both;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data .time-left, .s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data .support-number {
    color: #666;
    overflow: hidden;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data span {
    float: left;
    display: block;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data b {
    font-family: iconfont;
    font-weight: 400;
    font-size: 16px;
    padding-right: 5px;
}

.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data .data-number {
    padding-left: 5px;
    padding-right: 15px;
    font-size: 14px;
    color: #00cccf;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .project-status-detail .projects-schedule-data .time-left {
    background-position: left bottom;
}
.s-order .weekly-top-content .content-wrap .item-detail a .item-detail-box .desc {
    float: left;
    width: 370px;
    height: 85px;
    font-size: 14px;
    color: #666;
    overflow: hidden;
}
.s-order .weekly-top-content .content-wrap .right-panel {
    margin-left: -5px;
    float: left;
    padding-left: 5px;
    width: 300px;
    height: 320px;
    overflow: hidden;
}

ol, ul {
    list-style: none;
}
.s-order .weekly-top-content .content-wrap .right-panel li {
    position: relative;
    width: 300px;
    height: 61px;
    float: left;
    background: #b3bfc7;
    cursor: pointer;
}

.s-order .weekly-top-content .content-wrap .right-panel li i {
    position: absolute;
    top: 0;
    left: 0;
    width: 60px;
    height: 60px;
    display: block;
    overflow: hidden;
    float: left;
    font-family: ArialMT;
    font-style: italic;
    font-size: 38px;
    font-weight: lighter;
    color: #efecec;
    text-align: center;
    line-height: 60px;
}
.s-order .weekly-top-content .content-wrap .right-panel li .info-con {
    width: 230px;
    height: 60px;
    margin-left: 70px;
    border-bottom: 1px solid #c0c9d0;
}
.s-order .weekly-top-content .content-wrap .right-panel li .project-title {
    display: block;
    font-size: 16px;
    color: #fff;
    width: 210px;
    height: 20px;
    line-height: 20px;
    padding-top: 12px;
    overflow: hidden;
    white-space: nowrap;
    word-break: break-all;
    word-wrap: break-word;
    text-overflow: ellipsis;
}
.s-order .weekly-top-content .content-wrap .right-panel li .support-num {
    display: block;
    font-size: 12px;
    color: #efecec;
}
.s-order .weekly-top-content .content-wrap .right-panel li.current {
    height: 62px;
    background: #ff6458;
}
.s-order .weekly-top-content .content-wrap .right-panel li.current .support-num {
    height: 61px;
    line-height: 61px;
    font-size: 16px;
    color: #fff;
}


	</style>

  </head>
  
  <body>

<div class="s-order" data-spm="5" id="J_orderSection" data-spm-max-idx="5">
<div class="weekly-top-content">
        <div class="content-wrap J_WeeklyContent">
        <div class="item-detail">
    <b class="indicate J_WeeklyHot" style="top: 78px;"></b>
    <a class="J_itemDetailBox" href="//izhongchou.taobao.com/dreamdetail.htm?id=10040190" target="_blank">
                    <span class="item-detail-box item-detail-box-1">
                        <span class="item-image">
                            
                                 <img src="//img.alicdn.com/tfscom/TB13p.3JpXXXXc9XFXXSutbFXXX_430x430q75.jpg" alt="">

                            

                        </span>
                        <span class="item-info">
                            <span class="title">靠谱煲-WIFI智能，沁麟联合阿里小智为靠谱新青年</span>
                            <span class="money-title">目前累计资金:</span>
                            <span class="current-money"><span class="yen">￥</span>2002156.00</span>
                            <span class="project-status-detail">
                                <span class="project-status-bar">
                                <span class="schedule-bar">
                                    <i class="schedule-current progress-bar progress-bar-striped active" style="width:100%;"></i>
                                </span>
                                    <span class="percentage">2002%</span>
                                </span>
                                <span class="projects-schedule-data">

                                    <span class="support-number"><b></b>支持人数:</span><span class="data-number">18073</span>
                                    <span class="time-left"><b></b>剩余时间:</span><span class="data-number">18天</span>
                                </span>
                            </span>
                            <span class="desc">
                                Ciline 靠谱煲，阿里云智能，美味随心，99元献给靠谱新青年！智能、灵巧、美味、全能
                            </span>
                        </span>

                    </span>
    </a>
    
    <a class="J_itemDetailBox" href="//izhongchou.taobao.com/dreamdetail.htm?id=36102" target="_blank">
                    <span class="item-detail-box item-detail-box-2 item-detail-show">
                        <span class="item-image">
                            
                                 <img alt="" src="//img.alicdn.com/tfscom/TB1bbFhIVXXXXb_aXXXSutbFXXX_430x430q75.jpg">

                            

                        </span>
                        <span class="item-info">
                            <span class="title">六元老人午餐温暖全世界</span>
                            <span class="money-title">目前累计资金:</span>
                            <span class="current-money"><span class="yen">￥</span>226140.00</span>
                            <span class="project-status-detail">
                                <span class="project-status-bar">
                                <span class="schedule-bar">
                                    <i class="schedule-current progress-bar progress-bar-striped active" style="width:100%;"></i>
                                </span>
                                    <span class="percentage">2261%</span>
                                </span>
                                <span class="projects-schedule-data">

                                    <span class="support-number"><b></b>支持人数:</span><span class="data-number">11155</span>
                                    <span class="time-left"><b></b>剩余时间:</span><span class="data-number">9天</span>
                                </span>
                            </span>
                            <span class="desc">
                                每六元就可以成为一份爱心老人免费餐，温暖老人心，温暖全世界
                            </span>
                        </span>

                    </span>
    </a>
    
    <a class="J_itemDetailBox" href="//izhongchou.taobao.com/dreamdetail.htm?id=10040960" target="_blank">
                    <span class="item-detail-box item-detail-box-3">
                        <span class="item-image">
                            
                                 <img alt="" src="//img.alicdn.com/tfscom/TB1CxykJFXXXXXXXFXXSutbFXXX_430x430q75.jpg">

                            

                        </span>
                        <span class="item-info">
                            <span class="title">来电-颠覆众人想象的九良芯线</span>
                            <span class="money-title">目前累计资金:</span>
                            <span class="current-money"><span class="yen">￥</span>2928355.00</span>
                            <span class="project-status-detail">
                                <span class="project-status-bar">
                                <span class="schedule-bar">
                                    <i class="schedule-current progress-bar progress-bar-striped active" style="width:100%;"></i>
                                </span>
                                    <span class="percentage">292%</span>
                                </span>
                                <span class="projects-schedule-data">

                                    <span class="support-number"><b></b>支持人数:</span><span class="data-number">36786</span>
                                    <span class="time-left"><b></b>剩余时间:</span><span class="data-number">11天</span>
                                </span>
                            </span>
                            <span class="desc">
                                “来电”---更粗（191芯，苹果74芯）更持久（接头耐折1.5万次）研发四年，拿下中国发明专利！
                            </span>
                        </span>

                    </span>
    </a>
    
    <a class="J_itemDetailBox" href="//izhongchou.taobao.com/dreamdetail.htm?id=10041073" target="_blank">
                    <span class="item-detail-box item-detail-box-4">
                        <span class="item-image">
                            
                                 <img alt="" src="//img.alicdn.com/tfscom/TB1jTJlJFXXXXayXpXXSutbFXXX_430x430q75.jpg">

                            

                        </span>
                        <span class="item-info">
                            <span class="title">优雅的不像实用派——【莫比乌斯】苹果手表手机支架！</span>
                            <span class="money-title">目前累计资金:</span>
                            <span class="current-money"><span class="yen">￥</span>1011117.00</span>
                            <span class="project-status-detail">
                                <span class="project-status-bar">
                                <span class="schedule-bar">
                                    <i class="schedule-current progress-bar progress-bar-striped active" style="width:100%;"></i>
                                </span>
                                    <span class="percentage">1011%</span>
                                </span>
                                <span class="projects-schedule-data">

                                    <span class="support-number"><b></b>支持人数:</span><span class="data-number">9556</span>
                                    <span class="time-left"><b></b>剩余时间:</span><span class="data-number">1天</span>
                                </span>
                            </span>
                            <span class="desc">
                                专门为苹果手表手机定制的一款支架
                            </span>
                        </span>

                    </span>
    </a>
    
    <a class="J_itemDetailBox" href="//izhongchou.taobao.com/dreamdetail.htm?id=10039898" target="_blank">
                    <span class="item-detail-box item-detail-box-5">
                        <span class="item-image">
                            
                                 <img alt="" src="//img.alicdn.com/tfscom/TB1cAx8JpXXXXXfXFXXSutbFXXX_430x430q75.jpg">

                            

                        </span>
                        <span class="item-info">
                            <span class="title">锋鸟X-bird智能电动折叠车-1秒折叠10项专利</span>
                            <span class="money-title">目前累计资金:</span>
                            <span class="current-money"><span class="yen">￥</span>2570832.00</span>
                            <span class="project-status-detail">
                                <span class="project-status-bar">
                                <span class="schedule-bar">
                                    <i class="schedule-current progress-bar progress-bar-striped active" style="width:100%;"></i>
                                </span>
                                    <span class="percentage">2570%</span>
                                </span>
                                <span class="projects-schedule-data">

                                    <span class="support-number"><b></b>支持人数:</span><span class="data-number">34419</span>
                                    <span class="time-left"><b></b>剩余时间:</span><span class="data-number">16天</span>
                                </span>
                            </span>
                            <span class="desc">
                                在如今车多路窄、倡导环保的社会情况下，让出行工具更精巧、更便携且节能环保是我们锋鸟的使命！
                            </span>
                        </span>

                    </span>
    </a>
    


</div>

<ul class="right-panel">
    
        <li class="J_Top">
            <i>1</i>
            <div class="info-con">
                <span class="project-title">靠谱煲-WIFI智能，沁麟联合阿里小智为靠谱新青年</span>
                <span class="support-num">18073人支持&nbsp;&nbsp;达成率2002%</span>
            </div>
        </li>
    
        <li class="J_Top current">
            <i>2</i>
            <div class="info-con">
                <span class="project-title">六元老人午餐温暖全世界</span>
                <span class="support-num">11155人支持&nbsp;&nbsp;达成率2261%</span>
            </div>
        </li>
    
        <li class="J_Top">
            <i>3</i>
            <div class="info-con">
                <span class="project-title">来电-颠覆众人想象的九良芯线</span>
                <span class="support-num">36786人支持&nbsp;&nbsp;达成率292%</span>
            </div>
        </li>
    
        <li class="J_Top">
            <i>4</i>
            <div class="info-con">
                <span class="project-title">优雅的不像实用派——【莫比乌斯】苹果手表手机支架！</span>
                <span class="support-num">9556人支持&nbsp;&nbsp;达成率1011%</span>
            </div>
        </li>
    
        <li class="J_Top">
            <i>5</i>
            <div class="info-con">
                <span class="project-title">锋鸟X-bird智能电动折叠车-1秒折叠10项专利</span>
                <span class="support-num">34419人支持&nbsp;&nbsp;达成率2570%</span>
            </div>
        </li>
    
</ul></div>
    </div>

</div>
  </body>
</html>
