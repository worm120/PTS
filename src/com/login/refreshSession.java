package com.login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class refreshSession extends HttpServlet {

	public refreshSession() {
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
		//PrintWriter out = response.getWriter();
		HttpSession session=request.getSession();
 		//session.getMaxInactiveInterval();
 		//System.out.println(""+session.getMaxInactiveInterval()+"<>"+session.getCreationTime()+"<>"+session.getLastAccessedTime());
		//out.flush();
		//out.close();
	}
	public void init() throws ServletException {
		// Put your code here
	}

}
