<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@include file="../../common/common.jsp"%>
<c:set var="pageTitle" value="发布项目"></c:set>
<%@include file="../../common/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/common.css" />
<script type="text/javascript" src="<%=resourcePath %>/js/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/common.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/common/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=resourcePath %>/js/index/png.js"></script>

</head>
<body>
	<%@include file="../../common/uc_header.jsp"%>

<div class="wrap clear">
    <div class="row mt-20">
        <div class="col-7 mr-10">
            <!--左侧栏-->
			<%@include file="../uc_menu.jsp"%>
        </div>
        <!--右侧栏-->
        <div class="col-23 bg_white">
            <div class="pos_xiangm">
                <h3>发布项目</h3>
            </div>
            <div class="pos_jindu" style="background: #fff">
                <!--会员中心 v3调整 20150724 开始-->
                <div class="release-list">
					<ul class="release-ul releaseBg4">
					<li><a>基本资料</a></li>
					<li><a>股权设置</a></li>
					<li><a>项目编辑</a></li>
					<li><a>支付账号注册</a></li>
					<li><a class="release-w">平台审核</a></li>
					</ul>
			   </div>
                <!--会员中心 v3调整 20150724 结束-->
                <p style="background: #f0f0f0;"></p>
                
              <div class="zhi_fu">
                   <h3>了解融后管理</h3>
              </div>
              <div class="konw_manage">
                  <div class="ro_hou">融资后，我们建议融资方和融资店铺的投资人一起成立有限合作伙伴来管理融资后将要新开设的新店铺。由项目方充当该合伙企业的普通合伙
                      人，其他投资人为有限合伙人。同时项目方独立负责新开店铺的经营管理。
                      <br>将来的融后管理中，需要有《合伙协议》来约束有限合伙企业中您与投资人的权利和义务。在此，您可以下载《合伙协议》模板，详细阅读，认真填
                      写，填写后可以在后期上传至众投客平台。
                  </div>
                  <span><a href="#"><img src="<%=resourcePath %>/images/downlod_03.jpg" alt=""/></a></span>

              </div>
           </div>

            <div class="payment_next">
                <a style="margin-right: 40px;background: #ff6633;" href="<%=servletPath %>/portal/uc/publishThird.action?project.projectId=${project.projectId}">上一步</a>
                <a style="background: #ff6633" href="<%=servletPath %>/portal/uc/publishFifth.action?project.projectId=${project.projectId}">提交审核</a>
            </div>
        </div>
    </div>
</div>
	<!--首页底部-->
	<%@include file="../../common/footer.jsp"%>
</body>
</html>
