package com.add;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.interfaces.DSAKey;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class deleteDevice extends HttpServlet {

	public deleteDevice() {
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

		String s=request.getParameter("did");
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
				String sql="delete from Device where Device_ID='"+ddStrings[i]+"'";
				String sql1="delete from DeviceSet where Device_ID='"+ddStrings[i]+"'";
			 	int k=ds.update(sql);
				int j=ds.update(sql1);
			 	if(k>0&&j>0)
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
