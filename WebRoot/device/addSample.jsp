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
        <!-- <script src="../js/add/addSample.js" charset="gbk" type="text/javascript"></script> -->
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
                   	 采样点管理
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">全选</div>
                <div class="checktitle">查询条件</div>
                <div class="select">
                	<div class="selectname">采样点编号：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleId" id="sampleId" ></div>
                	<div class="selectname">采样点名称：</div><div class="selectCon"><input class="selectInput"  type="text" name="sampleName" id="sampleName" ></div>
                	<div class="selectname">类型：</div><div class="selectCon"><select name="seceltType" id="seceltType"><option value="no">---类型---</option><option value="01">温度</option><option value="00">图像</option><option value="02">弧光</option><option value="03">湿度</option></select></div>
                	
                	<div class="selectname">所属设备：</div>
                	<div class="selectCon">
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
                    <button id="adds" class="btn-add" href="#">新增</button>
                    <i class="icon-indent-left"></i>
                    <button id="changes" class="btn-edit" href="#">编辑</button> 
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
		    			String sqls="select * from Sample left join Substation on Substation.Substation_ID=Sample.Substation_ID left join Device on Device.Device_ID=Sample.Device_ID where Sample.Substation_ID='"+sid+"'";
		    			if(request.getParameter("sampleId")!=null&&request.getParameter("sampleId").trim().equals("")==false&&request.getParameter("sampleId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_ID='"+request.getParameter("sampleId")+"'";
		    			}
		    			else if(request.getParameter("sampleName")!=null&&request.getParameter("sampleName").trim().equals("")==false&&request.getParameter("sampleName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("sampleName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Sample.Sample_Name='"+Sname+"'";
		    			}
		    			else if(request.getParameter("seceltType")!=null&&request.getParameter("seceltType").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Sample_Type='"+request.getParameter("seceltType")+"'";
		    			}
		    			else if(request.getParameter("seceltDeviceID")!=null&&request.getParameter("seceltDeviceID").equals("no")==false)
		    			{
		    				sqls=sqls+" and Sample.Device_ID='"+request.getParameter("seceltDeviceID")+"'";
		    			}
						
						//sqls=sqls+" order by Sample.Device_ID";
						sqls=sqls+" order by Sample.Device_ID asc,Sample.Sample_Type";

						
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
		    					//System.out.println(num);
		    					if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("01"))
		    					{
		    						type="温度";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("00"))
		    					{
		    						type="图像";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("02"))
		    					{
		    						type="弧光";
		    					}
		    					else if(rs.getString("Sample_Type")!=null&&rs.getString("Sample_Type").equals("03"))
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
		    			//rs.close();
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add"> 
			<h4><span>添加采样点</span><span id="close">关闭</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>选择变电所：</label></div>
				<div class="addinput">
					<select id="Substation_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
					<%
						sqls="select * from Substation where Substation_ID='"+sid+"'";
		    			rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>编号</td><td>设备名称 </td><td>设备代号</td><td>设备地址</td><td>所属变电所 </td><td>备注</td></tr>");
		    				while(rs.next())
		    				{
		    					out.println("<option value='"+rs.getString("Substation_ID")+"'>"+rs.getString("Substation_Name")+"</option>");
		    				}
		    			}
		    			rs.close();
						ds.close();
					%>
				</select> 
				</div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>选择设备：</label></div>
				<div class="addinput">
					<select id="Device_ID"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
						<option value="first">---请选择设备---</option>
						<%=deviceSelect %>
					</select> 
				</div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>编号：</label></div>
				<div class="addinput"><input disabled id="Sample_ID" type="text" class="myinp"  onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div>
		<form action="#" method="post" id="formsub"> 
			<div class="inputdiv">
				<div class="addname"><label>采样点名称：</label></div>
				<div class="addinput"><input id="Sample_Name" type="text" class="myinp" title="少于25个汉字" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /><font color="red">*</font></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>位置：</label></div>
				<div class="addinput"><input id="Sample_Place" type="text" class="myinp" title="少于50个汉字" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>类型：</label></div>
				<div class="addinput">
					<select id="Sample_Type"  class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">
						<option value="01">温度</option>
						<option value="00">图像</option>
						<option value="02">弧光</option>
						<option value="03">湿度</option>
					</select> 
				</div>
			</div> 

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
    <script>
    	(function()
		{
			setTimeout("init()",300);
		}());
		
		function init()
		{
			//alert("1");
			var myAlert = document.getElementById("add"); 
			var reg = document.getElementById("adds"); 
			var mClose = document.getElementById("close");
			var sub=document.getElementById("submitt");
			var change=document.getElementById("changes");
			var deletes=document.getElementById("dels");
			var subidd=document.getElementById("Substation_ID");
			var devid=document.getElementById("Device_ID");
			var selectall=document.getElementById("title-checkbox");
			reg.onclick = function() 
			{ 
				var myAlert = document.getElementById("add"); 
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
				//获取自动编号
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
					//根据返回的变电所的数，自动编号
					    var result=xmlhttp.responseText;
					    //alert(result);
		
					    document.getElementById("Sample_ID").value=result;
				  }
				};
				xmlhttp.open("GET","../servlet/getNewSampleId?t="+new Date().getTime(),true);
				xmlhttp.send();
			} ;
		
			mClose.onclick = function() 
			{ 
				var myAlert = document.getElementById("add"); 
				myAlert.style.display = "none"; 
				//document.getElementById("mybg").style.display = "none"; 
				document.body.removeChild(document.getElementById("mybg"));
				
				document.body.style.overflow = "auto"; 

				document.getElementById("Sample_ID").value="";
				document.getElementById("Sample_Name").value="";
				//document.getElementById("Substation_ID").value="";
				//document.getElementById("Device_ID").innerHTML="<option value='first'>---请选择设备---</option>";
				document.getElementById("rem").value="";
				document.getElementById("hid").value="insert";
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
			
			
			document.getElementById("selectS").addEventListener("click", selectSamples, false);
			sub.addEventListener("click", sure, false);
			change.addEventListener("click", changeSam, false);
			deletes.addEventListener("click", deleteSam, false);
			subidd.addEventListener("change", subidchange, false);
			document.getElementById("hid").value="insert";
		}
		
		function selectSamples()
		{
			document.getElementById("formsub").action="addSample.jsp?sid="+document.getElementById("hid_sid").value+"&sampleId="+document.getElementById("sampleId").value+"&sampleName="+document.getElementById("sampleName").value+"&seceltType="+document.getElementById("seceltType").value+"&seceltDeviceID="+document.getElementById("seceltDeviceID").value;
			document.getElementById("formsub").submit();
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
				    var selectString="";
				    
					for(var i=0;i<result.length;i++)
					{
						//alert(i);
						var id=result[i].getElementsByTagName("deviceId")[0].childNodes[0].nodeValue;
						var value=result[i].getElementsByTagName("deviceValue")[0].childNodes[0].nodeValue;
						//alert(result[i].childNodes[1].childNodes[0].nodeValue);
						selectString=selectString+"<option value="+id+">"+value+"</option>";
					}
					document.getElementById("Device_ID").innerHTML=selectString;
			  }
			};
			var sid=document.getElementById("Substation_ID").options[document.getElementById("Substation_ID").selectedIndex].value;
			xmlhttp.open("GET","../servlet/getDevice?sid="+sid+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		}
		function sure()
		{
			//alert("2");
			var Sample_ID=document.getElementById("Sample_ID");
			var Sample_Name=document.getElementById("Sample_Name");
			var Device_ID=document.getElementById("Device_ID");
			var Substation_ID=document.getElementById("Substation_ID");
			var Sample_Type=document.getElementById("Sample_Type");
			var Sample_Place=document.getElementById("Sample_Place");
			var rem=document.getElementById("rem");
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
				    	alert("操作成功！");
				    }
				    else
				    {
				    	alert("操作失败，请重新更新或添加！");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload();    
			  }
			};
			var type="insert";
			if(document.getElementById("hid").value=="update")
			{
				type="update";
			}
			
			if(Sample_Name.value.length>=50)
			{
				alert("采样点名称长度不能超过50个字符或25个汉字，请重新输入！");
			}
			else if(Sample_Place.value.length>=100)
			{
				alert("安装地址长度不能超过100个字符或50个汉字，请重新输入！");
			}
			else if(rem.value.length>50)
			{
				alert("备注长度不能超过200个字符或100个汉字，请重新输入！");
			}
			else
			{
				xmlhttp.open("GET","../servlet/addSample?Substation_ID="+Substation_ID.options[Substation_ID.selectedIndex].value+"&Device_ID="+Device_ID.options[Device_ID.selectedIndex].value+"&Sample_Type="+Sample_Type.options[Sample_Type.selectedIndex].value+"&Sample_ID="+Sample_ID.value+"&Sample_Name="+Sample_Name.value+"&Sample_Place="+Sample_Place.value+"&rem="+rem.value+"&type="+type+"&t="+new Date().getTime(),true);
				xmlhttp.send();
			}
			
		}
		function changeSam()
		{
			var checkb=document.all("beixuan");
			var Substation_ID=document.getElementById("Substation_ID");
			var Sample_Type=document.getElementById("Sample_Type");
			//alert(checkb.length);
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
				document.getElementById("hid").value="update";
				var tb=document.getElementById("listtable");
				index=index+1;
				document.getElementById("Sample_ID").value=tb.rows[index].cells[2].innerHTML;
				document.getElementById("Sample_Name").value=tb.rows[index].cells[3].innerHTML;
				document.getElementById("Sample_Place").value=tb.rows[index].cells[5].innerHTML;
				document.getElementById("rem").value=tb.rows[index].cells[8].innerHTML;
				
				var temp = tb.rows[index].cells[4].innerHTML;
				//alert(temp);
				var selectString="";
				var value="01";
				if(temp=="温度"){
					value = "01";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'图像'+"</option>"+"<option value="+'02'+">"+'弧光'+"</option>"+"<option value="+'03'+">"+'湿度'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;	
					}
				else if (temp =="图像"){
					value="00";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'01'+">"+'温度'+"</option>"+"<option value="+'02'+">"+'弧光'+"</option>"+"<option value="+'03'+">"+'湿度'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
				else if (temp =="弧光"){
					value="02";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'图像'+"</option>"+"<option value="+'01'+">"+'温度'+"</option>"+"<option value="+'03'+">"+'湿度'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
				else if (temp =="湿度"){
					value="03";
					selectString=selectString+"<option value="+value+">"+temp+"</option>"+"<option value="+'00'+">"+'图像'+"</option>"+"<option value="+'01'+">"+'温度'+"</option>"+"<option value="+'02'+">"+'弧光'+"</option>";
					document.getElementById("Sample_Type").innerHTML=selectString;
					}
			
				
		
				var myAlert = document.getElementById("add"); 
				myAlert.style.display = "block"; 
				myAlert.style.position = "absolute"; 
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
				mybg.style.position = "absolute"; 
				mybg.style.top = "0"; 
				mybg.style.left = "0"; 
				mybg.style.zIndex = "500"; 
				mybg.style.opacity = "0.3"; 
				mybg.style.filter = "Alpha(opacity=30)"; 
				document.body.appendChild(mybg); 
				document.body.style.overflow = "hidden"; 
			}
		}
		
		function deleteSam()
		{
			var sid=new Array();
			
			
			var checkb=document.all("beixuan");
			//alert(checkb.length);
			var flag=0;
			var index=0;
			if(typeof(checkb.length)=="undefined")
			{
				sid=document.getElementById("beixuan").value;
			}
			else
			{
				for(var i=0;i<checkb.length;i++)
				{
					//alert(checkb.length);
					if(checkb[i].checked===true)
					{
						sid[index]=checkb[i].value;
						index++;
					}
				}
			}
			
			/*将被选中的待删除的Id数组转化为字符转上传服务器处理*/
			var id=sid.toString();
			
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
				//返回成功删除记录数
				    var result=xmlhttp.responseText;
				    alert("成功删除"+result+"条记录");
			    	window.location.href=window.location.href; 
				    //window.location.reload(); 
			  }
			};
			xmlhttp.open("GET","../servlet/deleteSample?sid="+id+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		
		}
    </script>
</html>

