<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <%
    	Runtime rn = Runtime.getRuntime();
    	Process p = rn.exec("cmd.exe /c start  "+application.getRealPath("images/")+"\\interface.jar");
    	System.out.println("cmd.exe /c start  "+application.getRealPath("images/")+"\\interface.jar");
		p.waitFor();
		 if (p.waitFor() != 0) 
		 {  
              if (p.exitValue() == 0)//p.exitValue()==0表示正常结束，1：非正常结束  
              {
              	out.print("<script>alert('Interface start sucess!')</script>");
              }
              else
              {
              	out.print("<script>alert('Interface start fail!')</script>");
              }
         }  
		
		
     %>
  </body>
</html>
