package com.link;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class getDeviceIdLinked extends HttpServlet {

	public getDeviceIdLinked() {
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
		ResultSet rs=null;
		String subid=request.getParameter("subid");
		
		try{
			/*查询该变电所所有已关联过的采样点*/
			String sql="select Pid,Devpoint.Device_ID from Devpoint where Device_ID in(select Device_ID from Device where Substation_ID='"+subid+"')";
			dataselect ds=new dataselect();
			rs=ds.select(sql);
			//System.out.println(sql);
			if(rs!=null)
			{
				out.println("<response>");
				while(rs.next())
				{	
					/*xml格式返回设备信息*/
					out.print("<device>");
					out.print("<deviceId>"+rs.getString("Device_ID")+"</deviceId>");   System.out.println("pid:"+rs.getString("Pid"));
					out.print("<deviceValue>"+rs.getString("Pid")+"</deviceValue>");
					out.print("</device>");
				}
				out.println("</response>");
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
