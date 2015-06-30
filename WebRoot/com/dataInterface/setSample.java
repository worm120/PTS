package com.dataInterface;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class setSample extends HttpServlet {

	public setSample() {
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
		response.setContentType("text/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		ResultSet rs=null;
		//String Substation_ID=request.getParameter("Substation_ID");
		String Sample_ID =request.getParameter("Sample_ID");
		String Device_Address=request.getParameter("Device_Address");
		String Sample_AddressH=request.getParameter("Sample_AddressH");
		String Sample_AddressL=request.getParameter("Sample_AddressL");
		String Sample_IndexID=request.getParameter("Sample_IndexID");
		String Sample_dataL=request.getParameter("Sample_dataL");

		
		try{
			dataselect ds=new dataselect();
			String is_exiString="select count(*) from SampleAddress where Sample_ID='"+Sample_ID+"'";
			rs=ds.select(is_exiString);
			int tem=-1;
			if(rs!=null)
			{
				while (rs.next()) 
				{
					tem=rs.getInt(1);
				}
			}
			String sql="";
			if(tem>0)
			{
				sql="update  SampleAddress set Device_Address='"
						+Device_Address+"',Sample_AddressH='"
						+Sample_AddressH+"',Sample_AddressL='"
						+Sample_AddressL+"',Sample_IndexID='"
						+Sample_IndexID+"',Sample_dataL='"
						+Sample_dataL+"' where Sample_ID='"+Sample_ID+"'";
				
			}
			else
			{
				sql="insert into SampleAddress(Sample_ID,Device_Address,Sample_AddressH,Sample_AddressL,Sample_IndexID,Sample_dataL) values('"
						   +Sample_ID+"','"
						   +Device_Address+"','"
						   +Sample_AddressH+"','"
						   +Sample_AddressL+"','"
						   +Sample_IndexID+"','"
						   +Sample_dataL+"')";
				
			}
			//System.out.println(sql);
		 	int i=ds.update(sql);
		 	rs.close();
		 	ds.close();
		 	
		 	if(i>0)
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
