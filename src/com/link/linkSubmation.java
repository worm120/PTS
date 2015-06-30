package com.link;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class linkSubmation extends HttpServlet {

	public linkSubmation() {
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
		String sid="";
		if(request.getParameter("sid")!=null)
		{
			sid=request.getParameter("sid").toString();
		}
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		try{
			dataselect ds=new dataselect();
			String isexist="select count(*) from SubMap where Substation_ID='"+sid+"'";
			rs=ds.select(isexist);
			rs.first();
			int count=rs.getInt(1);
			String sql="insert into SubMap(Substation_ID,Map_Name) values('"+sid+"','"+request.getParameter("svgname")+"')";
			if(count>0)
			{
				sql="update SubMap set Map_Name='"+request.getParameter("svgname")+"' where Substation_ID='"+sid+"'";
			}
			int i=ds.update(sql);
			//删除原来这张图上关联的开关柜
			String delDev="delete from Devpoint where rem='"+sid+"'";
			int j=ds.update(delDev);
			
			
			if(i>0)
			{
				out.print("success");
			}
			else {
				out.print("fail");
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
