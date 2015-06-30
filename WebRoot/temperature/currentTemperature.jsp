<%@ page language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<%@page import="java.sql.*"%>   
<%@page import="javax.naming.Context"%>   
<%@page import="javax.naming.InitialContext"%>   
<%@page import="javax.sql.DataSource"%>     
<%@page import="java.io.*"%> 
<html lang="en">
<head>
	<link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
    <link  rel="stylesheet" type="text/css" href="../css/add.css">
	<link href="../css/jquery.jqplot.css" rel="stylesheet" type="text/css">
	<script language="javascript" type="text/javascript" src="../SPC/js/jquery.js"></script>
	<script type="text/javascript" src="../SPC/js/jquery.jqplot.min.js"></script>
	<script type="text/javascript" src="../SPC/js/jqplot.barRenderer.min.js"></script>
	<script type="text/javascript" src="../SPC/js/jqplot.categoryAxisRenderer.min.js"></script>
	<script type="text/javascript" src="../SPC/js/jqplot.pointLabels.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
    	
    	//var data=[[820, 200, 210, 20],[260, 440, 320, 100],[160, 340, 120, 100],[40, 50, 60, 70]]
    	//var ticks = ['开关柜3', '开关柜4', '开关柜1', '开关柜2'];
    	var num=0;
    	<%
	    	dataselect ds=new dataselect();
	    	String getSubstation="select Sample.Sample_ID,Sample_Name,Sample_Place,TemValue from TemperatureCurrent,Sample where Sample_Type='01' and  TemperatureCurrent.Sample_ID = Sample.Sample_ID and Sample.Device_ID in(select Device_ID from Devpoint where Pid='"+request.getParameter("nodeid")+"')";
	    	ResultSet rs=ds.select(getSubstation);
	    	String s="";
	    	int num=0;
	    	if(rs!=null)
	    	{
	    		while(rs.next())
	    		{
	    			if(s.equals(""))
	    			{
	    				s=s.trim()+"[\""+rs.getString(2)+"\","+rs.getInt(4)+"]";
	    			}
	    			else
	    			{
	    				s=s.trim()+",[\""+rs.getString(2)+"\","+rs.getInt(4)+"]";
	    			}		
	    			num++;
	    		}
	    	}
	    	out.print("var data = [ "+s+" ];");
	    	out.print("num ="+num+";");
	    
	     %>
    	if(num>16)
		{
			document.getElementById("placeholder").style.cssText="width:"+((num/16)*1000)+"px;";
		}
		else if(num==0)
		{
			document.getElementById("placeholder").style.cssText="display:none;";
		}
    	
    	var plot1 = $.jqplot('placeholder', [data], {
        
        	seriesDefaults:{
            	renderer:$.jqplot.BarRenderer,
            	pointLabels: { show: true},
            	// Rotate the bar shadow as if bar is lit from top right.
            	//shadowAngle: 135,
            	//rendererOptions: {fillToZero: true}
        	},
        
        	series:[
            	{label:'当前温度'}
        	],
       
        	legend: {
        	    show: true,
        	    placement: 'outsideGrid'
        	},
        	axes: {
        	   
        	    xaxis: {
        	        renderer: $.jqplot.CategoryAxisRenderer//,
        	        //ticks: ticks
        	    },
           	 
        	    yaxis: {
        	        pad: 1.05//,
           	    	//tickOptions: {formatString: '%d'}
            	}
        	}
    	});
	});

	</script>
</head>
<body>

	<!--content start-->
    <div id="content" style="width:100%;">

       	<div id="demo-container" class="demo-container" style="width:1000px;margin:0 auto">
			<div id="placeholder"  class="demo-placeholder"></div>
		</div>
	
		<div id="content-field" style="width:1000px;margin:20px auto" >
            
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">采样点编号</th>
                        <th class="table-style-th">名称</th>
                        <th class="table-style-th">安装位置</th>
                        <th class="table-style-th">温度值</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		if(num==0)
                  		{
                  			//out.println("暂无数据！");	
                  		}
                  		else
                  		{
                  			num=0;
	                  		String Sample_ID="";
	    					String Sample_Name="";
	    					String TemValue="";
	    					String Sample_Place="";
	                  		
					    	if(rs!=null)
					    	{
					    		rs.beforeFirst();
					    		while(rs.next())
					    		{
					    			if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
			    					{
			    						Sample_ID=rs.getString("Sample_ID").trim();
			    					}
			    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
			    					{
			    						Sample_Name=rs.getString("Sample_Name").trim();
			    					}
			    					if(rs.getString("Sample_Place")!=null&&rs.getString("Sample_Place").equals("null")==false)
			    					{
			    						Sample_Place=rs.getString("Sample_Place").trim();
			    					}
			    					if(rs.getString("TemValue")!=null&&rs.getString("TemValue").equals("null")==false)
			    					{
			    						TemValue=rs.getString("TemValue").trim();
			    					}
			    					
			    					out.print("<tr><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
			    					+Sample_ID+"</td><td class='table-style-td'>"
			    					+Sample_Name+" </td><td class='table-style-td'>"
			    					+Sample_Place+"</td><td class='table-style-td'>"
			    					+TemValue+" </td></tr>");
			    					num++;
			    					Sample_ID="";
		    						Sample_Name="";
		    						Sample_Place="";
		    						TemValue="";
					    		}
					    		num=0;
					    		rs.close();
					    	}
					    	
                  		}
                  		
				    	ds.close();
                  	
    				%>
                  </tbody>
                </table>
                	<%
                		if(num==0)
                  		{
                  			//out.println("当前有 0 条记录！");	
                  		}
                	 %>
            </div>
        </div>
		
    </div>
    
    <!--content end-->

</body>
</html>
