package com.link;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class deleteLinkedDevice extends HttpServlet {

	public deleteLinkedDevice() {
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
		String svgid=request.getParameter("svgId");//获取要取消的接线图id
		try{
			/*删除关联*/
			String sql="delete from Devpoint where Pid='"+svgid+"'";
			dataselect ds=new dataselect();
			int num=ds.update(sql);
			if(num>=0)
			{
				out.print("success");
			}
			else
			{
				out.print("fail");
			}
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
