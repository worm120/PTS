<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
    
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
              if (p.exitValue() == 0)//p.exitValue()==0��ʾ����������1������������  
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
