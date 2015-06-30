package com.dataInterface;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class getSubDevice extends HttpServlet {

	public getSubDevice() {
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
		//System.out.println("ff");
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		String sid=request.getParameter("sid");
		try{
			String sql="select * from Device where Substation_ID='"+sid+"'";
			dataselect ds=new dataselect();
			rs=ds.select(sql);
			out.println("<response>");
			if(rs!=null)
			{
				while(rs.next())
				{	
					/*xml格式返回可关联开关柜信息*/
					out.print("<device>");
					out.print("<deviceId>"+rs.getString("Device_ID")+"</deviceId>");
					out.print("<deviceValue>"+rs.getString("Device_Name")+"</deviceValue>");
					out.print("</device>");
				}
			}
			rs.close();
			out.println("</response>");
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
