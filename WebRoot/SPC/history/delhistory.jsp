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
<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">ɾ���������ʷ����</font></b></a> 

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
            		<font size="4">ѡ��Ҫɾ������ʷ��¼��</font>
            		
            		&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
            		<input type="checkbox" name="temh" id="temh" value="�¶���ʷ��¼"/>&nbsp<font size="3">�¶���ʷ��¼</font>
            		&nbsp&nbsp
            		<input type="checkbox" name="pich" id="pich" value="ͼƬ��ʷ��¼"/>&nbsp<font size="3">ͼƬ��ʷ��¼</font>
            		&nbsp&nbsp
            		<input type="checkbox" name="arch" id="arch" value="������ʷ��¼"/>&nbsp<font size="3">������ʷ��¼</font>
            		&nbsp&nbsp
            		<input type="checkbox" name="humh" id="humh" value="ʪ����ʷ��¼"/>&nbsp<font size="3">ʪ����ʷ��¼</font>
				</p>
				<br>
				<p align="center" >
           			<font size="4"> ѡ��ɾ����¼ʱ��Σ�</font>
           			&nbsp&nbsp&nbsp&nbsp
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
			var ck=[document.getElementById("temh"),document.getElementById("pich"),document.getElementById("arch"),document.getElementById("humh")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
			if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true )
			{
			
			if(confirm("ȷ��ɾ��: ��"+s+"��"+f+"����"+table+" �ļ�¼��?"))
			{
				
				if(document.getElementById("temh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemh?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶���ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("pich").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpich?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ��ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("arch").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarch?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("humh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumh?sid=<%=sid%>&s="+s+"&f="+f,false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ����ʷ��¼ɾ���ɹ�");
				}
				
			}
			
		    else
		    {
				return false;				
		    }
		    
		    }
		    else{alert("��ѡ��Ҫɾ������ʷ��¼��");}
		}
		else
		{
			
			alert("��ѡ��ʱ��");
		}
	}
	function ft()
	{
		var table="";
		var ck=[document.getElementById("temh"),document.getElementById("pich"),document.getElementById("arch"),document.getElementById("humh")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true )
		{
		
			if(confirm("ȷ��ɾ��: �������ڱ�"+table+" �ļ�¼��?"))
			{
				
				if(document.getElementById("temh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemh?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶���ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("pich").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpich?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ��ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("arch").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarch?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("humh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumh?sid=<%=sid%>&date=tm",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ����ʷ��¼ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������ʷ��¼��");}
	}
	function fhy()
	{
		var table="";
		var ck=[document.getElementById("temh"),document.getElementById("pich"),document.getElementById("arch"),document.getElementById("humh")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true )
		{
		
			if(confirm("ȷ��ɾ��: �����ڱ�"+table+" �ļ�¼��?"))
			{
				
				if(document.getElementById("temh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemh?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶���ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("pich").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpich?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ��ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("arch").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarch?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("humh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumh?sid=<%=sid%>&date=hy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ����ʷ��¼ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������ʷ��¼��");}
	}
	function foy()
	{
		var table="";
		var ck=[document.getElementById("temh"),document.getElementById("pich"),document.getElementById("arch"),document.getElementById("humh")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true )
		{
		
			if(confirm("ȷ��ɾ��: һ���ڱ�"+table+" �ļ�¼��?"))
			{
				
				if(document.getElementById("temh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemh?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶���ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("pich").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpich?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ��ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("arch").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarch?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("humh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumh?sid=<%=sid%>&date=oy",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ����ʷ��¼ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������ʷ��¼��");}
	}
	function fa()
	{
		var table="";
		var ck=[document.getElementById("temh"),document.getElementById("pich"),document.getElementById("arch"),document.getElementById("humh")];
			for(i=0;i<ck.length;i++)
			{
				
				if(ck[i].checked==true)
				{
					table=table+ck[i].value+" ";
				}
			}
		if(ck[0].checked==true | ck[1].checked==true | ck[2].checked==true | ck[3].checked==true )
		{
		
			if(confirm("ȷ��ɾ��: ��"+table+" �����м�¼��?"))
			{
				
				if(document.getElementById("temh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/deltemh?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("�¶���ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("pich").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delpich?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ͼƬ��ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("arch").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delarch?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("������ʷ��¼ɾ���ɹ�");
				}
				if(document.getElementById("humh").checked==true)
				{
					var xmlhttp;
 					xmlhttp=new XMLHttpRequest();
  					xmlhttp.open("GET","../../servlet/delhumh?sid=<%=sid%>&date=all",false);
  					xmlhttp.send();
  					document.getElementById("a").innerHTML=xmlhttp.responseText;
					alert("ʪ����ʷ��¼ɾ���ɹ�");
				}
		
			}
			
		    else
		    {
				return false;				
		    }
		    
		 }
		 else{alert("��ѡ��Ҫɾ������ʷ��¼��");}
	}
</script>
</body>
</html>
