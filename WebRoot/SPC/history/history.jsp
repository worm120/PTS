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

<link rel="stylesheet" href="../css/datepicker.css" />
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<link rel="stylesheet" href="../css/matrix-style.css" />
<script src="../js/jquery.min.js"></script> 
<script src="../js/bootstrap-datepicker.js"></script> 





</head>

<body style="background: #efefef;">
	<%
			String sid="",sname="",didf="",dnamef="";
			if(request.getParameter("sid")!=null)
			{sid=request.getParameter("sid").toString();}
			if(request.getParameter("did")!=null)
			{didf=request.getParameter("did").toString();}
			
		
		%>
	
<br>
	<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">历史数据</font></b></a> 
    	
    	<%
 			Context ctx=new InitialContext();
		    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
		    Connection conn=ds.getConnection();
         	Statement stmt=conn.createStatement();
 			
            String sql="select * from Substation where Substation_ID='"+sid+"'";
			ResultSet rs=stmt.executeQuery(sql);
			if(rs!=null)
			{
				 while(rs.next())
				 {
					 if(rs.getString("Substation_Name")!=null)
						 {
							 sname=rs.getString("Substation_Name");
				         }
					
			      }
			}
			
			String sqlnf="select * from Device where Device_ID='"+didf+"'";
			ResultSet rsnf=stmt.executeQuery(sqlnf);
			if(rsnf!=null)
			{
				 while(rsnf.next())
				 {
					 if(rsnf.getString("Device_Name")!=null)
						 {
							 dnamef=rsnf.getString("Device_Name");
				         }
					
			      }
			}
			
			 out.println("变电所编号：");
			 out.println("<b>"+sid+"</b>");
			 out.print("&nbsp&nbsp&nbsp&nbsp&nbsp");
			 out.print("变电所名称：");
			 out.print("<b>"+sname+"</b>");
           	 rs.close();
           	 rsnf.close();
           
           %>
    	</div>
   
  <div class="container-fluid">
    
     
      <div class="row-fluid">
      <form  action="history.jsp?&sid=<%=sid%>" method="post">
        <div class="widget-title" >
        	
			<p align="center">
				
				<select id="device" name="device">
				<% 
				if(didf.equals("")==true)
				{    
				    out.print("<option name='device' id='device' value=''>选择开关柜</option>");
				
					String sql1="select * from Device where Substation_ID='"+sid+"'";
					ResultSet rs1=stmt.executeQuery(sql1);
					if(rs1!=null)
					{
						 while(rs1.next())
				 		{
				 			out.println("<option name='device' id='device' value='"+rs1.getString("Device_ID")+"'>"+rs1.getString("Device_Name")+"</option>");					
			     		}
					}
				
					rs1.close();stmt.close();conn.close();
				}
				else
				{
					out.println("<option name='device' id='device' value='didf'>dnamef</option>");					
				}
				%>
				</select>&nbsp&nbsp&nbsp
			起始日期：<input id="sdate" name="sdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
			&nbsp&nbsp&nbsp
			结束日期：<input id="fdate" name="fdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
			&nbsp&nbsp&nbsp<button  class="btn" type="submit"> 查询</button>
			</p>
           
           </div> 
           <br>
                 选择时间：&nbsp<input  id="now" name="now" class="btn" type="submit" style="width: 89px; " value="当天"><input id="oweek" name="oweek" class="btn" type="submit" style="width: 89px; " value="一周"><input id="tenday" name="tenday" class="btn" type="submit" style="width: 89px; " value="十天"><input id="hmonth" name="hmonth" class="btn" type="submit" style="width: 89px; " value="半月"><input id="omonth" name="omonth" class="btn" type="submit" style="width: 89px; " value="一个月"><input id="tmonth" name="tmonth" class="btn" type="submit" style="width: 89px; " value="三个月">
            <br><br><br>
             </form>
      </div>
       <%
       		int lineSize = 10 ;
       		int currentPage=1;
       		int pageSize=0;
       		int allRecorders = 30 ;
       		int currentPage1=1;
            int pageSize1=0;
       		int allRecorders1 = 30 ;
       		int currentPage2=1;
       		int pageSize2=0;
       		int allRecorders2 = 30 ;
       		int currentPage3=1;
            int pageSize3=0;
       		int allRecorders3 = 30 ;
       		
			String s="",f="",did="",dname="";int i=0;
			if(request.getParameter("sdate")!=null){s=request.getParameter("sdate");}
			if(request.getParameter("fdate")!=null){f=request.getParameter("fdate");}
			if(request.getParameter("device")!=null){did=request.getParameter("device");}
			String str1 = request.getParameter("now");
			String str2 = request.getParameter("omonth"); 
			String str3 = request.getParameter("tmonth"); 
			String str4 = request.getParameter("oweek");
			String str5 = request.getParameter("tenday");
			String str6 = request.getParameter("hmonth");
			if(str1!=null)
			{
				String datetime=new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
				s=datetime;
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.DATE, 1);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				f=data;
			}
			if(str2!=null)
			{
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.MONTH, -1);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				s=data;
				DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar1=Calendar.getInstance();
				Calendar cpcalendar1=(Calendar)calendar1.clone();
				cpcalendar1.add(Calendar.DATE, 1);
				String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
				f=data1;
			}
			if(str3!=null)
			{
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.MONTH, -3);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				s=data;
				DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar1=Calendar.getInstance();
				Calendar cpcalendar1=(Calendar)calendar1.clone();
				cpcalendar1.add(Calendar.DATE, 1);
				String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
				f=data1;
			}
			if(str4!=null)
			{
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.DATE, -7);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				s=data;
				DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar1=Calendar.getInstance();
				Calendar cpcalendar1=(Calendar)calendar1.clone();
				cpcalendar1.add(Calendar.DATE, 1);
				String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
				f=data1;
			}
			if(str5!=null)
			{
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.DATE, -10);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				s=data;
				DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar1=Calendar.getInstance();
				Calendar cpcalendar1=(Calendar)calendar1.clone();
				cpcalendar1.add(Calendar.DATE, 1);
				String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
				f=data1;
			}
			if(str6!=null)
			{
				DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar=Calendar.getInstance();
				Calendar cpcalendar=(Calendar)calendar.clone();
				cpcalendar.add(Calendar.DATE, -15);
				String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
				s=data;
				DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
				Calendar calendar1=Calendar.getInstance();
				Calendar cpcalendar1=(Calendar)calendar1.clone();
				cpcalendar1.add(Calendar.DATE, 1);
				String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
				f=data1;
			}
			
			Connection conn1=ds.getConnection();
         	Statement stmt1=conn1.createStatement();
			
			String sqln="select * from Device where Device_ID='"+did+"'";
			ResultSet rsn=stmt1.executeQuery(sqln);
			if(rsn!=null)
			{
				 while(rsn.next())
				 {
					 if(rsn.getString("Device_Name")!=null)
						 {
							 dname=rsn.getString("Device_Name");
				         }
					
			      }
			}
			
			
			
			int i1=0,i2=0,i3=0;
         	
			
			String sql2="select * from TemperatureHistory a,Sample b where a.Date between '"+s
						+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+
						did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='01'";
			ResultSet rs2=stmt1.executeQuery(sql2);
			
			if(rs2!=null)
			{
				while(rs2.next())
				{
					i1++;
				}
			}
			if(i1!=0)
			{
				out.println(dname+"查询结果：");
				if(str1!=null){out.println("查询时间：当天；");}
				else if(str2!=null){out.println("查询时间：一个月；");}
				else if(str3!=null){out.println("查询时间：三个月；");}
				else if(str4!=null){out.println("查询时间：一周；");}
				else if(str5!=null){out.println("查询时间：十天；");}
				else if(str6!=null){out.println("查询时间：半个月；");}
				out.print("温度历史记录数：<span id='rc'>"+i1+"</span>笔；");
				allRecorders = i1 ;
				pageSize = (allRecorders+lineSize-1)/lineSize ;
			}
			else{
				out.print(dname+"查询结果：");}
			sql2="select * from Photo a,Sample b where a.Date between '"+s+"' and '"+f
					+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did
					+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='00'";
			rs2=stmt1.executeQuery(sql2);
			
			if(rs2!=null)
			{
				while(rs2.next())
				{
					i2++;
				}
			}
			if(i2!=0)
			{
				out.print("图像历史记录数：<span id='rc1'>"+i2+"</span>笔；");
				allRecorders = i2 ;
				pageSize1 = (allRecorders+lineSize-1)/lineSize ;
			}
			sql2="select * from AlarmLogArc a,Sample b where a.Odate between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='02'";
			rs2=stmt1.executeQuery(sql2);
			
			if(rs2!=null)
			{
				while(rs2.next())
				{
					i3++;
				}
			}
			if(i3!=0)
			{
				out.print("弧光历史记录数：<span id='rc2'>"+i3+"</span>笔；");
				allRecorders = i3 ;
				pageSize2 = (allRecorders+lineSize-1)/lineSize ;
			}
			sql2="select * from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='03'";
			rs2=stmt1.executeQuery(sql2);
			int i4=0;
			if(rs2!=null)
			{
				while(rs2.next())
				{
					i4++;
				}
			}
			if(i4!=0)
			{
				out.print("湿度历史记录数：<span id='rc3'>"+i4+"</span>笔；");
				allRecorders = i4 ;
				pageSize3 = (allRecorders+lineSize-1)/lineSize ;
			}
			rsn.close();
			rs2.close();
			stmt1.close();
			conn1.close();
// 			System.out.print("hhh");
		%>
     
         <div class="widget-box" >
         
          <div class="widget-title" id="i" style="cursor:pointer"> 
             
            <h5>历史温度数据曲线：</h5>
             
           </div>
           
           <div class="widget-content" id="j" style="display:none">

             
       
          </div>
        
 
          <div class="widget-title"  id="k" style="cursor:pointer">
            <h5>历史湿度数据曲线：</h5>
          </div>
          
           <div class="widget-content"  id="l" style="display:none">
            
         </div>
         
    	<div class="widget-title" id="a" style="cursor:pointer"> 
        	<h5>温度历史记录</h5>
        </div>
        <div id="b" style="display:none">
        	<div class="widget-content nopadding" id="tem" style="height:400px">
	        </div>
        	<p align="right">
			<input class="btn" type="button" id="first" value="首页" onClick="first()" >
			<input class="btn" type="button" id="pre" value="上一页" onClick="pre()">
			<input class="btn" type="button" id="next" value="下一页" onClick="next()">
			<input class="btn" type="button" id="last" value="尾页" onClick="last()">
			<input type="hidden" name="cp" value="0"><font style="display:none" id="cpage"></font>
			<font id="page"></font>
			/
			<font id="pages">共<%=pageSize%>页</font>
			</p>
        </div>
   
          <div class="widget-title" id="c" style="cursor:pointer"> 
            <h5>图片历史记录</h5>
          </div>
          <div id="d" style="display:none">
          <div class="widget-content nopadding" id="pic" style="height:400px">
            
         </div>
        <p align="right">
		<input class="btn" type="button" id="first1" value="首页" onClick="first1()" >
		<input class="btn" type="button" id="pre1" value="上一页" onClick="pre1()">
		<input class="btn" type="button" id="next1" value="下一页" onClick="next1()">
		<input class="btn" type="button" id="last1" value="尾页" onClick="last1()">
		<input type="hidden" name="cp" value="0"><font style="display:none" id="cpage1"></font>
		<font id="page1"></font>
		/
		<font id="pages1">共<%=pageSize1%>页</font>
		</p>
       </div>
       
          <div class="widget-title" id="e" style="cursor:pointer"> 
            <h5>弧光历史记录</h5>
          </div>
          <div id="f" style="display:none">
          <div class="widget-content nopadding" id="arc" style="height:400px">
            
         </div>
        <p align="right">
		<input class="btn" type="button" id="first2" value="首页" onClick="first2()" >
		<input class="btn" type="button" id="pre2" value="上一页" onClick="pre2()">
		<input class="btn" type="button" id="next2" value="下一页" onClick="next2()">
		<input class="btn" type="button" id="last2" value="尾页" onClick="last2()">
		<input type="hidden" name="cp" value="0"><font style="display:none" id="cpage2"></font>
		<font id="page2"></font>
		/
		<font id="pages2">共<%=pageSize2%>页</font>
		</p>
       </div>
       <div class="widget-title" id="g" style="cursor:pointer"> 
            <h5>湿度历史记录</h5>
          </div>
          <div id="h" style="display:none">
          <div class="widget-content nopadding" id="hum" style="height:400px">
            
         </div>
        <p align="right">
		<input class="btn" type="button" id="first3" value="首页" onClick="first3()" >
		<input class="btn" type="button" id="pre3" value="上一页" onClick="pre3()">
		<input class="btn" type="button" id="next3" value="下一页" onClick="next3()">
		<input class="btn" type="button" id="last3" value="尾页" onClick="last3()">
		<input type="hidden" name="cp" value="0"><font style="display:none" id="cpage3"></font>
		<font id="page3"></font>
		/
		<font id="pages3">共<%=pageSize3%>页</font>
		</p>
       </div>
        </div>
			
    <form name="f1" id="f1" action="alarmlog.jsp" method="post">
            <p align="center">
			<button type="button" class="btn" onclick="toexcel1()" >导出温度表</button>
			<button type="button"  class="btn" onclick="toexcel2()" >导出图片表</button>
			<button type="button"  class="btn" onclick="toexcel3()" >导出弧光表</button>
			<button type="button"  class="btn" onclick="toexcel4()" >导出湿度表</button>
			</p>
	</form>    
        
  
</div>

<script type="text/javascript">

$(document).ready(function(){
	  $("#a").click(function(){
	  $("#b").toggle();
	  });
	  $("#c").click(function(){
	  $("#d").toggle();
	  });
	  $("#e").click(function(){
	  $("#f").toggle();
	  });
	  $("#g").click(function(){
	  $("#h").toggle();
	  });
	  $("#i").click(function(){
	  $("#j").toggle();
	   $("#j").empty();
	  var b = $("#j");
	  b.append('<iframe src="temline.jsp?did=<%=did%>&s=<%=s%>&f=<%=f%>" width="100%" height="400px" frameborder="0"></iframe>');
	
	
	  });
	  $("#k").click(function(){
	  $("#l").toggle();
	   $("#l").empty();
	  var b = $("#l");
	  b.append('<iframe src="humline.jsp?did=<%=did%>&s=<%=s%>&f=<%=f%>" width="100%" height="400px" frameborder="0"></iframe>');
	
	
	  });
});

</script>
<script type="text/javascript">
		function toexcel1()
		{
			document.all.f1.action="../../servlet/temexcel?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>";
			document.all.f1.submit();
		}
		function toexcel2()
		{
			document.all.f1.action="../../servlet/picexcel?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>";
			document.all.f1.submit();
		}
		function toexcel3()
		{
			document.all.f1.action="../../servlet/arcexcel?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>";
			document.all.f1.submit();
		}
		function toexcel4()
		{
			document.all.f1.action="../../servlet/humexcel?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>";
			document.all.f1.submit();
		}
</script>
<script type="text/javascript">
$('#sdate').datepicker();
$('#fdate').datepicker();
</script>
<script type="text/javascript">
	var cp=1;
	$(document).ready(function()
	{
  		var xmlhttp;
 		xmlhttp=new XMLHttpRequest();
  		xmlhttp.open("GET","../../servlet/temh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+1,false);
  		xmlhttp.send();
  		document.getElementById("tem").innerHTML=xmlhttp.responseText;
  		document.getElementById("page").innerHTML="第1页";
  		document.getElementById("cpage").innerHTML=1;
		var y=parseInt(document.getElementById("nys").innerHTML);
  		document.getElementById("pages").innerHTML="共"+y+"页";
	});
	if(cp==1)
	{
		document.getElementById("first").setAttribute("disabled","disabled");
        document.getElementById("pre").setAttribute("disabled","disabled"); 
    }
	else
	{
		document.getElementById("first").removeAttribute("disabled","disabled");
		document.getElementById("pre").removeAttribute("disabled","disabled");
	}
	if(cp==<%=pageSize%>)
	{ 
		document.getElementById("last").setAttribute("disabled","disabled");
		document.getElementById("next").setAttribute("disabled","disabled"); 
	}
	else
	{
		document.getElementById("last").removeAttribute("disabled","disabled");
		document.getElementById("next").removeAttribute("disabled","disabled");
	}
	function first()
	{
		cp=1;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/temh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("tem").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page").innerHTML="第"+cp+"页";
  		document.getElementById("cpage").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first").setAttribute("disabled","disabled");
        	document.getElementById("pre").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first").removeAttribute("disabled","disabled");
			document.getElementById("pre").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last").setAttribute("disabled","disabled");
			document.getElementById("next").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last").removeAttribute("disabled","disabled");
			document.getElementById("next").removeAttribute("disabled","disabled");
		}
	}
	function pre()
	{
		var c=parseInt(document.getElementById("cpage").innerHTML);
		//alert(c);
		cp=c-1;
		if(cp>0)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/temh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("tem").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page").innerHTML="第"+cp+"页";
  			document.getElementById("cpage").innerHTML=cp;
  		}
  		else
  		{
  			cp=1;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first").setAttribute("disabled","disabled");
            document.getElementById("pre").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first").removeAttribute("disabled","disabled");
			document.getElementById("pre").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last").setAttribute("disabled","disabled");
			document.getElementById("next").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last").removeAttribute("disabled","disabled");
			document.getElementById("next").removeAttribute("disabled","disabled");
		}
	}
	function next()
	{
		var c=parseInt(document.getElementById("cpage").innerHTML);
		//alert(c);
		cp=c+1;
		//alert(cp);
		var y=parseInt(document.getElementById("nys").innerHTML);
		var pageSize=y;
		if(cp<=pageSize)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/temh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("tem").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page").innerHTML="第"+cp+"页";
  			document.getElementById("cpage").innerHTML=cp;
  		}
  		else
  		{
  			cp=pageSize;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first").setAttribute("disabled","disabled");
        	document.getElementById("pre").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first").removeAttribute("disabled","disabled");
			document.getElementById("pre").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last").setAttribute("disabled","disabled");
			document.getElementById("next").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last").removeAttribute("disabled","disabled");
			document.getElementById("next").removeAttribute("disabled","disabled");
		}
		
	}
	function last()
	{
		var y=parseInt(document.getElementById("nys").innerHTML);
		var pageSize=y;
		cp=pageSize;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/temh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("tem").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page").innerHTML="第"+cp+"页";
  		document.getElementById("cpage").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first").setAttribute("disabled","disabled");
         	document.getElementById("pre").setAttribute("disabled","disabled"); 
         }
		else
		{
			document.getElementById("first").removeAttribute("disabled","disabled");
			document.getElementById("pre").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last").setAttribute("disabled","disabled");
			document.getElementById("next").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last").removeAttribute("disabled","disabled");
			document.getElementById("next").removeAttribute("disabled","disabled");
		}
	}

</script>
<script type="text/javascript">
	var cp=1;
	$(document).ready(function()
	{
		var xmlhttp2;
 		xmlhttp2=new XMLHttpRequest();
  		xmlhttp2.open("GET","../../servlet/pich?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+1,false);
  		xmlhttp2.send();
  		document.getElementById("pic").innerHTML=xmlhttp2.responseText;
  		document.getElementById("page1").innerHTML="第1页";document.getElementById("cpage1").innerHTML=1;
		var y=parseInt(document.getElementById("nys1").innerHTML);
  		document.getElementById("pages1").innerHTML="共"+y+"页";
	});
	if(cp==1)
	{
		document.getElementById("first1").setAttribute("disabled","disabled");
        document.getElementById("pre1").setAttribute("disabled","disabled"); 
    }
	else
	{
		document.getElementById("first1").removeAttribute("disabled","disabled");
		document.getElementById("pre1").removeAttribute("disabled","disabled");
	}
	if(cp==<%=pageSize1%>)
	{ 
		document.getElementById("last1").setAttribute("disabled","disabled");
		document.getElementById("next1").setAttribute("disabled","disabled"); 
	}
	else
	{
		document.getElementById("last1").removeAttribute("disabled","disabled");
		document.getElementById("next1").removeAttribute("disabled","disabled");
	}
	function first1()
	{
		cp=1;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/pich?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("pic").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page1").innerHTML="第"+cp+"页";
  		document.getElementById("cpage1").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first1").setAttribute("disabled","disabled");
        	document.getElementById("pre1").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first1").removeAttribute("disabled","disabled");
			document.getElementById("pre1").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys1").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last1").setAttribute("disabled","disabled");
			document.getElementById("next1").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last1").removeAttribute("disabled","disabled");
			document.getElementById("next1").removeAttribute("disabled","disabled");
		}
	}
	function pre1()
	{
		var c=parseInt(document.getElementById("cpage1").innerHTML);
		//alert(c);
		cp=c-1;
		if(cp>0)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/pich?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("pic").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page1").innerHTML="第"+cp+"页";
  			document.getElementById("cpage1").innerHTML=cp;
  		}
  		else
  		{
  			cp=1;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first1").setAttribute("disabled","disabled");
            document.getElementById("pre1").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first1").removeAttribute("disabled","disabled");
			document.getElementById("pre1").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys1").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last1").setAttribute("disabled","disabled");
			document.getElementById("next1").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last1").removeAttribute("disabled","disabled");
			document.getElementById("next1").removeAttribute("disabled","disabled");
		}
	}
	function next1()
	{
		var c=parseInt(document.getElementById("cpage1").innerHTML);
		//alert(c);
		cp=c+1;
		//alert(cp);
		var y=parseInt(document.getElementById("nys1").innerHTML);
		var pageSize=y;
		if(cp<=pageSize)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/pich?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("pic").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page1").innerHTML="第"+cp+"页";
  			document.getElementById("cpage1").innerHTML=cp;
  		}
  		else
  		{
  			cp=pageSize;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first1").setAttribute("disabled","disabled");
        	document.getElementById("pre1").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first1").removeAttribute("disabled","disabled");
			document.getElementById("pre1").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last1").setAttribute("disabled","disabled");
			document.getElementById("next1").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last1").removeAttribute("disabled","disabled");
			document.getElementById("next1").removeAttribute("disabled","disabled");
		}
		
	}
	function last1()
	{
		var y=parseInt(document.getElementById("nys1").innerHTML);
		var pageSize=y;
		cp=pageSize;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/pich?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("pic").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page1").innerHTML="第"+cp+"页";
  		document.getElementById("cpage1").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first1").setAttribute("disabled","disabled");
         	document.getElementById("pre1").setAttribute("disabled","disabled"); 
         }
		else
		{
			document.getElementById("first1").removeAttribute("disabled","disabled");
			document.getElementById("pre1").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last1").setAttribute("disabled","disabled");
			document.getElementById("next1").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last1").removeAttribute("disabled","disabled");
			document.getElementById("next1").removeAttribute("disabled","disabled");
		}
	}

</script>
<script type="text/javascript">
	var cp=1;
	$(document).ready(function()
	{
  		var xmlhttp3;
 		xmlhttp3=new XMLHttpRequest();
  		xmlhttp3.open("GET","../../servlet/arch?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+1,false);
  		xmlhttp3.send();
  		document.getElementById("arc").innerHTML=xmlhttp3.responseText;
  		document.getElementById("page2").innerHTML="第1页";document.getElementById("cpage2").innerHTML=1;
		var y=parseInt(document.getElementById("nys2").innerHTML);
  		document.getElementById("pages2").innerHTML="共"+y+"页";
	});
	if(cp==1)
	{
		document.getElementById("first2").setAttribute("disabled","disabled");
        document.getElementById("pre2").setAttribute("disabled","disabled"); 
    }
	else
	{
		document.getElementById("first2").removeAttribute("disabled","disabled");
		document.getElementById("pre2").removeAttribute("disabled","disabled");
	}
	if(cp==<%=pageSize2%>)
	{ 
		document.getElementById("last2").setAttribute("disabled","disabled");
		document.getElementById("next2").setAttribute("disabled","disabled"); 
	}
	else
	{
		document.getElementById("last2").removeAttribute("disabled","disabled");
		document.getElementById("next2").removeAttribute("disabled","disabled");
	}
	function first2()
	{
		cp=1;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/arch?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("arc").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page2").innerHTML="第"+cp+"页";
  		document.getElementById("cpage2").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first2").setAttribute("disabled","disabled");
        	document.getElementById("pre2").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first2").removeAttribute("disabled","disabled");
			document.getElementById("pre2").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys2").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last2").setAttribute("disabled","disabled");
			document.getElementById("next2").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last2").removeAttribute("disabled","disabled");
			document.getElementById("next2").removeAttribute("disabled","disabled");
		}
	}
	function pre2()
	{
		var c=parseInt(document.getElementById("cpage2").innerHTML);
		//alert(c);
		cp=c-1;
		if(cp>0)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/arch?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("arc").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page2").innerHTML="第"+cp+"页";
  			document.getElementById("cpage2").innerHTML=cp;
  		}
  		else
  		{
  			cp=1;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first2").setAttribute("disabled","disabled");
            document.getElementById("pre2").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first2").removeAttribute("disabled","disabled");
			document.getElementById("pre2").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys2").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last2").setAttribute("disabled","disabled");
			document.getElementById("next2").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last2").removeAttribute("disabled","disabled");
			document.getElementById("next2").removeAttribute("disabled","disabled");
		}
	}
	function next2()
	{
		var c=parseInt(document.getElementById("cpage2").innerHTML);
		//alert(c);
		cp=c+1;
		//alert(cp);
		var y=parseInt(document.getElementById("nys2").innerHTML);
		var pageSize=y;
		if(cp<=pageSize)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/arch?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("arc").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page2").innerHTML="第"+cp+"页";
  			document.getElementById("cpage2").innerHTML=cp;
  		}
  		else
  		{
  			cp=pageSize;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first2").setAttribute("disabled","disabled");
        	document.getElementById("pre2").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first2").removeAttribute("disabled","disabled");
			document.getElementById("pre2").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last2").setAttribute("disabled","disabled");
			document.getElementById("next2").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last2").removeAttribute("disabled","disabled");
			document.getElementById("next2").removeAttribute("disabled","disabled");
		}
		
	}
	function last2()
	{
		var y=parseInt(document.getElementById("nys2").innerHTML);
		var pageSize=y;
		cp=pageSize;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/arch?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("arc").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page2").innerHTML="第"+cp+"页";
  		document.getElementById("cpage2").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first2").setAttribute("disabled","disabled");
         	document.getElementById("pre2").setAttribute("disabled","disabled"); 
         }
		else
		{
			document.getElementById("first2").removeAttribute("disabled","disabled");
			document.getElementById("pre2").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last2").setAttribute("disabled","disabled");
			document.getElementById("next2").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last2").removeAttribute("disabled","disabled");
			document.getElementById("next2").removeAttribute("disabled","disabled");
		}
	}

</script>
<script type="text/javascript">
	var cp=1;
	$(document).ready(function()
	{
  		var xmlhttp4;
 		xmlhttp4=new XMLHttpRequest();
  		xmlhttp4.open("GET","../../servlet/humh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+1,false);
  		xmlhttp4.send();
  		document.getElementById("hum").innerHTML=xmlhttp4.responseText;
  		document.getElementById("page3").innerHTML="第1页";document.getElementById("cpage3").innerHTML=1;
		var y=parseInt(document.getElementById("nys3").innerHTML);
  		document.getElementById("pages3").innerHTML="共"+y+"页";
	});
	if(cp==1)
	{
		document.getElementById("first3").setAttribute("disabled","disabled");
        document.getElementById("pre3").setAttribute("disabled","disabled"); 
    }
	else
	{
		document.getElementById("first3").removeAttribute("disabled","disabled");
		document.getElementById("pre3").removeAttribute("disabled","disabled");
	}
	if(cp==<%=pageSize3%>)
	{ 
		document.getElementById("last3").setAttribute("disabled","disabled");
		document.getElementById("next3").setAttribute("disabled","disabled"); 
	}
	else
	{
		document.getElementById("last3").removeAttribute("disabled","disabled");
		document.getElementById("next3").removeAttribute("disabled","disabled");
	}
	function first3()
	{
		cp=1;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/humh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("hum").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page3").innerHTML="第"+cp+"页";
  		document.getElementById("cpage3").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first3").setAttribute("disabled","disabled");
        	document.getElementById("pre3").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first3").removeAttribute("disabled","disabled");
			document.getElementById("pre3").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys3").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last3").setAttribute("disabled","disabled");
			document.getElementById("next3").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last3").removeAttribute("disabled","disabled");
			document.getElementById("next3").removeAttribute("disabled","disabled");
		}
	}
	function pre3()
	{
		var c=parseInt(document.getElementById("cpage3").innerHTML);
		//alert(c);
		cp=c-1;
		if(cp>0)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/humh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("hum").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page3").innerHTML="第"+cp+"页";
  			document.getElementById("cpage3").innerHTML=cp;
  		}
  		else
  		{
  			cp=1;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first3").setAttribute("disabled","disabled");
            document.getElementById("pre3").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first3").removeAttribute("disabled","disabled");
			document.getElementById("pre3").removeAttribute("disabled","disabled");
		}
		var y=parseInt(document.getElementById("nys3").innerHTML);
		var pageSize=y;
		if(cp==pageSize)
		{ 
			document.getElementById("last3").setAttribute("disabled","disabled");
			document.getElementById("next3").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last3").removeAttribute("disabled","disabled");
			document.getElementById("next3").removeAttribute("disabled","disabled");
		}
	}
	function next3()
	{
		var c=parseInt(document.getElementById("cpage3").innerHTML);
		//alert(c);
		cp=c+1;
		//alert(cp);
		var y=parseInt(document.getElementById("nys3").innerHTML);
		var pageSize=y;
		if(cp<=pageSize)
		{
			var xmlhttp1;
  			xmlhttp1=new XMLHttpRequest();
  			xmlhttp1.open("GET","../../servlet/humh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("hum").innerHTML=xmlhttp1.responseText;
  			document.getElementById("page3").innerHTML="第"+cp+"页";
  			document.getElementById("cpage3").innerHTML=cp;
  		}
  		else
  		{
  			cp=pageSize;
  		}
  		if(cp==1)
  		{ 
  			document.getElementById("first3").setAttribute("disabled","disabled");
        	document.getElementById("pre3").setAttribute("disabled","disabled"); 
        }
		else
		{
			document.getElementById("first3").removeAttribute("disabled","disabled");
			document.getElementById("pre3").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last3").setAttribute("disabled","disabled");
			document.getElementById("next3").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last3").removeAttribute("disabled","disabled");
			document.getElementById("next3").removeAttribute("disabled","disabled");
		}
		
	}
	function last3()
	{
		var y=parseInt(document.getElementById("nys3").innerHTML);
		var pageSize=y;
		cp=pageSize;
		var xmlhttp1;
  		xmlhttp1=new XMLHttpRequest();
  		xmlhttp1.open("GET","../../servlet/humh?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&did=<%=did%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("hum").innerHTML=xmlhttp1.responseText;
  		document.getElementById("page3").innerHTML="第"+cp+"页";
  		document.getElementById("cpage3").innerHTML=cp;
  		if(cp==1)
  		{ 
  			document.getElementById("first3").setAttribute("disabled","disabled");
         	document.getElementById("pre3").setAttribute("disabled","disabled"); 
         }
		else
		{
			document.getElementById("first3").removeAttribute("disabled","disabled");
			document.getElementById("pre3").removeAttribute("disabled","disabled");
		}
		if(cp==pageSize)
		{ 
			document.getElementById("last3").setAttribute("disabled","disabled");
			document.getElementById("next3").setAttribute("disabled","disabled"); 
		}
		else
		{
			document.getElementById("last3").removeAttribute("disabled","disabled");
			document.getElementById("next3").removeAttribute("disabled","disabled");
		}
	}

</script>
</body>
</html>
