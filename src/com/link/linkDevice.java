package com.link;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class linkDevice extends HttpServlet {

	public linkDevice() {
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
		try{
			dataselect ds=new dataselect();
			//System.out.println(request.getParameter("svgId")+"<>"+request.getParameter("sampleId"));
			/*检查该节点是否已关联，若未关联则插入，若已关联则更新*/
			String check1="select count(*) from Devpoint where pid='"+request.getParameter("svgId")+"'";

			rs=ds.select(check1);
			int num=0;
			if(rs!=null)
			{
				while (rs.next())
				{
					num = rs.getInt(1);
				}
			}
			String sql="insert into Devpoint(pid,Device_ID,rem) values('"+request.getParameter("svgId")+"','"+request.getParameter("Device_ID")+"','"+request.getParameter("sid")+"')";
			if(num>0)
			{
				sql="update Devpoint set Device_ID='"+request.getParameter("Device_ID")+"' where pid='"+request.getParameter("svgId")+"'";
			}

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
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
