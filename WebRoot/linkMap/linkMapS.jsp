<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@page import="java.io.File"%>
<%@page import="com.action.dataselect;"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>大成DSEP-2000电力图像智能与温湿度安全监测系统</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="../css/linkmapS.css" rel="stylesheet">
         <script type="text/javascript" src="../js/link/showMaps.js" charset="gbk"></script>
        <!--<script type="text/javascript" src="../js/link/operation.js" charset="gbk"></script> -->
    </head>
    <body>
    
    	<div id="demo" class="demo">
		<%
			String sid="";
			dataselect ds=new dataselect();
			ResultSet rs=null;
			String getlinkedid="select * from SubMap";
			
			if(request.getParameter("sid")!=null)
			{
				sid=request.getParameter("sid").toString();
			}
	     	String svgpath=application.getRealPath("svg/");
	    	//System.out.println(svgpath);
	    	
	    	File allfile=new File(svgpath);
	    	String[] temp=allfile.list();
	    	String[] linkedname=null;
	    	String linkid="";
	    	String[] filename=new String[temp.length];
	    	int num=0;
	    	//只显示svg文件夹下的svg文件
	    	for(int i=0;i<temp.length;i++)
	    	{
	    		if(temp[i].contains(".svg"))
	    		{
	    			filename[num]=temp[i];
	    			num++;
	    		}
	    	}
	    	
	    	try
			{
				rs=ds.select(getlinkedid);
				if(rs!=null)
				{	int k=0;
					
					rs.last();
		  			int rows = rs.getRow();
		  			linkedname=new String[rows];
		  			rs.first();
		  			rs.previous();
					
					while(rs.next())
					{
						linkedname[k]=rs.getString("Map_Name");
						//System.out.println(linkedname[k]);
						if(rs.getString("Substation_ID").equals(sid))
						{
							linkid=rs.getString("Map_Name");
						}
						k++;
						
					}
				}
			
			}
			catch(Exception ex){
			ex.printStackTrace();
			}
	    	
	    	//System.out.println("id: "+linkid);
	    	/*显示可选接线图列表*/
	    	//for(int i=0;i<filename.length;i++)
	    	for(int i=0;i<num;i++)
	    	{
	    		if(linkedname==null)
	    		{
	    			out.print("<div class='box'><div class='photo'><img class='svgquan'  id='"+filename[i]+"'  src='"+"../svg/"+filename[i]+"' /></div><div class='imgname'>"+filename[i]+"</div><div class='msg'><span class='imgop' onclick='link(\""+filename[i]+"\")'>选定</span><span class='imgop' onclick='yulan(\""+"../svg/"+filename[i]+"\")'>预览</span></div></div>");
	    		}
	    		else
	    		{
	    			/*标志：是否能显示*/
	    			int flag=1;
	    			for(int j=0;linkedname!=null&&j<linkedname.length;j++)
		    		{
		    			if(filename[i].equals(linkedname[j])==true&&linkid.equals(linkedname[j])==false)
		    			{
		    				flag=0;
		    				break;
		    				
		    			}
		    			else if(filename[i].equals(linkedname[j])==true&&linkid.equals(linkedname[j])==true)
		    			{
		    				flag=2;
		    				break;
		    			}
		    		}
		    		
		    		if(flag==1)
		    		{
		    			out.print("<div class='box'><div class='photo'><img class='svgquan' id='"+filename[i]+"'  src='"+"../svg/"+filename[i]+"' /></div><div class='imgname'>"+filename[i]+"</div><div class='msg'><span class='imgop' onclick='link(\""+filename[i]+"\")'>选定</span><span class='imgop' onclick='yulan(\""+"../svg/"+filename[i]+"\")'>预览</span></div></div>");
		    		}
		    		else if(flag==2)
		    		{
		    			out.print("<div class='box'><div class='photo'><img class='svgquan' id='"+filename[i]+"'  src='"+"../svg/"+filename[i]+"' /></div><div class='imgname'>"+filename[i]+"</div><div class='msg'><span class='imgop' onclick='link(\""+filename[i]+"\")'>选定</span><span class='imgop' onclick='yulan(\""+"../svg/"+filename[i]+"\")'>预览</span></div><div class='ischecked'>已选</div></div>");
		    		}
		    		
	    		}
	    		//System.out.println(filename[i]);
	    	}
	    	rs.close();
	    	ds.close();	
	    %>
	    <div>
		<input type="hidden" name="sid" id="sid" value="<%=sid%>">
        <div id="enlarge" style="display:none;border:1px solid #ff0011;backgroup-color:#ff0011;"></div>
        <div id="zoom" style='position:fixed;z-index: 800;right:1px;bottom:0px;'><button type='button' onclick='big();'>Zoom +</button><button type='button' onclick='small();'>Zoom -</button></div>
    </body>
    <script type="text/javascript">
    	function big()
	    {
	    	var box = document.getElementById('showimage'); 
	    	var boxwidth=box.getAttribute("width")*1.2;
	    	var boxheight=box.getAttribute("height")*1.2;
	    	
	    	box.setAttribute("width",boxwidth);
	    	box.setAttribute("height",boxheight);
	    }
	    function small()
	    {
	    	var box = document.getElementById('showimage'); 
	    	var boxwidth=box.getAttribute("width")/1.2;
	    	var boxheight=box.getAttribute("height")/1.2;
	    	
	    	box.setAttribute("width",boxwidth);
	    	box.setAttribute("height",boxheight);
	    }
    
    </script>
</html>

