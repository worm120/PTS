package com.online;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class getDeviceId extends HttpServlet {

	public getDeviceId() {
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

		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		
		String nodeid=request.getParameter("nodeid");
		try
		{
			dataselect ds=new dataselect();
			ResultSet rs=null;
			String sql="select Device_ID from Devpoint where Pid='"+nodeid+"'";
			rs=ds.select(sql);
			if(rs!=null)
			{
				while(rs.next())
				{
					out.print(rs.getString(1));
				}
			}
			rs.close();
			ds.close();
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
