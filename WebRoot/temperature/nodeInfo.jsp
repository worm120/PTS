<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result" import="com.action.dataselect"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
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

   			String Device_id="";//������
   			String Device_name="";//�豸
   			String Device_Place="";
   			String substation="";//�����
   			
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
    		//����ڵ���Ϣ
			out.print("<div id='show1' ><div class='msg'><div class='msg-topic'>�ڵ�id:</div><div class='msg-content'>"+request.getParameter("pid")+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>���ع���:</div><div class='msg-content'>"+Device_id+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>���ع�����:</div><div class='msg-content'>"+Device_name+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>��װλ��:</div><div class='msg-content'>"+Device_Place+"</div></div>");
			out.print("<div class='msg'><div class='msg-topic'>�����:</div><div class='msg-content'>"+substation+"</div></div>");
    	 %>
    </div>
  </body>
</html>
