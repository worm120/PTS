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
<div id="breadcrumb"> <a  class="tip-bottom"><b><font size="3" color="#87CEFA">�������ݷ���</font></b></a> 

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
	<div class="widget-box">
    	<div class="widget-title"> 
        	<h5>���ع񱨾�Ƶ��</h5>
        </div>
        <div class="widget-content nopadding" id="b" style="height:400px;">
        <iframe src="totalalarmf.jsp?sid=<%=sid%>" width="100%" height="100%" frameborder="0"></iframe>
        </div>
    
        <div style="float:left;width:24.5%">
        <div class="widget-box">
        	<div class="widget-title"> 
        		<h5>���ع��¶ȱ���Ƶ�ʶԱ�</h5>
       		</div>
        	<div class="widget-content nopadding" id="b" style="height:400px;">
        	<iframe src="temaf.jsp?sid=<%=sid%>" width="100%" height="100%" frameborder="0"></iframe>
        	</div>
        </div>
        </div>
        <div style="float:right;width:75.2%">
        <div style="float:left;width:33.4%">
        <div class="widget-box">
        	<div class="widget-title"> 
        		<h5>���ع�ͼƬ����Ƶ�ʶԱ�</h5>
        	</div>
        	<div class="widget-content nopadding" id="b" style="height:400px;">
        	<iframe src="picaf.jsp?sid=<%=sid%>" width="100%" height="100%" frameborder="0"></iframe>
        	</div>
        </div>
        </div>
        <div style="float:right;width:66.3%">
        <div style="float:left;width:49.8%">
        <div class="widget-box">
        	<div class="widget-title"> 
        		<h5>���ع񻡹ⱨ��Ƶ�ʶԱ�</h5>
        	</div>
        	<div class="widget-content nopadding" id="b" style="height:400px;">
        	<iframe src="arcaf.jsp?sid=<%=sid%>" width="100%" height="100%" frameborder="0"></iframe>
        	</div>
        </div>
        </div>
        <div style="float:right;width:49.8%">
        <div class="widget-box">
        	<div class="widget-title"> 
        		<h5>���ع�ʪ�ȱ���Ƶ�ʶԱ�</h5>
        	</div>
        	<div class="widget-content nopadding" id="b" style="height:400px;">
        	<iframe src="humaf.jsp?sid=<%=sid%>" width="100%" height="100%" frameborder="0"></iframe>
        	</div>
        </div>
        </div>
        </div>
        </div>
       
        
	</div>
</div>
        
        
       
  
 


</body>
</html>
