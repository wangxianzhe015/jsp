<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="新手指南"></c:set>
	<c:set var="topPage" value="/mobile/help/index.action"></c:set>
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
	<%@include file="../common/header.jsp" %>
    <!--main-->
    <div class="main-content">
       
        <div class="wrap-rounded">
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-12">
                        <div>
                            <img src="<%=resourcePathM %>/images/01.png" class="step-img" alt="01 image">
                            <span class="help-section-title">关于众投客</span>
                        </div>
                        <div>
                        	<p>
                        	众投客（www.zhongtouke.com）隶属于福建众投网络科技有限公司是福建第一家专注于实体店众筹平台的互联网公司，是海峡第一家实体店众筹平台，共享经济时代产物的我们，只做实体店众筹，依托独特的商业运营模式，凭借专业的运营管理团队整合领域资源，促进项目方、投资者达成合作，帮助项目方快速筹资金、筹人脉，筹资源，快速品牌传播和复制项目，同时帮助投资者用最少的钱投资最优质的项目。
                        	</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-12">
                        <div>
                            <img src="<%=resourcePathM %>/images/02.png" class="step-img" alt="02 image">
                            <span class="help-section-title">项目模式</span>
                        </div>
                        <div class="guide-images">
	                        <div class="col-xs-4">
	                        	<img src="<%=resourcePathM %>/images/guide-02-1.png">
	                        </div>
	                        <div class="col-xs-4">
	                        	<img src="<%=resourcePathM %>/images/guide-02-2.png">
	                        </div>
	                        <div class="col-xs-4">
	                        	<img src="<%=resourcePathM %>/images/guide-02-3.png">
	                        </div>
                        </div>
                        <div>
                        	<p>1）项目方提交项目至众投客，众投客会经过系统性   的严格审核（7大审核标准）</p>
                        	<p>2）通过审核的项目在众投客网站上进行项目融资预热；</p>
                        	<p>3）项目融资预热到达一定程度后，平台将视融资预热情况组织项目方与投资方进行路演约谈</p>
                        	<p>4）项目正式上线后众投客会通过邮件或短信通知投资人正式认购；</p>
                        	<p>5）项目融资成功后，项目方会向众投客提出资金申请,同时会签订相应的认购协议；</p>
                        	<p>6）项目方根据项目实际进展阶段提出资金申请，审  核通过之后，众投客同意放款，由银行托管的资金将根据项目的运程分批给项目方，确保资金安全的同时项目能稳定有序的开展；</p>
                        	<p>7）店铺正常营业之后，众投客通过健全的资金管理  体系和第三方管理公司，项目资金三方同时监管，从而确保投资人资金安全、有序的支出，保障每一位投资人的利益。</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="help-section">
                <div class="row">
                    <div class="col-xs-12">
                        <div>
                            <img src="<%=resourcePathM %>/images/03.png" class="step-img" alt="03 image">
                            <span class="help-section-title">安全保障</span>
                        </div>
                        <div>
                        	<div class="guide-5-cols">
                        		<img src="<%=resourcePathM %>/images/guide-03-1.png">
                        		<strong>地域优势</strong>
                        	</div>
                        	<div class="guide-5-cols">
                        		<img src="<%=resourcePathM %>/images/guide-03-2.png">
                        		<strong>资深团队</strong>
                        	</div>
                        	<div class="guide-5-cols">
                        		<img src="<%=resourcePathM %>/images/guide-03-3.png">
                        		<strong>营销策划</strong>
                        	</div>
                        	<div class="guide-5-cols">
                        		<img src="<%=resourcePathM %>/images/guide-03-4.png">
                        		<strong>资金安全</strong>
                        	</div>
                        	<div class="guide-5-cols">
                        		<img src="<%=resourcePathM %>/images/guide-03-5.png">
                        		<strong>风控体系</strong>
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div><!-- /.container -->

    <!-- FOOTER -->
	<%@include file="../common/footer.jsp" %>
    <a href="javascript:window.scrollTo(0,0);" class="scrollTop" style="display: none;"><img src="<%=resourcePathM %>/images/ic_top.png"/></a>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="<%=resourcePathM %>/js/common/jquery-1.9.1.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/bootstrap.min.js"></script>
    <script src="<%=resourcePathM %>/js/common/main.js"></script>

    </body>
    </html>