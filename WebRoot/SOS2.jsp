<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>
<%@ page  import="java.util.*"  import="com.action.dataselect" import="java.text.DateFormat" import="java.text.SimpleDateFormat" import="java.util.Date" %>

<%!
	void sampleNotExist(String deviceId){
	    //���temperature���в����ڵĽڵ㣨20�������ڲ����ڵ���Ϊ���ߣ�
		String getSam = "select Sample_ID from Sample where Sample.Device_ID = 'deviceId' and Sample_Type ='01' and "+
							"Sample_ID not in (select Sample_ID from TemperatureCurrent where " + 
							"DATEDIFF(mi,Date,GetDate()) between 0 and 20)";
		//���temperature���и��豸���ڵĵ��ƽ���¶�
		String getDevAvaTem = "select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where "+
								"Sample_ID in (select Sample_ID from Sample where Sample.Device_ID = '0020046' and "+
								"Sample_Type ='01' and Sample_ID in (select Sample_ID from TemperatureCurrent where " +
								"DATEDIFF(mi,Date,GetDate()) between 0 and 20)";
		dataselect ds=new dataselect();
    	ResultSet rs=null;	
    	rs = ds.select(getDevAvaTem);
		float dev_avg_tvalue = 30;
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	           dev_avg_tvalue=rs.getFloat("tvalue");
	        }
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }	    	rs = ds.select(getDevAvaTem);
	    
		rs = ds.select(getSam);
	    try
	    {
	      if (rs != null) {
	        while (rs.next())
	        {
	           ds.execute(dev_avg_tvalue, 0, 0,rs.getString("Sample_ID"));
	        }
	      }
	    }
	    catch (SQLException e)
	    {
	      e.printStackTrace();
	    }			
	    
	}
	
	void sampleOvertime(String deviceId){
		
	}
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>���ݲ���ҳ</title>
    
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
    	Random random = new Random();
    	String deviceId; 
		float avg_tvalue=30;//ƽ���¶�
		/*
		//�ҳ����е��豸�����豸��û��ֵ�ĵ�
		String getDevice = "select Device.Device_ID from DeviceSet,Device where DeviceSet.Device_ID = Device.Device_ID and " +
							"Device_StartH is not null and Device_StartL is not null and Device_dataL is not null";
		rs = ds.select(getDevice);
		if(rs!=null)
		{
			while(rs.next())
			{
				 deviceId = rs.getString("Device_ID");
				 //1.�ҳ��豸���еĵ��temperatureCurrent����û�еĵ����Ϊ����豸��ƽ���¶�
				 sampleNotExist(deviceId);
				 //2.������еĵ㶼��temperatureCurrrent���д��ڵ����г���ʮ����δ���µĽڵ�Ҳ����Ϊ����豸��ƽ���¶�
				 sampleOvertime(deviceId);
			}
		}

		*/
		
    	//ȡ�����20���ӻ�ȡ�¶�ƽ��ֵ
		String get_avg="select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where TemValue>0 and DATEDIFF(mi,Date,GetDate()) between 0 and 20";
		rs=ds.select(get_avg);
		if(rs!=null)
		{
			while(rs.next())
			{
				avg_tvalue=rs.getFloat("tvalue");
			}
		}
		
		
		
		//��һ���ҳ��������õĵ�û�з������ݵĵ㣨û����Ӧ�ĵ㣩
		String get_s="";
		String getdevice="select Sample_ID from Sample where Sample_Type='01' " +
					"and Sample_ID not in(select Sample_ID from TemperatureCurrent) " +
					"and Device_ID in(select Device_ID from DeviceSet where Device_Addr is not null " +
					"and Device_IP is not null and Device_Port is not null)";
		
    	rs=ds.select(getdevice);
    	if(rs!=null)
    	{
    		int num=0;
    		while(rs.next())
	    	{
	    			//float tem=20;//�¶�
	    			float tem=avg_tvalue;
	    			//String getTem="select top 1 TemValue,Date from TemperatureCurrent where Sample_ID='00200010001'";
	    			/*
	    			String getTem="select top 1 TemValue,Date from TemperatureCurrent";
	    			ResultSet rs2=ds.select(getTem);
	    			while(rs2.next())
	    			{
	    				tem=rs2.getInt("TemValue");
	    			}
					rs2.close();
					*/
					int r1;//���100���ڵ������
					//int r2= 20;
					//int r3= 20;
					r1= random.nextInt()%3;//���0-2�����
					tem=tem+r1;
					ds.execute(tem, 0, 0,rs.getString("Sample_ID"));
	    	}
    	}
    	get_avg="select Round(AVG(TemValue),0) as tvalue from TemperatureCurrent where TemValue>0"+
    			" and DATEDIFF(mi,Date,GetDate()) between 0 and 20";
		rs=ds.select(get_avg);
		if(rs!=null)
		{
			while(rs.next())
			{
				avg_tvalue=rs.getFloat("tvalue");
			}
		}
    	
    	//��ȡ��ʱ���ϵĵ㣬ƥ��ʱ�䳬��10���ӵģ��Զ��������ݣ��Զ�����������ÿ5���Ӹ���һ�Σ�
    	
    	String get_str="select Sample_ID,TemValue,Date from TemperatureCurrent";
    	rs=ds.select(get_str);
    	if(rs!=null)
    	{
	        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        Date now_t=new Date();
	        
    		while(rs.next())
    		{
			    Date dt1 = df.parse(rs.getString("Date"));
			    if((now_t.getTime()-dt1.getTime())>600000)//�൱ǰ10����δ�������ݣ�����ģ������
			    {
			    	//���ģ�����ݣ���ǰ�����漴�Ӽ�3�ڵ������
			    	int r1;//���100���ڵ������
					//int r2= 20;
					//int r3= 20;
					//float tem=20;
					//tem=rs.getFloat("TemValue");
					float tem=avg_tvalue;
					r1= random.nextInt()%3;
					tem=tem+r1;
					ds.execute(tem, 0, 0,rs.getString("Sample_ID"));
			    }			
    		}
    	}
    	
    	
    	//�������ҳ��������õĵ�û�з������ݵĵ㣨û����Ӧ�ĵ㣩
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
	    			float tem=20;//�¶�
	    			tem=avg_tvalue;
	    			String Sample_ID=rs.getString("Sample_ID");
	    			String insertRecentHg="insert into recentHg(Sample_ID,hg_recent1_time,hg_recent1_date,hg_recent2_time,hg_recent2_date,hg_recent3_time,hg_recent3_date,hg_recent4_time,hg_recent4_date,hg_recent5_time,hg_recent5_date,hg_recent6_time,hg_recent6_date,hg_recent7_time,hg_recent7_date) values('"+Sample_ID+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"',0,'"+stime+"')";
					String updateRecentHg="update recentHg set hg_recent1_time=0,hg_recent1_date='"+stime+"',hg_recent2_time=0,hg_recent2_date='"+stime+"',hg_recent3_time=0,hg_recent3_date='"+stime+"',hg_recent4_time=0,hg_recent4_date='"+stime+"',hg_recent5_time=0,hg_recent5_date='"+stime+"',hg_recent6_time=0,hg_recent6_date='"+stime+"',hg_recent7_time=0,hg_recent7_date='"+stime+"' where Sample_ID='"+Sample_ID+"'";
					ds.update(insertRecentHg);
	    			
	    	}
    	}
    	*/
    	String updateRecentHg="update recentHg set hg_recent1_time=0,hg_recent1_date='"+stime+"',hg_recent2_time=0,hg_recent2_date='"+stime+"',hg_recent3_time=0,hg_recent3_date='"+stime+"',hg_recent4_time=0,hg_recent4_date='"+stime+"',hg_recent5_time=0,hg_recent5_date='"+stime+"',hg_recent6_time=0,hg_recent6_date='"+stime+"',hg_recent7_time=0,hg_recent7_date='"+stime+"' where Sample_ID='00200140197'";
					
    	ds.update(updateRecentHg);
    	
    	
    	
		rs.close();
    	ds.close();    	    	
    	
     %>
     <script type="text/javascript">
			//alert("dd");
			setTimeout("window.location='SOS2.jsp'",10000);
			
		</script>
  </body>
</html>
