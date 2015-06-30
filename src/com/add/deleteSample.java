package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class deleteSample extends HttpServlet {

	public deleteSample() {
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

		String s=request.getParameter("sid");
		String[] ddStrings=s.split(",");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		
		int num=0;//³É¹¦É¾³ýÊý
		try{
			dataselect ds=new dataselect();
			for(int i=0;i<ddStrings.length;i++)
			{
				String sql="delete from Sample where Sample_ID='"+ddStrings[i]+"'";
				String sql1="delete from SampleAddress where Sample_ID='"+ddStrings[i]+"'";
			 	int k=ds.update(sql);
			 	int l=ds.update(sql1);
			 	if(k>0&&l>0)
				{
					num++;
				}
			}
			ds.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		out.print(num);
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
