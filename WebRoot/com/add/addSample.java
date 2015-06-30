package com.add;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class addSample extends HttpServlet {

	public addSample() {
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

		request.setCharacterEncoding("gbk");
		response.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String Sample_Device_Substation=request.getParameter("Substation_ID");
		String Sample_Device =request.getParameter("Device_ID");
		String Sample_ID=request.getParameter("Sample_ID");
		String Sample_Name=request.getParameter("Sample_Name");

		String Sample_Type=request.getParameter("Sample_Type");
		String Sample_Place=request.getParameter("Sample_Place");
		
		String rem=request.getParameter("rem");
		String type=request.getParameter("type");
		dataselect ds=new dataselect();
		try{
			
			String sql="insert into Sample(Substation_ID,Device_ID,Sample_ID,Sample_Name,Sample_Place,Sample_Type,rem) values('"
					   +Sample_Device_Substation+"','"
					   +Sample_Device+"','"
					   +Sample_ID+"','"
					   +Sample_Name+"','"
					   +Sample_Place+"','"
					   +Sample_Type+"','"
					   +rem+"')";
			if(type.equals("update")==true)
			{
				sql="update  Sample set Sample_Name='"
					+Sample_Name+"',Sample_Place='"+Sample_Place+"',Sample_Type='"+Sample_Type+"',rem='"
					+rem+"' where Sample_ID='"+Sample_ID+"'";
				
			}
			//System.out.println(sql);
			
		 	int i=ds.update(sql);
		 	if(i>0)
			{
				out.print("success");
			}
			else {
				out.print("fail");
			}
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		ds.close();
		out.flush();
		out.close();
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
