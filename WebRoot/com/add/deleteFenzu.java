package com.add;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class deleteFenzu extends HttpServlet {

	public deleteFenzu() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String s=request.getParameter("gid");
		String[] ddStrings=s.split(",");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		//ResultSet rs=null;
		
		int num=0;//³É¹¦É¾³ýÊý
		dataselect ds=new dataselect();
		try{
			
			for(int i=0;i<ddStrings.length;i++)
			{
				String sql="delete from SampleAllocate where gid='"+ddStrings[i]+"'";
			 	int k=ds.update(sql);
			 	if(k>0)
				{
					num++;
				}
			}
			ds.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
		ds.close();
		out.print(num);
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
