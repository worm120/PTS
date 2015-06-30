package com.online;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class settleAlarm extends HttpServlet {

	public settleAlarm() {
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
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		ResultSet rs = null;

		String content = request.getParameter("alarmcontent");
		String id = request.getParameter("alarmid");
		String userid = request.getParameter("userid");
		String type = request.getParameter("type");
		//System.out.println(type);
		try {
			String sql = "update  AlarmLogTemperature set UID='" + userid
					+ "',Cresult='" + content + "',Sdate='"
					+ new Date().toLocaleString() + "' where Id=" + id + "";
			if (type != null && type.equals("huguang")) {
				sql = "update  AlarmLogArc set UID='" + userid + "',Cresult='"
						+ content + "',Sdate='" + new Date().toLocaleString()
						+ "' where Id=" + id + "";
			}
			if (type != null && type.equals("hum")) {
				sql = "update  AlarmLogHumidity set UID='" + userid
						+ "',Cresult='" + content + "',Sdate='"
						+ new Date().toLocaleString() + "' where Id=" + id + "";
			}
			if (type != null && type.equals("photo")) {
				sql = "update  AlarmLogPicture set UID='" + userid
						+ "',Cresult='" + content + "',Sdate='"
						+ new Date().toLocaleString() + "' where Id=" + id + "";
			}
			dataselect ds = new dataselect();
			int i = ds.update(sql);
			if (i > 0) {
				out.print("success");
			} else {
				out.print("fail");
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		out.flush();
		out.close();
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
