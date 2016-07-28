<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../common/common.jsp"%>
	<c:set var="pageTitle" value="关于平台"></c:set>
	<%@include file="../common/meta.jsp"%>
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/intro.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/jquery.slideBox.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/odometer-theme-car.css" />
	<link type="text/css" rel="stylesheet" href="<%=resourcePath %>/css/index.css" />
	
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.slideBox.min.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/odometer.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/jquery.SuperSlide.2.1.1.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/index/index.js"></script>	
	<script>
	$(document).ready(function(){
	    if ($(".fixed_side").length > 0) {
	        var offset = $(".fixed_side").offset();
	        $(window).scroll(function () {
	            var scrollTop = $(window).scrollTop();
	            //如果距离顶部的距离小于浏览器滚动的距离，则添加fixed属性。
	            if (offset.top < scrollTop) $(".fixed_side").addClass("fixed");
	            //否则清除fixed属性
	            else $(".fixed_side").removeClass("fixed");
	        });
	    }
		$(".ui-side-sub-item-link").click(function(){
			$(".ui-side-sub-item").removeClass("active");
			$(this).closest(".ui-side-sub-item").addClass("active");
		})
	});
		
	</script>
  </head>
  
<body>
<%@include file="../common/header.jsp" %>
<div class="layout-1190">
<div class="main">
	<div class="userSideBar fl fixed_side">
       <ul class="ui-side-list" id="ui-side-list">
           <li class="ui-side-item">
           	<a class="ui-side-item-link"><i class="fl ui-icon-mid index"></i>
           	<b><h1 style="font-size:16px; color:#db081c; font-weight:bold; padding-bottom:6px; padding-top:6px;">关于我们</h1></b>
           	</a>
           		<ul class="ui-side-sub-list" style="display: block;">
                   <li class="ui-side-sub-item active" style="width: 200px"><a href="#aboutUs" class="ui-side-sub-item-link" >众投客介绍</a>
                   </li>
					<li class="ui-side-sub-item">
                       <a href="#teamIntro" class="ui-side-sub-item-link">团队介绍</a>
                   </li>
					<li class="ui-side-sub-item">
                       <a href="#recruit" class="ui-side-sub-item-link">招聘信息</a>
                   </li>
					<li class="ui-side-sub-item">
                       <a href="#contactUs" class="ui-side-sub-item-link">联系我们</a>
                   </li>                                      
               </ul>
           </li>
           <li class="ui-side-item">
           	<a class="ui-side-item-link"><i class="fl ui-icon-mid capital"></i><b>
           	<h1 style="font-size:16px; color:#db081c; font-weight:bold; padding-bottom:6px; padding-left:10px; padding-top:6px;">帮助中心</h1></b>
           	</a>
               <ul class="ui-side-sub-list">
                   <li class="ui-side-sub-item ">
                       <a href="#guide" class="ui-side-sub-item-link">新手指引</a>
                   </li>
                   <li class="ui-side-sub-item ">
                       <a href="#login" class="ui-side-sub-item-link">注册及认证</a>
                   </li>
                   <li class="ui-side-sub-item ">
                       <a href="#addValue" class="ui-side-sub-item-link">充值指引</a>
                   </li>
                   <li class="ui-side-sub-item ">
                       <a href="#investment" class="ui-side-sub-item-link last">我要投资</a>
                   </li>
                   <li class="ui-side-sub-item ">
                       <a href="#financing" class="ui-side-sub-item-link">我要融资</a>
                   </li>
                   <li class="ui-side-sub-item ">
                       <a href="#answers" class="ui-side-sub-item-link">疑问解答</a>
                   </li>                   
               </ul>
           </li>
           <li class="ui-side-item ">
           	<a class="ui-side-item-link"><i class="fl ui-icon-mid invest" ></i>
           	<h1 style="font-size:16px; color:#db081c; font-weight:bold; padding-bottom:6px; padding-left:10px; padding-top:6px;"> 安全保障</h1></b>
           	</a>
               <ul class="ui-side-sub-list">
                   <li class="ui-side-sub-item ">
                   	<a href="#investmentSecurity" class="ui-side-sub-item-link">投资安全</a>
                   </li>
                   <li class="ui-side-sub-item ">
                   	<a href="#fundSecurity" class="ui-side-sub-item-link">资金安全</a>
                   </li>
                   <li class="ui-side-sub-item ">
                   	<a href="#investmentRisk" class="ui-side-sub-item-link">投资风险</a>
                   </li>
               </ul>
           </li>
       </ul>
   </div>
   
   <div class="userRight fr">
   <br/>
  <div class="aboutUs">
   <a name="aboutUs"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/>公司简介</b></h1> <br/>
   <p><b>众投客</b>（www.zhongtouke.com）隶属于福建众投网络科技有限公司是福建第一家专注于实体店众筹平台的互联网公司。众投客创始团队均来自BAT等各大互联网公司高管及各传统领域高管，拥有丰富的互联网经验和广泛的人脉资源。我们只做实体店众筹，依托独特的商业运营模式，凭借专业的运营管理团队整合领域资源，促进项目方、投资者达成合作，帮助项目方快速筹资金、筹人脉，筹资源，快速品牌传播和复制项目，为投资人、项目方以及社会创造无限价值，致力将众投客打造成海峡第一的股权众筹网络金融服务平台。</p><br/><br/>
   <!--以上是公司简介-->
   
   <h1 style="font-size:20px; text-align:center;"><b>我们的定位</b></h1> <br/>
   <p><b>众投客</b>众投客专注于互联网金融+共享经济的独特商业模式，为您全力以赴，为有成功运营经验的实体项目快速筹资金、筹人脉、筹资源，高执行力的营销策划团队为众筹项目进行品牌包装，通过整合营销资源宣传，快速提升项目品牌影响力。<br/>
  <br/><b>众投客</b>在项目方和投资大众之间建立桥梁，围绕掌握的核心能力和关键资源开展业务，拉近项目方和投资者距离，最大限度控制项目风险和成本，建立以众投客为中心的服务体系。 
</p><br/><br/>
	<!--以上是我们的定位-->
    
    <h1 style="font-size:20px; text-align:center;"><b>我们的优势</b></h1> <br/>
   <p>地域优势：海峡第一家实体店众筹平台，专注本土优质项目众筹<br/> 
资深团队：集合互联网、实体行业、传统领域资深人士，打造优质团队<br/> 
营销策划：高执行力的营销策划团队整合营销资源宣传，快速筹资金，筹人脉，筹资源<br/> 
资金安全：健全的资金管理体系和风控制度，项目资金三方同时监管 <br/>
商业模式：专注于互联网金融+共享经济，采用领投+跟投的商业模式，建立平台+自有品牌的发展道路<br/> 
风控体系：7大审核标准+第三方管理公司监管+投后财务管理系统 
 </p><br/><br/><img src="<%=contextPath %>/portal/intro/images/corporation.png"> <br/><br/><br/>
 <img src="<%=contextPath %>/portal/intro/images/wechat.png">
<br/><br/>
<p>了解更多详情，请关注我们的微信公众号：zhongtouke</p>
 
  </div><br/><br/><br/><br/>
    <!--以上是公司简介-->
    
    
    
     <div class="teamIntro">
    	<a name="teamIntro"></a><p class="teamName" style="font-size:20px;"><br/><br/><br/><br/>众投客核心管理团队</p><br/>
        <p>众投客核心团队均来自各大互联网公司高管及各传统领域高管，<br/>帮助您项目更快速的融资成功，也为您放心的投资项目保驾护航。</p>
    </div><br/><br/>
    <!--以上是团队简介-->
    
    <div class="ceoItro">
    <div>
    	<img class="ceoPic" src="<%=contextPath %>/portal/intro/images/CEO.png">
        <div class="ceoName">方黄鸿&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;众投客创始人&CEO </div>
    </div>
    <div class="information"><br/><br/>
    <img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
    <p>资深互联网人士，拥有多年互联网经验和丰富的管理经验，最早移动互联网及O2O创业者，众投客创始人兼CEO<br/><br/>
    <b>北京百度LBS大区总经理</b><br/>
    百度是全球最大的中文搜索引擎、最大的中文网站，国内互联网三巨头之一<br/><br/>
    <b>拉手网早期核心创始团队大区经理</b><br/>
    中国最早期O2O平台，累计融资1.67亿美金，最高估值10亿美金<br/><br/>
    <b>美团网城市区域总经理</b><br/>
    中国最大生活服务O2O平台，最新一轮融资7亿美金，估值70多亿美金<br/><br/>
    <b>安居客区域总经理</b><br/>
    安居客是中国最早期房地产互联网租售平台，累计融资7200W美金，2015年3月2日被上市公司58同城收购

    </p>
    </div>
    </div>
    <!--以上是CEO简介-->
    <br/>
    <div class="member" >
     	<div class="memberfr">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/chenjun.png">
        		<div class="memberName">陈俊&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;项目风控总监</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>众投客项目风控总监</b><br/><br/>
   			目前主要负责众投客风控部的管理工作；<br/>
   			 从事实体店行业多年，有丰富的传统行业经验；<br/>
   			 之前主要致力于餐饮连锁品牌项目风控管理，加盟管理，尤其在实体店项目早期选址，定位，装修预算，造价，筹备，运营，人员规划上有丰富的项目经验。
             </p>
   
    	</div>
		</div>
    
   
    <div class="memberfr-r">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/zhengfei.png">
        		<div class="memberName">郑飞&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;首席财务顾问</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>福建商务秘书服务有限公司执行董事兼总经理
				<br/>中国注册会计师
				<br/>福建中正恒瑞会计事务所首席合伙人</b><br/><br/>
   				具有二十多年财务管理经验，并在多家企业担任财务顾问，并辅导多家企业上市，在业内具有广泛的知名度和丰富人脉资源。<br/>
   			 1990年进入福州会计师事务所，从事审计验资工作。<br/>
   			 004年合伙创立福建中正恒瑞会计师事务所，担任副任会计师。<br/>
             2014年合伙创立福州商务秘书服务有限公司，担任执行董事兼总经理。
             </p><br/><br/>
   
    	</div>
    </div>
    
    <div class="member" >
     	<div class="memberfr">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/youwei.png">
        		<div class="memberName">林友伟&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市场总监</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>众投客市场总监</b><br/><br/>
   			主要负责众投客市场推广，品牌运营，媒体公关，对外合作等工作;从事移动互联网工作多年，对移动互联网行业有较深的认识，具有丰富的互联网市场运营经验和品牌建设经验。<br/><br/>
   			 <b>网龙信息技术有限公司市场经理<br/></b>
   			 带头组建市场部，并负责网龙旗下网站的市场运营工作<br/><br/>
             <b>搞趣网品牌经理</b><br/>
             负责搞趣网旗下产品的品牌建设和市场企划工作，成功塑造搞趣网品牌高度<br/><br/>
             <b>瀚海爱车（福州）网络有限公司企划经理</b><br/>
             负责爱车网事业部市场管理运营工作，制定和实施公司品牌的战略规划

             </p>
   
    	</div>
		</div>
    
    
    
    <div class="memberfr-r">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/nophoto.png">
        		<div class="memberName">翁增仁&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;技术总监</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>众投客技术总监</b><br/><br/>
   			主要负责众投客产品架构搭建，产品研发，技术团队搭建等工作。
13年以上的计算机软件开发、设计以及团队管理经验，过去主要致力于电信、金融行业的软件研发、架构设计、项目管理等工作<br/><br/>
   			 <b>福建星网锐捷网络有限公司系统架构师</b><br/>
   			 负责软件产品系统架构设计，以及云计算、大数据等软件产品研发工作<br/><br/>
             <b>上海普元信息技术股份有限公司华东金融服务总监</b><br/>
             领导华东金融服务团队，为客户提供整体信息化解决方案、架构设计以及项目管理等工作<br/><br/>
             <b>深圳新宇龙信息技术有限公司项目经理</b><br/>
             负责公司旗下各类项目规划，开发，设计，研发等工作<br/>

             </p>
   
    	</div>
    </div>
  
    <div class="member" >
     	<div class="memberfr">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/zhengchengjie.png">
        		<div class="memberName">郑成杰&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;云财务管理系统创始人</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>云财务管理系统创始人</b><br/><br/>
   			 <b>网龙91研发经理</b><br/>
   			 构建91无线移动端性能监测平台，对于移动端 的各项关键指标、云计算等领域有较深入研究<br/><br/>
   			 <b>北京百度运维部用户访问质量创始人</b><br/>
             负责百度全产品的访问质量分析UAQ，对全网产品的性能监测、预警，帮助百度从无到有自建了用户访问质量平台，WEB性能有较深入研究<br/><br/>
             <b>中科院计算所 研发经理</b><br/>
             负责天机舆情系统的运维工作<br/>
             </p>
   
    	</div>
		</div>
    
    
    
    <div class="memberfr-r">
    		<div>
    			<img class="memberPic" src="<%=contextPath %>/portal/intro/images/nophoto.png">
        		<div class="memberName">刘惠滨&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;项目风控顾问</div>
    		</div>
    	<div class="information">
    		<img src="<%=contextPath %>/portal/intro/images/intro.png"><br/><br/>
   			 <p><b>众投客项目风控顾问</b><br/><br/>
   			主要负责参与众投客项目评估，风险把控，项目指导及改进等指导工作<br/><br/>
   			 <b>现拉手网福州分公司总经理</b><br/>
   			 负责拉手网市场运营管理及市场开括. 具有丰富的项目运作，市场、运营、财务管理经验<br/><br/>
             <b>担任金世家金融营销销售主管</b><br/>
             负责销售日常管理和业务培训， 完成销售任务制定、绩效薪酬制定等销售管理工作。<br/>

             </p>
   
    	</div>
    </div>
    
    
    </div>
     <!--以上是团队合伙人-->
   
    <!--以上是团队介绍-->
    
    <br/><br/>
    
    
    
     <div class="recruit">
    <a name="recruit"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>诚招英才</b></h1> <br/>
     <h1 style="font-size:16px;"><b>后端开发</b></h1><br/>
     <b>岗位职责：</b><br/>
     <p>参与建设通用、灵活、智能的业务支撑平台的讨论与设计，完成所承担的功能需求的开发；<br/>
按照公司规范，参与完成项目的系统分析、设计；<br/>
负责后端服务器相关的项目技术选型，开发，运维工作。<br/>
</p><br/>
 <b>岗位要求：</b><br/>
     <p>1年以上后端开发经验。对后端服务器的性能检测、优化以及后端服务器的运维有一定的经验；<br/>
熟悉HTML5、JavaScript、Jquery、json、XML、WebService等开发技术；<br/>
熟悉SQLServer数据库，熟练编写SQL语句，了解存储过程，了解SQL注入；<br/>
富有团队精神，具有较强的理解能力与解决问题的能力及良好的沟通技能；<br/>
具有良好的技术文档和规范化、标准化的代码编写习惯。<br/><br/><br/>
</p>
<!--以上是后端开发-->
<h1 style="font-size:16px;"><b>WEB前端开发</b></h1><br/>
<b>岗位职责：</b><br/>
 <p>参与新产品的设计和开发；<br/>
与设计师和后台程序配合，高效率高质量地完成页面的实现工作；<br/>
撰写模块的设计文档并按照需求设计文档完成开发；<br/>
负责数网站PC端、移动端WAP功能设计、开发和优化；<br/>
持续优化网页，保证网站的高性能和可维护性。<br/><br/>
</p>
<b>岗位要求：</b><br/>
<p>本科以上学历，计算机或相关专业，1年以上Web前端开发工作经验；<br/>
了解HTML5、CSS3，能使用html/css/javascript熟练地进行页面开发；<br/>
熟练使用Photoshop对UI设计图进行切割和导出；<br/>
熟悉jQuery主流Javascript库/框架；<br/>
善于分析思考问题,较强的学习能力和沟通能力,乐于钻研新技术；<br/>
能承担一定工作压力；<br/>
有互联网产品软件前端研发经验者优先。<br/></p><br/><br/><br/>
<!--以上是WEB前端开发-->
<h1 style="font-size:16px;"><b>网站运营专员</b></h1><br/>
<b>岗位职责：</b><br/>
<p>根据众筹项目要求，并运用互联网思维，撰写产品策划文案、品牌宣传文案、广告软文及其他宣传文稿；<br/>
有独立的文字编辑能力,能独立进行文案创作；<br/>
负责专题栏目信息的搜集、编辑、审校等工作；<br/>
熟悉word PPT ps等相关办公软件应用。<br/><br/>
</p>
<b>岗位要求：</b><br/>
<p>大专以上学历，广告、新闻、中文专业专科以上学历优先；<br/>
热爱互联网，热爱吃喝玩乐，时尚潮流，能敢于接受挑战；<br/>
具有良好的数据分析能力、沟通、表达、协调能力，责任心强，能够承受一定强度的工作压力；<br/>
有文字编辑、微博微信、论坛运营相关内容运营工作经验优先；<br/>
工作积极热情，具备团队合作精神；<br/>
执行力强，工作高效，有自我驱动力；<br/>
能够配合上级完成相关工作。<br/><br/><br/>
</p>
<!--以上是网站运营专员-->

<h1 style="font-size:16px;"><b>网站平面UI设计</b></h1><br/>
<b>岗位职责：</b><br/>
<p>负责公司网页的设计、编辑、美化等工作；<br/>
根据项目需求完成包装设计；<br/>
负责客户及系统内的广告和专题的设计；<br/>
负责与开发人员配合完成网站页面设计和编辑。<br/><br/>
</p>
<b>岗位要求：</b><br/>
<p>美术、平面设计、网页设计等相关专业，专科及以上学历；<br/>
有1年以上网页设计及平面设计工作经验，有完整的个人作品；<br/>
有扎实的美术功底、良好的创意思维和理解能力，能及时把握客户需求；<br/>
熟练使用Photoshop/Dreamweaver/Illustrator等设计软件，具有良好的色彩感及审美意识，学习能力强；<br/>
能高效熟练编写HTML及CSS代码，确保代码对IE、Firefox、Safari、Opera等浏览器的良好兼容性；<br/>
善于与人沟通，良好的团队合作精神和高度的责任感，能够承受压力，有创新精神，保证工作质量；<br/><br/><br/>
</p>
<!--以上是UI设计-->

<h1 style="font-size:16px;"><b>人事行政人员</b></h1><br/>
<b>岗位职责：</b><br/>
<p>根据各部门的需求进行招聘工作，办理员工招聘、入职、离职、调任、升职等手续；<br/>
公司内部员工档案的建立与管理;<br/>
负责考勤及工资绩效的核算;<br/>
领导交办的其他事情。<br/><br/>
</p>
<b>岗位要求：</b><br/>
<p>大专及以上学历，有1-3年工作经验；<br/>
有良好的表达能力；<br/>
熟悉日常办公软件的使用；<br/>
工作有责任心，细致认真；<br/><br/><br/>
</p>
<!--以上是人事行政人员-->

<p>
工作时间：周一至周五，上午9:30-12:00，下午13:30-18:00<br/>
地    点：福州市晋安区东二环泰禾广场7-1002（众投客）<br/>
招聘邮箱：zhongtouke01@126.com<br/><br/><br/>
</p><br/><br/>
</div>
    <!--以上是招聘信息-->
    
 <div class="contactUs">
   <a name="contactUs"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>联系我们</b></h1> <br/>
客户服务热线：400-079-9617<br/><br/>
客户在线咨询：周一至周五 9:30—18:00<br/><br/> 
客服邮箱： zhongtouke06@163.com<br/><br>
商务合作邮箱：zhongtoke01@163.com<br/><br/>
媒体合作邮箱：zhongtoke02@163.com<br/><br/>
微信公众号：zhongtouke<br/><br/>
地址：福建省福州市晋安区连江北路东二环泰禾广场7#1002<br/><br/>
邮编：350000<br/><br/>
交通：乘坐 68路 ,317路 ,322路 ,56路 ,46路,317路支线，“东二环泰禾广场(公交站)”下车即可<br/><br/>
<img src="<%=contextPath %>/portal/intro/images/map.png"><br/><br/>
<br/>
</p>
<br/><br/> <br/><br/>
 </div>

   <!--以上是联系我们-->
 <div class="guide">
    <br/>
  <a name="guide"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>新手指引</b></h1> <br/>
   <p><b>平台介绍</b><br/><br/>
众投客隶属于福建众投网络科技有限公司是福建第一家专注于实体店众筹平台的互联网公司。我们只做实体店众筹，依托独特的商业运营模式，凭借专业的运营管理团队整合领域资源，促进项目方、投资者达成合作，帮助项目方快速筹资金、筹人脉，筹资源，快速品牌传播和复制项目，为投资人、项目方以及社会创造无限价值，致力将众投客打造成海峡第一的股权众筹网络金融服务平台。</p><br/><br/>
<p><b>运作流程</b><br/><br/>
项目方提交项目至众投客，众投客会经过系统的严格审核<br/>
●&nbsp;通过审核的项目将会被发布在众投客网站上进行项目融资预热<br/>
●&nbsp;项目融资预热到达一定程度后，平台将视融资预热情况组织项目方与投资方进行路演约谈 或 短信通知正式认购<br/>
●&nbsp;项目正式上线融资成功后，项目方会向众投客提出资金申请，届时，会签订相应的认购协议<br/>
●&nbsp;审核通过之后，众投客同意放款，由银行托管的资金将根据项目的运程分批给到项目方。确保资金安全的同时项目能稳定有序的开展<br/>
●&nbsp;店铺正常营业之后，众投客健全的资金管理体系和风控制度开始启动，项目资金三方同时监管 ，从而确保投资人资金安全、有序的支出，力争让每一位投资人都能拿到分红<br/>
</p><br/><br/>
<p><b>我们的优势,你们的保障</b><br><br/>
●&nbsp;地域优势：海峡第一家实体店众筹平台，专注本土优质项目众筹。投资人看得见摸得着，投资更放心<br/> 
●&nbsp;资深团队：众投客创始团队均来自BAT等各大互联网公司高管及各传统领域高管，拥有丰富的互联网经验和广泛的人脉资源，凭借专业的运营管理团队整合领域资源，为投资人、项目方以及社会创造无限价值<br/>
●&nbsp;营销策划：高执行力的营销策划团队整合营销资源宣传，快速筹资金，筹人脉，筹资源<br/> 
●&nbsp;资金安全：健全的资金管理体系和风控制度，项目资金三方同时监管 ，由银行托管。资金更加透明、安全<br/>
●&nbsp;商业模式：专注于互联网金融+共享经济，采用领投+跟投的商业模式，建立平台+自有品牌的发展道路<br/> 
●&nbsp;风控体系：7大审核标准+第三方管理公司监管,资金银行托管+投后财务管理系统 
</p><br/><br/> 

<br/><br/>
 </div>
 <!--以上是新手指引-->
 <div class="login">
    <br/>
  <a name="login"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>注册指引</b></h1> <br/><br/>
   <p><b>如何成为众投客注册用户？</b></p>
   <br/>●&nbsp;进入众投客首页，点击右上角“注册”按钮。<br/>
   ●&nbsp;根据提示信息，填写您的联系电话、网站验证码、短信验证码、密码等信息，认真阅读并同意《众投客网站服务协议》后，点击“注册”<br/><br/>
    <p><b>如何登录众投客？</b></p>
    <br/>●&nbsp;注册成为众投客用户后，您就可以使用用户名或手机号码登录众投客了
    <br/>●&nbsp;进入众投客首页，点击右上角“<img src="<%=contextPath %>/portal/intro/images/man.png"/>       ”按钮。<br/>
    ●&nbsp;进入用户中心，选择我的账户中的个人设置，完善个人信息，收货地址，其他信息，(请填写真实个人信息，避免后续投资过程出现问题)
     <br/>●&nbsp;点击提交<br/>
   <br/><br/><br/>
   <h1 style="font-size:20px; text-align:center;"><b>密码指引</b></h1> <br/><br/>
   <p><b>如何找回我的密码？</b></p><br/>
   如果您遗忘了密码，可以在网站用户登录页面中操作重置，具体操作步骤如下：<br/>
   ●&nbsp;进入众投客首页，点击“登录”, 点击“忘记密码”<br/>
   ●&nbsp;填写注册邮箱或绑定手机<br/>
   ●&nbsp;前往邮箱查看密码重置邮件获取验证码 或 查看手机获取短信验证码<br/>
   ●&nbsp;根据提示输入邮箱或手机短信验证码<br/>
   ●&nbsp;完成重置密码<br/><br/>
   <p><b>如何修改密码？</b></p><br/>
   ●&nbsp;打开个人中心点击“我的账户”中“安全设置”选项<br/>
   ●&nbsp;点击修改密码，输入原密码、新密码完成修改<br/><br/>
   <p><b>如何设置密码更安全？</b></p><br/>
   ●&nbsp;密码要保密且定期更改。<br/>
   ●&nbsp;请使用较长、复杂的字母数字组合以提高密码强度，不要用生日等容易被别人猜中的密码。<br/>
   ●&nbsp;如果使用了密码找回功能，请您及时删除我们发送给您的载有验证码的邮件。<br/><br/>
   <b>请记住不要与任何人共享您的密码。如果您已经与他人共享了密码，我们强烈建议您尽快更改。</b>
 </div><br/><br/><br/><br/>
 <!--以上是注册及认证-->
 <div class="addValue">
  <br/>
   <a name="addValue"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>充值指引</b></h1> <br/><br/>
   <p><b>如何绑定银行卡？</b></p>
   <br/>●&nbsp;进入众投客首页，点击右上角“<img src="<%=contextPath %>/portal/intro/images/man.png"> ”按钮，进入会员中心<br/>
   ●&nbsp;选择“我的账户”选项中“账户资金”按钮<br/>
   ●&nbsp;进入充值界面，选择银行卡绑定项目中“增加银行卡”<br/>
   ●&nbsp;填写本人银行卡信息，完成银行卡绑定操作<br/><br/><br/>
   <p><b>如何进行会员账户充值？</b></p><br/>
   ●&nbsp;进入众投客首页，点击右上角“<img src="<%=contextPath %>/portal/intro/images/man.png">  ”按钮，进入会员中心<br/>
   ●&nbsp;选择“我的账户”选项中“账户资金”按钮<br/>
   ●&nbsp;进入充值界面，点击“充值”<br/>
   ●&nbsp;在账户充值对话框中填写充值金额，选择支付卡账号，获取并输入验证码<br/>
   ●&nbsp;点击“确定”

 </div><br/><br/><br/><br/>
 <!--以上是充值指引-->
 <div class="investment">
  <br/>
    <a name="investment"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>投资项目指引</b></h1> <br/>
   <p><b>[ 温馨提醒 ]&nbsp;&nbsp;</b>投资人应根据自己的风险承受能力选择相应项目投资并设置好投资份额，众投客不保证平台上的所有项目融资结果，以及投资过程中出现部分/全部亏损的可能。众投客倡导客户理性投资。</p><br/><br/>
   <p><b>完成投资人认证</b><br/><br/>
   ●&nbsp;在您需要发布项目之前，您首先需要注册众投客账号，在会员中心绑定本人银行及手机，并进行个人身份认证；<br/>
   ●&nbsp;如果你都已经操作成功，恭喜您可以在平台上进行在线投资了</p><br/><br/>
<p><b>如何预约认购项目？</b><br/><br/>
●&nbsp;进入众投客首页，或点击首页页面上方“投资项目”选项<br/>
●&nbsp;选择预热项目，进入项目页面，点击“预约认购”按钮<br/>
●&nbsp;在预约认购处选择认购份数，点击“提交”，预约认购成功<br/>
●&nbsp;预约认购成功后可在“会员中心—认购的项目”界面，查看认购项目状态<br/>
●&nbsp;预约认购的项目在众投客正式上线融资时，平台将以短信的形式通知您（平台将视融资预热情况组织项目方与投资方进行路演约谈），届时各位投资者需在线上做项目认购的操作<br/>
</p><br/><br/>
<p><b>项目认购</b><br><br/>
●&nbsp;在众投客首页或者点击首页上方“投资项目”选项，选择正在进行融资的项目<br/> 
●&nbsp;进入项目页面，点击“认购”按钮<br/>
●&nbsp;在确认认购信息栏中选择认购份数，确认认购金额后，点击提交订单<br/> 
●&nbsp;在“会员中心—认购的项目”界面，查看认购的项目、认购份额及认购金额，确认无误，点击“立即支付”<br/>
●&nbsp;选择通过在线支付或者账户余额划款形式进行支付<br/> 
●&nbsp;支付成功后可在“会员中心—认购的项目”界面，查看认购项目状态 
</p><br/><br/> <br/><br/>

 </div>
 <!--以上是我要投资-->
 <div class="financing1">
 <br/>
   <a name="financing"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>发布项目指引</b></h1> <br/>
   <p>如何发布自己的项目？</p><br/>
   <p><b>完成投资人认证</b><br/>
   ●&nbsp;在您需要发布项目之前，您首先需要注册众投客账号，在会员中心绑定本人银行及手机，并进行个人身份认证；<br/>
   ●&nbsp;如果你都已经操作成功，恭喜您可以在平台上进行线上项目众筹了。</p><br/>
<p><b>提交项目</b><br/>
●&nbsp;进入众投客首页，点击页面上方“发起项目”选项或在会员中心点击“发布项目”选项<br/>
●&nbsp;完成项目基本信息、股权设置信息的填写<br/>
●&nbsp;点击“提交审核”，等待审核结果<br/>
</p><br/>
<p><b>项目预热</b><br>
●&nbsp;众投客将对通过审核的项目进行完善项目资料，发布在众投客网站上进行项目融资预热<br/> 
●&nbsp;项目融资预热到达一定程度后，平台将视融资预热情况组织项目方与投资方进行路演约谈<br/><br/>
<p><b>项目认购</b><br>
●&nbsp;项目正式上线融资，项目方按协议约定进行领投<br/> 
●&nbsp;投资人在众投客平台进行项目认购<br/> 
</p><br/> 
<p><b>融资成功</b><br>
●&nbsp;在众筹期限内，达到项目方最低众筹金额要求的视为项目众筹成功;反之，视为众筹失败<br/> 
●&nbsp;融资成功，众投客组织项目方与投资人签订投资协议等相关事宜<br/>
●&nbsp;项目方根据项目进度申请费用支取<br/> 
</p><br/><br/> 

<br/><br/>

 </div>
 <!--以上是我要融资-->
 <div class="answers">
 <br/>
  <a name="answers"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>疑问解答</b></h1> <br/><br/>
  <p> <b>1.什么是众筹?</b><br/><br/>
众筹(crowdfunding)，即大众筹资或群众筹资，由项目发起人、投资人、平台构成，具有普遍性、多样性、依靠大众力量、注重创意的特征。众筹利用互联网和SNS传播的特性，让项目方对公众展示他们的项目品牌，争取大家的关注和支持，进而获得所需要的资金、人脉、资源援助。相对于传统的融资方式，众筹更为开放，能否获得资金也不再是由项目的商业价值作为唯一标准，只要是大众喜欢的项目，都可以通过众筹方式获得项目启动的第一笔资金，为更多优质品牌项目的人提供了无限的可能。</p><br/><br/>
  <p> <b>2.	众筹模式是不是非法集资?	</b><br/><br/>
众筹模式不是非法集资。
根据《关于取缔非法金融机构和非法金融业务活动中有关问题的通知》规定，非法集资是指单位或者个人未依照法定程序经有关部门批准，以发行股票、债券、彩票、投资基金证券或者其他债权凭证的方式向社会公众筹集资金，并承诺在一定期限内以货币、实物以及其他方式向出资人还本付息或给予回报的行为。
众筹模式从商业和资金流动的角度来看，其实是一种团购的形式，和非法集资有本质上的差别，所有的项目不能够以股权或是资金作为回报，项目发起人更不能向支持者许诺任何资金上的收益，必须是以实物、服务或者媒体内容等作为回报，对一个项目的支持属于购买行为，而不是投资行为。
</p><br/><br/>
 <p> <b>3.	众投客网站的投资流程是什么？	</b><br/><br/>
投资者<br/>
注册会员—认购—成为股东—项目分红<br/>
项目发起人<br/>
提交众筹项目信息—审核项目—签署《委托融资协议》—项目上线融资—注册合伙企业—投后管理 
</p><br/><br/>
  <p> <b>4.	投资后多久给投资人分红？</b><br/><br/>
这个是根据全体合伙人签订相关合作协议情况来。项目方分红收益会按照条款进行发放，分红收益发放到投资人成为股东时提供的银行卡账号，通常是按季度进行分红。
</p><br/><br/>
  <p> <b>5.	投资项目是否保本保息？</b><br/><br/>
众筹项目是不保本不保息的，最后的收益完全看项目的运营情况，众投客是一个股权众筹的平台，我们不对任何项目的盈利、亏损作担保。我们会通过严格的风控制度，为投资人优选出优质的项目。同时，我们倡导理性投资。
</p><br/><br/>
  <p> <b>6.	如何联系项目方？</b><br/><br/>
投资前和投资后，我们会建立微信群和QQ群，您可以在微信群或者QQ群里面和项目方互动。众投客针对个别上线的项目会开展线下路演活动，您可以在路演活动现场与项目方以及其他的投资人进行交流。
</p><br/><br/>
  <p> <b>7.	如何防止项目方侵吞收益？</b><br/><br/>
众投客会定期查账，并聘请第三方审计进行审计。<br/>
众筹成功后，众投客将根据项目的进展分批次、按比例放款给项目方，大大降低了投资人的风险。
</p><br/><br/>
  <p> <b>8.	项目方和投资人的钱是直接打到你们公司的账户吗?</b><br/><br/>
众投客不设立资金池，所有投资资金均进入第三方进行监管。众筹成功后众投客按照协议约定条款分批次、按比例放款给项目方，如果众筹失败，投资金额将解除冻结，退还给投资人。
</p><br/><br/>
<p> <b>9.	项目众筹成功后你们是不是就不管了?</b><br/><br/>
众筹成功后我们会提供投后管理服务，包括协议的签订、公司的注册、投资人财务系统的安装、每日营收报表、经营信息异常反馈、大额预算支出报告等等后续服务。
</p><br/><br/>
<p> <b>10.	 众投客如何把控项目方和项目?</b><br/><br/>
众投客严格执行项目选择的七大标准，拥有专业的项目审核团队，具备专业的风控知识及项目分析能力，严格把关每一个上线项目。
</p><br/><br/>
<p> <b>11.	什么叫项目众筹成功?什么叫项目众筹失败?</b><br/><br/>
在众筹期限内，达到项目方最低众筹金额要求的视为项目众筹成功;反之，视为众筹失败。
</p><br/><br/>
<p> <b>12.	如果投资满一年，想要退股，退回资金是按照投资资金完全退还么还是按企业市值比率来退还或是通过其他评估手段?</b><br/><br/>
投资满一年后，投资人如果需要转让股权，转让价格由转让方与受让方双方协商确认，退出机制在项目展示页里面有详细介绍。
</p><br/><br/><br/><br/>
  
 </div>
 <!--以上是疑难解答-->
 
 <div class="investmentSecurity">
<a name="investmentSecurity"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>投资安全</b></h1> <br/><br/>
 <p><b>本土项目</b><br/>
 众投客平台只做本土优质项目的实体店众筹。投资人看得见摸得着，和项目方更能很好的进行沟通和交流，成为朋友一起体验创业的乐趣。
项目方不只需要资金，也需要顾客，和其他的资源，股东既是顾客也是宣传者，为商家很好的解决了后顾之忧。
</p><br/>
<p><b>项目选择七大标准</b><br/>
1. 项目具备1家以上成功经营实体店，且有1年以上经营年限；<br/>
2. 项目投资回报率高于30%以上；<br/>
3. 项目在当地具有广泛认知度和品牌度；<br/>
4. 项目具有工商注册商标或授权许可；<br/>
5. 项目方具有良好的征信记录；<br/>
6. 项目方投入资金不低于20%； <br/>
7. 项目具有良好的市场发展前景<br/><br/>
</p>
<p><b>投后管理系统</b><br/>
（一）新店筹办 <br/>
1、通过第三方资金安全托管平台按项目进度分批拨付项目资金 <br/>
2、融资款使用情况每周以财务报表形式向委托融资平台“众投客”及所有投资人汇报 <br/>
3、指定收银系统 <br/>
4、安装安防监控 <br/>
（二）新店营业<br/> 
1、第三方管理公司监管：通过财务监管、财务审计、法律支持三方面监管和规范运营过程，项目方按月支付相应管理费用<br/> 
2、实地监管：股东有权利到项目经营场地进行经营状况视察<br/> 
3、平台监管：定期（季度）披露项目经营报表，由股东共同监督；项目方必须定期项目经营股东交流会<br/> 
4、项目分红：所有股东根据合伙协议规定定期分红<br/> 
5、退出机制：一年投资锁定期后股东根据项目情况进行转让、出售股份，以实际项目方商定为准
</p><br/><br/><br/><br/>
</div>
 <!--以上是投资安全-->
 
  <div class="fundSecurity">
 <a name="fundSecurity"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>资金安全</b></h1> <br/>
<p><b>第三方账户托管</b><br/>
在资金方面，众投客平台与在托管业务中资质最全的商业银行之一      招商银行达成合作。招商银行将作为第三方，对项目投资人的资金进行托管。平台不不设资金池，资金的每一笔流动都能被投资人清晰地监控，保障投资人资金安全。
</p><br/>
<p><b>分批次放款</b><br/>
众投客平台与招商银行针对内控流程进行了严格设计，项目众筹成功后众投客按照协议约定条款分批次放款给项目方；如果众筹失败，投资金额将解除冻结，退还给投资人。严格的操作程序，通过约定杜绝流程上存在的潜在风险。
</p><br/>
<p><b>账户保障</b>
会员用户信息加密，保障信息安全；<br/>
会员用户需进行身份认证和短信认证，并只限绑定本人银行卡，保障资金进出安全。
</p><br/><br/><br/><br/>
 </div>
 <!--以上是资金安全-->
 
 
 <div class="investmentRisk">
  <br/>
   <a name="investmentRisk"></a><h1 style="font-size:20px; text-align:center;"><b><br/><br/><br/><br/>投资风险</b></h1> <br/>
   <p><b>投资风险提示书</b><br/>
众投客是一个非公开股权融资的平台，为投资人提供投资项目，为创业者提供目标投资人。在投/融资过程中可能获得一定的投资收益，但同时也存在着较大的投资风险，众投客不对任何项目的盈利、亏损作担保。我们会通过严格的风控制度，为投资人优选出优质的项目，同时，我们倡导理性投资。为了是您更好的了解其中的风险，请您认真详细阅读投资中包括的不限于以下的风险。</p><br/><br/>
<p><b>项目投资风险</b><br/>
投资人应根据自己的风险承受能力选择相应项目投资并设置好投资额度，众投客不保证平台上的所有项目融资结果，以及投资过程中出现部分/全部亏损甚至破产的可能。如项目融资失败，众投客会协助项目发起人将融资金额无息返还给项目投资人，众投客不承担任何责任。</p><br/><br/>
<p><b>流动性风险</b><br>
被投资标的为创业型企业的股权或股权性质的其他权益，由于众筹市场仍在成长阶段，尚未成熟化，存在所投资的股权在需要转让时找不到买家的可能。</p><br/><br/> 
<p><b>股权稀释的风险</b><br/>		
在创业投资中，创业企业进行多轮融资是常态，当企业进行多轮融资时，若投资人放弃认购新的股权时，投资人所持股权比例将因其他投资者的进入而存在降低的可能，随后会影响到投资人在企业的决策权、分红权等。</p><br/><br/>
<p><b>破产清算赔付靠后的风险</b><br/>
若被投资,
众筹投资是针对当前的相关法律法规和政策设计出的产物。受国家宏观政策以及市场相关法规变化的影响，可能造成投资的受理、投资、回报等的无法正常进行，甚至存在出现投资金额损失的可能。众投客不承担由此造成的损失。</p><br/><br/>
<p><b>不可抗力因素风险</b><br/>
由于自然灾害、战争等不可抗力的出现，将严重影响金融市场的运行，可能造成投资的受理、投资、回报等的无法正常进行，甚至存在出现投资金额损失的可能。众投客不承担由此造成的损失。
企业经营状况不佳，面临破产时，企业资产会优先赔付职工工资、所欠税款及其他债务等，投资人的赔偿顺位靠后。</p><br/><br/>
<p><b>宏观经济风险</b><br/>	
由于我国及周边国家、地区宏观经济环境和周边市场变化的影响，使该类公司平台的经营处于波动状态，从而导致价值不同程度的贬损，使您存在亏损的可能。众投客不承担由此造成的损失。</p><br/><br/>

   
<br/><br/>

 </div>
 <!--以上是投资风险-->
   
   </div>
   
 
  </div>
  
</div>

</body>
    
</html>
