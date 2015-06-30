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
        <script src="../js/add/fenxiang.js" charset="gbk" type="text/javascript"></script>
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
                   	 采样点分相
                </a>
            </div>
        </div>
        <div id="content-field"  style="height:350px;over-flow:auto;">
            <div class="box-title">
                <div class="checktitle">查询条件</div>
                <div class="select">
                	<!-- 
                	<div class="selectname">采样点编号：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleId" id="sampleId" ></div>
                	<div class="selectname">采样点名称：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleName" id="sampleName" ></div>
                	<div class="selectname">类型：</div><div class="selectCon"><select name="seceltType" id="seceltType"><option value="no">---类型---</option><option value="01">温度</option><option value="00">图像</option><option value="02">弧光</option><option value="03">湿度</option></select></div>
                	 -->
                	<div class="selectname">所属设备：</div>
                	<div class="selectCon">
                		<form action="#" method="post" id="formsub"></form>
                		<select name="seceltDeviceID" id="seceltDeviceID">
                			<option value="no">---选择设备---</option>
                			<%
						    	dataselect ds=new dataselect();
						    	String sid=request.getParameter("sid");//变电所编号
						    	String getdevice="select * from Device where Substation_ID='"+sid+"'";
						    	ResultSet rs=ds.select(getdevice);
						    	String deviceSelect=""; 
						    	if(rs!=null)
						    	{
						    		while(rs.next())
						    		{
						    			out.print("<option value='"+rs.getString("Device_ID")+"'>"+rs.getString("Device_Name")+"</option>");
						    			deviceSelect=deviceSelect+"<option value='"+rs.getString("Device_ID")+"'>"+rs.getString("Device_Name")+"</option>";
						    		}
						    	}
						     %>
                		</select>
                	</div>
                </div>
                <div class="caozuo">
                    <button id="selectS"  class="btn-add">查询</button>
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">分组</button>
                    <!-- 
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">编辑</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">删除</button>
                     -->
                </div>
            </div>
            <div class="box-content" >
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">编号</th>
                        <th class="table-style-th">采样点名称</th>
                        <th class="table-style-th">采样点类型</th>
                        <th class="table-style-th">采样点位置</th>
						<th class="table-style-th">所属设备</th>
                        <th class="table-style-th">所属变电所</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			String sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID where Sample.Sample_ID not in(select Sample_ID from SampleAllocate) and Sample_Type='01' and Sample.Substation_ID='"+sid+"'";
		    			
		    		    if(request.getParameter("seceltDeviceID")!=null&&request.getParameter("seceltDeviceID").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Device_ID='"+request.getParameter("seceltDeviceID")+"'";
		    			}

		    			rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
		    				int num=1;
		    				String type="";
		    				String Sample_ID="";
	    					String Sample_Name="";
	    					String Sample_Place="";
	    					String Device_Name="";
	    					String Substation_Name="";
	    					String rem="";
		    				while(rs.next())
		    				{
		    					if(rs.getString("Sample_Type").equals("01"))
		    					{
		    						type="温度";
		    					}
		    					else if(rs.getString("Sample_Type").equals("00"))
		    					{
		    						type="图像";
		    					}
		    					else if(rs.getString("Sample_Type").equals("02"))
		    					{
		    						type="弧光";
		    					}
		    					else if(rs.getString("Sample_Type").equals("03"))
		    					{
		    						type="湿度";
		    					}
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					if(rs.getString("Sample_Place")!=null&&rs.getString("Sample_Place").equals("null")==false)
		    					{
		    						Sample_Place=rs.getString("Sample_Place").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Sample_ID+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_ID+"</td><td class='table-style-td'>"
		    					+Sample_Name+" </td><td class='table-style-td'>"
		    					+type+"</td><td class='table-style-td'>"
		    					+Sample_Place+"</td><td class='table-style-td'>"
								+Device_Name+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					num++;
		    					type="";
		    					Sample_ID="";
	    						Sample_Name="";
	    						Sample_Place="";
	    						Device_Name="";
	    						Substation_Name="";
	    						rem="";
		    				}
		    				//out.print("</table>");
		    			}
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    
    <!--  /*****************采样点分相列表********************/-->
    <div  style="over-flow:auto;height:350px;top:400px;width:99%;position:absolute;padding: 0px;font-size: 12px;color: #666;background:none repeat scroll 0 0 #F9F9F9; border-left: 1px solid #CDCDCD;border-right: 1px solid #CDCDCD; border-top: 1px solid #CDCDCD;margin-top: 10px;margin: 5px;">
            <div class="box-title">
                <div class="caozuo">
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">删除</button>
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">组号</th>
                        <th class="table-style-th">三相编号号</th>
                        <th class="table-style-th">采样点</th>
						<th class="table-style-th">所属设备</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  	
                  		String get_fenzu="";
                  		
                  		if(request.getParameter("seceltDeviceID")==null)
		    			{
		    				//get_fenzu="select SampleAllocate。Id,Three_ID,Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample_ID from Sample where Substation_ID='"+sid+"') order by SampleAllocate.Id";
		    				get_fenzu="select SampleAllocate.gid,Three_ID,SampleAllocate.Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample.Sample_ID from Sample where Substation_ID='"+sid+"') order by SampleAllocate.Id";
		    			}
		    			else if(request.getParameter("seceltDeviceID").equals("no")==true)
		    			{
		    				get_fenzu="select SampleAllocate.gid,Three_ID,SampleAllocate.Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample.Sample_ID from Sample where Substation_ID='"+sid+"') order by SampleAllocate.Id";
		    			}
                  		else
                  		{
                  			//get_fenzu="select SampleAllocate。Id,Three_ID,Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample_ID from Sample where Device_ID='"+request.getParameter("seceltDeviceID").toString()+"') order by SampleAllocate.Id";
                  			//get_fenzu="select SampleAllocate.Id,Three_ID,SampleAllocate.Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID='"+request.getParameter("seceltDeviceID").toString()+"') order by SampleAllocate.Id";
                  			get_fenzu="select SampleAllocate.gid,Three_ID,SampleAllocate.Sample_ID,Sample_Name,Device_Name from SampleAllocate left join (Sample left join Device on Device.Device_ID=Sample.Device_ID) on Sample.Sample_ID=SampleAllocate.Sample_ID  where Sample.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID='"+request.getParameter("seceltDeviceID")+"') order by SampleAllocate.Id";
                  		}
		    			
		    			rs=ds.select(get_fenzu);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
		    				int num=1;
		    				String Id="";
		    				String Three_ID="";
		    				String Sample_ID="";
	    					String Sample_Name="";
	    					String Device_Name="";
	    					String rem="";
		    				while(rs.next())
		    				{
		    					if(rs.getString("gid")!=null&&rs.getString("gid").equals("null")==false)
		    					{
		    						Id=rs.getString("gid").trim();
		    					}
		    					if(rs.getString("Three_ID")!=null&&rs.getString("Three_ID").equals("null")==false)
		    					{
		    						Three_ID=rs.getString("Three_ID").trim();
		    					}
		    					if(rs.getString("Sample_ID")!=null&&rs.getString("Sample_ID").equals("null")==false)
		    					{
		    						Sample_ID=rs.getString("Sample_ID").trim();
		    					}
		    					if(rs.getString("Sample_Name")!=null&&rs.getString("Sample_Name").equals("null")==false)
		    					{
		    						Sample_Name=rs.getString("Sample_Name").trim();
		    					}
		    					
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					
	    						rem="";
								
								if((num-1)%3==0)
								{
									out.print("<tr><td rowspan='3' class='table-style-td' style='width:10px;'><input type='checkbox' name='fenxiang_beixuan' id='fenxiang_beixuan' value='"+Id+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
			    					+Id+"</td><td class='table-style-td'>"
			    					+Three_ID+"</td><td class='table-style-td'>"
			    					+Sample_ID+"</td><td class='table-style-td'>"
			    					+Sample_Name+" </td><td class='table-style-td'>"
									+Device_Name+" </td><td class='table-style-td'>"
			    					+rem+"</td></tr>");
								}
								else
								{
									out.print("<tr><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
			    					+Id+"</td><td class='table-style-td'>"
			    					+Three_ID+"</td><td class='table-style-td'>"
			    					+Sample_ID+"</td><td class='table-style-td'>"
			    					+Sample_Name+" </td><td class='table-style-td'>"
									+Device_Name+" </td><td class='table-style-td'>"
			    					+rem+"</td></tr>");
								}
								
								/*
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='fenxiang_beixuan' id='fenxiang_beixuan' value='"+Id+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Id+"</td><td class='table-style-td'>"
		    					+Three_ID+"</td><td class='table-style-td'>"
		    					+Sample_ID+"</td><td class='table-style-td'>"
		    					+Sample_Name+" </td><td class='table-style-td'>"
								+Device_Name+" </td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					*/
		    					num++;
		    					Sample_ID="";
	    						Sample_Name="";
	    						Device_Name="";
	    						Id="";
	    						Three_ID="";
	    						rem="";
		    				}
		    				//out.print("</table>");
		    			}
		    			rs.close();
		    			ds.close();
    				%>
                  </tbody>
                </table>
            </div>
        </div>
    <!--  /*************************************/-->
    <input id="hid" type="hidden">
	<input id="hid_sid" type="hidden" value="<%=sid %>">
    </body>
</html>

