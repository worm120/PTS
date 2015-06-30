<%@ page language="java" import="java.util.*"  pageEncoding="gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<%@page import="java.sql.*"%>   
<%@page import="javax.naming.Context"%>   
<%@page import="javax.naming.InitialContext"%>   
<%@page import="javax.sql.DataSource"%>     
<%@page import="java.io.*"%> 
<html lang="en">
<head>
	
	<link href="../css/jquery.jqplot.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="../js/jquery.js"></script>
	<script type="text/javascript" src="../js/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="../js/jqplot.barRenderer.min.js"></script>
	<script type="text/javascript" src="../js/jqplot.categoryAxisRenderer.min.js"></script>
	<script type="text/javascript" src="../js/jqplot.pointLabels.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
    	/*
    	var data=[[40, 50, 60, 70],[60, 50, 20, 820],[260, 440, 320, 200],[160, 340, 120, 200]]
    	var ticks = ['开关柜1', '开关柜2', '开关柜3', '开关柜4'];
    	*/
    	<%
		String sid="",sname="";
		if(request.getParameter("sid")!=null)
		{
			sid=request.getParameter("sid").toString();
		}
		Context ctx=new InitialContext();
		DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
		Connection conn=ds.getConnection();
        Statement stmt=conn.createStatement();
        String sql="select Device_ID from Device  where Substation_ID='"+sid+"' ";
		ResultSet rs=stmt.executeQuery(sql);
		int dr=0;//设备数量
		if(rs!=null)
		{
			while(rs.next())
			{
				dr++;
			}
		}
		if(dr!=0)
		{
			String did[]=new String[dr];
			String dname[]=new String[dr];
			sql="select Device_ID,Device_Name from Device a,Substation b where a.Substation_ID=b.Substation_ID and b.Substation_ID='"+sid+"' ";
		    rs=stmt.executeQuery(sql);
			if(rs!=null)
			{
				int k=0;
				while(rs.next())
				{
					did[k]=rs.getString("Device_ID");
					dname[k]=rs.getString("Device_Name");
					k++;
				}
			}
			int dalarm[]=new int[dr];
			int dta[]=new int[dr];
			int dpa[]=new int[dr];
			int daa[]=new int[dr];
			int dha[]=new int[dr];
			int i;
			for(int j=0;j<dr;j++)
			{
				dalarm[j]=0;
				dta[j]=0;
				dpa[j]=0;
				daa[j]=0;
				dha[j]=0;
			}
			for(i=0;i<dr;i++)
			{
				sql="select * from AlarmLogTemperature a,Sample b,Device c where a.Sample_ID=b.Sample_ID and b.Device_ID=c.Device_ID and c.Device_ID='"+did[i]+"'";
				rs=stmt.executeQuery(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						dta[i]++;
					}
				}
			}
			for(i=0;i<dr;i++)
			{
				sql="select * from AlarmLogPicture a,Sample b,Device c where a.Sample_ID=b.Sample_ID and b.Device_ID=c.Device_ID and c.Device_ID='"+did[i]+"'";
				rs=stmt.executeQuery(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						dpa[i]++;
					}
				}
			}
			for(i=0;i<dr;i++)
			{
				sql="select * from AlarmLogArc a,Sample b,Device c where a.Sample_ID=b.Sample_ID and b.Device_ID=c.Device_ID and c.Device_ID='"+did[i]+"'";
				rs=stmt.executeQuery(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						daa[i]++;
					}
				}
			}
			for(i=0;i<dr;i++)
			{
				sql="select * from AlarmLogHumidity a,Sample b,Device c where a.Sample_ID=b.Sample_ID and b.Device_ID=c.Device_ID and c.Device_ID='"+did[i]+"'";
				rs=stmt.executeQuery(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						dha[i]++;
					}
				}
			}
			for(i=0;i<dr;i++)
			{
				dalarm[i]=dta[i]+dpa[i]+daa[i]+dha[i];
			}
			//int a[] = {5,9,21,4,3,1,30};
			int j;    //临时变量
			String didt="";
			int temt;
			int pict;
			int arct;
			int humt;
			int dalarmt;
			for(i=0;i<dr;i++)
			{
     			for(j=0;j<dr-1;j++)
     			{
             		dalarmt=dalarm[j];
             		didt=did[j];
             		temt=dta[j];
             		pict=dpa[j];
             		arct=daa[j];
             		humt=dha[j];
             		if(dalarm[j] < dalarm[j+1])
            		 {                   
                   		dalarm[j]=dalarm[j+1];
                   		did[j]=did[j+1];
                   		dta[j]=dta[j+1];
                   		dpa[j]=dpa[j+1];
                   		daa[j]=daa[j+1];
                   		dha[j]=dha[j+1];
                   		did[j+1]=didt;
                   		dta[j+1]=temt;
                   		dpa[j+1]=pict;
                   		daa[j+1]=arct;
                   		dha[j+1]=humt;
                   		dalarm[j+1]=dalarmt;
             		}
    	 		}
			}
			
    		out.print("var ticks=[");
    		i=0;
    		//for(i=0;i<dr;i++)
    		while(dalarm[i]!=0)
    		{
    			out.print("'"+dname[i]+"',");
    			i++;
    			if(i==dr)break;
    		}
    		out.print("];");
			out.print("var data = [");
			out.print("[");
			i=0;
    		//for(i=0;i<dr;i++)
    		while(dalarm[i]!=0)
			{
				out.print(dta[i]+",");
				i++;
				if(i==dr)break;
			}	
			out.print("],");
			/*out.print("[");
			i=0;
    		//for(i=0;i<dr;i++)
    		while(dalarm[i]!=0)
			{
				out.print(dpa[i]+",");
				i++;
				if(i==dr)break;
			}	
			out.print("],");*/
			/*out.print("[");
			i=0;
    		//for(i=0;i<dr;i++)
    		while(dalarm[i]!=0)
			{
				out.print(daa[i]+",");
				i++;
				if(i==dr)break;
			}	
			out.print("],");*/
			out.print("[");
			i=0;
    		//for(i=0;i<dr;i++)
    		while(dalarm[i]!=0)
			{
				out.print(dha[i]+",");
				i++;
				if(i==dr)break;
			}	
			out.print("],");
			out.print("];");
		}
		else
		{
			out.print("document.getElementById(\"placeholder\").innerHTML=\"<img src='../img/nrn.jpg'/ style='height:100%;width:100%'>\"");
		}
	
		rs.close();
		stmt.close();
		conn.close();	
	
		%>
     
    	var plot1 = $.jqplot('placeholder', data, {
        
        	seriesDefaults:{
            	renderer:$.jqplot.BarRenderer,
            	pointLabels: { show: true},
            	// Rotate the bar shadow as if bar is lit from top right.
            	//shadowAngle: 135,
            	//rendererOptions: {fillToZero: true}
        	},
        
        	series:[
            	{label:'温度报警数'},
            	//{label:'图片报警数'},
            	//{label:'弧光报警数'},
            	{label:'湿度报警数'}
        	],
       
        	legend: {
        	    show: true,
        	    placement: 'outsideGrid'
        	},
        	axes: {
        	   
        	    xaxis: {
        	        renderer: $.jqplot.CategoryAxisRenderer,
        	        ticks: ticks
        	    },
           	 
        	    yaxis: {
        	        //pad: 1.05,
        	        min:-1,
           	    	tickOptions: {formatString: '%d'}
            	}
        	}
    	});
	});

	</script>
</head>
<body>

	<div id="placeholder" ></div>

</body>
</html>
