<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result" import="com.action.dataselect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	body,html{ margin: 0px; padding: 0px; background-color:#e2ecf5; font-size: 12px;}
		.main{ margin: 5px; padding: 0px; position: relative; width:290px; height: 240px;border-top: 1px solid #686868;}		
		.msg{ float: left; width: 100%; height: 25px; border-bottom: 1px solid #686868;border-right: 1px solid #686868;border-left: 1px solid #686868;background-color: #f9f9f9;}
		.msg-topic{ width: 100px; float:left; line-height: 25px; text-align: right;border-right: 1px solid #686868;color: #666666;background-color: #efefef;}
		.msg-content{width:auto;  float:left; line-height: 25px; text-align: left; padding-left: 10px;color: #ee0000;}
	</style>

  </head>
  
  <body>
    <div class="main">

    	<%
    		dataselect ds=new dataselect();
   			String sqls="select * from Devpoint left join (Device left join Substation on Substation.Substation_ID=Device.Substation_ID) on Device.Device_ID=Devpoint.Device_ID  where Pid='"+request.getParameter("pid")+"'";
   			ResultSet rs=ds.select(sqls);

   			String Device_id="";//采样点
   			String Device_name="";//设备
   			String Device_Place="";
   			String substation="";//变电所
   			
   			if(rs!=null)
   			{	
   				while(rs.next())
   				{
					Device_id=rs.getString("Device_ID");
					Device_name=rs.getString("Device_Name");
					Device_Place=rs.getString("Substation_ID");
					substation=rs.getString("Substation_Name");
					
   				}
   			}
    		rs.close();
    		ds.close();
    		//输出节点信息
			out.print("<div id='show1' ><div class='msg'><div class='msg-topic'>节点id:</div><div class='msg-content'>"+request.getParameter("pid")+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>开关柜编号:</div><div class='msg-content'>"+Device_id+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>开关柜名称:</div><div class='msg-content'>"+Device_name+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>安装位置:</div><div class='msg-content'>"+Device_Place+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>变电所:</div><div class='msg-content'>"+substation+"</div></div>");
    	 %>
    </div>
  </body>
</html>
