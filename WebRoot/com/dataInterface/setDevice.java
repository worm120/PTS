package com.dataInterface;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class setDevice extends HttpServlet {

	public setDevice() {
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
		
		//System.out.println("ddd");
		
		request.setCharacterEncoding("gbk");
		response.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		//String Substation_ID=request.getParameter("Substation_ID");
		String Device_ID =request.getParameter("Device_ID");
		String Device_Addr=request.getParameter("Device_Addr");
		String Device_StartH=request.getParameter("Device_StartH");
		String Device_StartL=request.getParameter("Device_StartL");
		String Device_dataL=request.getParameter("Device_dataL");
		String Device_IP=request.getParameter("Device_IP");
		String Device_Port=request.getParameter("Device_Port");
		String Device_Feature=request.getParameter("Device_Feature");
		
		try{
			dataselect ds=new dataselect();
			String is_exiString="select count(*) from DeviceSet where Device_ID='"+Device_ID+"'";
			rs=ds.select(is_exiString);
			int tem=-1;
			if(rs!=null)
			{
				while (rs.next()) 
				{
					tem=rs.getInt(1);
				}
			}
			
			String sql="";
			
			if(tem>0)
			{
				sql="update  DeviceSet set Device_Addr='"
						+Device_Addr+"',Device_Feature='"
						+Device_Feature+"',Device_StartH='"
						+Device_StartH+"',Device_StartL='"
						+Device_StartL+"',Device_dataL='"
						+Device_dataL+"',Device_IP='"+Device_IP+"',Device_Port='"+Device_Port+"' where Device_ID='"+Device_ID+"'";
				
			}
			else
			{
				sql="insert into DeviceSet(Device_ID,Device_Addr,Device_Feature,Device_StartH,Device_StartL,Device_dataL,Device_IP,Device_Port) values('"
						   +Device_ID+"','"
						   +Device_Addr+"','"
						   +Device_Feature+"','"
						   +Device_StartH+"','"
						   +Device_StartL+"','"
						   +Device_dataL+"','"
						   +Device_IP+"','"
						   +Device_Port+"')";
				
			}
			//System.out.println(sql);
		 	int i=ds.update(sql);
		 	rs.close();
		 	ds.close();
		 	
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
