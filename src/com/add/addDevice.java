package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class addDevice extends HttpServlet {

	public addDevice() {
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
		ResultSet rs=null;
		String Substation_ID=request.getParameter("Substation_ID");
		String Device_ID =request.getParameter("Device_ID");
		String Device_Card=request.getParameter("Device_Card");
		String Device_Name=request.getParameter("Device_Name");
		String Device_Place=request.getParameter("Device_Place");
		//String Device_Feature=request.getParameter("Device_Feature");
		String rem=request.getParameter("rem");
		String type=request.getParameter("type");
		
		try{
			
			String sql="insert into Device(Substation_ID,Device_ID,Device_Card,Device_Name,Device_Place,rem) values('"
					   +Substation_ID+"','"
					   +Device_ID+"','"
					   +Device_Card+"','"
					   +Device_Name+"','"
					   +Device_Place+"','"
					  // +Device_Feature+"','"
					   +rem+"')";
			if(type.equals("update")==true)
			{
				sql="update  Device set Substation_ID='"
					+Substation_ID+"',Device_Place='"
					+Device_Place+"',Device_Card='"
					+Device_Card+"',Device_Name='"
					+Device_Name+"',rem='"
					+rem+"' where Device_ID='"+Device_ID+"'";
				
			}
			//System.out.println(sql);
			dataselect ds=new dataselect();
		 	int i=ds.update(sql);
		 	int j=0;

		 	if(type.equals("insert")==true)//更新变电所的设备数
		 	{
		 		String up="update Substation set Substation_Device=Substation_Device+1 where Substation_ID='"+Substation_ID+"'";
		 		j=ds.update(up);
		 	}
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
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
