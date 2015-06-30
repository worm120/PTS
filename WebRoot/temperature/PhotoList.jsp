<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">   
        <!-- <script src="../js/online/getRemotePic.js" charset="gbk" type="text/javascript"></script>-->
        
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
                   	图像报警设置
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <!--  <div class="quanxuan">全选</div>-->
                <div class="checktitle">选测图像采样点设置图像监测区域</div>
                <div class="caozuo">
                    <i class="icon-wrench"></i>
                    <button id="adds" class="btn-add" href="#">设置</button>
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">序号</th>
                        <th class="table-style-th">编号</th>
                        <th class="table-style-th">采样点名称</th>          
						<th class="table-style-th">采样点类型</th>
						<th class="table-style-th">采样点安装地址</th>
						<th class="table-style-th">所属设备</th>
                        <th class="table-style-th">所属变电所</th>
                        <th class="table-style-th">设备id</th>
                        <th class="table-style-th">目的地址</th>
                        <th class="table-style-th">端口号</th>
                        <th class="table-style-th">摄像头ID||位序</th>
                        <th class="table-style-th">数据起始地址H</th>
                        <th class="table-style-th">数据起始地址L</th>
                        <th class="table-style-th">数据长度</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("nodeid");
                  		String sid=request.getParameter("sid");
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID left join DeviceSet on DeviceSet.Device_ID=Sample.Device_ID left join SampleAddress on SampleAddress.Sample_ID=Sample.Sample_ID where  Sample.Sample_ID in(select Sample.Sample_ID from Sample where Sample_Type='00' and Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where pid='"+pid+"')) and Device_Address is not null and Sample_AddressH is not null order by Sample.Substation_ID,Sample.Device_ID";
	
		    			ResultSet rs=ds.select(sqls);
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
	    					String Device_Addr="";
	    					String Sample_AddressH="";
	    					String Sample_AddressL="";
	    					String Device_IP="";
	    					String Device_Port="";
	    					
	    					String Sample_IndexID="";
	    					String Sample_dataL="";
	    					String rem="";
		    				
		    				while(rs.next())
		    				{
		    					//String type="";
		    					if(rs.getString("Sample_Type").equals("1"))
		    					{
		    						type="温度";
		    					}
		    					else if(rs.getString("Sample_Type").equals("0"))
		    					{
		    						type="图像";
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
		    					if(rs.getString("Device_Addr")!=null&&rs.getString("Device_Addr").equals("null")==false)
		    					{
		    						Device_Addr=rs.getString("Device_Addr").trim();
		    					}
		    					if(rs.getString("Device_IP")!=null&&rs.getString("Device_IP").equals("null")==false)
		    					{
		    						Device_IP=rs.getString("Device_IP").trim();
		    					}
		    					if(rs.getString("Device_Port")!=null&&rs.getString("Device_Port").equals("null")==false)
		    					{
		    						Device_Port=rs.getString("Device_Port").trim();
		    					}
		    					if(rs.getString("Sample_AddressH")!=null&&rs.getString("Sample_AddressH").equals("null")==false)
		    					{
		    						Sample_AddressH=rs.getString("Sample_AddressH").trim();
		    					}
		    					if(rs.getString("Sample_AddressL")!=null&&rs.getString("Sample_AddressL").trim().equals("null")==false)
		    					{
		    						Sample_AddressL=rs.getString("Sample_AddressL").trim();
		    					}
		    					
		    					if(rs.getString("Sample_IndexID")!=null&&rs.getString("Sample_IndexID").equals("null")==false)
		    					{
		    						Sample_IndexID=rs.getString("Sample_IndexID").trim();
		    					}
		    					if(rs.getString("Sample_dataL")!=null&&rs.getString("Sample_dataL").equals("null")==false)
		    					{
		    						Sample_dataL=rs.getString("Sample_dataL").trim();
		    					}
		    					
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Sample_ID+"'></td><td class='table-style-td' style='width:50px;'>"+num+"</td><td class='table-style-td'>"
		    					+Sample_ID+"</td><td class='table-style-td'>"
		    					+Sample_Name+"</td><td class='table-style-td'>"
		    					+type+"</td><td class='table-style-td'>"
		    					+Sample_Place+"</td><td class='table-style-td'>"
								+Device_Name+"</td><td class='table-style-td'>"
								+Substation_Name+"</td><td class='table-style-td'>"
								+Device_Addr+"</td><td class='table-style-td'>"
								+Device_IP+"</td><td class='table-style-td'>"
								+Device_Port+"</td><td class='table-style-td'>"
								+Sample_IndexID+"</td><td class='table-style-td'>"
		    					+Sample_AddressH+"</td><td class='table-style-td'>"
		    					+Sample_AddressL+"</td><td class='table-style-td'>"
		    					+Sample_dataL+"</td><td class='table-style-td'>"
		    					+rs.getString("rem")+"</td></tr>");
		    					num++;
		    					type="";
		    					Sample_ID="";
	    						Sample_Name="";
	    						Sample_Place="";
	    						Device_Name="";
	    						Substation_Name="";
	    						Device_Addr="";
	    						Sample_AddressH="";
	    						Sample_AddressL="";
	    						Device_IP="";
	    						Device_Port="";
	    					
	    						Sample_IndexID="";
	    						Sample_dataL="";
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
	
	
    </body>
    <script type="text/javascript">
    	var myAlert = document.getElementById("add"); 
		var reg = document.getElementById("adds"); 
		var mClose = document.getElementById("close");
		var sub=document.getElementById("submitt");
	
		var selectall=document.getElementById("title-checkbox");
		
		var setindex;
		reg.onclick = function() 
		{ 
			var checkb=document.all("beixuan");
			var flag=0;
			var index=-1;
			if(typeof(checkb.length)=="undefined")
			{
				if(document.getElementById("beixuan").checked==true)
				{
					flag++;
					index=0;
				}
			}
			else
			{
				for(var i=0;i<checkb.length;i++)
				{
					//alert(checkb.length);
					if(checkb[i].checked===true)
					{
						flag++;
						index=i;
					}
				}
			}
			if(flag<=0)
			{
				alert("请选则一个图像采样点进行拍摄！");
			}
			else if(flag>1)
			{
				alert("每次只能对一个图像采样点进行远程拍摄！");
			}
			else
			{
				var tb=document.getElementById("listtable");
				index=index+1;
				var Sample_ID=tb.rows[index].cells[2].innerHTML;
				window.open("setPhotoAlarm.jsp?Sample_ID="+Sample_ID,"hhhhhhhhhhhh","resizable=yes,height=500px,width=800px,top=30px,left=30px,scrollbars=yes");
			}
		} ;
		
    </script>
</html>

