<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--头部-->
<div class="top-box">
    <!--头部搜索-->
    <div class="header-news">
         <div class="header-news-content">
              <h1 class="logo-news">
                   <a href="http://www.zhongtouke.com">
                        <img src="<%=resourcePath %>/images/ztklogo.png" alt="众投客股权众筹平台logo" />
                   </a>
              </h1>
              <div class="search-hot-list">
                   <div class="index-news-search">
                        <input type="text" placeholder="找项目" id="keyword" value="">
                        <span id="keywordSearchBtn">搜索</span>
                   </div>
                   <ul class="search-hot-li">       
                   </ul>
              </div>
              <div class="after-landing">
                        <div class="after-landing-list">
                                 <span></span>
                                  <ul class="after-landing-ul">
                                  <li><a class="icon-img1" href="<%=servletPath%>/portal/uc/index.action">个人中心</a></li>
                                  <li><a class="icon-img2" href="<%=servletPath%>/portal/uc/accountInfo.action">账户充值</a></li>
                                  <li><a class="icon-img4" href="<%=servletPath%>/portal/uc/publishProject.action">发布项目</a></li>
                                  <li><a class="icon-img5" href="<%=servletPath%>/portal/uc/safeSetting.action">安全设置</a></li>
                                  <li><a class="icon-img6" href="<%=servletPath%>/portal/login/logout.action">安全退出</a></li>
                             </ul>
                        </div>
                        <p style="cursor: pointer" onclick="javascript:location='<%=servletPath%>/portal/uc/receiveMessages.action'">
                        </p>
              </div>
              <div class="clear-both"></div>
         </div>
    </div>
</div>
 <!--头部导航-->
<div class="index-nav-box" id="navFixed">
     <div class="nav-box" id="mynav">
          <ul class="index-nav-list">
              <li <c:if test="${empty menuId || menuId=='main'}" > class="on" </c:if>>
                  <a href="<%=servletPath%>/portal/main/index.action?menuId=main">首页</a>
              </li>
              <li <c:if test="${menuId=='list' }" > class="on" </c:if>>
                  <a href="<%=servletPath%>/portal/main/projectlist.action?menuId=list">投资项目</a>
              </li>
              <li <c:if test="${menuId=='guide' }" > class="on" </c:if>>
                  <a href="<%=contextPath %>/portal/guide.jsp" target="_blank" >新手指引</a>
              </li>
              <li <c:if test="${menuId=='notice' }" > class="on" </c:if>>
                  <a href="<%=servletPath %>/portal/main/aboutus.action">关于我们</a>
              </li>
          </ul>
          <div class="index-nav-text"><a href="<%=servletPath%>/portal/uc/publishProject.action">+发起项目</a></div>
          <div class="index-nav-phone">官方咨询电话：400-079-9617</div>
     </div>
     <div class="clear-both"></div>
</div>


<script>
function searchProject(keyword)
{
    var url = "<%=servletPath%>/portal/main/query.action";
    if (keyword) {
        url += "?project.projectName=" + keyword;
    }
    location = url;
}

$(document).ready(function(){

    // 搜索项目
    $("#keywordSearchBtn, #keywordSearchBtn2").bind("click", function(){
        var keyword = "";
        if ($(this).attr("id") == "keywordSearchBtn") {
            keyword = $("#keyword").val();
        } else {
            keyword = $("#keyword2").val();
        }
        searchProject(keyword);
    });
    $("#keyword, #keyword2").bind("keyup", function(event){
        // 回车
        if (event.keyCode == 13) {
            searchProject($(this).val());
        }
    });

});
</script>

	<link rel="stylesheet" type="text/css" href="<%=resourcePath %>/css/user.css" />
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator_regex.js"></script>
	<script type="text/javascript" src="<%=resourcePath %>/js/common/formvalidator.js"></script>
	<!--会员中心顶部导航开始-->
	<div class="user_nav_bg">
		<div class="wrap nav_box clear">
			<div class="fl"><span class="f30"> </span><span class="f22">
			<a href="<%=servletPath %>/portal/uc/index.action">会员中心</a></span></div>
			<a href="<%=servletPath%>/portal/uc/publishProject.action" class="show_ico">发布项目</a> </div>
	</div>
	<!--会员中心顶部导航结束--> 