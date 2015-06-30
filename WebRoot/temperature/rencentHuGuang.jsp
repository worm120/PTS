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
                   	 最近弧光记录
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
                        <!--<th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>-->
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">采样点</th>
                        <th class="table-style-th">最近一次弧光持续时间</th>
                        <th class="table-style-th">最近一次弧光发生日期</th>
						<th class="table-style-th">最近二次弧光持续时间</th>
                        <th class="table-style-th">最近二次弧光发生日期</th>
                        <th class="table-style-th">最近三次弧光持续时间</th>
                        <th class="table-style-th">最近三次弧光发生日期</th>
                        <th class="table-style-th">最近四次弧光持续时间</th>
                        <th class="table-style-th">最近四次弧光发生日期</th>
                        <th class="table-style-th">最近五次弧光持续时间</th>
                        <th class="table-style-th">最近五次弧光发生日期</th>
                        <th class="table-style-th">最近六次弧光持续时间</th>
                        <th class="table-style-th">最近六次弧光发生日期</th>
                        <th class="table-style-th">最近七次弧光持续时间</th>
                        <th class="table-style-th">最近七次弧光发生日期</th>
						<th class="table-style-th">开关柜</th>
                        <th class="table-style-th">所属变电所</th>
                       <!--  <th class="table-style-th">备注</th> -->
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("pid");//变电所编号
		    			dataselect ds=new dataselect();
		    				    			
		    			String gethu="select recentHg.id,recentHg.Sample_ID,Sample_Name,recentHg.Sample_ID,hg_recent1_time,hg_recent1_date,hg_recent2_time,hg_recent2_date,hg_recent3_time,hg_recent3_date,hg_recent4_time,hg_recent4_date,hg_recent5_time,hg_recent5_date,hg_recent6_time,hg_recent6_date,hg_recent7_time,hg_recent7_date,Device_Name,Substation_Name from recentHg left join SampleDetail on SampleDetail.Sample_ID=recentHg.Sample_ID where recentHg.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			
		    			ResultSet rs=ds.select(gethu);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
		    				int num=1;
		    				String Sample_ID="";
		    				String Sample_Name="";	    					
	    					String Device_Name="";
	    					String Substation_Name="";
	    					String hg_recent1_time="";//最近一次弧光发生时，弧光长度时间（单位毫秒）

							String hg_recent1_date="";//最近一次弧光发生日期
							
							//最近第二次
							String hg_recent2_time="";//最近二次弧光发生时，弧光长度时间（单位毫秒）
	
							String hg_recent2_date="";//最近二次弧光发生日期					
							
							//最近第三次
							String hg_recent3_time="";//最近三次弧光发生时，弧光长度时间（单位毫秒）
	
							String hg_recent3_date="";//最近三次弧光发生日期

							//最近第四次
							String hg_recent4_time="";//最近四次弧光发生时，弧光长度时间（单位毫秒）

							String hg_recent4_date="";//最近四次弧光发生日期

							
							//最近第五次
							String hg_recent5_time="";//最近五次弧光发生时，弧光长度时间（单位毫秒）

							String hg_recent5_date="";//最近五次弧光发生日期
							
							//最近第六次
							String hg_recent6_time="";//最近六次弧光发生时，弧光长度时间（单位毫秒）

							String hg_recent6_date="";//最近六次弧光发生日期
							
							//最近第七次
							String hg_recent7_time="";//最近次弧光发生时，弧光长度时间（单位毫秒）

							String hg_recent7_date="";//最近七次弧光发生日期
							
							
		    				while(rs.next())
		    				{
		    					int index=0;
		    					index=rs.getInt("id");
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
		    					
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
								
								hg_recent1_time=rs.getString("hg_recent1_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								
								hg_recent1_date=rs.getString("hg_recent1_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent1_time.equals("0"))
								{
									hg_recent1_time="未发生";
									hg_recent1_date="无";
								}
	
								
								hg_recent2_time=rs.getString("hg_recent2_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent2_date=rs.getString("hg_recent2_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent2_time.equals("0"))
								{
									hg_recent2_time="未发生";
									hg_recent2_date="无";
								}
								
								hg_recent3_time=rs.getString("hg_recent3_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent3_date=rs.getString("hg_recent3_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent3_time.equals("0"))
								{
									hg_recent3_date="无";
								}
								
								hg_recent4_time=rs.getString("hg_recent4_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent4_date=rs.getString("hg_recent4_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent4_time.equals("0"))
								{
									hg_recent4_time="未发生";
									hg_recent4_date="无";
								}
								
								hg_recent5_time=rs.getString("hg_recent5_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent5_date=rs.getString("hg_recent5_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent5_time.equals("0"))
								{
									hg_recent5_time="未发生";
									hg_recent5_date="无";
								}
								
								hg_recent6_time=rs.getString("hg_recent6_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent6_date=rs.getString("hg_recent6_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent6_time.equals("0"))
								{
									hg_recent6_time="未发生";
									hg_recent6_date="无";
								}
								
								hg_recent7_time=rs.getString("hg_recent7_time");//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent7_date=rs.getString("hg_recent7_date");//最近一次弧光发生到现在时长（单位秒）
								if(hg_recent7_time.equals("0"))
								{
									hg_recent7_time="未发生";
									hg_recent7_date="无";
								}

								
		    					out.print("<tr><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_Name+"("+Sample_ID+")"+"</td><td class='table-style-td'>"
		    					+hg_recent1_time+"</td><td class='table-style-td'>"
		    					+hg_recent1_date+"</td><td class='table-style-td'>"
								
								+hg_recent2_time+"</td><td class='table-style-td'>"
		    					+hg_recent2_date+"</td><td class='table-style-td'>"
								//+hg_2_date+" </td><td class='table-style-td'>"
								+hg_recent3_time+"</td><td class='table-style-td'>"
		    					+hg_recent3_date+"</td><td class='table-style-td'>"
								//+hg_3_date+" </td><td class='table-style-td'>"
								+hg_recent4_time+"</td><td class='table-style-td'>"
		    					+hg_recent4_date+"</td><td class='table-style-td'>"
								//+hg_4_date+" </td><td class='table-style-td'>"
								+hg_recent5_time+"</td><td class='table-style-td'>"
		    					+hg_recent5_date+"</td><td class='table-style-td'>"
								//+hg_5_date+" </td><td class='table-style-td'>"
								+hg_recent6_time+"</td><td class='table-style-td'>"
		    					+hg_recent6_date+"</td><td class='table-style-td'>"
								//+hg_6_date+" </td><td class='table-style-td'>"
								+hg_recent7_time+"</td><td class='table-style-td'>"
		    					+hg_recent7_date+"</td><td class='table-style-td'>"
								//+hg_7_date+" </td><td class='table-style-td'>"
								
								
								+Device_Name+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td></tr>");
		    					num++;
		    					Sample_Name="";
	    						Device_Name="";
	    						Sample_ID="";

	    						Substation_Name="";
	    						
								hg_recent1_time="";//最近一次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent1_date="";//最近一次弧光发生到现在时长（单位秒）
							
								//最近第二次
								hg_recent2_time="";//最近二次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent2_date="";//最近二次弧光发生到现在时长（单位秒）
								
								//最近第三次
								hg_recent3_time="";//最近三次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent3_date="";//最近三次弧光发生到现在时长（单位秒）
								
								//最近第四次
								hg_recent4_time="";//最近四次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent4_date="";//最近四次弧光发生到现在时长（单位秒）
								
								
								//最近第五次
								hg_recent5_time="";//最近五次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent5_date="";//最近五次弧光发生到现在时长（单位秒）
								
								//最近第六次
								hg_recent6_time="";//最近六次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent6_date="";//最近六次弧光发生到现在时长（单位秒）
								
								//最近第七次
								hg_recent7_time="";//最近次弧光发生时，弧光长度时间（单位毫秒）
								hg_recent7_date="";//最近七次弧光发生到现在时长（单位秒）
								
								
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

