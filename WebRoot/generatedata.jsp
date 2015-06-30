<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>
<%@page import="com.action.dataselect"%>
<%@ page  import="java.util.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>数据产生页</title>
    
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
    	dataselect ds=new dataselect();
    	ResultSet rs=null;
    	String insert_sam="";
    	/*
    	String getsub="select Substation_ID from Substation";
    	rs=ds.select(getsub);
    	if(rs!=null)
    	{
    		while(rs.next())
    		{
    			String sid=rs.getString(1);
    			for(int i=1;i<61;i++)
		    	{
		    		String sql="insert into Device(Device_ID,Substation_ID,Device_Card,Device_Name,Device_Place) values('"+sid+"000"+i+"','"+sid+"','000"+i+"','开关柜"+i+"','"+i+"号开关柜')";
		    		if(i<10)
		    		{
		    			sql="insert into Device(Device_ID,Substation_ID,Device_Card,Device_Name,Device_Place) values('"+sid+"000"+i+"','"+sid+"','000"+i+"','开关柜"+i+"','"+i+"号开关柜')";
		    		}
		    		else if(i<100&&i>=10)
		    		{
		    			sql="insert into Device(Device_ID,Substation_ID,Device_Card,Device_Name,Device_Place) values('"+sid+"00"+i+"','"+sid+"','00"+i+"','开关柜"+i+"','"+i+"号开关柜')";
		    		}
		    		else
		    		{
		    			sql="insert into Device(Device_ID,Substation_ID,Device_Card,Device_Name,Device_Place) values('"+sid+"0"+i+"','"+sid+"','0"+i+"','开关柜"+i+"','"+i+"号开关柜')";
		    		}
		    		
		    		ds.update(sql);
		    		//ds.close();
		    	}
		    	
    		}
    	}
    	out.print("<script>alert('device数据产生成功！');</script>");
    	
    	
    	
    	//////////////////////////////////
    	
    	insert_sam="select * from Device";
        rs=ds.select(insert_sam);
    	if(rs!=null)
    	{
    		int num=0;
    		while(rs.next())
	    	{
	    		for(int i=1;i<10;i++)
		    	{
		    		String s="insert into Sample(Sample_ID,Substation_ID,Device_ID,Sample_Name,Sample_Type) values('"+rs.getString("Device_ID")+"000"+i+"','"+rs.getString("Substation_ID")+"','"+rs.getString("Device_ID")+"','温度传感器"+num+"','01')";
		    		ds.update(s);
		    		num++;
		    	}
		    	for(int i=11;i<14;i++)
		    	{
		    		String s="insert into Sample(Sample_ID,Substation_ID,Device_ID,Sample_Name,Sample_Type) values('"+rs.getString("Device_ID")+"00"+i+"','"+rs.getString("Substation_ID")+"','"+rs.getString("Device_ID")+"','湿度传感器"+num+"','03')";
		    		ds.update(s);
		    		num++;
		    	}
		    	String s="insert into Sample(Sample_ID,Substation_ID,Device_ID,Sample_Name,Sample_Type) values('"+rs.getString("Device_ID")+"0014','"+rs.getString("Substation_ID")+"','"+rs.getString("Device_ID")+"','图像传感器','00')";
	    		ds.update(s);
	    		num++;
	    		s="insert into Sample(Sample_ID,Substation_ID,Device_ID,Sample_Name,Sample_Type) values('"+rs.getString("Device_ID")+"0015','"+rs.getString("Substation_ID")+"','"+rs.getString("Device_ID")+"','弧光传感器','02')";
	    		ds.update(s);
	    		num++;
	    	}
    	}
    	//ds.close();
    	out.print("<script>alert('sample数据产生成功！');</script>");
    	
    	*/
    	

    	insert_sam="select * from Sample where Sample_Type='01' and Device_ID in(select Device_ID from Devpoint)";
    	rs=ds.select(insert_sam);
    	Random random = new Random();
    	if(rs!=null)
    	{
    		int num=0;
    		while(rs.next())
	    	{
					int r1= random.nextInt()%80;//获得100以内的随机数
					int r2= random.nextInt()%80;
					int r3= random.nextInt()%80;
					
					if(r1<0)
					{
						r1=30;
					}
					if(r2<0)
					{
						r2=32;
					}
					if(r3<0)
					{
						r3=29;
					}
					
					Date timerr=new Date();
					ds.execute(r1, r2, r3,rs.getString("Sample_ID"));
					ds.executeHum(r1, r2, r3,rs.getString("Sample_ID"));
					//System.out.print("insertTemperature()");
					
		    		//String s="insert into TemperatureCurrent(Sample_ID,TemValue,VoltageValue,HumidityValue,Date) values('"+rs.getString("Sample_ID")+"','"+r1+"','"+r2+"','"+r3+"','"+timerr.toLocaleString()+"')";
		    		//ds.update(s);
		    		//String ss="insert into TemperatureHistory(Sample_ID,TemValue,VoltageValue,HumidityValue,Date) values('"+rs.getString("Sample_ID")+"','"+r1+"','"+r2+"','"+r3+"','"+timerr.toLocaleString()+"')";
		    		//ds.update(ss);
		    		out.print(rs.getString("Sample_ID")+"<>"+r1+"<>"+r2+"<>"+r3+"</br>");
	    	}
    	}

    	ds.close();
    	//out.print("<script>alert('sample数据产生成功！');</script>");
    	
    	
     %>
     <script type="text/javascript">
			setTimeout("window.location='generatedata.jsp'",30000);
		</script>
  </body>
</html>
