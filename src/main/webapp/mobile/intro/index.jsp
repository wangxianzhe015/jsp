<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="关于我们"></c:set>
	<c:set var="topPage" value="/mobile/main/index.action?menuId=main"></c:set>
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
       
        <div class="wrap">
           <div class="sub-title">公司简介</div>
           <p>众投客（www.zhongtouke.com）隶属于福建众投网络科技有限公司是福建第一家专注于实体店众筹平台的互联网公司。众投客创始团队均来自BAT等各大互联网公司高管及各传统领域高管，拥有丰富的互联网经验和广泛的人脉资源。我们只做实体店众筹，依托独特的商业运营模式，凭借专业的运营管理团队整合领域资源，促进项目方、投资者达成合作，帮助项目方快速筹资金、筹人脉，筹资源，快速品牌传播和复制项目，为投资人、项目方以及社会创造无限价值，致力将众投客打造成海峡第一的股权众筹网络金融服务平台。</p>  
           <div class="sub-title">我们的定位</div>
           <p>众投客众投客专注于互联网金融+共享经济的独特商业模式，为您全力以赴，为有成功运营经验的实体项目快速筹资金、筹人脉、筹资源，高执行力的营销策划团队为众筹项目进行品牌包装，通过整合营销资源宣传，快速提升项目品牌影响力。</p> 
           <div class="sub-title">我们的优势</div>   
           <p>地域优势：海峡第一家实体店众筹平台，专注本土优质项目众筹<br/>
                资深团队：集合互联网、实体行业、传统领域资深人士，打造优质团队<br/>
                营销策划：高执行力的营销策划团队整合营销资源宣传，快速筹资金，筹人脉，筹资源<br/>
                资金安全：健全的资金管理体系和风控制度，项目资金三方同时监管 <br/>
                商业模式：专注于互联网金融+共享经济，采用领投+跟投的商业模式，建立平台+自有品牌的发展道路<br/>
                风控体系：7大审核标准+第三方管理公司监管+投后财务管理系统</p>
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

    <script>
        $(document).ready(function() {
            $('.btnDecrease').on('click', function() {
                var selClass = $('#selClass').val();
                if (selClass == '')selClass = 1;
                if (selClass>1) selClass--;
                $('#selClass').val(selClass);
            });
            $('.btnIncrease').on('click', function() {
                var selClass = $('#selClass').val();
                if (selClass == '')selClass = 0;
                selClass++;
                $('#selClass').val(selClass);
            });
            $('#btnSubmit').on('click', function() {
                //showConfirmModal('预约成功！');
                showConfirmModal('您已经预约过此项目！');
            });
        });
        function showConfirmModal(msg) {
            $('#confirm_msg').html(msg);
            $("#confirm_dialog").modal('show');
        }
    </script>
</body>
</html>
