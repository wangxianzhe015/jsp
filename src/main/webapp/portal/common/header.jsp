<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.User"%>
<%
  User sessionUser=(User)session.getAttribute(User.KEY_IN_SESSION);
  pageContext.setAttribute("sessionUser", sessionUser);
%>
<!--头部-->
<div class="top-box">
    <!--头部搜索-->
    <div class="header-news">
         <div class="header-news-content">
              <h1 class="logo-news">
                   <a href="http://www.zhongtouke.com">
                        <img src="<%=resourcePath %>/images/logo_new.png"  alt="众投客股权众筹平台logo" />
                   </a>
              </h1>
              <div class="search-hot-list">
                   <div class="index-news-search">
                        <input type="text" placeholder="找项目" id="keyword" value="">
                        <span id="keywordSearchBtn">搜索</span>
                   </div>
              </div>
              <c:if test="${empty sessionUser}">
                  <div class="index-news-login">
                       <a href="javascript:void(0);" onclick="common_show_user('register');">注册</a>
                       <a>│</a>
                       <a href="javascript:void(0);" onclick="common_show_user();">登录</a>
                  </div>
               </c:if>
               <c:if test="${not empty sessionUser}">   
                   <div class="after-landing">
                        <div class="after-landing-list">
                                   <span></span>
                             <ul class="after-landing-ul">
                                  <li><a class="icon-img1" href="<%=servletPath%>/portal/uc/index.action">个人中心</a></li>
                                  <li><a class="icon-img2" href="<%=servletPath%>/portal/uc/accountInfo.action">账户充值</a></li>
                                  <li><a class="icon-img4" href="<%=servletPath%>/portal/uc/publishFirst.action">发布项目</a></li>
                                  <li><a class="icon-img5" href="<%=servletPath%>/portal/uc/safeSetting.action">安全设置</a></li>
                                  <li><a class="icon-img6" href="<%=servletPath%>/portal/login/logout.action">安全退出</a></li>
                             </ul>
                        </div>
                        <p style="cursor: pointer" onclick="javascript:location='<%=servletPath%>/portal/uc/receiveMessages.action'"> </p>
                  </div>
               </c:if>
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
                  <a href="<%=contextPath%>/portal/guide.jsp" target="_blank" >新手指引</a>
              </li>
              <li <c:if test="${menuId=='aboutus' }" > class="on" </c:if>>
                  <a href="<%=servletPath %>/portal/main/aboutus.action?menuId=aboutus">关于我们</a>
              </li>
          </ul>
          <div class="index-nav-text"><a href="<%=servletPath%>/portal/uc/publishFirst.action">+发起项目</a></div>
          <div class="index-nav-phone">官方咨询电话：400-079-9617</div>
     </div>
     <div class="clear-both"></div>
</div>


<script>
function searchProject(keyword)
{
    var url = "<%=servletPath%>/portal/main/query.action";
    if (keyword) {
        url += "?project.projectName=" + encodeURI(keyword);
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

function getRTime(id, time)
{
    var date = new Date();
    var t = time - date.getTime() / 1000;
    var d = Math.floor(t / 60 / 60 / 24);
    var h = Math.floor(t / 60 / 60 % 24);
    var m = Math.floor(t / 60 % 60);
    var s = Math.floor(t % 60);

    if (d <= 0 && h <= 0 && m <= 0 && s < 0) {
		return false;
    }
    d = d < 10 ? "0" + d : d;
    h = h < 10 ? "0" + h : h;
    m = m < 10 ? "0" + m : m;
    s = s < 10 ? "0" + s : s;
    $(".t_d_" + id).html(d + "天");
    $(".t_h_" + id).html(h + "时");
    $(".t_m_" + id).html(m + "分");
    $(".t_s_" + id).html(s + "秒");
}
</script>
<%@include file="../login/login.jsp" %>
