<%@ page language="java" import="java.util.*"  pageEncoding="gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<%@page import="java.sql.*"%>   
<%@page import="javax.naming.Context"%>   
<%@page import="javax.naming.InitialContext"%>   
<%@page import="javax.sql.DataSource"%>    
<%@page import="java.io.*"%> 

<html >
<head>

 <link rel="stylesheet" href="../css/bootstrap.min.css" /> 
<link rel="stylesheet" href="../css/matrix-style.css" />
<script src="../js/jquery.min.js"></script>  





</head>

<body >
	<%
			String did="",s="",f="";
			if(request.getParameter("did")!=null)
			{did=request.getParameter("did").toString();}
			if(request.getParameter("s")!=null)
			{s=request.getParameter("s").toString();}
			if(request.getParameter("f")!=null)
			{f=request.getParameter("f").toString();}
		
		%>
	

           
<br>
            <div id="placeholder"></div>
            <p id="choices"></p>
      
        
  





<script src="../js/jquery.flot.js"></script> 
<script language="javascript" type="text/javascript" src="../js/jquery.flot.categories.js"></script>
<script type="text/javascript" src="../js/jquery.flot.axislabels.js"></script>
<script language="javascript" type="text/javascript" src="../js/jquery.flot.navigate.js"></script>

<script type="text/javascript">

$(document).ready(function(){


    var datasets = {
        <%
          	Context ctx=new InitialContext();
		    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
		    Connection conn=ds.getConnection();
         	Statement stmt=conn.createStatement();
        	//获取历史记录的条数，动态生成等大小的数组
        	int record_num=100;
        	String sql_get_num="select count(*) from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Sample_Type='03' and b.Device_ID='"+did+"' and a.Sample_ID=b.Sample_ID";
        	ResultSet rs3=stmt.executeQuery(sql_get_num);
        	if(rs3!=null)
        	{
        		while(rs3.next())
        		{
        			record_num=rs3.getInt(1);
        		}
        	}
           int i=0;
			//String xdate[][]=new String[100][100];float ydate[][]=new float[100][100];
			String xdate[][]=new String[record_num+1][record_num+1];float ydate[][]=new float[record_num+1][record_num+1];
			String sql3="select distinct a.Sample_ID from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Sample_Type='03'  and b.Device_ID='"+did+"' and a.Sample_ID=b.Sample_ID";
			//ResultSet rs3=myDBBean.query(sql3);
			rs3=stmt.executeQuery(sql3);
			int j,l,m;
			j=0;
			if(rs3!=null)
			{
				while(rs3.next())
				{
					
				 xdate[j][0]=rs3.getString("Sample_ID");
				 j++;
				}
			}
			int js[]=new int[record_num];
			String sql4;
			for(l=0;l<j;l++){
			m=1;
			sql4="select Date,TemValue from HumidityHistory where Date between '"+s+"' and '"+f+"' and Sample_ID='"+xdate[l][0]+"'";
			 rs3=stmt.executeQuery(sql4);
			if(rs3!=null){
			while(rs3.next()){
			xdate[l][m]=rs3.getString("Date");
			ydate[l][m]=rs3.getFloat("HumValue");
			m++;
			}
			js[l]=m;
			}
			}
			rs3.close();
			//rs4.close();
			stmt.close();conn.close();
			
           for(int k=0;k<j;k++){
            out.print("'"+xdate[k][0]+"':{");
            out.print("label:'"+xdate[k][0]+"',data:[");
            //out.print("data:(function() {var data = [];");
            for (i=1;i<js[k];i++) 
            	out.print("["+i+","+ydate[k][i]+",'"+xdate[k][i]+"'],");
            out.print("]},");
            }
         
          %>
         /* var datasets = {
       "usa": {
				label: "采样点1",
				data: [[1, 30,"2014-10-1 10:10:10"], [2, 33,"2014-10-2 10:10:10"], [3, 35,"2014-10-3 10:10:10"], [4, 45,"2014-10-4 10:10:10"], [5, 50,"2014-10-5 10:10:10"], [6, 43,"2014-10-6 10:10:10"], [7, 33,"2014-10-7 10:10:10"], [8, 65,"2014-10-8 10:10:10"]]
			},        
			"russia": {
				label: "采样点2",
				data: [[1, 45,"2014-10-1 10:10:10"], [2, 34,"2014-10-2 10:10:10"], [3, 55,"2014-10-3 10:10:10"], [4, 51,"2014-10-4 10:10:10"], [5, 52,"2014-10-5 10:10:10"], [6, 33,"2014-10-6 10:10:10"], [7, 49,"2014-10-7 10:10:10"], [8, 50,"2014-10-8 10:10:10"]]
			},
			"uk": {
				label: "采样点3",
				data: [[1, 33,"2014-10-1 10:10:10"], [2, 43,"2014-10-2 10:10:10"], [3, 33,"2014-10-3 10:10:10"], [4, 44,"2014-10-4 10:10:10"], [5, 55,"2014-10-5 10:10:10"], [6, 52,"2014-10-6 10:10:10"], [7, 54,"2014-10-7 10:10:10"], [8, 45,"2014-10-8 10:10:10"]]
			},
		 */	
    };

		// hard-code color indices to prevent them from shifting as
		// countries are turned on/off

		var i = 0;
		$.each(datasets, function(key, val) {
			val.color = i;
			++i;
		});

		// insert checkboxes 
		var choiceContainer = $("#choices");
		   $.each(datasets, function(key, val) {
    	choiceContainer.append('<br/><input type="checkbox" name="' + key +
                               '"  id="id' + key + '">' +
                               '<label for="id' + key + '">'
                                + val.label + '</label>');
    }
    );
    choiceContainer.find("input").click(plotAccordingToChoices);
    choiceContainer.find("input").first().attr("checked","checked");

		function plotAccordingToChoices() {

			var data = [];

			choiceContainer.find("input:checked").each(function () {
				var key = $(this).attr("name");
				if (key && datasets[key]) {
					data.push(datasets[key]);
				}
			});

			if (data.length > 0) {
				$.plot("#placeholder", data, {
				   series: {
				lines: {
					show: true
				},
				points: {
					show: true
				}
			},
			grid: {
				hoverable: true,
				clickable: true
			},
					yaxis: {
					axisLabel: "湿度",
					 max:100,
						min: 0,
						tickSize:10
						//ticks:[0,10,20,30,40,50,60,70,80,90,100]
					},
					xaxis: {
						min:1,
						max:50,
						tickSize:1,
						tickDecimals: 0,
						show:false
					},
			zoom: {
				interactive: true
			},
			pan: {
				interactive: true
			}
				});
			}
		}

		plotAccordingToChoices();
			$("<div id='tooltip'></div>").css({
			position: "absolute",
			display: "none",
			border: "1px solid #fdd",
			padding: "2px",
			"background-color": "black",
			opacity: 0.80
		}).appendTo("body");

		$("#placeholder").bind("plothover", function (event, pos, item) {

			
				var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
				$("#hoverdata").text(str);
			

			
				if (item) {
					var x = item.datapoint[0],
						y = item.datapoint[1],
						n = x-1; 
				    var t = item.series['data'][n][2];
					$("#tooltip").html(item.series.label + " : 时间" + t + " ；湿度： " + y)
						.css({top: item.pageY+5, left: item.pageX+5})
						.fadeIn(0);
				} else {
					$("#tooltip").hide();
				}   
			
		});

		$("#placeholder").bind("plotclick", function (event, pos, item) {
			if (item) {
				$("#clickdata").text(" - click point " + item.dataIndex + " in " + item.series.label);
				plot.highlight(item.series, item.datapoint);
			}
		});

		// Add the Flot version string to the footer

		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
		// Add the Flot version string to the footer

		$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
    

});


</script>


</body>
</html>
