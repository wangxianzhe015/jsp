<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="./common/common.jsp"%>
    <base href="<%=basePath%>">
	<c:set var="pageTitle" value="众投客"/>
	<c:set var="topPage" value=""/>
	<%@include file="./common/meta.jsp" %>	
	
    <title>首页</title>
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <!-- Bootstrap core CSS -->
    <link href="<%=resourcePathM %>/css/bootstrap.min.css" rel="stylesheet" />
    <link href="<%=resourcePathM %>/css/style.css" rel="stylesheet" />
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->    
  </head>
  
  <body>

    <%@include file="./common/header.jsp"%>
    <div style="min-height: 50px;">
        <!-- Jssor Slider Begin -->
        <!-- To move inline styles to css file/block, please specify a class name for each element. --> 
        <!-- ================================================== -->
        <div id="slider1_container" style="visibility: hidden; position: relative; margin: 0 auto; top: 0px; left: 0px; width: 640px; height: 750px; overflow: hidden;">
            <!-- Loading Screen -->
            <div u="loading" style="position: absolute; top: 0px; left: 0px;">
                <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;">
                </div>
                <div style="position: absolute; display: block; background: url('<%=resourcePathM %>/images/loading.gif') no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
                </div>
            </div>
            <!-- Slides Container -->
            <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 640px; height: 750px; overflow: hidden;">
                <div>
                    <img u="image" src2="<%=resourcePathM %>/images/banner01.png" />
                </div>
                <div>
                    <img u="image" src2="<%=resourcePathM %>/images/banner01.png" />
                </div>
                <div>
                    <img u="image" src2="<%=resourcePathM %>/images/banner01.png" />
                </div>
            </div>
            
            <!-- bullet navigator container -->
            <div u="navigator" class="jssorb21" style="bottom: 26px; right: 6px;">
                <!-- bullet navigator item prototype -->
                <div u="prototype"></div>
            </div>
            <!--#endregion Bullet Navigator Skin End -->            
            
            <!-- Arrow Left -->
            <span u="arrowleft" class="jssora21l" style="top: 123px; left: 8px;"></span>
            <!-- Arrow Right -->
            <span u="arrowright" class="jssora21r" style="top: 123px; right: 8px;"></span>
            <!--#endregion Arrow Navigator Skin End -->
            <a style="display: none" href="http://www.jssor.com">Bootstrap Carousel</a>
        </div>
        <!-- Jssor Slider End -->
    </div>
    <div class="content">    	
    	<div class="h1-title">
    		<span>众筹项目</span>
    	</div>
    	<c:forEach items="${recommendProjects}" var="project">
    	<div class="box">
    		<div class="h2-title"><span>${project.projectName}</span></div>
    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
    		<img class="img-responsive box-img" src="${project.projectImage}"/>
    		<p class="description">${project.projectProfile }</p>
    		<div class="box-bar-container">
    			<div class="box-bar">
    				<div class="inner-box-bar" style="width:${project.progress}%;"></div>
    			</div>	    			
    		</div>
    		<div class="location">
    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>${project.provinceName}${project.cityName}</span>
    		</div>
    		<hr class="divider">
    		<div class="data">
    			<div class="row">
	    			<div class="col-xs-3">
	    				<span>项目总额</span>
	    				<span>${project.financeAmount}</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>单笔投资</span>
	    				<span>${project.minInvestAmount}元</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>项目进度</span>
	    				<span>${project.progress}%</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>剩余天数</span>
	    				<span>${project.remainingDays }天</span>
	    			</div>
    			</div>
    		</div>
    		<c:choose>
			<c:when test="${project.projectState=='prepared' }">
    			<div class="box-mark box-mark-prepare">预热中</div>
    		</c:when>
			<c:when test="${project.projectState=='successed' }">
	    		<div class="box-mark box-mark-done">已成功</div>	    		
    		</c:when>
    		<c:otherwise>
    			<div class="box-mark box-mark-going">众筹中</div>
    		</c:otherwise>
    		</c:choose>
    	</div>
    	</c:forEach>
    	<div class="box">
    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box01.jpg"/>
    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
    		<div class="box-bar-container">
    			<div class="box-bar">
    				<div class="inner-box-bar w100"></div>
    			</div>	    			
    		</div>
    		<div class="location">
    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
    		</div>
    		<hr class="divider">
    		<div class="data">
    			<div class="row">
	    			<div class="col-xs-3">
	    				<span>项目总额</span>
	    				<span>100万</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>单笔投资</span>
	    				<span>1000元</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>项目进度</span>
	    				<span>50%</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>剩余天数</span>
	    				<span>2天</span>
	    			</div>
    			</div>
    		</div>
    		<div class="box-mark box-mark-done">已成功</div>	    		
    	</div>	    	
    	<div class="box">
    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box01.jpg"/>
    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
    		<div class="box-bar-container">
    			<div class="box-bar">
    				<div class="inner-box-bar w50"></div>
    			</div>	    			
    		</div>
    		<div class="location">
    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
    		</div>
    		<hr class="divider">
    		<div class="data">
    			<div class="row">
	    			<div class="col-xs-3">
	    				<span>项目总额</span>
	    				<span>100万</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>单笔投资</span>
	    				<span>1000元</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>项目进度</span>
	    				<span>50%</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>剩余天数</span>
	    				<span>2天</span>
	    			</div>
    			</div>
    		</div>
    		<div class="box-mark box-mark-prepare">预热中</div>
    	</div>	    	
    	<div class="box">
    		<div class="h2-title"><span>令狐冲烤鱼东二环泰禾店</span></div>
    		<div class="h3-title"><span>预期年化收益50%——75%</span></div>
    		<img class="img-responsive box-img" src="<%=resourcePathM %>/images/box02.jpg"/>
    		<p class="description">一种烤鱼，多种风味，总有一款能满足你的味蕾一种烤鱼，多种风味，总有一款能满足你的味蕾...</p>
    		<div class="box-bar-container">
    			<div class="box-bar">
    				<div class="inner-box-bar w100"></div>
    			</div>	    			
    		</div>
    		<div class="location">
    			<img class="img-responsive" src="<%=resourcePathM %>/images/ic_location.png"/><span>福建福州</span>
    		</div>
    		<hr class="divider">
    		<div class="data">
    			<div class="row">
	    			<div class="col-xs-3">
	    				<span>项目总额</span>
	    				<span>100万</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>单笔投资</span>
	    				<span>1000元</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>项目进度</span>
	    				<span>50%</span>
	    			</div>
	    			<div class="col-xs-3">
	    				<span>剩余天数</span>
	    				<span>2天</span>
	    			</div>
    			</div>
    		</div>
    		<div class="box-mark box-mark-done">已成功</div>
    	</div>
    	<hr class="divider">
    	<div class="container-bottom">
    		<div class="container-fluid">
	    		<div class="col-xs-3">
	    			<a href="<%=servletPath %>/mobile/main/aboutus.action" class="group">
	    				<img src="<%=resourcePathM %>/images/ic_group.png" class="img-responsive"/>
	    				<p>关于我们</p>
	    			</a>
	    		</div>
	    		<div class="col-xs-3">
	    			<a href="<%=servletPath %>/mobile/help/index.action">
		    			<img src="<%=resourcePathM %>/images/ic_alert.png" class="img-responsive"/>
		    			<p>帮助中心</p>
	    			</a>
	    		</div>
	    		<div class="col-xs-3">
	    			<a href="<%=servletPath %>/mobile/main/aboutus.action">
		    			<img src="<%=resourcePathM %>/images/ic_speech.png" class="img-responsive"/>
		    			<p>关注我们</p>
	    			</a>
	    		</div>
	    		<div class="col-xs-3">
	    			<a href="<%=servletPath %>/mobile/help/contactus.action" data-toggle="modal" data-target="#calling" class="phone">
		    			<img src="<%=resourcePathM %>/images/ic_phone.png" class="img-responsive"/>
		    			<p>联系客服</p>
	    			</a>
	    		</div>
	    	</div>
    	</div>
    	<div class="qrcode" style="display: none;">
			<img src="<%=resourcePathM %>/images/qrcode.jpg" class="img-responsive qrcode_img"/>
			<div class="qrcode_description">
				<div class="row">
					<div class="col-xs-3 pdr0">
						<img src="<%=resourcePathM %>/images/friendship.jpg" class="img-responsive"/>
					</div>
					<div class="col-xs-9">
						<span>众投客项目交流群</span><br/>
						<span>群号 : 315738716</span><br/>
						<span class="des_s">扫一扫二维码，进入该群</span>
					</div>
				</div>
			</div>	    		
    	</div>
    	<div class="modal fade custom_modal" id="calling" tabindex="-1" role="dialog">
    		<div class="modal-content">
    			<div class="modal-header">
    				400-489-2031
    			</div>
    			<div class="modal-footer">
    				<div class="row">
    					<div class="col-xs-6"><a href="javascript:" data-dismiss="modal">取消</a></div>
    					<div class="col-xs-6"><a href="javascript:">呼叫</a></div>
    				</div>
    			</div>
    		</div>
    	</div> 
    </div><!-- /.content -->
    <!-- FOOTER -->
	<%@include file="./common/footer.jsp" %>
	<!-- /.footer -->
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/docs.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="<%=resourcePathM %>/js/common/ie10-viewport-bug-workaround.js"></script>

    <!-- jssor slider scripts-->
    <!-- use jssor.slider.debug.js for debug -->
    <script type="text/javascript" src="<%=resourcePathM %>/js/common/jssor.slider.mini.js"></script>
    <script type="text/javascript" src="<%=resourcePathM %>/js/common/slider.js"></script>
    <script type="text/javascript" src="<%=resourcePathM%>/js/common/main.js"></script>
    <script>
    	$(document).ready(function() {
	    	$('.group').on("mouseenter", function() {
	    		$('.qrcode').fadeIn();
	    	});
	    	$('.group').on("mouseout", function() {
	    		$('.qrcode').fadeOut();
	    	});
	    	
    	});
    </script>
</body>
</html>