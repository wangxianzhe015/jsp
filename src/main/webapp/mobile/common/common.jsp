<%@page import="com.smartcloud.platform.component.common.config.PropertyResourceConfigurer"%>
<%
String path = request.getContextPath();
String contextPath=path;
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servletPath=contextPath+"/platform";
String resourcePath=contextPath+"/portal/resources";
String resourcePathM=contextPath+"/mobile/resources";

String productResourcePath=PropertyResourceConfigurer.getInstance().getProperty("product.resource.path");
if(productResourcePath!=null && productResourcePath.trim().length()>0){
	resourcePath=productResourcePath;
}

String productContextPath=PropertyResourceConfigurer.getInstance().getProperty("product.context.path");
if(productContextPath!=null &&productContextPath.trim().length()>0){
	contextPath="/".equals(productContextPath)?"":productContextPath;
	path=contextPath;
	servletPath=contextPath+"/platform";
}

%>
<script>
   var contextPath="<%=contextPath%>";
   var servletPath=contextPath+"/platform";
</script>