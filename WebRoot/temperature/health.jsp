<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <link href="../css/examples.css" rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript" src="../js/realchart/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="../js/realchart/jquery.flot.js"></script>
		<script language="javascript" type="text/javascript" src="../js/realchart/jquery.flot.categories.js"></script>
		<script language="javascript" type="text/javascript" src="../js/realchart/jquery.flot.pie.js" charset=gbk></script>
		<script language="javascript" type="text/javascript" src="../js/realchart/jquery.flot.categories.js"></script>
		<script type="text/javascript">

			$(function() {
				var num=0;
				//var data = [ ["January", 10], ["February", 8], ["March", 4], ["April", 13], ["May", 17], ["June", 9] ];
				<%/*
			    	dataselect ds=new dataselect();
			    	String getSubstation="select Sample_ID,count(*) from AlarmLog group by Sample_ID having Sample_ID in(select Sample_ID from Sample where Substation_ID='"+request.getParameter("sid")+"') order by count(*) desc";
			    	ResultSet rs=ds.select(getSubstation);
			    	String s="";
			    	int num=0;
			    	if(rs!=null)
			    	{
			    		while(rs.next())
			    		{
			    			if(s.equals(""))
			    			{
			    				s=s.trim()+"[\""+rs.getString(1)+"\","+rs.getInt(2)+"]";
			    			}
			    			else
			    			{
			    				s=s.trim()+",[\""+rs.getString(1)+"\","+rs.getInt(2)+"]";
			    			}		
			    			num++;
			    		}
			    	}
			    	rs.close();
			    	ds.close();
			    	out.print("var data = [ "+s+" ];");
			    	out.print("num ="+num+";");
			    	*/
			     %>
			     
			    var data = [ ["温度", 10], ["图像", 4], ["弧光", 1]];
				if(num>16)
				{
					document.getElementById("placeholder").style.cssText="width:"+((num/16)*1000)+"px;";
					document.getElementById("demo-container").style.cssText="width:"+((num/16)*1000+10)+"px;";
					document.getElementById("content").style.cssText="width:"+((num/16)*1000)+"px;";
				}
				$.plot("#placeholder", [ {data: data,label:"报警频率分布"} ], {
					series: {
						bars: {
							show: true,
							barWidth: 0.2,
							align: "center"
						}
					},
					xaxis: {
						mode: "categories",
						tickLength: 0
					},
					grid: {
						hoverable: true,
						clickable: true
					}
				});
				$("<div id='tooltip'></div>").css({
					position: "absolute",
					display: "none",
					border: "1px solid #fdd",
					padding: "2px",
					"background-color": "#fee",
					opacity: 0.80
				}).appendTo("body");
		
				$("#placeholder").bind("plothover", function (event, pos, item) {
						var x = item.datapoint[0].toFixed(2),
							y = item.datapoint[1].toFixed(2);
							//item.series.label
						$("#tooltip").html("报警频率: "+ y)
							.css({top: item.pageY+5, left: item.pageX+5})
							.fadeIn(200);
				});
				// Add the Flot version string to the footer

				var data = [ {label:"温度",data:10}, {label:"图像",data: 4}, {label:"弧光",data:1}];
				/*var data = [],
				series = Math.floor(Math.random() * 6) + 3;

				for (var i = 0; i < series; i++) {
					data[i] = {
						label: "Series" + (i + 1),
						data: Math.floor(Math.random() * 100) + 1
					};
				};
				*/
				$.plot('#placeholder_2', data, {
				    series: {
				        pie: {
				            show: true,
				            radius: 3/4,
				            label: {
				                show: true,
				                radius: 3/4,
				                background: {
				                    opacity: 0.5,
				                    color: '#000'
				                }
				            }
				        }
				    },
				    legend: {
				        show: false
				    }
				});
				$("#placeholder_2").bind("plothover", function(event, pos, obj) {

					if (!obj) {
						return;
					}
	
					var percent = parseFloat(obj.series.percent).toFixed(2);
					$("#hover").html("<span style='font-weight:bold; color:" + obj.series.color + "'>" + obj.series.label + " (" + percent + "%)</span>");
				});
	
				$("#placeholder_2").bind("plotclick", function(event, pos, obj) {
	
					if (!obj) {
						return;
					}
					percent = parseFloat(obj.series.percent).toFixed(2);
					alert(""  + obj.series.label + ": " + percent + "%");
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
        <div id="demo-container_2" class="demo-container" style="width:1000px;margin:0 auto">
			<div id="placeholder_2"  class="demo-placeholder"></div>
		</div>
		<div id="demo-container_2" style="width:1000px;height=500px;margin:0 auto">
			<iframe src="../SPC/datastatistic/datas.jsp?sid=<%=request.getParameter("sid") %>"  width=100% height=500px></iframe>
		</div>
		<div id="demo-container" class="demo-container" style="width:1000px; height:100px; margin:0 auto">设备运行状况：良好。</div>
    </div>
    
    <!--content end-->
    </body>
</html>

