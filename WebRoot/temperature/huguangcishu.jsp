<%@page import="java.sql.ResultSet"%>
<%@page import="javax.naming.spi.DirStateFactory.Result"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=gbk" language="java" import="java.util.*" import="com.action.dataselect"  pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
        <meta http-equiv="pragma" content="no-cache">
        <link href="../css/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css">  
        <link  rel="stylesheet" type="text/css" href="../css/add.css">  
        <link rel="stylesheet" href="../../SPC/css/datepicker.css" />
		<link rel="stylesheet" href="../../SPC/css/bootstrap.min.css" />
<!-- 		<link rel="stylesheet" href="../../SPC/css/matrix-style.css" /> -->
		<script src="../../SPC/js/jquery.min.js"></script> 
        <script src="../../SPC/js/bootstrap-datepicker.js"></script>  
       

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
                   	 弧光次数记录
                </a>
            </div>
        </div>
        <div align="center" style="height:30px;">
        	<form  action="alarmlog.jsp?sid=1" method="post">
	        	起始日期：<input id="sdate" name="sdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="height:25px;width: 213px; "/>
				&nbsp&nbsp&nbsp
				结束日期：<input id="fdate" name="fdate" type="text"  data-date-format="yyyy-mm-dd"  class="datepicker span11" style="height:25px;width: 213px; "/>
				&nbsp&nbsp&nbsp
				<button  class="btn-add" type="submit" style="height:25px;width:40px;">查 询</button>
			</form>
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
                        <th class="table-style-th">采样点名称</th>
                        <th class="table-style-th">弧光总次数</th>
                        <th class="table-style-th">强弧次数</th>
                        <th class="table-style-th">弱弧次数</th>
                        <!-- <th class="table-style-th">发生时间</th> -->
                        <th class="table-style-th">开关柜</th>
                        <th class="table-style-th">所属变电所</th>
                       <!--  <th class="table-style-th">备注</th> -->
                    </tr>
                  </thead>
                  <tbody>
                  	<%
                  		String pid=request.getParameter("pid");//变电所编号
		    			dataselect ds=new dataselect();
		    				    			
		    			
		    			
		    			//String gethu="select Hgcishu.Id,Hgcishu.Sample_ID,Sample_Name,Total,Qianghu,Ruohu,Datetime,Device_Name,Substation_Name from Hgcishu left join SampleDetail on SampleDetail.Sample_ID=Hgcishu.Sample_ID where Hgcishu.Sample_ID in(select Sample.Sample_ID from Sample where Sample.Device_ID in(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			String getid="select distinct Hgcishu.Sample_ID from Hgcishu "+
		    						"left join SampleDetail on SampleDetail.Sample_ID=Hgcishu.Sample_ID "
		    						+"where Hgcishu.Sample_ID in "
		    						+"(select Sample.Sample_ID from Sample where Sample.Device_ID in "
		    						+"(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			
		    			ResultSet rs=ds.select(getid);
		    			
		    			int length=0;
		    			String[] sample = null;//new String [length];
		    			if(rs!=null)
		    			{	
		    				rs.last();
 							length = rs.getRow();
 							sample=new String[length];
							rs.beforeFirst();//返回到开始
							int count=0;
							while(rs.next())
							{
  								sample[count]=rs.getString(1);
  								count++;
							}
						}
						
						String gethu="select Hgcishu.Sample_ID,Sample_Name,Total,Qianghu,"
										+"Ruohu,Datetime,Device_Name,Substation_Name "
										+"from Hgcishu left join SampleDetail "
										+"on SampleDetail.Sample_ID=Hgcishu.Sample_ID "
										+"where Hgcishu.Sample_ID in "
										+"(select Sample.Sample_ID from Sample "
										+"where Sample.Device_ID in "
										+"(select Devpoint.Device_ID from Devpoint where Devpoint.Pid='"+pid+"'))";
		    			rs=ds.select(gethu);
		    			
		    			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    			String date = df.format(new Date());
		    			String date1 = date.split(" ")[0];
		    			String month=date1.split("-")[1];//获取当前月份
		    			int month1 = Integer.parseInt(month);
		    			if (month1 == 1)
		    			{
		    				month1=13;
		    			}
		    			String day=date1.split("-")[2];//获取当前日期
		    			int day1 = Integer.parseInt(day);
		    			
		    			int [] total = new int[length];
		    			for (int j = 0;j<length;j++)
		    			{
		    				total[j]=0;
		    			}
		    			int [] qiang = new int[length];
		    			for (int j = 0;j<length;j++)
		    			{
		    				qiang[j]=0;
		    			}
		    			int [] ruo = new int[length];
		    			for (int j = 0;j<length;j++)
		    			{
		    				ruo[j]=0;
		    			}
		    			String [] nameSam = new String[length];
		    			String [] nameDev = new String[length];
		    			String [] nameSub = new String[length];
		    			int n1 = 0;
		    			int n2 = 0;
		    			int n3 = 0;
		    			if(rs!=null)
		    			{
		    				while(rs.next())
		    				{
		    					for(int i = 0; i < length;i++){
		    						if(rs.getString(1).equals(sample[i])&& ((( (Integer.parseInt((rs.getString(6).toString().split(" ")[0]).split("-")[1]))==month1) &&( (Integer.parseInt((rs.getString(6).toString().split(" ")[0]).split("-")[2])) <= day1))|| (  (Integer.parseInt((rs.getString(6).toString().split(" ")[0]).split("-")[1])) ==(month1-1) ) && ( (Integer.parseInt((rs.getString(6).toString().split(" ")[0]).split("-")[2])) >=day1)   )         )
		    						{
		    							n1=rs.getInt(3);//总的弧光次数
		    							n2=rs.getInt(4);//强弧弧光次数
		    							n3=rs.getInt(5);//弱弧弧光次数
		    							total[i]=total[i]+n1;
		    							qiang[i]=qiang[i]+n2;
		    							ruo[i]=ruo[i]+n3;
		    							nameSam[i]=rs.getString(2);
		    							nameDev[i]=rs.getString(7);
		    							nameSub[i]=rs.getString(8);
		    						}
		    					}
		    					
		    				}
		    			}
		    			
		    			int num=1;
		    			for(int m=0;m<length;m++)
		    			{
		    			out.print("<tr><td class='table-style-td' style='width:100px;'>"
		    					+num+"</td><td class='table-style-td'>"
		    					+sample[m]+"</td><td class='table-style-td'>"
		    					+nameSam[m]+"</td><td class='table-style-td'>"
		    					+total[m]+"</td><td class='table-style-td'>"
		    					+qiang[m]+"</td><td class='table-style-td'>"
								//+Odate+" </td><td class='table-style-td'>"
								+ruo[m]+" </td><td class='table-style-td'>"
		    					+nameDev[m]+"</td><td class='table-style-td'>"
		    					+nameSub[m]+" </td></tr>");
		    					num++;
		    					
		    			}		
    				%>
                  </tbody>
                </table>
            </div>
        </div>
       <!--  <div id="content-foot"></div> -->
        
    </div>
    <!--content end-->
    
    <!--  
    <div id="add" > 
		<form action="#" method="post" id="formsub">
			<h4><span>添加设备</span><span id="close">关闭</span></h4>
			<div style="margin:15px;"></div>
			<div class="inputdiv">
				<div class="addname"><label>记录编号：</label></div>
				<div class="addinput"><input disabled id="Id" type="text" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'" /> </div>
			</div> 
			<div class="inputdiv">
				<div class="addname"><label>输入处理日志：</label></div>
				<div class="addinput"><textarea id="Cresult" type="text" title="少于200个汉字" class="myinp" onmouseover="this.style.border='1px solid #f60'" onfoucs="this.style.border='1px solid #f60'" onblur="this.style.border='1px solid #ccc'">报警记录！</textarea><font color="red">*</font></div>
			</div> 
			<p class="inputdiv">
			<input id="submitt" type="submit" value="提交" class="sub" onClick="chuli()"/>
			<input type="reset" value="重置"  class="sub" />
			</p> 
			<input id="hid" type="hidden">
			<input id="hid_sid" type="hidden" value="<% %>">
		</form>
	</div> 
    
    </body>
    <script type="text/javascript">
    	function chuli()
    	{
    		var alarmID=document.getElementById("Id").value;//日志编号
    		var alarmcontent=document.getElementById("Cresult").value;//处理日志的内容
    		
    		//alert("fff");
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
				//是否更新成功
				var result=xmlhttp.responseText;
			    if(result=="success")
			    {
			    	alert("操作成功！");
			    }
			    else
			    {
			    	alert("操作失败，请重新更新或添加！");
			    }
			  }
			};
			//alert(svgid.toString());
			xmlhttp.open("GET","../servlet/settleAlarm?type=huguang&alarmid="+alarmID+"&userid=kkk&alarmcontent="+alarmcontent+"&r="+new Date().getTime(),true);
			xmlhttp.send();
    	}
    	function settle(id)
    	{
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

			document.getElementById("Id").value=id;
			
			
	
    	}
    	var mClose = document.getElementById("close");
    	mClose.onclick = function() 
		{ 
			myAlert.style.display = "none"; 
			mybg.style.display = "none"; 
			document.getElementById("Substation_ID").value="";
			document.getElementById("Substation_Name").value="";
			document.getElementById("Substation_Place").value="";
			document.getElementById("Substation_Tele").value="";
			//document.getElementById("Substation_Device").value="";
			document.getElementById("rem").value="";
			document.getElementById("hid").value="insert";
		};
		
		
		
    
    </script>
    -->
    	<script type="text/javascript">
    		$('#sdate').datepicker();
			$('#fdate').datepicker();	
		</script>
    </body>
</html>

