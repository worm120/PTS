package delete;
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

public class delhumalarm extends HttpServlet {
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
		String sid="",s="",f="",date="";
		if(request.getParameter("sid")!=null)
		{sid=request.getParameter("sid").toString();}
		if(request.getParameter("s")!=null)
		{s=request.getParameter("s").toString();}
		if(request.getParameter("f")!=null)
		{f=request.getParameter("f").toString();}
		if(request.getParameter("date")!=null)
		{date=request.getParameter("date").toString();}
		int flag=0;
		//System.out.print(date);
		if(date.equals("tm")==true)
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
		if(date.equals("hy")==true)
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
		if(date.equals("oy")==true)
		{
			
			DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar=Calendar.getInstance();
			Calendar cpcalendar=(Calendar)calendar.clone();
			cpcalendar.add(Calendar.MONTH, -12);
			String data=df.format( new java.util.Date(cpcalendar.getTimeInMillis()));
			s=data;
			DateFormat df1=new SimpleDateFormat("yyyy-MM-dd");
			Calendar calendar1=Calendar.getInstance();
			Calendar cpcalendar1=(Calendar)calendar1.clone();
			cpcalendar1.add(Calendar.DATE, 1);
			String data1=df1.format( new java.util.Date(cpcalendar1.getTimeInMillis()));
			f=data1;
			
		}
		if(date.equals("all")==true)
		{
			
			flag=1;
			
		}
		 
		try{
			//System.out.print(sid);
			//System.out.print(s);
			//System.out.print(f);
			Context ctx=new InitialContext();
		    DataSource ds=(DataSource)ctx.lookup("java:comp/env/jdbc/c");
		    Connection conn=ds.getConnection();
			Statement stmt=conn.createStatement();
			String sql="";
			if(flag==0)
			{
				//System.out.print("not all");
				sql="delete from AlarmLogHumidity where Sample_ID in (select Sample_ID from Sample where Substation_ID='"+sid+"' and Sample_Type='03') and Odate between '"+s+"' and '"+f+"'";
			}
			else
			{
				//System.out.print("all");
				sql="delete from AlarmLogHumidity where Sample_ID in (select Sample_ID from Sample where Substation_ID='"+sid+"' and Sample_Type='03')";
			}
			stmt.executeUpdate(sql);
			
			stmt.close();
			conn.close();
			out.flush();
			out.close();	
		} catch   (Exception   e)   { 
		      e.printStackTrace(); }
		
	}
	public void inti() throws ServletException{}
}
