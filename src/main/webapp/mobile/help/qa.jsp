<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <%@include file="../common/common.jsp"%>
	<%@include file="../common/meta.jsp"%>
	<c:set var="pageTitle" value="疑难解答"></c:set>
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
                <div class="query-wrap">什么是众筹?</div>
                <div class="answer-wrap">众筹(crowdfunding)，即大众筹资或群众筹资，由项目发起人、投资人、平台构成，具有普遍性、多样性、依靠大众力量、注重创意的特征。众筹利用互联网和SNS传播的特性，让项目方对公众展示他们的项目品牌，争取大家的关注和支持，进而获得所需要的资金、人脉、资源援助。相对于传统的融资方式，众筹更为开放，能否获得资金也不再是由项目的商业价值作为唯一标准，只要是大众喜欢的项目，都可以通过众筹方式获得项目启动的第一笔资金，为更多优质品牌项目的人提供了无限的可能。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">众筹模式是不是非法集资?</div>
                <div class="answer-wrap">众筹模式不是非法集资。 根据《关于取缔非法金融机构和非法金融业务活动中有关问题的通知》规定，非法集资是指单位或者个人未依照法定程序经有关部门批准，以发行股票、债券、彩票、投资基金证券或者其他债权凭证的方式向社会公众筹集资金，并承诺在一定期限内以货币、实物以及其他方式向出资人还本付息或给予回报的行为。 众筹模式从商业和资金流动的角度来看，其实是一种团购的形式，和非法集资有本质上的差别，所有的项目不能够以股权或是资金作为回报，项目发起人更不能向支持者许诺任何资金上的收益，必须是以实物、服务或者媒体内容等作为回报，对一个项目的支持属于购买行为，而不是投资行为。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">众投客网站的投资流程是什么？</div>
                <div class="answer-wrap">投资者<br/>
                    注册会员—认购—成为股东—项目分红<br/>
                    项目发起人<br/>
                    提交众筹项目信息—审核项目—签署《委托融资协议》—项目上线融资—注册合伙企业—投后管理</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">投资后多久给投资人分红？</div>
                <div class="answer-wrap">这个是根据全体合伙人签订相关合作协议情况来。项目方分红收益会按照条款进行发放，分红收益发放到投资人成为股东时提供的银行卡账号，通常是按季度进行分红。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">投资项目是否保本保息？</div>
                <div class="answer-wrap">众筹项目是不保本不保息的，最后的收益完全看项目的运营情况，众投客是一个股权众筹的平台，我们不对任何项目的盈利、亏损作担保。我们会通过严格的风控制度，为投资人优选出优质的项目。同时，我们倡导理性投资。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">如何联系项目方？</div>
                <div class="answer-wrap">投资前和投资后，我们会建立微信群和QQ群，您可以在微信群或者QQ群里面和项目方互动。众投客针对个别上线的项目会开展线下路演活动，您可以在路演活动现场与项目方以及其他的投资人进行交流。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">如何防止项目方侵吞收益？</div>
                <div class="answer-wrap">众投客会定期查账，并聘请第三方审计进行审计。<br/>
                    众筹成功后，众投客将根据项目的进展分批次、按比例放款给项目方，大大降低了投资人的风险。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">项目众筹成功后你们是不是就不管了?</div>
                <div class="answer-wrap">众筹成功后我们会提供投后管理服务，包括协议的签订、公司的注册、投资人财务系统的安装、每日营收报表、经营信息异常反馈、大额预算支出报告等等后续服务。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">众投客如何把控项目方和项目?</div>
                <div class="answer-wrap">众投客严格执行项目选择的七大标准，拥有专业的项目审核团队，具备专业的风控知识及项目分析能力，严格把关每一个上线项目。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">什么叫项目众筹成功?什么叫项目众筹失败?</div>
                <div class="answer-wrap">在众筹期限内，达到项目方最低众筹金额要求的视为项目众筹成功;反之，视为众筹失败。</div>
            </div>
            <div class="help-section">
                <div class="query-wrap">如何退出？</div>
                <div class="answer-wrap">投资满一年后，投资人如果需要转让股权，转让价格由转让方与受让方双方协商确认，退出机制在项目展示页里面有详细介绍。</div>
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