<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--首页底部-->
    <div class="footer">
    	<div class="container-fluid">
    		<div class="col-xs-3">
    			<a href="<%=servletPath%>/mobile/main/index.action?menuId=main">
    				<img src="<%=resourcePathM %>/images/ic_home.png" class="img-responsive"/>
    				<p>首页</p>
    			</a>
    		</div>
    		<div class="col-xs-3">
    			<a href="<%=servletPath%>/mobile/main/projectlist.action">
	    			<img src="<%=resourcePathM %>/images/ic_project.png" class="img-responsive"/>
	    			<p>项目</p>
    			</a>
    		</div>
    		<div class="col-xs-3">
    			<a href="<%=servletPath%>/mobile/main/listNews.action">
	    			<img src="<%=resourcePathM %>/images/ic_info.png" class="img-responsive"/>
	    			<p>资讯</p>
    			</a>
    		</div>
    		<div class="col-xs-3">
    			<a href="<%=servletPath%>/mobile/uc/index.action">
	    			<img src="<%=resourcePathM %>/images/ic_me.png" class="img-responsive"/>
	    			<p>我的</p>
    			</a>
    		</div>
    	</div>
    </div>