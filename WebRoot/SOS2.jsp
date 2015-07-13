<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>
<%@ page  import="java.util.*"  import="com.action.dataselect" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.util.Date" %>

<%!
// 	void sampleNotExist(String deviceId){
// 		float dev_avg_tvalue = 0;
// 		获得temperature表中存在的节点
// 		String getSamExsist = "select Sample_ID from Sample where Sample.Device_ID = '"+deviceId+"' and Sample_Type ='01' and "+
// 							"Sample_ID in (select Sample_ID from TemperatureCurrent where TemValue <> 0)";
// 	    获得temperature表中不存在的节点
// 		String getSamNotExsist = "select Sample_ID from Sample where Sample.Device_ID = '"+deviceId+"' and Sample_Type ='01' and "+
// 							"Sample_ID not in (select Sample_ID from TemperatureCurrent where TemValue <> 0)";
// 		获得temperature表中该设备存在的点的平均温度
// 		String getDevAvaTem = "select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where "+
// 								"Sample_ID in (select Sample_ID from Sample where Sample.Device_ID = '"+deviceId+"' and "+
// 								"Sample_Type ='01') and Sample_ID in (select Sample_ID from TemperatureCurrent where TemValue <> 0 and " +
// 								"DATEDIFF(mi,Date,GetDate()) between 0 and 15)";
// 		dataselect ds=new dataselect();
//     	ResultSet rs=null;	
    	
//     	rs = ds.select(getSamNotExsist);
// 	    if (rs == null) return;//如果全部存在就直接返回
	    
// 	    rs = ds.select(getSamExsist);
// 	    if (rs==null){
// 	    	sosForOfflineDevice(deviceId);
// 	    	return;
// 	    }//如果全部不存在返回
	    
// 	    rs = ds.select(getDevAvaTem);
		
// 	    try
// 	    {
// 	      if (rs != null) {
// 	        while (rs.next())
// 	        {
// 	           dev_avg_tvalue=rs.getFloat("tvalue");
// 	        }
// 	      }
	      
// 	    }
// 	    catch (SQLException e)
// 	    {
// 	      e.printStackTrace();
// 	    }	    	
	    
	    
// 		rs = ds.select(getSamNotExsist);
// 	    try
// 	    {
// 	      if (rs != null) {
// 	        while (rs.next())
// 	        {
// 	           ds.execute(dev_avg_tvalue, 0, 0,rs.getString("Sample_ID"));
// 	        }
// 	      }
	      
// 	    }
// 	    catch (SQLException e)
// 	    {
// 	      e.printStackTrace();
// 	    }		
// 	    try{	
// 	    	rs.close();
// 	    	ds.close(); 
// 	    }
// 	    catch (SQLException e){
// 	    	e.printStackTrace();
// 	    }
    	
// 	}
	
	void sampleOvertime(String deviceId){
		dataselect ds=new dataselect();
    	ResultSet rs=null;	
    	Random random = new Random();
    	float avgTem = 0;
    	float dev_avg_tvalue = 0;
    	//获得temperature表中没有超时的节点（10分钟的认为掉线）
		String getSamNotOverTime = "select Sample_ID from Sample where Sample.Device_ID = '"+ deviceId +"' and Sample_Type ='01' and "+
							"Sample_ID in (select Sample_ID from TemperatureCurrent where TemValue <> 0 and " + 
							"DATEDIFF(mi,Date,GetDate()) between 0 and 10)";
		 //获得temperature表中超时的节点（15分钟的认为掉线）
		String getSamOverTime = "select Sample_ID from Sample where Sample.Device_ID = '"+ deviceId +"' and Sample_Type ='01' and "+
							"Sample_ID not in (select Sample_ID from TemperatureCurrent where TemValue <> 0 and " + 
							"DATEDIFF(mi,Date,GetDate()) between 0 and 10)";
		//获得temperature表中该设备存在的点的平均温度
		String getDevAvaTem = "select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where "+
								"Sample_ID in (select Sample_ID from Sample where Sample.Device_ID = '"+deviceId+"' and "+
								"Sample_Type ='01') and Sample_ID in (select Sample_ID from TemperatureCurrent where TemValue <> 0 and " +
								"DATEDIFF(mi,Date,GetDate()) between 0 and 10)";
		rs = ds.select(getSamNotOverTime);
	    try
	    {
	      if (rs != null) {
	      	int i = 0;
	        while (rs.next())
	        {
	           i++;
	        }
	        if(i==0){sosForOfflineDevice(deviceId); return;}
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }//如果全部超时就返回
	    
    	rs = ds.select(getSamOverTime);
	    try
	    {
	      if (rs != null) {
	      	int i = 0;
	        while (rs.next())
	        {
	           i++;
	        }
	        if(i==0) return;
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }//如果全部没有超时就直接返回
    	rs = ds.select(getDevAvaTem);
		
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	           dev_avg_tvalue=rs.getFloat("tvalue");
	        }
	      }else return;
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	    	
	    
	    
		rs = ds.select(getSamOverTime);
		System.out.println(getSamOverTime+"\n");
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	        	int r1= random.nextInt()%3;//获得0-2随机数
	           	avgTem += r1;
	           	System.out.println(rs.getString("Sample_ID")+"\n");
	           	ds.execute(dev_avg_tvalue, 0, 0,rs.getString("Sample_ID"));
	        }
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	
	   try{	
	    	rs.close();
	    	ds.close(); 
	    }
	    catch (SQLException e){
	    	e.printStackTrace();
	    }
	}
	//获得全部点都掉的设备然后模拟整个变电所的平均温度
	void sosForOfflineDevice(String deviceId){
		dataselect ds=new dataselect();
    	ResultSet rs=null;	
    	float avgTem = 0;
    	Random random = new Random();
		String getSam = "select Sample_ID from Sample where Device_ID = '"+ deviceId +"' and Sample_Type ='01'";
		String getAvgTem="select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where TemValue>0 and"+
						" DATEDIFF(mi,Date,GetDate()) between 0 and 10";
    	rs = ds.select(getAvgTem);
    	
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	           avgTem=rs.getFloat("tvalue");
	        }
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	
	    
	    rs = ds.select(getSam);
	    System.out.println(getSam);
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	           int r1= random.nextInt()%3;//获得0-2随机数
	           avgTem += r1;
	           System.out.println(rs.getString("Sample_ID"));
	           ds.execute(avgTem, 0, 0,rs.getString("Sample_ID"));
	        }
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	
	    try{	
	    	rs.close();
	    	ds.close(); 
	    }
	    catch (SQLException e){
	    	e.printStackTrace();
	    }
	}
 %>
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
    	
    	Random random = new Random();
    	String deviceId; 
		float avg_tvalue=30;//平均温度
		
		//找出所有的设备，按设备找没有值的点
		String getDevice = "select Device.Device_ID from DeviceSet,Device where DeviceSet.Device_ID = Device.Device_ID and " +
							"Device_StartH is not null and Device_StartL is not null and Device_dataL is not null";
		rs = ds.select(getDevice);
		if(rs!=null)
		{
			while(rs.next())
			{
				System.out.println(rs.getString("Device_ID"));
				 deviceId = rs.getString("Device_ID");
				 //1.找出设备下有的点而temperatureCurrent表中没有的点更新为这个设备的平均温度
// 				 sampleNotExist(deviceId);
				 //2.如果所有的点都在temperatureCurrrent表中存在但是有超过15分钟未更新的节点也更新为这个设备的平均温度
				 sampleOvertime(deviceId);
			}
		}

		
		
    	//取最近的20分钟获取温度平均值
		/*String get_avg="select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where TemValue>0 and DATEDIFF(mi,Date,GetDate()) between 0 and 20";
		rs=ds.select(get_avg);
		if(rs!=null)
		{
			while(rs.next())
			{
				avg_tvalue=rs.getFloat("tvalue");
			}
		}*/
		
		
		
		//第一步找出所有设置的但没有返回数据的点（没有响应的点）
// 		String get_s="";
// 		String getdevice="select Sample_ID from Sample where Sample_Type='01' " +
// 					"and Sample_ID not in(select Sample_ID from TemperatureCurrent) " +
// 					"and Device_ID in(select Device_ID from DeviceSet where Device_Addr is not null " +
// 					"and Device_IP is not null and Device_Port is not null)";
		
//     	rs=ds.select(getdevice);
//     	if(rs!=null)
//     	{
//     		int num=0;
//     		while(rs.next())
// 	    	{
// 	    			float tem=20;//温度
// 	    			float tem=avg_tvalue;
// 	    			String getTem="select top 1 TemValue,Date from TemperatureCurrent where Sample_ID='00200010001'";
// 	    			/*
// 	    			String getTem="select top 1 TemValue,Date from TemperatureCurrent";
// 	    			ResultSet rs2=ds.select(getTem);
// 	    			while(rs2.next())
// 	    			{
// 	    				tem=rs2.getInt("TemValue");
// 	    			}
// 					rs2.close();
// 					*/
// 					int r1;//获得100以内的随机数
// 					int r2= 20;
// 					int r3= 20;
// 					r1= random.nextInt()%3;//获得0-2随机数
// 					tem=tem+r1;
// 					ds.execute(tem, 0, 0,rs.getString("Sample_ID"));
// 	    	}
//     	} 
    	

    	
    	//获取临时故障的点，匹配时间超出10分钟的，自动产生数据（自动产生的数据每5分钟更新一次）
    	
//     	String get_str="select Sample_ID,TemValue,Date from TemperatureCurrent";
//     	rs=ds.select(get_str);
//     	if(rs!=null)
//     	{
// 	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
// 	        Date now_t=new Date();
	        
//     		while(rs.next())
//     		{
// 			    Date dt1 = df.parse(rs.getString("Date"));
// 			    if((now_t.getTime()-dt1.getTime())>600000)//距当前10分钟未更新数据，产生模拟数据
// 			    {
// 			    	添加模拟数据，当前数据随即加减3内的随机数
// 			    	int r1;//获得100以内的随机数
// 					int r2= 20;
// 					int r3= 20;
// 					float tem=20;
// 					tem=rs.getFloat("TemValue");
// 					float tem=avg_tvalue;
// 					r1= random.nextInt()%3;
// 					tem=tem+r1;
// 					ds.execute(tem, 0, 0,rs.getString("Sample_ID"));
// 			    }			
//     		}
//     	}
    	
    	
    	//第三步找出所有设置的但没有返回数据的点（没有响应的点）
		Date dt=new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String stime=df.format(dt);
		
		/*
		String gethg="select Sample_ID from Sample where Sample_Type='02' and Sample_ID not in(select Sample_ID from TemperatureCurrent) and Device_ID in(select Device_ID from DeviceSet where Device_Addr is not null and Device_IP is not null and Device_Port is not null)";
		
		
    	rs=ds.select(getdevice);
    	if(rs!=null)
    	{
    		int num=0;
    		while(rs.next())
	    	{
	    			float tem=20;//温度
	    			tem=avg_tvalue;
	    			String Sample_ID=rs.getString("Sample_ID");
	    			String insertRecentHg="insert into recentHg(Sample_ID,hg_recent1_time,hg_recent1_date,hg_recent2_time,hg_recent2_date,hg_recent3_time,hg_recent3_date,hg_recent4_time,hg_recent4_date,hg_recent5_time,hg_recent5_date,hg_recent6_time,hg_recent6_date,hg_recent7_time,hg_recent7_date) values('"+Sample_ID+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"')";
					String updateRecentHg="update recentHg set hg_recent1_time=0,hg_recent1_date='"+stime+"',hg_recent2_time=0,hg_recent2_date='"+stime+"',hg_recent3_time=0,hg_recent3_date='"+stime+"',hg_recent4_time=0,hg_recent4_date='"+stime+"',hg_recent5_time=0,hg_recent5_date='"+stime+"',hg_recent6_time=0,hg_recent6_date='"+stime+"',hg_recent7_time=0,hg_recent7_date='"+stime+"' where Sample_ID='"+Sample_ID+"'";
					ds.update(insertRecentHg);
	    			
	    	}
    	}
    	*/
    	String updateRecentHg="update recentHg set hg_recent1_time=0,hg_recent1_date='"+
    							stime+"',hg_recent2_time=0,hg_recent2_date='"+stime+
    							"',hg_recent3_time=0,hg_recent3_date='"+stime+
    							"',hg_recent4_time=0,hg_recent4_date='"+stime+
    							"',hg_recent5_time=0,hg_recent5_date='"+stime+
    							"',hg_recent6_time=0,hg_recent6_date='"+stime+
    							"',hg_recent7_time=0,hg_recent7_date='"+stime+
    							"' where Sample_ID='00200140197'";
					
    	ds.update(updateRecentHg);
    	
    	
    	
		rs.close();
    	ds.close();    	    	
    	
     %>
     <script type="text/javascript">
			//alert("dd");
			setTimeout("window.location='SOS2.jsp'",100000);
			
		</script>
  </body>
</html>
