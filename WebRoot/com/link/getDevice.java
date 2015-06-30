package com.link;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class getDevice extends HttpServlet {

	public getDevice() {
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
		String id="未关联";
		try{
			String sql="select * from Device";
			//System.out.println(request.getParameter("sid"));
			if(request.getParameter("sid")!=null)
			{
				if(request.getParameter("type").equals("able")==true)
				{
					sql="select * from Device where Substation_ID='"+request.getParameter("sid").toString()+"' and Device_ID not in(select Device_ID from Devpoint)";
				}
				else
				{
					sql="select * from Device where Substation_ID='"+request.getParameter("sid").toString()+"'";
				}
			}
			else if(request.getParameter("type").equals("able")==true)
			{
				sql="select * from Device where Device_ID not in(select Device_ID from Devpoint)";
			}
			//System.out.println(sql);
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
			/*获取该接线图id已关联的采样点id*/
			ResultSet rs1=null;
			if(request.getParameter("svgid")!=null)
			{
				String getLinkSvgIdString="select Devpoint.Device_ID,Device_Name from Devpoint left join Device on Device.Device_ID=Devpoint.Device_ID where Pid='"+request.getParameter("svgid")+"'";
				
				rs1=ds.select(getLinkSvgIdString);
				String name="";
				if(rs1!=null)
				{
					while (rs1.next())
					{
						id=rs1.getString(1);
						name=rs1.getString(2);
					}
				}
				rs1.close();
				out.print("<sample>");
				if(id.equals("未关联"))
				{
					out.print("<sampleid>"+id+"</sampleid>");
				}
				else
				{
					out.print("<sampleid>"+name+"("+id+")</sampleid>");
				}
				out.print("</sample>");
			}
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
