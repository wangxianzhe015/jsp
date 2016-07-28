<%
String path = request.getContextPath();
String contextPath=path;
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servletPath=contextPath+"/platform";
String resourcePath=contextPath+"/portal/resources";
%>
<script>
   var contextPath="<%=request.getContextPath()%>";
   var servletPath=contextPath+"/platform";
</script>