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
        <link  rel="stylesheet" type="text/css" href="../css/add_new.css">   
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
                	<i class="icon-double-angle-right"></i>
                   	 设备管理
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">全选</div>
                <div class="checktitle">设备查询条件：</div>
                <div class="select">
                	<div class="selectname">设备编号：</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceId" id="DeviceId"></div>
                	<div class="selectname">设备名称：</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceName" id="DeviceName"></div>
                	<!--<div class="selectname">特征值：</div><div class="selectCon"><input class="selectInput"  type="text" name="DeviceFea" id="DeviceFea"></div>-->
                </div>
                <div class="caozuo">
                    <button id="selectD"  class="btn-add">查询</button>
                    <i class="icon-plus"></i>
                    <button id="adds" class="btn-add" href="#">新增</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">编辑</button> 
                    <i class="icon-remove-sign"></i>
                    <button id="dels" class="btn-del" href="#">删除</button>
                    <!-- <i class="icon-wrench"></i>
                    	<button id="managed" class="btn-link" href="#">管理采样点</button>
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
                        <th class="table-style-th">设备名称</th>
                        <th class="table-style-th">设备代号</th>
                        <th class="table-style-th">设备地址</th>
						<!--  <th class="table-style-th">设备特征值</th>-->
                        <th class="table-style-th">所属变电所</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String sid=request.getParameter("sid");//变电所编号
		    			dataselect ds=new dataselect();
		    			String sqls="select * from Device left join Substation on Substation.Substation_ID=Device.Substation_ID where Device.Substation_ID='"+sid+"'";
		    			if(request.getParameter("DeviceId")!=null&&request.getParameter("DeviceId").trim().equals("")==false&&request.getParameter("DeviceId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Device.Device_ID='"+request.getParameter("DeviceId")+"'";
		    			}
		    			else if(request.getParameter("DeviceName")!=null&&request.getParameter("DeviceName").trim().equals("")==false&&request.getParameter("DeviceName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("DeviceName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Device.Device_Name='"+Sname+"'";
		    			}
		    			/*else if(request.getParameter("DeviceFea")!=null&&request.getParameter("DeviceFea").trim().equals("")==false&&request.getParameter("DeviceFea").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Device.Device_Feature='"+request.getParameter("DeviceFea")+"'";
		    			}
		    			*/
		    			//System.out.println(sqls);
		    			ResultSet rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>变电所名称 </td><td>变电所所在的位置</td><td>联系电话</td><td>设备数 </td><td>备注</td></tr>");
		    				int num=1;
		    				String Device_ID="";
	    					String Device_Name="";
	    					String Device_Card="";
	    					String Device_Place="";
	    					//String Device_Feature="";
	    					String Substation_Name="";
	    					String rem="";
		    				
		    				while(rs.next())
		    				{
		    					if(rs.getString("Device_ID")!=null&&rs.getString("Device_ID").equals("null")==false)
		    					{
		    						Device_ID=rs.getString("Device_ID").trim();
		    					}
		    					if(rs.getString("Device_Name")!=null&&rs.getString("Device_Name").equals("null")==false)
		    					{
		    						Device_Name=rs.getString("Device_Name").trim();
		    					}
		    					if(rs.getString("Device_Card")!=null&&rs.getString("Device_Card").equals("null")==false)
		    					{
		    						Device_Card=rs.getString("Device_Card").trim();
		    					}
		    					if(rs.getString("Device_Place")!=null&&rs.getString("Device_Place").equals("null")==false)
		    					{
		    						Device_Place=rs.getString("Device_Place").trim();
		    					}
		    					/*if(rs.getString("Device_Feature")!=null&&rs.getString("Device_Feature").equals("null")==false)
		    					{
		    						Device_Feature=rs.getString("Device_Feature").trim();
		    					}*/
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Device_ID+"'></td><td class='table-style-td' style='width:100px;'>"+num+"</td><td class='table-style-td'>"
		    					+Device_ID+"</td><td class='table-style-td'>"
		    					+Device_Name+" </td><td class='table-style-td'>"
		    					+Device_Card+"</td><td class='table-style-td'>"
		    					+Device_Place+"</td><td class='table-style-td'>"
								//+Device_Feature+" </td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					num++;
		    					Device_ID="";
	    						Device_Name="";
	    						Device_Card="";
	    						Device_Place="";
	    						//Device_Feature="";
	    						Substation_Name="";
	    						rem="";
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
    
    <div id="add" > 
		
			<h4><span>添加设备</span><span id="close">关闭</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>选择变电所：</label></div>
				<div class="addinput">
					<select id="Substation_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
					<%
						sqls="select * from Substation where Substation_ID='"+request.getParameter("sid")+"'";
		    			ResultSet rs1=ds.select(sqls);
		    			if(rs1!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>设备名称 </td><td>设备代号</td><td>设备地址</td><td>所属变电所 </td><td>备注</td></tr>");
		    				while(rs1.next())
		    				{
		    					out.println("<option value='"+rs1.getString("Substation_ID")+"'>"+rs1.getString("Substation_Name")+"</option>");
		    				}
		    			}
		    			rs1.close();
						ds.close();
					%>
				</select>
				</div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>编号：</label></div>
				<div class="addinput"><input disabled id="Device_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
		<form action="#" method="post" id="formsub">
			<div class="inputdiv">
				<div class="addname"><label>设备名称：</label></div>
				<div class="addinput"><input id="Device_Name" type="text" title="少于30个汉字" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>设备代号：</label></div>
				<div class="addinput"><input id="Device_Card" type="text" title="少于10个字符" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>设备地址：</label></div>
				<div class="addinput"><input id="Device_Place" type="text" title="少于50个汉字" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<!-- 
			<div class="inputdiv">
				<div class="addname"><label>设备特征值：</label></div>
				<div class="addinput"><input id="Device_Feature" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			  -->
			<div class="inputdiv">
				<div class="addname"><label>备注：</label></div>
				<div class="addinput"><input id="rem" type="text" class="myinp" title="少于200个字符，100个汉字" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="提交" class="sub" />
			<input type="reset" value="重置"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
			<input id="hid_sid" type="hidden" value="<%=sid %>">
		</form>
	</div> 
    
    </body>
</html>

