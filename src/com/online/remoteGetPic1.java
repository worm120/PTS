package com.online;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class remoteGetPic1 extends HttpServlet {

	public remoteGetPic1() {
		super();
	}

	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fid=request.getParameter("index_id");//摄像头序号
		String fName="none";//最新的文件名
		String imgpath=request.getSession().getServletContext().getRealPath("")+"\\liangw\\images\\photo";
		File fileDir=new File(imgpath);
    	if(!fileDir.exists())
    	{
    		try 
    		{
				fileDir.createNewFile();
			} 
    		catch (IOException e) 
    		{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}

    	File[]  allFiles=fileDir.listFiles();//取图像文件夹下的所有文件
		long tt=0;//当前最大的文件修改时间
		if(allFiles!=null)
		{//找出该摄像头最新的一张图像
	    	for(int i=0;i<allFiles.length;i++)
	    	{
	    		if(allFiles[i].isFile())
	    		{
	    			long t= allFiles[i].lastModified();
	    			int k=allFiles[i].getName().indexOf("_");
	    			if(k>0)
	    			{
	    				String index_id=allFiles[i].getName().substring(0,k);//取摄像头编号
		    			if(index_id.equals(fid)==true)
		    			{
		    				if(t>tt)//新
			    			{
			    				tt=t;
			    				fName=allFiles[i].getName();
			    			}
		    			}
	    			}
	    		}
	    	}
		}

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();	
		out.print(fName);
		out.flush();
		out.close();
		
		//System.out.println("<>"+request.getSession().getServletContext().getRealPath("") );
		//System.out.println(request.getRequestURL() );
	}

	public void init() throws ServletException {
		// Put your code here
	}

}
