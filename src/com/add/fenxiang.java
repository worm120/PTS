package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class fenxiang extends HttpServlet {

	public fenxiang() {
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
		String spid=request.getParameter("Sample_ID");
		String[] sample_id=spid.split(",");
		ResultSet rs=null;
		try{
			dataselect ds=new dataselect();
			String getid="select top 1 id from SampleAllocate order by id desc";
			rs=ds.select(getid);
		 	int index=1;
		 	while(rs.next())
		 	{
		 		index=rs.getInt(1);
		 		index++;
		 	}
			String group1="insert into SampleAllocate(gid,Three_ID,Sample_ID,Sample_Type) values("+index+",'A','"+sample_id[0]+"','01')";
			String group2="insert into SampleAllocate(gid,Three_ID,Sample_ID,Sample_Type) values("+index+",'B','"+sample_id[1]+"','01')";
			String group3="insert into SampleAllocate(gid,Three_ID,Sample_ID,Sample_Type) values("+index+",'C','"+sample_id[2]+"','01')";
			
			
		 	int i=ds.update(group1);
		 	int j=ds.update(group2);
		 	int k=ds.update(group3);
		 	ds.close();
		 	if(i>0&&j>0&&k>0)
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
