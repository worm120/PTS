<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page language="java" import="java.io.*" %>
<%@ page language="java" import="java.text.DateFormat" %>
<%@ page language="java" import="java.text.SimpleDateFormat" import="java.util.regex.Matcher" import="java.util.regex.Pattern"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>svg图像保存至服务器</title>
    
	<meta http-equiv="pragma" content="no-cache">
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
	//out.println("<script>alert('hello');</script>");
	//System.out.println("start");
	request.setCharacterEncoding("utf-8");
	
	if(request.getParameterMap()==null)
	{
		out.println("<script>alert('null');</script>");
	}
	else
	{
		Map mp=	request.getParameterMap();
		String[] strName = (String[])mp.get("Action");
		String[] svgName = (String[])mp.get("name");
		try 
		{  /******由于svg图必须加入viewBox属性才能支持放大缩小及自适应问题，需程序自动更改svg文本文档，加入viewBox属性*********/
			String writerContent = strName[0];//获取到的前端发来的svg文本
			Pattern p = Pattern.compile("<svg\\s+width=\\D(\\d*)\\D\\s+height=\\D(\\d*)\\D.*>");
	        //进行匹配，并将匹配结果放在Matcher对象中
	        Matcher m = p.matcher(writerContent);
	        m.find();
	        String width=m.group(1);
	        String height=m.group(2);
	        //System.out.println(width+"<>"+height);
	        Pattern pattern = Pattern.compile("<svg");
			Matcher matcher = pattern.matcher(writerContent);
			StringBuffer sbr = new StringBuffer();
			while (matcher.find()) {
			    matcher.appendReplacement(sbr, "<svg viewBox=\"0 0 "+width+" "+height+"\" ");
			}
			matcher.appendTail(sbr);
			//System.out.println(sbr.toString());
	        
	        writerContent=sbr.toString();

			
			String svgpath=application.getRealPath("svg/");
			Date time=new Date();
			DateFormat format = new SimpleDateFormat("yyMMddHHmmss");  
			
			
			if(svgName[0].equals("datetime")==false)//用户自定义文件名
			{
				svgpath=svgpath+"\\"+svgName[0]+".svg";
			}
			else
			{
				svgpath=svgpath+"\\"+format.format(time)+".svg";
			}
			
			//System.out.println(svgpath);
			//File file = new File("E:\\dd.svg");
			File file = new File(svgpath);
			
			if (!file.exists()) {
				file.createNewFile();  
			}  
			//FileWriter writer = new FileWriter(file); 
			OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(file),"UTF-8");
			BufferedWriter writer=new BufferedWriter(write);   
			writer.write(writerContent);
			writer.flush();
			writer.close();
		} 
		catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}	
		
        //System.out.println("mmmm"); 
		//System.out.println(strName[0]); 
		//out.println("<script>alert('ssss');</script>");
	}
    %>
  </body>
</html>
