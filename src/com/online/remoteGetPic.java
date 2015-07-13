package com.online;

import com.action.dataselect;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class remoteGetPic
  extends HttpServlet
{
  public void destroy()
  {
    super.destroy();
  }
  
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doPost(request, response);
  }
  
  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    String picid = request.getParameter("index_id");
    String fName = "none";
    String imgpath = "";
    String picurl = request.getSession().getServletContext().getRealPath("") + "\\liangw\\images\\";
    
    File fileDir = new File(picurl + "photo\\");
    if (!fileDir.exists()) {
      try
      {
        fileDir.createNewFile();
      }
      catch (IOException e)
      {
        e.printStackTrace();
      }
    }
    dataselect ds = new dataselect();
    String get_sampleid = "select Sample_IndexID,Sample_AddressH,Sample_AddressL from "+
    "SampleAddress,Sample where Sample.Sample_ID=SampleAddress.Sample_ID and"+
    		" Sample_Type='00' and Sample_AddressH is not null and Sample_AddressL" +
    " is not null and Sample_IndexID='" + picid + "'";
    ResultSet rs = ds.select(get_sampleid);
    if (rs != null) {
      try
      {
        while (rs.next())
        {
          String Sample_AddressH = rs.getString("Sample_AddressH");
          String Sample_AddressL = rs.getString("Sample_AddressL");
          picid = rs.getString("Sample_IndexID");
          
          Date time = new Date();
          DateFormat format = new SimpleDateFormat("yyMMddHHmmss");
          
          imgpath = picurl + "photo\\" + picid + "_" + format.format(time) + ".jpg";
          String picname = picid + "_" + format.format(time) + ".jpg";
          fName = picname;
          
          boolean k = getImg(Sample_AddressH, Sample_AddressL, picurl, imgpath);
          if (k) {
            picSQL(picid, picname, picurl);
          }
        }
      }
      catch (SQLException e)
      {
        e.printStackTrace();
      }
    }
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.print(fName);
    out.flush();
    out.close();
  }
  
  public void init()
    throws ServletException
  {}
  
  public static boolean getImg(String ip, String port, String path, String imageName)
  {
    boolean flag = false;
    Runtime rn = Runtime.getRuntime();
    Process p = null;
    try
    {
      String imgName = imageName;
      String exePath = path + "Debug\\testsdk.exe";
      String cmd = exePath + " " + ip + " " + port + " " + imgName;
      p = rn.exec(cmd);
      p.waitFor();
      flag = true;
    }
    catch (Exception e)
    {
      return flag;
    }
    return flag;
  }
  
  public void picSQL(String picid, String picname, String picurl)
    throws SQLException
  {
    Date time = new Date();
    DateFormat format = new SimpleDateFormat("yyMMddHHmmss");
    dataselect ds = new dataselect();
    ResultSet rs = null;
    String device_Address = "";
    String sample_id = "";
    String photoid = "";
    
    String get_sampleid = "select Device_Address,SampleAddress.Sample_ID"+
    " from SampleAddress,Sample where Sample.Sample_ID=SampleAddress.Sample_ID and" +
    		" Sample_Type='00' and Sample_IndexID='" + picid + "'";
    
    rs = ds.select(get_sampleid);
    try
    {
      if (rs != null) {
        while (rs.next())
        {
          sample_id = rs.getString(2);
          device_Address = rs.getString(1);
        }
      }
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    if ((!sample_id.equals("")) && (sample_id != null))
    {
      String insertPic = "insert into Photo(Sample_ID,Photo_Name,Photo_Location,Date) values('" + 
    		  	sample_id + "','" + picname + "','../images/photo/" + 
    		  picname + "','" + time.toLocaleString() + "')";
      
      int k = ds.update(insertPic);
      /*if (k > 0)
      {
        String getid = "select Photo_Id from Photo where sample_id='" + sample_id + "' and Date='" + time.toLocaleString() + "'";
        rs = ds.select(getid);
        while (rs.next()) {
          photoid = rs.getString(1);
        }
      }
      String check = "select count(*) from ReferPhoto where Sample_ID='" + sample_id + "'";
      rs = ds.select(check);
      try
      {
        rs.first();
        if (rs.getInt(1) < 1)
        {
          String setcaokaopic = "insert into ReferPhoto(Sample_ID,Photo_Id,Photo_Name,Photo_Location,Date) values('" + sample_id + "','" + photoid + "','" + picname + "','" + "../images/photo/" + picname + "','" + time.toLocaleString() + "') ";
          int i = ds.update(setcaokaopic);
        }
      }
      catch (SQLException e)
      {
        e.printStackTrace();
      }*/
    }
    try
    {
      rs.close();
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    /*String getPath = picurl;
    int thresh = 30;
    String imageOldName = "";
    String getimagePathOld = "select * from ReferPhoto where sample_id='" + sample_id + "'";
    
    ResultSet rs2 = ds.select(getimagePathOld);
    while (rs2.next()) {
      imageOldName = rs2.getString("Photo_Name");
    }
    rs2.close();
    
    String cmpExePathString = getPath + "sub.exe";
    String imagePathOld = getPath + "photo\\" + imageOldName;
    String imagepath = getPath + "photo\\" + picname;
    
    String result = getPath + "result\\" + picname;
    
    System.out.println("getPath:" + getPath);
    System.out.println(cmpExePathString);
    System.out.println(imagePathOld);
    System.out.println(imagepath);
    System.out.println(result);
    
    int flag1 = 0;
    int flag2 = 0;
    
    File fileTO = new File(imagePathOld);
    if (fileTO.exists()) {
      if (fileTO.length() > 0L) {
        flag1 = 1;
      }
    }
    File fileTC = new File(imagepath);
    if (fileTC.exists()) {
      if (fileTC.length() > 0L) {
        flag2 = 1;
      }
    }
    if ((flag1 > 0) && (flag2 > 0))
    {
      Runtime rn = Runtime.getRuntime();
      Process p = null;
      try
      {
        p = rn.exec(cmpExePathString + " " + imagePathOld + " " + imagepath + " " + result + " " + thresh);
        p.waitFor();
        
        int[][] list = getPX(result);
        int xiangsi = 0;
        int zong = 0;
        int i = 0;int j = 0;
        for (i = 0; i < list.length; i++) {
          for (j = 0; j < list[i].length; j++) {
            if (list[i][j] == 0)
            {
              xiangsi++;
              zong++;
            }
            else
            {
              zong++;
            }
          }
        }
        String baifen = Double.parseDouble(new StringBuilder(String.valueOf(xiangsi)).toString()) / Double.parseDouble(new StringBuilder(String.valueOf(zong)).toString());
        double rate = new Double(baifen).doubleValue() * 100.0D;
        String rate2 = String.format("%.2f", new Object[] { Double.valueOf(rate) });
        
        String insertResult = "update Photo set Result_Location='../images/result/" + picname + "',Rate=" + rate2 + ",Fam_Pixel='" + xiangsi + "',Total_Pixel='" + zong + "' where Photo_Id=" + photoid;
        System.out.println("insertResult:" + insertResult);
        int k1 = ds.update(insertResult);
        if (rate < 98.0D)
        {
          String insertAlarm = "insert into AlarmLogPicture(Sample_ID,AlarmPhoto,AlarmType,Odate) values('" + sample_id + "','" + photoid + "','0','" + time.toLocaleString() + "')";
          int j = ds.update(insertAlarm);
        }
      }
      catch (Exception localException) {}
    }
    ds.close();*/
  }
  
  public int[][] getPX(String args)
  {
    int rgb = 0;
    File file = new File(args);
    if (!file.exists()) {
      try
      {
        file.createNewFile();
      }
      catch (IOException e)
      {
        e.printStackTrace();
      }
    }
    BufferedImage bi = null;
    try
    {
      bi = ImageIO.read(file);
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    int width = bi.getWidth();
    int height = bi.getHeight();
    int minx = bi.getMinX();
    int miny = bi.getMinY();
    int[][] list = new int[width][height];
    for (int i = minx; i < width; i++) {
      for (int j = miny; j < height; j++)
      {
        int pixel = bi.getRGB(i, j);
        rgb = (pixel & 0xFF0000) >> 16;
        
        list[i][j] = rgb;
      }
    }
    return list;
  }
}
