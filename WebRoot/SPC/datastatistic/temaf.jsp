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
	
	<link href="../css/fexamples.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="../js/jquery.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery.flot.js"></script>
	<script language="javascript" type="text/javascript" src="../js/jquery.flot.pie.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){

	/*
	var data = [
    	{label: "开关柜1", data: 20},
    	{ label: "开关柜2", data: 60},
    	{ label: "开关柜3", data: 30},
    	{ label: "开关柜4", data: 10},
	];
	
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
        String sql="select Device_ID from Device a,Substation b where a.Substation_ID=b.Substation_ID and b.Substation_ID='"+sid+"' ";
		ResultSet rs=stmt.executeQuery(sql);
		int dr=0;
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
			for(int j=0;j<dr;j++)
			{
				dalarm[j]=0;
			}
			for(int i=0;i<dr;i++)
			{
				sql="select * from AlarmLogTemperature a,Sample b,Device c where a.Sample_ID=b.Sample_ID and b.Device_ID=c.Device_ID and c.Device_ID='"+did[i]+"'";
				rs=stmt.executeQuery(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						dalarm[i]++;
					}
				}
			}
			int flag=0;
			for(int i=0;i<dr;i++)
			{
				if(dalarm[i]!=0)
				{
					flag=1;
				}
			}
			if(flag==0)
			{
				out.print("document.getElementById(\"placeholder\").innerHTML=\"<img src='../img/nrn.jpg'/ style='height:100%;width:100%'>\"");
			}
			else
			{
				out.print("var data = [");
				for(int k=0;k<dr;k++)
				{
					out.print("{label:'"+dname[k]+"',data:'"+dalarm[k]+"'},");
				}
				out.print("];");
			}
		}
		else
		{
			out.print("document.getElementById(\"placeholder\").innerHTML=\"<img src='../img/nrn.jpg'/ style='height:100%;width:100%'>\"");
		}
	
	rs.close();
	stmt.close();
	conn.close();	
	
	%>
	

		

	
	$.plot("#placeholder", data, {
		series: {
			pie: { 
				show: true,
				innerRadius: 0.4
			}
		},
		legend: {
			show: false
		}
	});

		
		

	});

	</script>
</head>
<body>

	<div id="placeholder" class="demo-placeholder"></div>

</body>
</html>
