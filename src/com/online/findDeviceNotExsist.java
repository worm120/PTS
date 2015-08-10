package com.online;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class findDeviceNotExsist extends HttpServlet {
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
		String[] svgid=nodeid.split(",");
		

		dataselect ds=null;
		ResultSet rs=null;
		try
		{
			ds=new dataselect();
			
			//out.println("<response>");
			out.print("<nodes>");
			for(int i=0;i<svgid.length;i++)
			{
				String sql="select top 1 Devpoint.Device_ID,Device_Name from"+
			" Devpoint left join Device on Device.Device_ID=Devpoint.Device_ID where Pid='"
						+svgid[i]+"'";
				rs=ds.select(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						
						int temDevNum = 0;
						int humDevNum = 0;
						int arcDevNum = 0;
						int picDevNum = 0;

						String getTemDevNum = "select count(*) from  dbo.Sample where Sample_Type = '01' and Device_ID= '"
									+rs.getString("Device_ID")+"'";
						String getHumDevNum = "select count(*) from  dbo.Sample where Sample_Type = '03' and Device_ID= '"
								+rs.getString("Device_ID")+"'";
						String getArcDevNum = "select count(*) from  dbo.Sample where Sample_Type = '02' and Device_ID= '"
								+rs.getString("Device_ID")+"'";
						String getPicDevNum = "select count(*) from  dbo.Sample where Sample_Type = '00' and Device_ID= '"
								+rs.getString("Device_ID")+"'";
						
						
						ResultSet rs2=ds.select(getTemDevNum);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								temDevNum=rs2.getInt(1);
							}
						}
						
						rs2 = ds.select(getHumDevNum);
						if(rs2!=null)
						{
							while(rs2.next()){
								humDevNum = rs2.getInt(1);
							}
						}
						
						rs2 = ds.select(getArcDevNum);
						if(rs2!=null)
						{
							while(rs2.next()){
								arcDevNum = rs2.getInt(1);
							}
						}
			
						rs2 = ds.select(getPicDevNum);
						if(rs2!=null)
						{
							while(rs2.next()){
								picDevNum = rs2.getInt(1);
							}
						}
						rs2.close();
						
						out.print("<node>");
						out.print("<svgid>"+svgid[i]+"</svgid>");
//						out.print("<Device_ID>"+rs.getString("Device_ID")+"</Device_ID>");
//						out.print("<Device_Name>"+rs.getString("Device_Name")+"</Device_Name>");

						out.print("<temNum>"+temDevNum+"</temNum>");
						
						out.print("<humNum>"+humDevNum+"</humNum>");
						
						out.print("<arcNum>"+arcDevNum+"</arcNum>");
						out.print("<picNum>"+picDevNum+"</picNum>");
//						System.out.println("<temNum>"+temDevNum+"</temNum>");
						out.print("</node>");
					}
				}
			}
			out.print("</nodes>");
			//out.println("</response>");
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		finally
		{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ds.close();
			rs=null;
			ds=null;
			out.flush();
			out.close();
			System.gc();
		}
		
	}

}
