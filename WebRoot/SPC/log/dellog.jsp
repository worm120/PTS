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
<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">ɾ���������־</font></b></a> 

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
			
			 out.println("�������ţ�");
			 out.println("<b>"+sid+"</b>");
			 out.print("&nbsp&nbsp&nbsp&nbsp&nbsp");
			 out.print("��������ƣ�");
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
            		<font size="4">ѡ��Ҫɾ������־��</font>
            		&nbsp&nbsp&nbsp
<!--             		<input type="checkbox" name="oplog" id="oplog" value="������־"/>&nbsp<font size="3">������־</font> -->
<!--             		&nbsp&nbsp -->
            		<input type="checkbox" name="temlog" id="temlog" value="�¶ȱ�����־"/>&nbsp<font size="3">�¶ȱ�����־</font>
<!--             		&nbsp&nbsp -->
<!--             		<input type="checkbox" name="piclog" id="piclog" value="ͼƬ������־"/>&nbsp<font size="3">ͼƬ������־</font> -->
<!--             		&nbsp&nbsp -->
<!--             		<input type="checkbox" name="arclog" id="arclog" value="���ⱨ����־"/>&nbsp<font size="3">���ⱨ����־</font> -->
            		&nbsp&nbsp
            		<input type="checkbox" name="humlog" id="humlog" value="ʪ�ȱ�����־"/>&nbsp<font size="3">ʪ�ȱ�����־</font>
				</p>
				<br>
				<p align="center" >
           			<font size="4"> ѡ��ɾ����¼ʱ��Σ�</font>
           			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
					<font size="3">��ʼ���ڣ�</font><input id="sdate" name="sdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
					&nbsp&nbsp&nbsp
					<font size="3">�������ڣ�</font><input id="fdate" name="fdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="width: 213px; ">
				</p>
				<br><br>
				<p align="center" >  
            		<button  class="btn" type="submit"  style="width: 100px;" onclick="f()"> ɾ��</button>                          
            		<input id="tm" name="tm" class="btn" type="submit" style="width: 100px;" onclick="ft()" value="ɾ��������"/>
            		<input id="hy" name="hy" class="btn" type="submit" style="width: 100px;" onclick="fhy()" value="ɾ������"/>
            		<input id="oy" name="oy" class="btn" type="submit" style="width: 100px;" onclick="foy()" value="ɾ��һ��"/>
            		<input id="all" name="all" class="btn" type="submit" style="width: 100px;" onclick="fa()" value="ɾ��ȫ��"/>
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
			
			if(confirm("ȷ��ɾ��: ��"+s+"��"+f+"����"+table+" �ļ�¼��?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������־ɾ���ɹ�");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶ȱ�����־ɾ���ɹ�");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ������־ɾ���ɹ�");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("���ⱨ����־ɾ���ɹ�");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ�ȱ�����־ɾ���ɹ�");
				}
				
			}
			
		    else
		    {
				return false;				
		    }
		    
		    }
		    else{alert("��ѡ��Ҫɾ������־��");}
		}
		else
		{
			
			alert("��ѡ��ʱ��");
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
		
			if(confirm("ȷ��ɾ��: �������ڱ�"+table+" �ļ�¼��?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������־ɾ���ɹ�");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶ȱ�����־ɾ���ɹ�");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ������־ɾ���ɹ�");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("���ⱨ����־ɾ���ɹ�");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ�ȱ�����־ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������־��");}
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
		
			if(confirm("ȷ��ɾ��: �����ڱ�"+table+" �ļ�¼��?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������־ɾ���ɹ�");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶ȱ�����־ɾ���ɹ�");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ������־ɾ���ɹ�");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("���ⱨ����־ɾ���ɹ�");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ�ȱ�����־ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������־��");}
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
		
			if(confirm("ȷ��ɾ��: һ���ڱ�"+table+" �ļ�¼��?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������־ɾ���ɹ�");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶ȱ�����־ɾ���ɹ�");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ������־ɾ���ɹ�");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("���ⱨ����־ɾ���ɹ�");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ�ȱ�����־ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������־��");}
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
		
			if(confirm("ȷ��ɾ��: ��"+table+" �����м�¼��?"))
			{
				if(document.getElementById("oplog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delopalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������־ɾ���ɹ�");
				}
				if(document.getElementById("temlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶ȱ�����־ɾ���ɹ�");
				}
				if(document.getElementById("piclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpicalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ������־ɾ���ɹ�");
				}
				if(document.getElementById("arclog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarcalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("���ⱨ����־ɾ���ɹ�");
				}
				if(document.getElementById("humlog").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumalarm?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ�ȱ�����־ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������־��");}
	}
</script>
</body>
</html>
