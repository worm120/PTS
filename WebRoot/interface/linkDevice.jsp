<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>���DSEP-2000����ͼ����������ʪ�Ȱ�ȫ���ϵͳ</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add_new.css">   
        <!-- <script src="../js/deTemp/deviceInterface.js" charset="gbk" type="text/javascript"></script> -->
    </head>
    <body>
    <!--content start-->
    <div id="content">
        <div id="content-header">
            <div id="content-header-leader">
                <a class="tip-button">
                    <i class="icon icon-home"></i>
                   	 ��ҳ
                </a>
                <a class="current" href="#">
                   	 �豸���ݽӿ�����
                </a>
            </div>
        </div>
        <div id="content-field">
            <div class="box-title">
                <div class="checkall"><input name="title-checkbox" id="title-checkbox" type="checkbox"></div>
                <div class="quanxuan">ȫѡ</div>
                <div class="checktitle">�豸����</div>
                <div class="select">
                	<div class="selectname">�豸��ţ�</div><div class="selectCon"><input class="selectInput" type="text" name="SDeviceId" id="SDeviceId"></div>
                	<div class="selectname">�豸���ƣ�</div><div class="selectCon"><input class="selectInput"  type="text" name="SDeviceName" id="SDeviceName"></div>
<!--                 	<div class="selectname">�豸id��</div><div class="selectCon"><input class="selectInput"  type="text" name="SDevice_Addr" id="SDevice_Addr"></div> -->
<!--                 	<div class="selectname">IP��</div><div class="selectCon"><input class="selectInput"  type="text" name="SDevice_IP" id="SDevice_IP"></div> -->
                	<div class="selectname">�������</div>
                	<div class="selectCon">
                		<select name="seceltSubstationID" id="seceltSubstationID">
                			<!-- <option value="no">---ѡ������---</option> -->
                			<%
                				String sid=request.getParameter("sid");
						    	dataselect ds=new dataselect();
						    	String getSubstation="select * from Substation where Substation_ID='"+sid+"'";
						    	ResultSet rs=ds.select(getSubstation);
						    	if(rs!=null)
						    	{
						    		while(rs.next())
						    		{
						    			out.print("<option value='"+rs.getString("Substation_ID")+"'>"+rs.getString("Substation_Name")+"</option>");
						    		}
						    	}
						     %>
                		</select>
                	</div>
                </div>
                <div class="caozuo">
                	<button id="selectD"  class="btn-add">��ѯ</button>
                    <i class="icon-wrench"></i>
                    <button id="adds" class="btn-add" href="#">����</button>
                </div>
            </div>
            <div class="box-content">
                <table class="table-style" id="listtable">
                  <thead>
                    <tr>
                        <th class="table-style-th" style="width:10px;text-align:center;"><i class="icon-resize-vertical"></i></th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">���</th>
                        <th class="table-style-th">�豸����</th>          
                        <th class="table-style-th">�豸��װ��ַ</th>
						<!-- <th class="table-style-th">�豸����ֵ</th> -->
                        <th class="table-style-th">���������</th>
                        <th class="table-style-th">�豸id</th>
                        <th class="table-style-th">�豸����ֵ</th>
                        <th class="table-style-th">������ʼ��ַH</th>
                        <th class="table-style-th">������ʼ��ַL</th>
                        <th class="table-style-th">������ݳ���</th>
                        <th class="table-style-th">�ӿ�IP</th>
                        <th class="table-style-th">�ӿڶ˿�</th>
                        <th class="table-style-th">��ע</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<%
		    			//dataselect ds=new dataselect();
		    			String sqls="select Device.Device_ID,Device.Device_Name,Device_Place,Substation_Name,Device_Addr,Device_StartH,Device_StartL,Device_dataL,Device.rem,Device_IP,Device_Port,Device_Feature from Device left join DeviceSet on DeviceSet.Device_ID=Device.Device_ID left join Substation on Substation.Substation_ID=Device.Substation_ID where '1'='1' ";
		    			
		    			if(request.getParameter("SDeviceId")!=null&&request.getParameter("SDeviceId").trim().equals("")==false&&request.getParameter("SDeviceId").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and Device.Device_ID='"+request.getParameter("SDeviceId")+"'";
		    			}
		    			if(request.getParameter("SDeviceName")!=null&&request.getParameter("SDeviceName").trim().equals("")==false&&request.getParameter("SDeviceName").trim().equals("undefined")==false)
		    			{
		    				String Sname=new String(request.getParameter("SDeviceName").getBytes("ISO-8859-1"),"GB2312");
		    				sqls=sqls+" and Device.Device_Name='"+Sname+"'";
		    			}
		    			if(request.getParameter("SDevice_Addr")!=null&&request.getParameter("SDevice_Addr").trim().equals("")==false&&request.getParameter("SDevice_Addr").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and DeviceSet.Device_Addr='"+request.getParameter("SDevice_Addr")+"'";
		    			}
		    			if(request.getParameter("SDevice_IP")!=null&&request.getParameter("SDevice_IP").trim().equals("")==false&&request.getParameter("SDevice_IP").trim().equals("undefined")==false)
		    			{
		    				sqls=sqls+" and DeviceSet.Device_IP='"+request.getParameter("SDevice_IP")+"'";
		    			}
		    			
		    			if(request.getParameter("seceltSubstationID")!=null&&request.getParameter("seceltSubstationID").trim().equals("no")==false)
		    			{
		    				sqls=sqls+" and Device.Substation_ID='"+request.getParameter("seceltSubstationID")+"'";
		    			}
		    			else
		    			{
		    				sqls=sqls+" and Device.Substation_ID='"+request.getParameter("sid")+"'";
		    			}
		    			
		    			sqls=sqls+"  order by Substation_Name";
		    			
		    			
		    			//System.out.println(sqls+"<>"+request.getParameter("seceltSubstationID"));
		    			//ResultSet rs=ds.select(sqls);
		    			rs=ds.select(sqls);
		    			if(rs!=null)
		    			{	
		    				//out.print("<table id='listtable' class='listtable'><tr><td></td><td>���</td><td>��������� </td><td>��������ڵ�λ��</td><td>��ϵ�绰</td><td>�豸�� </td><td>��ע</td></tr>");
		    				int num=1;
		    				String Device_ID="";
	    					String Device_Name="";
	    					String Device_Place="";
	    					String Device_Feature="";
	    					String Substation_Name="";
	    					String Device_Addr="";
	    					String Device_StartH="";
	    					String Device_StartL="";
	    					String Device_dataL="";
	    					String Device_IP="";
	    					String Device_Port="";
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
		    					if(rs.getString("Device_Place")!=null&&rs.getString("Device_Place").equals("null")==false)
		    					{
		    						Device_Place=rs.getString("Device_Place").trim();
		    					}
		    					if(rs.getString("Device_Feature")!=null&&rs.getString("Device_Feature").equals("null")==false)
		    					{
		    						Device_Feature=rs.getString("Device_Feature").trim();
		    					}
		    					if(rs.getString("Substation_Name")!=null&&rs.getString("Substation_Name").equals("null")==false)
		    					{
		    						Substation_Name=rs.getString("Substation_Name").trim();
		    					}
		    					if(rs.getString("Device_Addr")!=null&&rs.getString("Device_Addr").equals("null")==false)
		    					{
		    						Device_Addr=rs.getString("Device_Addr").trim();
		    					}
		    					if(rs.getString("Device_StartH")!=null&&rs.getString("Device_StartH").equals("null")==false)
		    					{
		    						Device_StartH=rs.getString("Device_StartH").trim();
		    					}
		    					if(rs.getString("Device_StartL")!=null&&rs.getString("Device_StartL").equals("null")==false)
		    					{
		    						Device_StartL=rs.getString("Device_StartL").trim();
		    					}
		    					
		    					if(rs.getString("Device_dataL")!=null&&rs.getString("Device_dataL").equals("null")==false)
		    					{
		    						Device_dataL=rs.getString("Device_dataL").trim();
		    					}
		    					if(rs.getString("Device_IP")!=null&&rs.getString("Device_IP").equals("null")==false)
		    					{
		    						Device_IP=rs.getString("Device_IP").trim();
		    					}
		    					if(rs.getString("Device_Port")!=null&&rs.getString("Device_Port").equals("null")==false)
		    					{
		    						Device_Port=rs.getString("Device_Port").trim();
		    					}
		    					if(rs.getString("rem")!=null&&rs.getString("rem").equals("null")==false)
		    					{
		    						rem=rs.getString("rem").trim();
		    					}
		    					out.print("<tr><td class='table-style-td' style='width:10px;'><input type='checkbox' name='beixuan' id='beixuan' value='"+Device_ID+"'></td><td class='table-style-td' style='width:50px;'>"+num+"</td><td class='table-style-td'>"
		    					+Device_ID+"</td><td class='table-style-td'>"
		    					+Device_Name+" </td><td class='table-style-td'>"
		    					+Device_Place+"</td><td class='table-style-td'>"
		    					+Substation_Name+" </td><td class='table-style-td'>"
		    					+Device_Addr+"</td><td class='table-style-td'>"
		    					+Device_Feature+"</td><td class='table-style-td'>"
		    					+Device_StartH+"</td><td class='table-style-td'>"
		    					+Device_StartL+"</td><td class='table-style-td'>"
		    					+Device_dataL+"</td><td class='table-style-td'>"
		    					+Device_IP+"</td><td class='table-style-td'>"
		    					+Device_Port+"</td><td class='table-style-td'>"
		    					+rem+"</td></tr>");
		    					num++;
		    					Device_ID="";
		    					Device_Name="";
		    					Device_Place="";
		    					Device_Feature="";
		    					Substation_Name="";
		    					Device_Addr="";
		    					Device_StartH="";
		    					Device_StartL="";
		    					Device_dataL="";
		    					Device_IP="";
		    					Device_Port="";
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
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <div id="add" > 
		
			<h4><span>�����豸���ݽӿ���Ϣ</span><span id="close">�ر�</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>��ţ�</label></div>
				<div class="addinput"><input disabled id="Device_ID" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div>
		<form action="#" method="post" name="formsub" id="formsub" onSubmit="return false">
			<div class="inputdiv">
				<div class="addname"><label>�豸id��</label></div>
				<div class="addinput"><input id="Device_Addr" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>�豸����ֵ��</label></div>
				<div class="addinput"><input id="Device_Feature" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>��ʼ��ַ��λ��</label></div>
				<div class="addinput"><input id="Device_StartH" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>��ʼ��ַ��λ��</label></div>
				<div class="addinput"><input id="Device_StartL" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>���ݳ��ȣ�</label></div>
				<div class="addinput"><input id="Device_dataL" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>�ӿ�IP��</label></div>
				<div class="addinput"><input id="Device_IP" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			
			<div class="inputdiv">
				<div class="addname"><label>�ӿڶ˿ڣ�</label></div>
				<div class="addinput"><input id="Device_Port" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /></div>
			</div> 
			
			<p class="inputdiv">
			<input id="submitt" name="submitt" type="button" value="�ύ" class="sub" />
			<input type="reset" value="����"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
		</form>
	</div> 
    <script type="text/javascript">
    	(function()
		{
			setTimeout("init()",100);
		}());
		
		function init()
		{	var mybg=null;
			var myAlert = document.getElementById("add"); 
			var reg = document.getElementById("adds"); 
			var mClose = document.getElementById("close");
			var sub=document.getElementById("submitt");
			var selectall=document.getElementById("title-checkbox");
		
			
			reg.onclick = function() 
			{ 
				//var Substation_ID=document.getElementById("Substation_ID");
				var checkb=document.all("beixuan");
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
					alert("��ѡ��һ����¼�����޸ģ�");
				}
				else if(flag>1)
				{
					alert("ÿ��ֻ�ܶ�һ����¼�����޸ģ�");
				}
				else
				{
					//alert("sss");
					var tb=document.getElementById("listtable");
					index=index+1;
					
					//Substation_ID.value=tb.rows[index].cells[6].innerHTML;
					//alert(tb.rows[index].cells[6].innerHTML);
					
					document.getElementById("Device_ID").value=tb.rows[index].cells[2].innerHTML;
					document.getElementById("Device_Addr").value=tb.rows[index].cells[6].innerHTML;
					document.getElementById("Device_Feature").value=tb.rows[index].cells[7].innerHTML;
					document.getElementById("Device_StartH").value=tb.rows[index].cells[8].innerHTML;
					document.getElementById("Device_StartL").value=tb.rows[index].cells[9].innerHTML;
					document.getElementById("Device_dataL").value=tb.rows[index].cells[10].innerHTML;
					
					document.getElementById("Device_IP").value=tb.rows[index].cells[11].innerHTML;
					document.getElementById("Device_Port").value=tb.rows[index].cells[12].innerHTML;

					if(  index>1
						 &&tb.rows[index].cells[6].innerHTML==""
					     &&tb.rows[index].cells[7].innerHTML==""
					     &&tb.rows[index].cells[8].innerHTML==""
					     &&tb.rows[index].cells[9].innerHTML==""
					     &&tb.rows[index].cells[10].innerHTML==""
					     &&tb.rows[index].cells[11].innerHTML==""
					     &&tb.rows[index].cells[12].innerHTML=="" )
					{
						index--;
						//alert(tb.rows[index].cells[6].innerHTML);
						document.getElementById("Device_Addr").value=tb.rows[index].cells[6].innerHTML;
						document.getElementById("Device_Feature").value=tb.rows[index].cells[7].innerHTML;
						document.getElementById("Device_StartH").value=tb.rows[index].cells[8].innerHTML;
						document.getElementById("Device_StartL").value=tb.rows[index].cells[9].innerHTML;
						document.getElementById("Device_dataL").value=tb.rows[index].cells[10].innerHTML;
						document.getElementById("Device_IP").value=tb.rows[index].cells[11].innerHTML;
						document.getElementById("Device_Port").value=tb.rows[index].cells[12].innerHTML;
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
		
			mClose.onclick = function() 
			{ 
				myAlert.style.display = "none"; 
				//mybg.style.display = "none"; 
				document.body.removeChild(document.getElementById("mybg"));
				document.body.style.overflow = "auto"; 

				document.getElementById("Device_ID").value="";
				document.getElementById("Device_Addr").value="";
				document.getElementById("Device_StartH").value="";
				document.getElementById("Device_StartL").value="";
				document.getElementById("Device_dataL").value="";
				document.getElementById("Device_IP").value="";
				document.getElementById("Device_Port").value="";
				document.getElementById("Device_Feature").value="";
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
			
			document.getElementById("selectD").addEventListener("click", selectDevicesSet, false);
			document.getElementById("submitt").addEventListener("click", suret, false);
		}
		
		function selectDevicesSet()
		{
			//alert("gg");
			document.getElementById("formsub").action="linkDevice.jsp?SDeviceId="+document.getElementById("SDeviceId").value+"&SDeviceName="+document.getElementById("SDeviceName").value+"&SDevice_Addr="+document.getElementById("SDevice_Addr").value+"&SDevice_IP="+document.getElementById("SDevice_IP").value+"&sid="+document.getElementById("seceltSubstationID").value;
			document.getElementById("formsub").submit();
		}
		
		function suret()
		{
		
			var Device_ID=document.getElementById("Device_ID");
			var Device_Addr=document.getElementById("Device_Addr");
			var Device_StartH=document.getElementById("Device_StartH");
			var Device_StartL=document.getElementById("Device_StartL");
			var Device_dataL=document.getElementById("Device_dataL");
			var Device_IP=document.getElementById("Device_IP");
			var Device_Port=document.getElementById("Device_Port");
			var Device_Feature=document.getElementById("Device_Feature");
		
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
				//���ݷ��ص��豸�����Ϣ��������ͼ�ϵĽڵ�
				    var result=xmlhttp.responseText;
				    if(result=="success")
				    {
				    	alert("���óɹ���");
				    }
				    else
				    {
				    	alert("����ʧ�ܣ����������ã�");
				    }
				    window.location.href=window.location.href; 
				    window.location.reload;    
			  }
			};
			var type="insert";
			//if(document.getElementById("hid").value=="update")
			//{
				//type="update";
			//}
			//alert("f");
			xmlhttp.open("GET","../servlet/setDevice?Device_ID="+Device_ID.value+"&Device_Addr="+Device_Addr.value+"&Device_StartH="+Device_StartH.value+"&Device_StartL="+Device_StartL.value+"&Device_dataL="+Device_dataL.value+"&Device_IP="+Device_IP.value+"&Device_Port="+Device_Port.value+"&Device_Feature="+Device_Feature.value+"&t="+new Date().getTime(),true);
			xmlhttp.send();
		}

    </script>
    </body>
</html>

