package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class getNewSampleId extends HttpServlet {

	public getNewSampleId() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		String did="00000000000";
		try{
			String sql="select top 1 Sample_ID  from Sample order by Sample_ID desc";
			dataselect ds=new dataselect();
		 	rs=ds.select(sql);
		 	if(rs!=null)
		 	{
		 		while(rs.next())
		 		{
			 		did=rs.getString(1);
		 		}
		 	}
		 	rs.close();
		 	ds.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		System.out.println(did+"<>"+did.substring(0,7)+"<>"+did.substring(7)+"<M>");
		int id=Integer.parseInt(did.substring(7))+1;
		System.out.println("<id>"+id+"<M>");
		if(id<10)
		{
			did=did.substring(0,7)+"000"+id;
		}
		else if(id>=10&&id<100) 
		{
			did=did.substring(0,7)+"00"+id;
		}
		else if(id>=100&&id<1000) 
		{
			did=did.substring(0,7)+"0"+id;
		}
		else if(id>=1000&&id<10000) 
		{
			did=did.substring(0,7)+id;
		}
		System.out.println(did);
		out.println(did);
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
