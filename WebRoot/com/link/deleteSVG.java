package com.link;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class deleteSVG extends HttpServlet {
	public deleteSVG() {
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
		String svgName=request.getParameter("svgname");//获取要删除文件名
		try{
			/*删除关联*/
			String sql="select count(*) from SubMap where Map_Name='"+svgName+"'";
			dataselect ds=new dataselect();
			ResultSet rs=ds.select(sql);
			int num=0;
			while(rs!=null&&rs.next())
			{
				num=rs.getInt(1);
			}
			rs.close();
			ds.close();
			if(num>0)
			{
				System.out.println("1");
				out.print("fail");
			}
			else
			{
				String svgpath=request.getRealPath("/svg/"+svgName);
				//System.out.println(svgpath);
				File svgfile=new File(svgpath);
				boolean flag=svgfile.delete();
				if(flag)
				{
					out.print("success");
				}
				else
				{
					out.print("fail");
				}
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
