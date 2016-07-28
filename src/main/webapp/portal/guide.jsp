<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="./common/common.jsp"%>
<base href="<%=basePath%>">
<c:set var="pageTitle" value="新手指引"/>
<%@include file="./common/meta.jsp" %>	
<link rel="stylesheet" href="<%=resourcePath %>/css/guide.min.css">
</head>
<body>
<div id="demo">
	<!-- page1 -->
	<div class="section page1">
		<h1 class="elem1">新手上路</h1>
		<h2 class="elem2">让天下没有难做的投资</h2>
	</div>
	<!-- page2 -->
	<div class="section page2">
		<h3 class="u-page-tt elem1">关于我们</h3>
		<div class="f-n-wrap">
			<p class="u-dcr elem2"><span class="bigTxt">众投客</span>（<a href="www.zhongtouke.com">www.zhongtouke.com</a>）隶属于福建众投网络科技有限公司是福建第一家专注于实体店众筹平台的互联网公司，是海峡第一家实体店众筹平台，共享经济时代产物的我们，只做实体店众筹，依托独特的商业运营模式，凭借专业的运营管理团队整合领域资源，促进项目方、投资者达成合作，帮助项目方快速筹资金、筹人脉，筹资源，快速品牌传播和复制项目，同时帮助投资者用最少的钱投资最优质的项目。</p>
			<div class="m-lr">
				<div class="lr-img elem3"><img src="<%=resourcePath %>/images/img/pic1.jpg" alt=""></div>
				<div class="lr-txt elem4">
					<p>我们是实体经济的<span class="s-fc_red">领路者</span></p>
					<p>我们是优质项目的<span class="s-fc_red">发掘者</span></p>
					<p>我们是投资人的<span class="s-fc_red">引导者</span></p>
				</div>
				<div class="f-clear"></div>
			</div>
		</div>
	</div>
	<!-- page3 -->
	<div class="section page3">
		<h3 class="u-page-tt elem1">项目模式</h3>
		<div class="f-n-wrap">
			<img class="elem2" src="<%=resourcePath %>/images/img/pic2.jpg" alt="">
			<ul class="elem3">
				<li>1．项目方提交项目至众投客，众投客会经过系统性的严格审核（7大审核标准）</li>
				<li>2．通过审核的项目在众投客网站上进行项目融资预热；</li>
				<li>3．项目融资预热到达一定程度后，平台将视融资预热情况组织项目方与投资方进行路演约谈</li>
				<li>4．项目正式上线后众投客会通过邮件或短信通知投资人正式认购；</li>
				<li>5．项目融资成功后，项目方会向众投客提出资金申请，同时会签订相应的认购协议；</li>
				<li>6．项目方根据项目实际进展阶段提出资金申请，审核通过之后，众投客同意放款，由银行托管的资金将根据项目的运程分批给到项目方，确保资金安全的同时项目能稳定有序的开展；</li>
				<li>7.店铺正常营业之后，众投客通过健全的资金管理体系和第三方管理公司，项目资金三方同时监管 ，从而确保投资人资金安全、有序的支出，保障每一位投资人的利益。</li>
			</ul>
		</div>
	</div>
	<!-- page4 -->
	<div class="section page4">
		<h3 class="u-page-tt elem1">安全保障</h3>
		<div class="f-n-wrap">
			<ul class="m-safe-list elem2">
				<li>
					<h3 class="u-safe-tt">地域优势</h3>
					<p>海峡第一家实体店众筹平台，专注本土优质项目众筹</p>
				</li>
				<li>
					<h3 class="u-safe-tt">资深团队</h3>
					<p>集合互联网、实体行业、传统领域资深人士，打造优质团队</p>
				</li>
				<li>
					<h3 class="u-safe-tt">营销策划</h3>
					<p>高执行力的营销策划团队整合营销资源宣传，快速筹资金，筹人脉，筹资源</p>
				</li>
				<li>
					<h3 class="u-safe-tt">资金安全</h3>
					<p>健全的资金管理体系和风控制度，项目资金第三方监管</p>
				</li>
				<li>
					<h3 class="u-safe-tt">风控体系</h3>
					<p>7大审核标准+第三方管理公司监管+投后财务管理系统</p>
				</li>
				<li class="clear"></li>
			</ul>
		</div>
	</div>
	<!-- page5 -->
	<div class="section page5">
		<h3 class="u-page-tt elem1">如何认购</h3>
		<div class="f-n-wrap">
			<div class="m-page-menu f-tac elem2">
				<a class="u-slider-btn cur" href="javascript:;">注册</a>
				<span class="sp"></span>
				<a class="u-slider-btn " href="javascript:;">充值</a>
				<span class="sp"></span>
				<a class="u-slider-btn " href="javascript:;">认购</a>
				<span class="sp"></span>
				<a class="u-slider-btn " href="javascript:;">分红</a>
			</div>
			<div class="slide-out elem3">
				<div class="m-slide-wrap f-mt60">
					<div class="slide-inner">
						<img src="<%=resourcePath %>/images/buy/b1.jpg" alt="">
						<img src="<%=resourcePath %>/images/buy/b2.jpg" alt="">
						<img src="<%=resourcePath %>/images/buy/b3.jpg" alt="">
						<img src="<%=resourcePath %>/images/buy/b4.jpg" alt="">
					</div>
				</div>
				<a href="javascript:;" class="page-btn prev-btn"></a>
				<a href="javascript:;" class="page-btn next-btn"></a>
			</div>
		</div>
	</div>
	<!-- page6 -->
	<div class="section page6">
		<h3 class="u-page-tt elem1">如何融资</h3>
		<div class="f-n-wrap">
			<div class="m-page-menu f-tac elem2">
				<a class="u-slider-btn cur" href="javascript:;">注册</a>
				<i class="sp"></i>
				<a class="u-slider-btn " href="javascript:;">发布项目</a>
				<i class="sp"></i>
				<a class="u-slider-btn " href="javascript:;">项目审核</a>
				<i class="sp"></i>
				<a class="u-slider-btn " href="javascript:;">上线融资</a>
				<i class="sp"></i>
				<a class="u-slider-btn " href="javascript:;">融资成功</a>
			</div>
			<div class="slide-out elem3">
				<div class="m-slide-wrap f-mt60">
					<div class="slide-inner">
						<img src="<%=resourcePath %>/images/new/n1.jpg" alt="">
						<img src="<%=resourcePath %>/images/new/n2.jpg" alt="">
						<img src="<%=resourcePath %>/images/new/n3.jpg" alt="">
						<img src="<%=resourcePath %>/images/new/n4.jpg" alt="">
						<img src="<%=resourcePath %>/images/new/n5.jpg" alt="">
					</div>
				</div>
				<a href="javascript:;" class="page-btn prev-btn"></a>
				<a href="javascript:;" class="page-btn next-btn"></a>
			</div>
		</div>
	</div>
	<!--  page7 -->
	<div class="section page7">
		<div class="f-n-wrap f-tac">
			<img class="elem1" src="<%=resourcePath %>/images/img/img_btm.png"  alt="">
			<div class="elem2" style="margin-top: 100px;">
				<a href="<%=servletPath %>/portal/registry/registry.action" class="u-lgBtn f-mr20">立即注册</a><a href="#" class="u-lgBtn">返回首页</a>
			</div>
		</div>
	</div>

</div>
<script src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script src="<%=resourcePath %>/js/guide/guide.min.js"></script>
<script src="<%=resourcePath %>/js/guide/freshman.js"></script>
<script>
$('#demo').fullpage({
	sectionsColor: ['#fff','#efefef','#fff','#efefef','#fff','#efefef','#ECF0F1'],
	scrollingSpeed: 600,
	navigation: true
});

freshMan('.page5 .slide-inner');
freshMan('.page6 .slide-inner');
</script>

</body>
</html>