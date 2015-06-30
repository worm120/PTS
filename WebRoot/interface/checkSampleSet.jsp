<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>
<% 
//该页面用于检查采样点设置中SampleAddress是否存在设备id为空的情况。

%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add_new.css">   
        <!-- <script src="../js/deTemp/sampleInterface.js" charset="gbk" type="text/javascript"></script>  -->
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
                   	 采样点数据接口设置
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">全选</div>
                <div class="checktitle">查询设置</div>
                <div class="select">
                	<div class="selectname">采样点编号：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleId" id="sampleId"></div>
                	<div class="selectname">采样点名称：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleName" id="sampleName"></div>
                	<div class="selectname">类型：</div><div class="selectCon"><select name="seceltType" id="seceltType"><option value="no">---类型---</option><option value="01">温度</option><option value="00">图像</option><option value="02">弧光</option><option value="03">湿度</option></select></div>
                	<div class="selectname">所属设备：</div>
                	<div class="selectCon">
                		<select name="seceltSubstationID" id="seceltSubstationID">
                			<!-- <option value="no">---选择变电所---</option> -->
                			<%
                				String sid="002";//request.getParameter("sid");
                				dataselect ds=new dataselect();
						    	
						    	String getSubstation="select * from Substation where Substation_ID='"+sid+"'";
								ResultSet rs=ds.select(getSubstation);
						    	/*
						    	if(rs!=null)
						    	{
						    		int g=0;
						    		while(rs.next())
						    		{
						    			if(g==0)
						    			{
						    				//sid_f=rs.getString("Substation_ID");
						    			}
						    			out.print("<option value='"+rs.getString("Substation_ID")+"'>"+rs.getString("Substation_Name")+"</option>");
						    		}
						    	}
						    	*/
						     %>
                		</select>
                	</div>
                	<div class="selectCon">
                		<select name="seceltDeviceID" id="seceltDeviceID">
                			<option value="no">---选择设备---</option>
                			<%
						    	
						    	//String sid=request.getParameter("sid");//变电所编号
						    	String getdevice="select * from Device where Substation_ID='"+sid+"'";
						    	rs=ds.select(getdevice);
						    	if(rs!=null)
						    	{
						    		while(rs.next())
						    		{
						    			out.print("<option value='"+rs.getString("Device_ID")+"'>"+rs.getString("Device_Name")+"</option>");
						    		}
						    	}
						     %>
                		</select>
                	</div>
                </div>
                <div class="caozuo">
                	<button id="selectS"  class="btn-add">查询</button>
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
                        <th class="table-style-th">摄像头ID||位序</th>
                        <th class="table-style-th">数据起始地址H</th>
                        <th class="table-style-th">数据起始地址L</th>
                        <th class="table-style-th">数据长度</th>
                        <th class="table-style-th">备注</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			//dataselect ds=new dataselect();
		    			String sqls="select  * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID left join DeviceSet on DeviceSet.Device_ID=Sample.Device_ID left join SampleAddress on SampleAddress.Sample_ID=Sample.Sample_ID  where '1'='1'  ";
		    			
		    			if(request.getParameter("sampleId")!=null&&request.getParameter("sampleId").trim().equals("")==false&&request.getParameter("sampleId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_ID='"+request.getParameter("sampleId")+"'";
		    			}
		    			if(request.getParameter("sampleName")!=null&&request.getParameter("sampleName").trim().equals("")==false&&request.getParameter("sampleName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("sampleName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Sample.Sample_Name='"+Sname+"'";
		    			}
		    			if(request.getParameter("seceltType")!=null&&request.getParameter("seceltType").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_Type='"+request.getParameter("seceltType")+"'";
		    			}
		    			if(request.getParameter("seceltDeviceID")!=null&&request.getParameter("seceltDeviceID").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Device_ID='"+request.getParameter("seceltDeviceID")+"'";
		    			}
		    			
		    			
		    			if(request.getParameter("seceltSubstationID")!=null&&request.getParameter("seceltSubstationID").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Substation_ID='"+request.getParameter("seceltSubstationID")+"'";
		    			}
		    			else if(sid.equals("")==false)
		    			{
		    				sqls=sqls+" and Sample.Substation_ID='"+sid+"' ";
		    			}
		    			sqls=sqls+"  order by Sample.Substation_ID,Sample.Device_ID";
		    			//ResultSet rs=ds.select(sqls);
		    			//System.out.println(sqls);
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
	    					String Device_Addr="";
	    					String Sample_AddressH="";
	    					String Sample_AddressL="";
	    					
	    					String Sample_IndexID="";
	    					String Sample_dataL="";
	    					
	    					
	    					String rem="";
		    				while(rs.next())
		    				{
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
		    					/*
		    					if(rs.getString("Device_Addr")!=null&&rs.getString("Device_Addr").equals("null")==false)
		    					{
		    						Device_Addr=rs.getString("Device_Addr").trim();
		    					}
		    					*/
		    					if(rs.getString("Device_Address")!=null&&rs.getString("Device_Address").equals("null")==false)
		    					{
		    						Device_Addr=rs.getString("Device_Address").trim();
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
								+Sample_IndexID+"</td><td class='table-style-td'>"
		    					+Sample_AddressH+"</td><td class='table-style-td'>"
		    					+Sample_AddressL+"</td><td class='table-style-td'>"
		    					+Sample_dataL+"</td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
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
	    						Sample_IndexID="";
	    						Sample_dataL="";
	    						rem="";
		    				}
		    				//out.print("</table>");
		    				num=0;
		    			}
		    			rs.close();
		    			ds.close();
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add" > 
		
			<h4><span>设置采样点数据接口信息</span><span id="close">关闭</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>编号：</label></div>
				<div class="addinput"><input disabled id="Sample_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>设备id：</label></div>
				<div class="addinput"><input id="Device_Address" type="text" class="myinp" title="以十六进制方式输入！" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
		<form action="#" method="post" id="formsub" onSubmit="return false">
			<div class="inputdiv">
				<div class="addname"><label>摄像头id||位序：</label></div>
				<div class="addinput"><input id="Sample_IndexID" type="text" class="myinp" title="以摄像头Id十六进制方式输入,位序按十进制输入！" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>起始地址高位：</label></div>
				<div class="addinput"><input id="Sample_AddressH" type="text" class="myinp" title="以十六进制方式输入！" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>起始地址低位：</label></div>
				<div class="addinput"><input id="Sample_AddressL" type="text" title="以十六进制方式输入！" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>数据长度：</label></div>
				<div class="addinput"><input id="Sample_dataL" type="text" class="myinp" title="以十六进制方式输入！" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div>
		
			<p class="inputdiv">
			<input id="submitt" type="submit" value="提交" class="sub" />
			<input type="reset" value="重置"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
		</form>
	</div> 
   
    </body>
    <script>
    	(function()
		{
			setTimeout("init()",100);
		}());
		
		function init()
		{	
			var myAlert = document.getElementById("add"); 
			var reg = document.getElementById("adds"); 
			var mClose = document.getElementById("close");
			var sub=document.getElementById("submitt");
		
			var selectall=document.getElementById("title-checkbox");
			
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
					alert("请选则一条记录进行修改！");
				}
				else if(flag>1)
				{
					alert("每次只能对一条记录进行修改！");
				}
				else
				{
					//alert("sss");
					//document.getElementById("hid").value="update";
					var tb=document.getElementById("listtable");
					index=index+1;
					
					//Substation_ID.value=tb.rows[index].cells[6].innerHTML;
					document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
					document.getElementById("Device_Address").value=tb.rows[index].cells[8].innerHTML;
					document.getElementById("Sample_IndexID").value=tb.rows[index].cells[9].innerHTML;
					document.getElementById("Sample_AddressH").value=tb.rows[index].cells[10].innerHTML;
					document.getElementById("Sample_AddressL").value=tb.rows[index].cells[11].innerHTML;
					document.getElementById("Sample_dataL").value=tb.rows[index].cells[12].innerHTML;
					
					if(  index>1
					     &&tb.rows[index].cells[9].innerHTML==""
					     &&tb.rows[index].cells[10].innerHTML==""
					     &&tb.rows[index].cells[11].innerHTML==""
					     &&tb.rows[index].cells[12].innerHTML=="" )
					{
						index--;
						document.getElementById("Sample_IndexID").value=tb.rows[index].cells[9].innerHTML;
						document.getElementById("Sample_AddressH").value=tb.rows[index].cells[10].innerHTML;
						document.getElementById("Sample_AddressL").value=tb.rows[index].cells[11].innerHTML;
						document.getElementById("Sample_dataL").value=tb.rows[index].cells[12].innerHTML;
					}
					//alert(tb.rows[index+1].cells[1].innerHTML);
					myAlert = document.getElementById("add"); 
					myAlert.style.display = "block"; 
					myAlert.style.position = "fixed"; 
					myAlert.style.top = "50%"; 
					myAlert.style.left = "50%"; 
					myAlert.style.marginTop = "-150px"; 
					myAlert.style.marginLeft = "-200px"; 
					myAlert.style.zIndex = "501"; 
					
					mybg = document.createElement("div"); 
					mybg.setAttribute("id","mybg"); 
					mybg.style.background = "#000"; 
					mybg.style.width = "100%"; 
					mybg.style.height = "100%"; 
					mybg.style.position = "fixed"; 
					mybg.style.top = "0"; 
					mybg.style.left = "0"; 
					mybg.style.zIndex = "500"; 
					mybg.style.opacity = "0.3"; 
					mybg.style.filter = "Alpha(opacity=30)"; 
					document.body.appendChild(mybg); 
					document.body.style.overflow = "hidden"; 
				}
			} ;
			//alert(mClose);
			mClose.onclick = function() 
			{ 
				myAlert.style.display = "none"; 
				//mybg.style.display = "none"; 
				document.body.removeChild(document.getElementById("mybg"));
				document.body.style.overflow = "auto"; 
				document.getElementById("Sample_ID").value="";
				document.getElementById("Device_Address").value="";
				document.getElementById("Sample_AddressH").value="";
				document.getElementById("Sample_AddressL").value="";
				document.getElementById("Sample_IndexID").value="";
				document.getElementById("Sample_dataL").value="";
			} ;
			
			selectall.onchange=function()
			{
				var checkb=document.all("beixuan");
				var flag=0;
				if(typeof(checkb.length)=="undefined")
				{
					if(document.getElementById("beixuan").checked===true)
					{
						document.getElementById("beixuan").checked=false;
					}
					else
					{
						document.getElementById("beixuan").checked=true;
					}
				}
				else
				{
					for(var i=0;i<checkb.length;i++)
					{
						if(checkb[i].checked===false)
						{
							flag=1;
						}
					}
					
					if(flag==1)
					{
						for(var i=0;i<checkb.length;i++)
						{
							checkb[i].checked=true;
						}
					}
					else
					{
						for(var i=0;i<checkb.length;i++)
						{
							checkb[i].checked=false;
						}
					}
				}
			};
			
			sub.addEventListener("click", sure, false);
			document.getElementById("seceltSubstationID").addEventListener("change", subidchange, false);
			document.getElementById("selectS").addEventListener("click", selectSamples, false);
			//change.addEventListener("click", changeDev, false);
			//deletes.addEventListener("click", deleteDev, false);
			//document.getElementById("hid").value="insert";
		}
		function selectSamples()
		{
			document.getElementById("formsub").action="linkSample.jsp?sid="+document.getElementById("seceltSubstationID").value+"&sampleId="+document.getElementById("sampleId").value+"&sampleName="+document.getElementById("sampleName").value+"&seceltType="+document.getElementById("seceltType").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
			document.getElementById("formsub").submit();
		}
		function sure()
		{
			//alert("dd");
			var Sample_ID=document.getElementById("Sample_ID");
			var Device_Address=document.getElementById("Device_Address");
			var Sample_AddressH=document.getElementById("Sample_AddressH");
			var Sample_AddressL=document.getElementById("Sample_AddressL");
			var Sample_IndexID=document.getElementById("Sample_IndexID");
			var Sample_dataL=document.getElementById("Sample_dataL");
		
			var xmlhttp;
			if (window.XMLHttpRequest)
			{
			  xmlhttp=new XMLHttpRequest();
			}
			else
			{
			  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			  {
				//根据返回的设备借点信息关联接线图上的节点
				    var result=xmlhttp.responseText;
				    if(result.indexOf("success")>=0)
				    {
				    	alert("设置成功！");
				    }
				    else
				    {
				    	alert("操作失败，请重新设置！");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload;    
			  }
			};
			xmlhttp.open("GET","../servlet/setSample?Sample_ID="+Sample_ID.value+"&Device_Address="+Device_Address.value+"&Sample_AddressH="+Sample_AddressH.value+"&Sample_AddressL="+Sample_AddressL.value+"&Sample_dataL="+Sample_dataL.value+"&Sample_IndexID="+Sample_IndexID.value+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		}
		function subidchange()
		{
			//alert("ff");
			var xmlhttp;
			if (window.XMLHttpRequest)
			{
			  xmlhttp=new XMLHttpRequest();
			}
			else
			{
			  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			  {
				//返回对应变电所的设备
				    var result=xmlhttp.responseXML.getElementsByTagName("device");
				    alert(result);
				    var selectString="";
				    
					for(var i=0;i<result.length;i++)
					{
						//alert(i);
						var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
						var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
						selectString=selectString+"<option value="+id+">"+value+"</option>";
					}
					alert(selectString);
					document.getElementById("seceltDeviceID").innerHTML=selectString;
			  }
			};
			var sid=document.getElementById("seceltSubstationID").options[document.getElementById("seceltSubstationID").selectedIndex].value;
			//alert(sid);
			xmlhttp.open("GET","../servlet/getSubDevice?sid="+sid+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		}
    </script>
</html>

