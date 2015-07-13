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
<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">删除变电所日志</font></b></a> 

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
		
			<div>
				<br><br>
				<p align="center">
            		<font size="4">选择要删除的日志表：</font>
            		&nbsp&nbsp&nbsp
<!--             		<input type="checkbox" name="oplog" id="oplog" value="操作日志"/>&nbsp<font size="3">操作日志</font> -->
<!--             		&nbsp&nbsp -->
            		<input type="checkbox" name="temlog" id="temlog" value="温度报警日志"/>&nbsp<font size="3">温度报警日志</font>
<!--             		&nbsp&nbsp -->
<!--             		<input type="checkbox" name="piclog" id="piclog" value="图片报警日志"/>&nbsp<font size="3">图片报警日志</font> -->
<!--             		&nbsp&nbsp -->
<!--             		<input type="checkbox" name="arclog" id="arclog" value="弧光报警日志"/>&nbsp<font size="3">弧光报警日志</font> -->
            		&nbsp&nbsp
            		<input type="checkbox" name="humlog" id="humlog" value="湿度报警日志"/>&nbsp<font size="3">湿度报警日志</font>
				</p>
				<br>
				<p align="center" >
           			<font size="4"> 选择删除记录时间段：</font>
           			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
					<font size="3">起始日期：</font><input id="sdate" name="sdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
					&nbsp&nbsp&nbsp
					<font size="3">结束日期：</font><input id="fdate" name="fdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
				</p>
				<br><br>
				<p align="center" >  
            		<button  class="btn" type="submit"  style="width: 100px;" onclick="f()"> 删除</button>                          
            		<input id="tm" name="tm" class="btn" type="submit" style="width: 100px;" onclick="ft()" value="删除三个月"/>
            		<input id="hy" name="hy" class="btn" type="submit" style="width: 100px;" onclick="fhy()" value="删除半年"/>
            		<input id="oy" name="oy" class="btn" type="submit" style="width: 100px;" onclick="foy()" value="删除一年"/>
            		<input id="all" name="all" class="btn" type="submit" style="width: 100px;" onclick="fa()" value="删除全部"/>
	        	</p>
			</div>
			<div id="a" style="display:none"></div>
	</div>
</div>

<script type="text/javascript">
	$('#sdate').datepicker();
	$('#fdate').datepicker();
</script>
<script type="text/javascript">
	function f()
	{
		var s=document.getElementById("sdate").value;
		var f=document.getElementById("fdate").value;
		var table="";
		if(s!="" & f!="")
		{ 
			var ck=[document.getElementById("oplog"),document.getElementById("temlog"),document.getElementById("piclog"),document.getElementById("arclog"),document.getElementById("humlog")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
			if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true | ck[4].checked==true)
			{
			
			if(confirm("确定删除: 从"+s+"到"+f+"，表："+table+" 的记录吗?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("操作日志删除成功");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("温度报警日志删除成功");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("图片报警日志删除成功");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("弧光报警日志删除成功");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("湿度报警日志删除成功");
				}
				
			}
			
		    else
		    {
				return false;				
		    }
		    
		    }
		    else{alert("请选择要删除的日志表");}
		}
		else
		{
			
			alert("请选择时间");
		}
	}
	function ft()
	{
		var table="";
		var ck=[document.getElementById("oplog"),document.getElementById("temlog"),document.getElementById("piclog"),document.getElementById("arclog"),document.getElementById("humlog")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true | ck[4].checked==true)
		{
		
			if(confirm("确定删除: 三个月内表："+table+" 的记录吗?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("操作日志删除成功");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("温度报警日志删除成功");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("图片报警日志删除成功");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("弧光报警日志删除成功");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("湿度报警日志删除成功");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("请选择要删除的日志表");}
	}
	function fhy()
	{
		var table="";
		var ck=[document.getElementById("oplog"),document.getElementById("temlog"),document.getElementById("piclog"),document.getElementById("arclog"),document.getElementById("humlog")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true | ck[4].checked==true)
		{
		
			if(confirm("确定删除: 半年内表："+table+" 的记录吗?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("操作日志删除成功");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("温度报警日志删除成功");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("图片报警日志删除成功");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("弧光报警日志删除成功");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("湿度报警日志删除成功");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("请选择要删除的日志表");}
	}
	function foy()
	{
		var table="";
		var ck=[document.getElementById("oplog"),document.getElementById("temlog"),document.getElementById("piclog"),document.getElementById("arclog"),document.getElementById("humlog")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true | ck[4].checked==true)
		{
		
			if(confirm("确定删除: 一年内表："+table+" 的记录吗?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("操作日志删除成功");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("温度报警日志删除成功");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("图片报警日志删除成功");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("弧光报警日志删除成功");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("湿度报警日志删除成功");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("请选择要删除的日志表");}
	}
	function fa()
	{
		var table="";
		var ck=[document.getElementById("oplog"),document.getElementById("temlog"),document.getElementById("piclog"),document.getElementById("arclog"),document.getElementById("humlog")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true | ck[4].checked==true)
		{
		
			if(confirm("确定删除: 表："+table+" 的所有记录吗?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("操作日志删除成功");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("温度报警日志删除成功");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("图片报警日志删除成功");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("弧光报警日志删除成功");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("湿度报警日志删除成功");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("请选择要删除的日志表");}
	}
</script>
</body>
</html>
