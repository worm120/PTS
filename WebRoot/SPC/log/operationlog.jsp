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
<link rel="stylesheet" href="../css/datepicker.css" />
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<link rel="stylesheet" href="../css/matrix-style.css" />
<script src="../js/jquery.min.js"></script> 
<script src="../js/bootstrap-datepicker.js"></script> 

</head>
<body style="background: #efefef;" >
	<%
			String sid="",sname="";
			if(request.getParameter("sid")!=null)
			{sid=request.getParameter("sid").toString();}
			
			
		
		%>

<br>
<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">操作日志</font></b></a> 

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
			
			 out.println("变电所编号：");
			 out.println("<b>"+sid+"</b>");
			 out.print("&nbsp&nbsp&nbsp&nbsp&nbsp");
			 out.print("变电所名称：");
			 out.print("<b>"+sname+"</b>");
          rs.close();
          stmt.close();
          conn.close();
          %>

</div>

 
  <div class="container-fluid">
    <div class="row-fluid" >
			
			<form action="operationlog.jsp?sid=<%=sid%>" method="post">
			<div class="widget-title" >
        
			<p align="center">
			起始日期：<input id="sdate" name="sdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
			&nbsp&nbsp&nbsp
			结束日期：<input id="fdate" name="fdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<button  class="btn" type="submit"> 查询</button>
			</p>
           
           </div> 
           <br>
                 选择时间：&nbsp<input  id="now" name="now" class="btn" type="submit" style="width: 89px; " value="当天"><input id="omonth" name="omonth" class="btn" type="submit" style="width: 89px; " value="一个月"><input id="tmonth" name="tmonth" class="btn" type="submit" style="width: 89px; " value="三个月"><input id="hyear" name="hyear" class="btn" type="submit" style="width: 89px; " value="半年">
            <br><br><br>
             </form>
            
            
            
            </div>
            <%
       		int currentPage=1;
            int lineSize = 10;
       		int pageSize=0;
       		int allRecorders = 30 ;
			String s="",f="";int i=0;
			if(request.getParameter("sdate")!=null){s=request.getParameter("sdate");}
			if(request.getParameter("fdate")!=null){f=request.getParameter("fdate");}
			String str1 = request.getParameter("now");
			String str2 = request.getParameter("omonth"); 
			String str3 = request.getParameter("tmonth"); 
			String str4 = request.getParameter("hyear");
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
				cpcalendar.add(Calendar.MONTH, -6);
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
			String sql2="select * from Logs a,Users b,ACL c where a.OTim between '"+s+"' and '"+f+"' and a.UID=b.User_Login and b.User_Login=c.User_ID and c.Substation_ID='"+sid+"'";
			ResultSet rs2=stmt1.executeQuery(sql2);
			if(rs2!=null)
			{
				while(rs2.next())
				{
				  i++;
				}
			}
			
			//测试数据	
			//i=10;
			
			
			if(i!=0){out.println("查询结果：");
						if(str1!=null){out.println("查询时间：当天；");}
						else if(str2!=null){out.println("查询时间：一个月；");}
						else if(str3!=null){out.println("查询时间：三个月；");}
						else if(str4!=null){out.println("查询时间：半年；");}
						else{out.println("查询时间："+s+"至"+f+"；");}
						out.println("列表记录数：<span id='rc'>"+i+"</span>笔；");
						allRecorders = i ;
						pageSize = (allRecorders+lineSize-1)/lineSize ;}
			else {out.println("查询结果：");}
			rs2.close();
			stmt1.close();
			conn1.close();
		%>
     

    
   
        


        
        
    <form name="f1" id="f1"  action="operationlog.jsp?sid=<%=sid%>&s=<%=s%>&f=<%=f%>" method="post">
			<p align="right"><button class="btn" type="button" onclick="toexcel()" >导出excel</button></p>
			</form>
        <div class="widget-box">
          <div class="widget-title"> 
            <h5>操作日志</h5>
          </div>
          <div class="widget-content nopadding" id="b" style="height:400px;">
          </div>
          <!--  
          <span align="left">
         <input class="btn" type='button' onclick="del()" value="删除"/></span>-->
         <span style="float:right">
        
		<input class="btn" type="button" id="first" value="首页" onClick="first()" >
		<input class="btn" type="button" id="pre" value="上一页" onClick="pre()">
		<input class="btn" type="button" id="next" value="下一页" onClick="next()">
		<input class="btn" type="button" id="last" value="尾页" onClick="last()">
		<input type="hidden" name="cp" value="0"><font style="display:none" id="cpage"></font>
		<font id="page"></font>
		/
		<font id="pages">共<%=pageSize%>页</font>
		</span>
       
        </div>
        
			
        
        
       
  
 
</div>
<script type="text/javascript">
		function toexcel()
		{
			document.all.f1.action="../../servlet/toexcel?sid=<%=sid%>&s=<%=s%>&f=<%=f%>";
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
  		xmlhttp.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+1,false);
  		xmlhttp.send();
  		document.getElementById("b").innerHTML=xmlhttp.responseText;
  		document.getElementById("page").innerHTML="第1页";document.getElementById("cpage").innerHTML=1;
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
  		xmlhttp1.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("b").innerHTML=xmlhttp1.responseText;
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
  			xmlhttp1.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("b").innerHTML=xmlhttp1.responseText;
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
  			xmlhttp1.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+cp,false);
  			xmlhttp1.send();
  			document.getElementById("b").innerHTML=xmlhttp1.responseText;
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
  		xmlhttp1.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+cp,false);
  		xmlhttp1.send();
  		document.getElementById("b").innerHTML=xmlhttp1.responseText;
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
 
<script>
function getcheck(){
	var y=document.getElementById("qx");
	if(y.checked==true)
	{
		var x=document.all;
		for(i=0;i<x.length;i++)
		{
			if(x[i].id=="pldel")
			{
				x[i].checked=true?x[i].checked=true:x[i].checked=true;
			}
		}
	}
	else
	{
		var x=document.all;
		for(i=0;i<x.length;i++)
		{
			if(x[i].id=="pldel")
			{
				x[i].checked=true?x[i].checked=false:x[i].checked=true;
			}
		}
	}
}
</script>
<script>
	function del()
	{
		var cp=document.getElementById("cpage");
		var c=cp.innerHTML;
		var pl=document.all;
		var pldel="";
   			for(i=0;i<pl.length;i++)
   			{
   				if(pl[i].checked==true)
   				{	
   						pldel=pldel+"a"+pl[i].value;
   				}
   			}
   			
		var xmlhttp;
 		xmlhttp=new XMLHttpRequest();
  		xmlhttp.open("GET","../../servlet/operationlog?sid=<%=sid%>&s=<%=s%>&f=<%=f%>&cp="+c+"&pldel="+pldel,false);
  		xmlhttp.send();
  		document.getElementById("b").innerHTML=xmlhttp.responseText;
  		var c=parseInt(document.getElementById("ncp").innerHTML);
  		document.getElementById("page").innerHTML="第"+c+"页";
  		document.getElementById("cpage").innerHTML=c;
  		var y=parseInt(document.getElementById("nys").innerHTML);
  		document.getElementById("pages").innerHTML="共"+y+"页";
  		var r=parseInt(document.getElementById("nrc").innerHTML);
  		document.getElementById("rc").innerHTML=r;
	}
</script>
</body>
</html>
