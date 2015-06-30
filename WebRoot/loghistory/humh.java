package loghistory;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import java.text.*; 
import java.sql.*;  
import javax.naming.Context;   
import javax.naming.InitialContext;   
import javax.sql.DataSource;   
import java.io.*;

public class humh extends HttpServlet {
	public void destroy(){
		super.destroy();
		
	}
	public void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		doPost(request,response);
	}
	public void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException{
		response.setContentType("text/html");
		response.setCharacterEncoding("gbk");
		PrintWriter out=response.getWriter();
		String sid="",did="",s="",f="",pldel="";
		int currentPage=1;
		int lineSize=10;
   		int pageSize=0;
   		int allRecorders = 30 ;
		if(request.getParameter("sid")!=null)
		{sid=request.getParameter("sid").toString();}
		if(request.getParameter("did")!=null)
		{did=request.getParameter("did").toString();}
		if(request.getParameter("s")!=null)
		{s=request.getParameter("s").toString();}
		if(request.getParameter("f")!=null)
		{f=request.getParameter("f").toString();}
		if(request.getParameter("cp")!=null)
		{currentPage = Integer.parseInt(request.getParameter("cp")) ;}
		if(request.getParameter("pldel")!=null)
		{pldel = request.getParameter("pldel") ;}
		  int l=pldel.length();int i=1,k=0;
		  String a[]=new String[l];
		  for(int j=0;j<l;j++){a[j]="";}
		  if(l!=0){
		  while(i<l)
		  {
		  	if(pldel.charAt(i)!='a'){
		  	a[k]=a[k]+pldel.charAt(i);
		  	i++;
		  }
		  else{i++;k++;}
		  }
		  k++;}
		 String pl[]=new String[k];
		 //System.out.print(pl.length);
		 for(i=0;i<pl.length;i++){pl[i]=a[i];}
		 
		try{
			Context ctx=new InitialContext();
		    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
		    Connection conn=ds.getConnection();
			Statement stmt=conn.createStatement();
			
			int rc=0;
			String sql5="select * from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='03'";
			ResultSet rs5=stmt.executeQuery(sql5);
			if(rs5!=null){while(rs5.next()){rc++;}}
			
			int ys=0;
			if((rc%lineSize)!=0){ys=rc/lineSize+1;}
			else{ys=rc/lineSize;}
			//System.out.print(ys);
			int key;
			String sql7="";
			if(k!=0){for(i=0;i<1;i++){if(pl[i].equals("0")==true & currentPage==ys){currentPage=currentPage-1;}}}
			for(i=0;i<pl.length;i++)
			{	
				if(pl[i].equals("0")==false)
				{
					key=Integer.parseInt(pl[i]);
					sql7="delete from Logs where Id='"+key+"'";
					stmt.executeUpdate(sql7);
				}
			}
			
			String sql6="select * from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='03'";
			ResultSet rs6=stmt.executeQuery(sql6);
			 
			out.print("<table class='table table-bordered data-table' >");
	        out.print("<thead>");
	        out.print("<tr>");
	        //out.print("<th width='2%'><input type='checkbox' onchange='getcheck()' id='qx' name='qx' value='0'></th>");
	        out.print("<th>日期</th>");
	        out.print("<th>时间</th>");
	        out.print("<th>采样点</th>");
	        out.print("<th>湿度值</th>");
	        out.print("<th>备注</th>"); 
	        out.print("</tr>");   
	        out.print("</thead>");
			out.print("<tbody>"); 
			int x;
			if(rs6!=null)
			{
				for(x=0;x<(currentPage-1)*lineSize;x++)
				{
					rs6.next();
				}
				for(x=0;x<lineSize;x++)
				{
					if(rs6.next())
					{
						//out.println("<tr><td><input type='checkbox' id='pldel' name='pldel' value="+rs6.getInt("Id")+"></td>");
						if(rs6.getDate("Date")!=null){out.println("<tr><td>"+rs6.getDate("Date")+"</td>");}else {out.println("<tr><td></td>");}
						if(rs6.getTime("Date")!=null){out.println("<td>"+rs6.getTime("Date")+"</td>");}else {out.println("<td></td>");}
						if(rs6.getString("Sample_ID")!=null){out.println("<td>"+rs6.getString("Sample_ID")+"</td>");}else {out.println("<td></td>");}
						out.println("<td>"+rs6.getFloat("HumValue")+"</td>");
						if(rs6.getString("rem")!=null){out.println("<td>"+rs6.getString("rem")+"</td></tr>");}else {out.println("<td></td></tr>");}
					}
					else if(!rs6.next() & k!=0 & x==0)
					{
						x=lineSize;
						if(currentPage>1){currentPage=currentPage-1;}
						sql6="select * from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='03'";
						rs6=stmt.executeQuery(sql6);
						for(x=0;x<(currentPage-1)*lineSize;x++)
						{
							rs6.next();
						}
						for(x=0;x<lineSize;x++)
						{
							if(rs6.next())
							{
								//out.println("<tr><td><input type='checkbox' id='pldel' name='pldel' value="+rs6.getInt("Id")+"></td>");
								if(rs6.getDate("Date")!=null){out.println("<tr><td>"+rs6.getDate("Date")+"</td>");}else {out.println("<tr><td></td>");}
								if(rs6.getTime("Date")!=null){out.println("<td>"+rs6.getTime("Date")+"</td>");}else {out.println("<td></td>");}
								if(rs6.getString("Sample_ID")!=null){out.println("<td>"+rs6.getString("Sample_ID")+"</td>");}else {out.println("<td></td>");}
								out.println("<td>"+rs6.getFloat("HumValue")+"</td>");
								if(rs6.getString("rem")!=null){out.println("<td>"+rs6.getString("rem")+"</td></tr>");}else {out.println("<td></td></tr>");}
							}
						}
					}
				}
			}
			
			/*//test
			for(i=0;i<10;i++)
			{
				out.print("<tr>");
		        //out.print("<th width='2%'><input type='checkbox' onchange='getcheck()' id='qx' name='qx' value='0'></th>");
		        out.print("<td>2014-10-"+i+"</td>");
		        out.print("<td>10:10:10</td>");
		        out.print("<td>采样点"+i+"</td>");
		        out.print("<td>"+i+"</td>");
		        out.print("<td>无</td>"); 
		        out.print("</tr>");   
			}
			*/
			out.print("</tbody>"); 
			out.print("</table>");
			out.print("<p id='ncp3' style='display:none'>"+currentPage+"</p>");
			
			sql5="select * from HumidityHistory a,Sample b where a.Date between '"+s+"' and '"+f+"' and b.Substation_ID='"+sid+"' and b.Device_ID='"+did+"' and b.Sample_ID=a.Sample_ID and b.Sample_Type='03'";
			rs5=stmt.executeQuery(sql5);
			rc=0;
			if(rs5!=null){while(rs5.next()){rc++;}}
			if((rc%lineSize)!=0){ys=rc/lineSize+1;}
			else{ys=rc/lineSize;}
			out.print("<p id='nys3' style='display:none'>"+ys+"</p>");
			out.print("<p id='nrc3' style='display:none'>"+rc+"</p>");
			
			rs5.close();
			rs6.close();
			stmt.close();
			conn.close();
			//rs6.close();stmt.close();conn.close();
			//out.print("<h2 class='h'>error</h2>");
			out.flush();
			out.close();	
		} catch   (Exception   e)   { 
		      e.printStackTrace(); }
		
	}
	public void inti() throws ServletException{}
}
