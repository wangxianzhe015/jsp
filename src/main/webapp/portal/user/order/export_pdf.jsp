<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%><%
out.clear();
out = pageContext.pushBody();
String filePath = request.getAttribute("path").toString();  
String fileName = request.getAttribute("name").toString();
FileInputStream fis = null;
ServletOutputStream sos = null;
try {
     response.setContentType("application/pdf; charset=UTF-8");
     System.out.println(">>>Header:"+request.getHeader("USER-AGENT").toLowerCase());
     //if(request.getHeader("USER-AGENT").toLowerCase().indexOf("msie")>0 ||
     //		 request.getHeader("USER-AGENT").toLowerCase().indexOf("gecko")>0){
    	 response.setHeader("Content-disposition","attachment; filename=" + java.net.URLEncoder.encode(fileName,"UTF-8"));
     //}else{
     //	 response.setHeader("Content-disposition","attachment; filename=" + new String(fileName.getBytes("UTF-8"),"iso8859-1"));
    // }
     
     fis = new FileInputStream(filePath);
     sos = response.getOutputStream();
     sos.flush();
     int aRead = 0;
     while ((aRead = fis.read()) != -1 & fis != null) {
          sos.write(aRead);
     }
     sos.flush();
} catch (Throwable e) {
} finally {
     try {
          fis.close();
          sos.close();
     } catch (Throwable e){
     }
}
%>