<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">   
        <script src="../js/add/addDevice.js" charset="gbk" type="text/javascript"></script>
    </head>
    <body>
    <!--content start-->
    <div id="content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 首页
                </a>
                <a class="current" href="#">
                   	 强弧记录
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                
            </div>
            <div class="box-content" >
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">采样点</th>
                        <th class="table-style-th">弧光次数</th>
                        <th class="table-style-th">弧光类型</th>
                        <th class="table-style-th">发生时间</th>
                        <th class="table-style-th">开关柜</th>
                        <th class="table-style-th">所属变电所</th>
                       <!--  <th class="table-style-th">备注</th> -->
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("pid");//变电所编号
		    			dataselect ds=new dataselect();
		    				    			
		    			String gethu="select AlarmLogArc.Id,AlarmLogArc.Sample_ID,Sample_Name,AlarmNum,AlarmType,Odate,Device_Name,Substation_Name from AlarmLogArc left join SampleDetail on SampleDetail.Sample_ID=AlarmLogArc.Sample_ID where AlarmLogArc.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			
		    			ResultSet rs=ds.select(gethu);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
		    				int num=1;
		    				String Sample_ID="";
		    				String Sample_Name="";
	    					String AlarmNum="";
	    					String AlarmType="";
	    					String Odate="";
	    					String Device_Name="";
	    					String Substation_Name="";
	    					
		    				
		    				while(rs.next())
		    				{
		    					int index=0;
		    					index=rs.getInt("Id");
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					if(rs.getString("AlarmNum")!=null&&rs.getString("AlarmNum").equals("null")==false)
		    					{
		    						AlarmNum=rs.getString("AlarmNum").trim();
		    					}
		    					if(rs.getString("AlarmType")!=null&&rs.getString("AlarmType").equals("null")==false&&rs.getString("AlarmType").equals("0")==true)
		    					{
		    						AlarmType="强弧";
		    					}
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("Odate")!=null&&rs.getString("Odate").equals("null")==false)
		    					{
		    						Odate=rs.getString("Odate").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_Name+"("+Sample_ID+")"+"</td><td class='table-style-td'>"
		    					+AlarmNum+"</td><td class='table-style-td'>"
		    					+AlarmType+"</td><td class='table-style-td'>"
								+Odate+" </td><td class='table-style-td'>"
								+Device_Name+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td></tr>");
		    					num++;
		    					Sample_Name="";
	    						Device_Name="";
	    						Sample_ID="";
	    						AlarmNum="";
	    						AlarmType="";
	    						Substation_Name="";
	    						Odate="";
		    				}
		    				num=0;
		    			}
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->

    </body>
    
</html>

