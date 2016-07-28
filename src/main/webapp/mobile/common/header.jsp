<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smartcloud.platform.component.mvc.User"%>
<%
  User sessionUser=(User)session.getAttribute(User.KEY_IN_SESSION);
  pageContext.setAttribute("sessionUser", sessionUser);
%>
<!--头部-->
    <div class="navbar-wrapper">
        <div class="container">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0px;">
                <div class="container">
                    <div class="navbar-header">                        
                        <a class="navbar-brand">${pageTitle }</a>
                        <c:if test="${topPage!='' }">
	                    <a href="<%=servletPath %>${topPage }" class="navbar-back">
	                        <img src="<%=resourcePathM %>/images/ic_back.png" />
	                    </a>
	                    </c:if>
                        <button type="button" class="toggle-rightmenu navbar-toggle">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                    </div>
				    <div class="right-menu animated slideOutRight">
				        <div class="top-section">
				        <c:choose>
					        <c:when test="${empty sessionUser}">
		                        <a href="<%=servletPath %>/mobile/login/login.action"><button class="btn-cyan btn-over">登录</button></a>
					            <a href="<%=servletPath %>/mobile/login/register.action"><button class="btn-cyan">注册</button></a>
				            </c:when>
				            <c:otherwise>
					            <div class="avatar-image"><img src="${sessionUser.userImage }" class="img-circle img-responsive" alt="abata image"></div>
					            <h2>您好，
					            <c:choose>
						            <c:when test="${sessionUser.realName=='' }">
						            	${sessionUser.mobileNo }
						            </c:when>
						            <c:otherwise>
						            	${sessionUser.realName}
						            	<c:choose>
							            	<c:when test="${sessionUser.gender=='2' }">
							            	女士
							            	</c:when>
							            	<c:otherwise>
							            	先生
							            	</c:otherwise>
						            	</c:choose>
						            </c:otherwise>
					            </c:choose>
					            </h2>
				            </c:otherwise>
			            </c:choose>
				        </div>
				        <div class="bottom-section">
				            <ul>
				                <li><a href="<%=servletPath %>/mobile/main/projectlist.action"  class="grid-icon">项目浏览</a></li>
				                <li><a href="<%=servletPath %>/mobile/help/guide.action"  class="post-icon">新手指引</a></li>
				                <li><a href="<%=servletPath %>/mobile/help/index.action" class="alert-icon">帮助中心</a></li>
				                <li><a href="<%=servletPath %>/mobile/help/contactus.action"  class="phone-icon">联系我们</a></li>
				            </ul>
				        </div>
				        
				
				    </div>
                </div>
            </nav>

        </div>
    </div>
