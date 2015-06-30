package com.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.dataselect;

public class checklogin extends HttpServlet {

	public checklogin() {
		super();
	}

	public void destroy() {
		super.destroy(); 
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
		ResultSet rs=null;
		String name=request.getParameter("username");
		String psw =request.getParameter("password");
		dataselect ds=new dataselect();
		try{
			String sql="select User_Password from Users where User_Login='"+name+"'";
			rs=ds.select(sql);
			String truePsw="";
		 	
			while(rs.next())
			{	
				truePsw=rs.getString(1);
			}
			rs.close();
		 	if(psw.equals(truePsw)==true)//用户名密码正确
		 	{
		 		HttpSession session=request.getSession();
		 		session.setAttribute("user_id",name);
		 		/*记录登录日志*/
  				Date d=new Date();
  				String insert="insert into Logs(UID,OTim,Oper,Res,IP) values('"+name+"','"+d.toLocaleString()+"','1','成功登录','"+request.getLocalAddr()+"')";
  				ds.update(insert);		
		 		out.print("sucess");
		 	}
		 	else
		 	{
		 		out.print("fail");
		 	}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		
		ds.close();
		out.flush();
		out.close();
	}
	public void init() throws ServletException {
		// Put your code here
	}
}
