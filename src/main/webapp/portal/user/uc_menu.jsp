<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
           <div class="left_bar">
				<!--新增修改开始-->
				<ul>
					<li class=" bor-t"><span class="now-img1 <c:if test="${ucmenuId=='index'}">now</c:if>"><a href="<%=servletPath%>/portal/uc/index.action">用户中心</a></span></li>
					<li><span class="now-img2 <c:if test="${ucmenuId=='publish_project'}">now</c:if>" ><a href="<%=servletPath%>/portal/uc/publishFirst.action">发布项目</a></span></li>
					<li>
                        <span class="now-img3 "><a href="<%=servletPath%>/portal/uc/findMyProject.action">我的项目</a></span><i></i>
                        <div class="news-fb">
                        	<a class="<c:if test="${ucmenuId=='my_projects'}">on </c:if>" href="<%=servletPath%>/portal/uc/findMyProject.action">发布的项目</a>
                            <a class="<c:if test="${ucmenuId=='subscribe_projects'}">on </c:if>" href="<%=servletPath%>/portal/uc/findSubscribeProject.action">认购的项目</a> 
                            <a class="<c:if test="${ucmenuId=='focus_projects'}">on </c:if>" href="<%=servletPath%>/portal/uc/findFocusProject.action">关注的项目</a>
                        </div>
                    </li>
					<li>
                        <span class="now-img5" ><a href="<%=servletPath%>/portal/uc/safeSetting.action">我的账户</a></span><i></i>
                        <div class="news-fb">
                             <a class="<c:if test="${ucmenuId=='safe_setting'}">on </c:if>" href="<%=servletPath%>/portal/uc/safeSetting.action" >安全设置</a>
                             <a class="<c:if test="${ucmenuId=='personal_setting'}">on </c:if>" href="<%=servletPath%>/portal/uc/personalSetting.action">个人设置</a>
                             <a class="<c:if test="${ucmenuId=='finance_deal'}">on </c:if>" href="<%=servletPath%>/portal/uc/rechargeRecord.action">交易记录</a>
                             <a class="<c:if test="${ucmenuId=='finance_account'}">on </c:if>" href="<%=servletPath%>/portal/uc/accountInfo.action">账户资金</a>
                        </div>
                    </li>
					<li><span class="now-img6 <c:if test="${ucmenuId=='message_list'}">now </c:if>" ><a href="<%=servletPath%>/portal/uc/receiveMessages.action">消息中心</a></span></li>
				</ul>
                <!--新增修改结束-->
				<div class="tel_box">
					<div class="tel_ico">联系客服</div>
					<div class="num">400-079-9617</div>
					<div class=" text-c color-6">周一至周五（09:00-18:30）</div>
				</div>
			</div>