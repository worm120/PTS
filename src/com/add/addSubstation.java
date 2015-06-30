package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class addSubstation extends HttpServlet {

	public addSubstation() {
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
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		//ResultSet rs=null;
		String Substation_ID=request.getParameter("Substation_ID");
		String Substation_Name=request.getParameter("Substation_Name");
		String Substation_Place=request.getParameter("Substation_Place");
		String Substation_Tele=request.getParameter("Substation_Tele");
		//String Substation_Device=request.getParameter("Substation_Device");
		String rem=request.getParameter("rem");
		String type=request.getParameter("type");
		try{
			
			String sql="insert into Substation(Substation_ID,Substation_Name,Substation_Place,Substation_Tele,Substation_Device,rem) values('"
					   +Substation_ID+"','"
					   +Substation_Name+"','"
					   +Substation_Place+"','"
					   +Substation_Tele+"','0','"
					   +rem+"')";
			if(type.equals("update")==true)
			{
				sql="update  Substation set Substation_Name='"+Substation_Name+"',Substation_Place='"+Substation_Place+"',Substation_Tele='"+Substation_Tele+"',rem='"+rem+"' where Substation_ID='"+Substation_ID+"'";
				
			}
			dataselect ds=new dataselect();
		 	int i=ds.update(sql);
		 	if(i>0)
			{
				out.print("success");
			}
			else {
				out.print("fail");
			}
			ds.close();
		}catch(Exception ex){
			out.print("fail");
			ex.printStackTrace();
		}
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
