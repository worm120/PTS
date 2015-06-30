package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.action.*;

public class getNewSubstationID extends HttpServlet {

	public getNewSubstationID() {
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
		String sid="000";
		try{
			
			String sql="select top 1 Substation_ID from Substation order by Substation_ID desc";
			dataselect ds=new dataselect();
		 	rs=ds.select(sql);
		 	if(rs!=null)
		 	{
		 		rs.next();
		 		sid=rs.getString(1);
		 	}
		 	rs.close();
		 	ds.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		//System.out.print(sid);
		int id=Integer.parseInt(sid)+1;
		out.println(id);
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
