package com.online;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.dataselect;

public class showOnlineDevice extends HttpServlet {
	
	//static dataselect ds=null;//new dataselect();
	
	public showOnlineDevice() {
		super();
	}

	public void destroy() {
		//ds.close();
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
		
		String nodeid=request.getParameter("nodeid");
		String sid=request.getParameter("sid");
		String[] svgid=nodeid.split(",");
		
		float TemValue=0;//环境温度
		float HumidityValue=0;//环境湿度
		int zhouqi=60;//巡检周期
		dataselect ds=null;
		ResultSet rs=null;
		try
		{
			ds=new dataselect();
			
			/*
			String getSurroundTemperature="select TemValue,HumValue from SurroundTemperature where Sample_ID in(select Sample_ID from Sample where Substation_ID='"+sid+"')";
			rs=ds.select(getSurroundTemperature);//查询环境温湿度
			if(rs!=null)
			{
				while(rs.next())
				{
					TemValue=rs.getFloat("TemValue");
					HumidityValue=rs.getFloat("HumValue");
				}
			}
			*/
			String getZhouqi="select Para_Check from Parameter where Substation_ID='"+sid+"'";
			rs=ds.select(getZhouqi);//查询巡检周期
			if(rs!=null)
			{
				while(rs.next())
				{
					zhouqi=rs.getInt("Para_Check");
				}
			}
			
			out.println("<response>");
				/*
				//返回环境温湿度
				out.print("<surround>");
				out.print("<TemValue>"+TemValue+"</TemValue>");
				out.print("<HumidityValue>"+HumidityValue+"</HumidityValue>");
				out.print("</surround>");
				*/
			out.print("<zhouqi>");
			out.print("<Para_Check>"+zhouqi+"</Para_Check>");
			out.print("</zhouqi>");
			
			for(int i=0;i<svgid.length;i++)
			{
				String sql="select top 1 Devpoint.Device_ID,Device_Name from Devpoint left join Device on Device.Device_ID=Devpoint.Device_ID where Pid='"+svgid[i]+"'";
				rs=ds.select(sql);
				if(rs!=null)
				{
					while(rs.next())
					{
						//String  getTemAlarm="select count(*) from AlarmLogTemperature where Cresult is null and AlarmLogTemperature.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='01' and Device_ID='"+rs.getString("Device_ID")+"')";
						//String  getHumAlarm="select count(*) from AlarmLogHumidity where Cresult is null and AlarmLogHumidity.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='03' and Device_ID='"+rs.getString("Device_ID")+"')";
						String  getTemAlarm_Pre="select count(*) from TemperatureCurrent where TemValue>(select Para_PreExceed_Tem from Parameter where Substation_ID=(select Substation_ID from Device where Device_ID='"+rs.getString("Device_ID")+"')) and Sample_ID in(select Sample_ID from Sample where Device_ID='"+rs.getString("Device_ID")+"')";
						String  getHumAlarm_Pre="select count(*) from HumidityCurrent where HumValue>(select Para_PreExceed_Hum from Parameter where Substation_ID=(select Substation_ID from Device where Device_ID='"+rs.getString("Device_ID")+"')) and Sample_ID in(select Sample_ID from Sample where Device_ID='"+rs.getString("Device_ID")+"')";
						String  getTemAlarm="select count(*) from TemperatureCurrent where TemValue>(select Para_Exceed_Tem from Parameter where Substation_ID=(select Substation_ID from Device where Device_ID='"+rs.getString("Device_ID")+"')) and Sample_ID in(select Sample_ID from Sample where Device_ID='"+rs.getString("Device_ID")+"')";
						String  getHumAlarm="select count(*) from HumidityCurrent where HumValue>(select Para_Exceed_Hum from Parameter where Substation_ID=(select Substation_ID from Device where Device_ID='"+rs.getString("Device_ID")+"')) and Sample_ID in(select Sample_ID from Sample where Device_ID='"+rs.getString("Device_ID")+"')";
						
						
						
						String  getPicAlarm="select count(*) from AlarmLogPicture where Cresult is null and AlarmLogPicture.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='00' and Device_ID='"+rs.getString("Device_ID")+"')";
						String  getHugAlarm="select count(*) from AlarmLogArc where Cresult is null and AlarmLogArc.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='02' and Device_ID='"+rs.getString("Device_ID")+"')";
						
						int TemPre=0;
						int HumPre=0;
						int Tem=0;
						int Hum=0;
						int Pic=0;
						int Hug=0;
						
						ResultSet rs2=ds.select(getTemAlarm_Pre);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								TemPre=rs2.getInt(1);
							}
						}
						
						rs2=ds.select(getHumAlarm_Pre);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								HumPre=rs2.getInt(1);
							}
						}
						
						rs2=ds.select(getTemAlarm);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								Tem=rs2.getInt(1);
							}
						}
						
						rs2=ds.select(getHumAlarm);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								Hum=rs2.getInt(1);
							}
						}
						
						rs2=ds.select(getPicAlarm);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								Pic=rs2.getInt(1);
							}
						}
						
						rs2=ds.select(getHugAlarm);
						if(rs2!=null)
						{
							while(rs2.next())
							{
								Hug=rs2.getInt(1);
							}
						}
						rs2.close();
						
						out.print("<node>");
						out.print("<svgid>"+svgid[i]+"</svgid>");
						out.print("<Device_ID>"+rs.getString("Device_ID")+"</Device_ID>");
						out.print("<Device_Name>"+rs.getString("Device_Name")+"</Device_Name>");
						////////0:正常；1：预警；2：报警//////
						if(Tem>0)
						{
							out.print("<Device_Tem>2</Device_Tem>");
						}
						else if(Tem<=0&&TemPre>0)
						{
							out.print("<Device_Tem>1</Device_Tem>");
						}
						else
						{
							out.print("<Device_Tem>0</Device_Tem>");
						}
						if(Hum>0)
						{
							out.print("<Device_Hum>2</Device_Hum>");
						}
						else if(Hum<=0&&HumPre>0)
						{
							out.print("<Device_Hum>1</Device_Hum>");
						}
						else
						{
							out.print("<Device_Hum>0</Device_Hum>");
						}
						if(Pic>0)
						{
							out.print("<Device_Pic>1</Device_Pic>");
						}
						else
						{
							out.print("<Device_Pic>0</Device_Pic>");
						}
						if(Hug>0)
						{
							out.print("<Device_Hug>1</Device_Hug>");
						}
						else
						{
							out.print("<Device_Hug>0</Device_Hug>");
						}
						out.print("</node>");
					}
				}
			}
			out.println("</response>");
			
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		finally
		{
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ds.close();
			rs=null;
			ds=null;
			//Connection co=ds.getCon();
			out.flush();
			out.close();
			System.gc();
		}
		
	}

	public void init() throws ServletException {
		// Put your code here
		//ds=new dataselect();
	}

}
