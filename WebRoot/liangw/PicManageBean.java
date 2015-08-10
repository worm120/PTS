package liangw;

import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import com.action.dataselect;

public class PicManageBean extends dataselect {

	// 查找所有变电所名称并返回其值
	public List<PicManage> getSubstation() {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Substation";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setSubid(rs.getString("Substation_ID"));
				picmanage.setSubname(rs.getString("Substation_Name"));
				picmanage.setSubplace(rs.getString("Substation_Place"));
				picmanage.setSubtele(rs.getString("Substation_Tele"));
				picmanage.setSubdevice(rs.getString("Substation_Device"));
				picmanage.setSubrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据变电所编号查找开关柜
	public List<PicManage> getDevice(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Device where Substation_ID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setDid(rs.getInt("ID"));
				picmanage.setDeviceid(rs.getString("Device_ID"));
				picmanage.setDsubid(rs.getString("Substation_ID"));
				picmanage.setDcard(rs.getString("Device_Card"));
				picmanage.setDname(rs.getString("Device_Name"));
				picmanage.setDplace(rs.getString("Device_Place"));
				picmanage.setDrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// // 根据开关柜编号查找采样点
	// public List<PicManage> getSample(String id) {
	// try {
	// List<PicManage> list = new ArrayList<PicManage>();
	// Connection conn = this.getCon();
	// String sql = "select * from Sample where Device_ID=? and Sample_Type=?";
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// pstmt.setString(1, id);
	// pstmt.setString(2, "00");
	// ResultSet rs = pstmt.executeQuery();
	// while (rs.next()) {
	// PicManage picmanage = new PicManage();
	// picmanage.setSid(rs.getString("Sample_ID"));
	// picmanage.setSubstationid(rs.getString("Substation_ID"));
	// picmanage.setSdeviceid(rs.getString("Device_ID"));
	// picmanage.setSname(rs.getString("Sample_Name"));
	// picmanage.setSplace(rs.getString("Sample_Place"));
	// picmanage.setStype(rs.getString("Sample_Type"));
	// picmanage.setSrem(rs.getString("rem"));
	// list.add(picmanage);
	// }
	// return list;
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally {
	// this.closeAll();
	// }
	// return null;
	// }
	// 根据Devpoint表中的Pid查找Device_ID
	public String getDeviceId(String nodeid) {
		String deviceid = null;
		String sql = "select Device_ID from Devpoint where Pid=?";
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nodeid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				deviceid = rs.getString("Device_ID");
			}
			return deviceid;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return deviceid;
	}

	// 根据变电所和开关柜编号查找采样点
	public List<PicManage> getSample(String sid, String deviceid) {
		String sql = "select * from Sample where Substation_ID=? and Device_ID=? and Sample_Type=?";
		deviceid = getDeviceId(deviceid);
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			pstmt.setString(2, deviceid);
			pstmt.setString(3, "00");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setSid(rs.getString("Sample_ID"));
				picmanage.setSubstationid(rs.getString("Substation_ID"));
				picmanage.setSdeviceid(rs.getString("Device_ID"));
				picmanage.setSname(rs.getString("Sample_Name"));
				picmanage.setSplace(rs.getString("Sample_Place"));
				picmanage.setStype(rs.getString("Sample_Type"));
				picmanage.setSrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据采样点编号查找采样点
	public List<PicManage> getSample0(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Sample where Sample_ID=? and Sample_Type=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, "00");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setSid(rs.getString("Sample_ID"));
				picmanage.setSubstationid(rs.getString("Substation_ID"));
				picmanage.setSdeviceid(rs.getString("Device_ID"));
				picmanage.setSname(rs.getString("Sample_Name"));
				picmanage.setSplace(rs.getString("Sample_Place"));
				picmanage.setStype(rs.getString("Sample_Type"));
				picmanage.setSrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据采样点编号查找并显示参照图像,并按时间顺序显示
	public List<PicManage> getPicTime1(String id, String referid) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Photo where Sample_ID=? and "
					+ "Photo_Id!=? order by Date desc";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// System.out.println(id);
			pstmt.setString(1, id);
			pstmt.setString(2, referid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setPhotoid(rs.getInt("Photo_Id"));
				picmanage.setPid(rs.getString("Pid"));
				picmanage.setPsampleid(rs.getString("Sample_ID"));
				picmanage.setPname(rs.getString("Photo_Name"));
				picmanage.setPlocation(rs.getString("Photo_Location"));
				picmanage.setPdate(rs.getString("Date"));
				picmanage.setPrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据采样点编号查找并显示参照图像,并按时间顺序显示
	public List<PicManage> getPicTime(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Photo where Sample_ID=? order by Date desc";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// System.out.println(id);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setPhotoid(rs.getInt("Photo_Id"));
				picmanage.setPid(rs.getString("Pid"));
				picmanage.setPsampleid(rs.getString("Sample_ID"));
				picmanage.setPname(rs.getString("Photo_Name"));
				picmanage.setPlocation(rs.getString("Photo_Location"));
				picmanage.setPdate(rs.getString("Date"));
				picmanage.setPrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据采样点编号查找参照图像ID
	public String getInfer(String id) {
		String pid = null;
		String sql = "select Photo_Id from ReferPhoto where Sample_ID=?";
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				pid = rs.getString("Photo_Id");
			}
			return pid;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return pid;
	}

	// 显示参照图像
	public List<PicManage> showInferPic(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Photo,ReferPhoto where Photo.Sample_ID=? and Photo.Photo_Id=ReferPhoto.Photo_Id";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// System.out.println(id);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setPhotoid(rs.getInt("Photo_Id"));
				picmanage.setPid(rs.getString("Pid"));
				picmanage.setPsampleid(rs.getString("Sample_ID"));
				picmanage.setPname(rs.getString("Photo_Name"));
				picmanage.setPlocation(rs.getString("Photo_Location"));
				picmanage.setPdate(rs.getString("Date"));
				picmanage.setPrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	//
	// // 根据采样点编号查找并显示参照图像
	// public String findResPic(int id) {
	// String sql = "select * from Photo where Sample_ID=?";
	// String resPic = null;
	// try {
	// Connection conn = this.getCon();
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// pstmt.setInt(1, id);
	// ResultSet rs = pstmt.executeQuery();
	// if (rs.next()) {
	// resPic = rs.getString("Photo_Location");
	// }
	// return resPic;
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally {
	// this.closeAll();
	// }
	// return resPic;
	// }

	// 设为参照图像
	public boolean setInfer(String sid, String pid, String pname,
			String plocation, String pdate, String flag) throws IOException,
			InterruptedException {
		boolean result = false;
		int thresh = 30;
		String path = System.getProperty("user.dir").replace("bin", "webapps")
				+ "\\PTS";
		String img[] = plocation.split("/");
		String imgPath1 = path + "\\liangw\\images\\photo\\"
				+ img[img.length - 1];
		String setdate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());
		// 标记为“1”表示要更新数据
		String sql = null;
		Object[] a = null;
		String sql1 = "select * from Photo where Sample_ID=? "
				+ "and Photo_Id!=?";// 查找该采样点的除设置图片之外的所有图片路径

		String sql2 = "update Photo set Result_Location=?,Fam_Pixel=?,Total_Pixel=?,Rate=?"
				+ " where Photo_Id=?";// 更新结果图片的路径和分析数据等
		if (flag.equals("1")) {

			sql = "update ReferPhoto set Photo_Id=?,Photo_Name=?,"
					+ "Photo_Location=?,Date=?,setDate=? where Sample_ID=?";// 更新参照图像表
			a = new Object[] { pid, pname, plocation, pdate, setdate, sid };// a更新参照图像

		}
		if (flag.equals("0")) {
			sql = "insert into ReferPhoto(Sample_ID,Photo_Id,Photo_Name,Photo_Location,Date,setDate,referFlag) "
					+ "values(?,?,?,?,?,?,?)";// 插入参照图像表
			a = new Object[] { sid, pid, pname, plocation, pdate, setdate, "1" };// a插入参照图像
		}

		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, sid);
			pstmt.setString(2, pid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				String plocal = rs.getString("Photo_Location");
				String picid = rs.getString("Photo_Id");
				String img2[] = plocal.split("/");
				String imgPath2 = path + "\\liangw\\images\\photo\\"
						+ img2[img2.length - 1];
				String resul = path + "\\liangw\\images\\result\\"
						+ img2[img2.length - 1];// 结果图像存放的绝对路径
				Runtime rn = Runtime.getRuntime();
				Process p = null;

				p = rn.exec(path + "\\liangw\\images\\sub.exe " + imgPath1
						+ " " + imgPath2 + " " + resul + " " + thresh);
				p.waitFor();
				String result1 = "../images/result/" + img2[img2.length - 1];// 结果图像存放的相对路径
				// System.out.println(resul);
				int[][] list = getPX(resul); // 对比图片
				System.out.println("cc");
				int xiangsi = 0;
				int zong = 0;
				int i = 0, j = 0;
				for (i = 0; i < list.length; i++) {// 遍历纵向的数据
					for (j = 0; j < list[i].length; j++) {// 遍历横向的数据
						// System.out.println(list1[i][j] );
						if (list[i][j] == 0) {
							xiangsi++;
							zong++;
						} else {
							zong++;
						}
					}
				}
				String baifen = ((Double.parseDouble(xiangsi + "") / Double
						.parseDouble((zong) + "")) + "");
				// System.out.println(baifen);

				double rate = (new Double(baifen)).doubleValue();
				Object[] c = new Object[] { result1, xiangsi, zong, rate * 100,
						picid };
				this.update(sql2, c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		result = this.update(sql, a);// 更新参照图像
		this.closeAll();
		return result;
	}

	// 根据采样点编号查找参照图像路径和ID
	public List<PicManage> getReferPic(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from ReferPhoto where Sample_ID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// System.out.println(id);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setPhotoid(rs.getInt("Photo_Id"));
				picmanage.setPlocation(rs.getString("Photo_Location"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// public String getReferPic(String id) {
	// String plocation = null;
	// String sql = "select * from ReferPhoto where Sample_ID=?";
	// try {
	// Connection conn = this.getCon();
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// pstmt.setString(1, id);
	// ResultSet rs = pstmt.executeQuery();
	// if (rs.next()) {
	// plocation = rs.getString("Photo_Location");
	// plocation = rs.getString("Photo_Id");
	// }
	// return plocation;
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally {
	// this.closeAll();
	// }
	// return plocation;
	// }

	// 根据图像ID在PhotoFeature表查找数据，返回布尔型数据
	public boolean getSel(String id) {
		boolean result = false;
		String sql = "select * from PhotoFeature where Photo_Id=?";
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return result;
	}

	// 根据图像编号查找选区信息
	public List<PicManage> getSelect(String id) {
		// System.out.println(id);
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from PhotoFeature where Photo_Id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setX1(rs.getString("Photo_X1"));
				picmanage.setX2(rs.getString("Photo_X2"));
				picmanage.setY1(rs.getString("Photo_Y1"));
				picmanage.setY2(rs.getString("Photo_Y2"));
				picmanage.setWidth(rs.getString("Photo_Width"));
				picmanage.setHeight(rs.getString("Photo_Height"));

				// System.out.println(rs.getString("Photo_X1"));

				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据图像编号查找选区信息
	public List<PicManage> getSelectArea1(String id) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from PhotoFeature where Photo_Id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setX1(rs.getString("Photo_X1"));
				picmanage.setX2(rs.getString("Photo_X2"));
				picmanage.setY1(rs.getString("Photo_Y1"));
				picmanage.setY2(rs.getString("Photo_Y2"));
				picmanage.setWidth(rs.getString("Photo_Width"));
				picmanage.setHeight(rs.getString("Photo_Height"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据图像ID和选区编号查找数据，返回布尔型数据
	public boolean addSel1(String sampleid, String picid, String selnum) {
		boolean result = false;
		String sql = "select * from PhotoFeature where Sample_ID=? and Photo_Id=? and Photo_Select=?";
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sampleid);
			pstmt.setString(2, picid);
			pstmt.setString(3, selnum);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
			return result;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return result;
	}

	// 插入图像和选区信息
	public boolean insertSel1(String sampleid, String picid, String selnum,
			String x1, String x2, String y1, String y2, String width,
			String height) {
		boolean result = false;
		// 获取当前服务器时间
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());

		String sql = "insert into PhotoFeature(Sample_ID,Photo_Id,Photo_Select,Photo_X1,Photo_X2,Photo_Y1,Photo_Y2,"
				+ "Photo_Width,Photo_Height,Date) values(?,?,?,?,?,?,?,?,?,?)";
		Object[] a = new Object[] { sampleid, picid, selnum, x1, x2, y1, y2,
				width, height, date };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 插入选区信息
	public boolean insertSel(String x1, String y1, String x2, String y2,
			String width, String height, String sampleid, String picid) {
		boolean result = false;
		// 获取当前服务器时间
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());

		System.out.println(sampleid + "??" + picid + "??" + x1 + "??" + x2
				+ "??" + y1 + "??" + y2 + "??" + width + "??" + height + "??"
				+ date);

		String sql = "insert into PhotoFeature(Sample_ID,Photo_Id,Photo_X1,Photo_X2,Photo_Y1,Photo_Y2,"
				+ "Photo_Width,Photo_Height,Date) values(?,?,?,?,?,?,?,?,?)";
		Object[] a = new Object[] { sampleid, picid, x1, x2, y1, y2, width,
				height, date };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 更新选区信息
	public boolean updateSel(String x1, String y1, String x2, String y2,
			String width, String height, String sampleid, String picid) {
		boolean result = false;
		// 获取当前服务器时间
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());

		String sql = "update PhotoFeature set Photo_X1=?,Photo_X2=?,Photo_Y1=?,Photo_Y2=?,Photo_Width=?,Photo_Height=?,"
				+ "Date=? where Photo_Id=?";
		Object[] a = new Object[] { x1, x2, y1, y2, width, height, date, picid };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 根据采样点ID删除选区
	public boolean deleSel(String id) {
		String sql = "delete from PhotoFeature where Sample_ID =?";
		Object[] a = new Object[] { id };
		boolean result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// // 插入图像和选区信息
	// public boolean insertSel(String sampleid, String picid, String selnum,
	// String x1, String x2, String y1, String y2, String width,
	// String height) {
	// boolean result = false;
	// // 获取当前服务器时间
	// String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	// .format(Calendar.getInstance().getTime());
	//
	// String sql =
	// "insert into PhotoFeature(Sample_ID,Photo_Id,Photo_Select,Photo_X1,Photo_X2,Photo_Y1,Photo_Y2,"
	// + "Photo_Width,Photo_Height,Date) values(?,?,?,?,?,?,?,?,?,?)";
	// Object[] a = new Object[] { sampleid, picid, selnum, x1, x2, y1, y2,
	// width, height, date };
	// result = this.update(sql, a);
	// this.closeAll();
	// return result;
	// }
	//
	// // 更新图像和选区信息
	// public boolean updateSel1(String picid, String selnum, String x1,
	// String x2, String y1, String y2, String width, String height) {
	// boolean result = false;
	// // 获取当前服务器时间
	// String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
	// .format(Calendar.getInstance().getTime());
	//
	// String sql =
	// "update PhotoFeature set Photo_X1=?,Photo_X2=?,Photo_Y1=?,Photo_Y2=?,Photo_Width=?,Photo_Height=?,"
	// + "Date=? where Photo_Id=? and Photo_Select=?";
	// Object[] a = new Object[] { x1, x2, y1, y2, width, height, date, picid,
	// selnum };
	// result = this.update(sql, a);
	// this.closeAll();
	// return result;
	// }

	// 查找数据库里的图像信息,返回的是list类型的结果集
	public List<PicManage> getPicInfo() {
		try {
			String sql = "select * from Photo,Substation,Device,Sample where Photo.Sample_ID=Sample.Sample_ID and "
					+ "Substation.Substation_ID= Sample.Substation_ID and Sample.Device_ID= "
					+ "Device.Device_ID order by Substation.Substation_ID";
			ResultSet rs = this.query(sql);
			List<PicManage> list = new ArrayList<PicManage>();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setRow(rs.getRow());
				picmanage.setPhotophotoid(rs.getInt("Photo_Id"));
				picmanage.setPhotosubname(rs.getString("Substation_Name"));
				picmanage.setPhotosid(rs.getString("Sample_ID"));
				picmanage.setPhotossubid(rs.getString("Substation_ID"));
				picmanage.setDeviceid(rs.getString("Device_ID"));
				picmanage.setDname(rs.getString("Device_Name"));
				picmanage.setPhotosname(rs.getString("Sample_Name"));
				picmanage.setPhotostype(rs.getString("Sample_Type"));
				picmanage.setPhotopsid(rs.getString("Sample_ID"));
				picmanage.setPhotopname(rs.getString("Photo_Name"));
				picmanage.setPhotoplocation(rs.getString("Photo_Location"));
				picmanage.setPhotopdate(rs.getString("Date"));
				String a = rs.getString("rem");
				if (rs.getString("rem") == null)
					a = "";
				picmanage.setPhotoprem(a);
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据变电所查找数据库里的图像信息,返回的是list类型的结果集
	public List<PicManage> inquerySub(String subid) {
		try {
			Connection conn = this.getCon();
			String sql = "select * from Photo,Device,Substation,Sample where Photo.Sample_ID=Sample.Sample_ID and "
					+ "Substation.Substation_ID= Sample.Substation_ID and Sample.Device_ID = Device.Device_ID "
					+ "and Substation.Substation_ID=? order by Substation.Substation_ID";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subid);
			ResultSet rs = pstmt.executeQuery();
			List<PicManage> list = new ArrayList<PicManage>();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setRow(rs.getRow());

				// System.out.println(rs.getInt("Sample_ID"));

				picmanage.setPhotophotoid(rs.getInt("Photo_Id"));
				picmanage.setPhotosubname(rs.getString("Substation_Name"));
				picmanage.setPhotosid(rs.getString("Sample_ID"));
				picmanage.setPhotossubid(rs.getString("Substation_ID"));
				picmanage.setDeviceid(rs.getString("Device_ID"));
				picmanage.setDname(rs.getString("Device_Name"));
				picmanage.setPhotosname(rs.getString("Sample_Name"));
				picmanage.setPhotostype(rs.getString("Sample_Type"));
				picmanage.setPhotopsid(rs.getString("Sample_ID"));
				picmanage.setPhotopname(rs.getString("Photo_Name"));
				picmanage.setPhotoplocation(rs.getString("Photo_Location"));
				picmanage.setPhotopdate(rs.getString("Date"));
				picmanage.setPhotoprem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据变电所和开关柜查找数据库里的图像信息,返回的是list类型的结果集
	public List<PicManage> inqueryDevice(String nodeid, String subid) {
		deviceid = getDeviceId(nodeid);
		try {
			Connection conn = this.getCon();
			String sql = "select * from Photo,Device,Substation,Sample where Photo.Sample_ID=Sample.Sample_ID and "
					+ "Substation.Substation_ID= Sample.Substation_ID and Sample.Device_ID = Device.Device_ID "
					+ "and Device.Device_ID=? and Substation.Substation_ID=? "
					+ "order by Substation.Substation_ID";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, deviceid);
			pstmt.setString(2, subid);
			ResultSet rs = pstmt.executeQuery();
			List<PicManage> list = new ArrayList<PicManage>();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setRow(rs.getRow());
				picmanage.setPhotophotoid(rs.getInt("Photo_Id"));
				picmanage.setPhotosubname(rs.getString("Substation_Name"));
				picmanage.setPhotosid(rs.getString("Sample_ID"));
				picmanage.setPhotossubid(rs.getString("Substation_ID"));
				picmanage.setDeviceid(rs.getString("Device_ID"));
				picmanage.setDname(rs.getString("Device_Name"));
				picmanage.setPhotosname(rs.getString("Sample_Name"));
				picmanage.setPhotostype(rs.getString("Sample_Type"));
				picmanage.setPhotopsid(rs.getString("Sample_ID"));
				picmanage.setPhotopname(rs.getString("Photo_Name"));
				picmanage.setPhotoplocation(rs.getString("Photo_Location"));
				picmanage.setPhotopdate(rs.getString("Date"));
				picmanage.setPhotoprem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 根据变电所和开关柜以及采样点查找数据库里的图像信息,返回的是list类型的结果集
	public List<PicManage> inquerySample(String sampleid, String subid,
			String deviceid) {
		deviceid = getDeviceId(deviceid);
		try {
			Connection conn = this.getCon();

			String sql = "select * from Photo,Substation,Device,Sample where Photo.Sample_ID=Sample.Sample_ID and "
					+ "Substation.Substation_ID= Sample.Substation_ID and Sample.Device_ID = Device.Device_ID "
					+ "and Substation.Substation_ID=? and Device.Device_ID=? and "
					+ "Sample.Sample_ID=? order by Substation.Substation_ID";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subid);
			pstmt.setString(2, deviceid);
			pstmt.setString(3, sampleid);
			ResultSet rs = pstmt.executeQuery();
			List<PicManage> list = new ArrayList<PicManage>();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setRow(rs.getRow());
				picmanage.setPhotophotoid(rs.getInt("Photo_Id"));
				picmanage.setPhotosubname(rs.getString("Substation_Name"));
				picmanage.setPhotosid(rs.getString("Sample_ID"));
				picmanage.setPhotossubid(rs.getString("Substation_ID"));
				picmanage.setDeviceid(rs.getString("Device_ID"));
				picmanage.setDname(rs.getString("Device_Name"));
				picmanage.setPhotosname(rs.getString("Sample_Name"));
				picmanage.setPhotostype(rs.getString("Sample_Type"));
				picmanage.setPhotopsid(rs.getString("Sample_ID"));
				picmanage.setPhotopname(rs.getString("Photo_Name"));
				picmanage.setPhotoplocation(rs.getString("Photo_Location"));
				picmanage.setPhotopdate(rs.getString("Date"));
				picmanage.setPhotoprem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// 删除单张图像
	public boolean deleOne(String id) {
		String sql = "delete from Photo where Photo_Id =?";
		String sql1 = "delete from PhotoFeature where Photo_Id =?";
		String sql2 = "delete from ReferPhoto where Photo_Id =?";
		Object[] a = new Object[] { id };
		Object[] b = new Object[] { id };
		Object[] c = new Object[] { id };
		boolean result = this.update(sql, a);
		result = this.update(sql1, b);
		result = this.update(sql2, c);
		this.closeAll();
		return result;
	}

	// 批量删除图像
	public boolean delePic(String ids) {
		String[] id = ids.split(",");
		boolean result = false;
		// String sql = "delete from Photo where Photo_Id =?";
		String sql = "delete from Photo where Photo_Id =?";
		String sql1 = "delete from PhotoFeature where Photo_Id =?";
		String sql2 = "delete from ReferPhoto where Photo_Id =?";
		Connection conn = this.getCon();
		PreparedStatement pstmt;
		PreparedStatement pstmt1;
		PreparedStatement pstmt2;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt1 = conn.prepareStatement(sql1);
			pstmt2 = conn.prepareStatement(sql2);
			for (int i = 0; i < id.length; i++) {
				pstmt.setString(1, id[i].trim());
				pstmt1.setString(1, id[i].trim());
				pstmt2.setString(1, id[i].trim());
				pstmt.addBatch();
				pstmt1.addBatch();
				pstmt2.addBatch();
			}
			pstmt.executeBatch(); // 批量执行
			pstmt1.executeBatch(); // 批量执行
			pstmt2.executeBatch(); // 批量执行
			conn.commit();// 提交事务
			result = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback(); // 进行事务回滚
			} catch (SQLException ex) {
			}
		} finally {
			this.closeAll();
		}
		System.out.println(result);
		return result;
	}

	// 选择比较的图像
	public List<PicManage> getCmpPic() {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Photo order by Date desc";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setPhotoid(rs.getInt("Photo_Id"));
				picmanage.setPid(rs.getString("Pid"));
				picmanage.setPsampleid(rs.getString("Sample_ID"));
				picmanage.setPname(rs.getString("Photo_Name"));
				picmanage.setPlocation(rs.getString("Photo_Location"));
				picmanage.setPdate(rs.getString("Date"));
				picmanage.setPrem(rs.getString("rem"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	public static int[][] getPX(String args) {
		int rgb = 0;
		File file = new File(args);
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int width = bi.getWidth();
		int height = bi.getHeight();
		int minx = bi.getMinX();
		int miny = bi.getMinY();
		int[][] list = new int[width][height];
		// System.out.println("getPX");
		for (int i = minx; i < width; i++) {
			for (int j = miny; j < height; j++) {
				int pixel = bi.getRGB(i, j);
				rgb = (pixel & 0xff0000) >> 16;
				// int g = (pixel & 0xff00) >> 8;
				// System.out.println(rgb + "?" + g);
				list[i][j] = rgb;
				// System.out.println(rgb + "  m");
			}
		}

		return list;
	}

	// 查找图像的相似率等
	public List<PicManage> getCompare(String pid) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			String sql = "select * from Photo where Photo_Id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PicManage picmanage = new PicManage();
				picmanage.setFam(rs.getString("Fam_Pixel"));
				picmanage.setTotal(rs.getString("Total_Pixel"));
				picmanage.setRate(rs.getString("Rate"));
				list.add(picmanage);
			}
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return null;
	}

	// public List<Picture> compareImage(String imgPath1, String imgPath2)
	// throws IOException {
	//
	// String path = System.getProperty("user.dir").replace("bin", "webapps")
	// + "\\PTS";
	// // System.out.println(imgPath1 + "..." + imgPath2);
	// String img1[] = imgPath1.split("/");
	// String img2[] = imgPath2.split("/");
	//
	// // imgPath1=img1[img1.length-1];
	// // imgPath2=img2[img2.length-1];
	//
	// // System.out.println(img1[img1.length-1]);
	//
	// // File img = new File("images");
	// // img=img.getAbsoluteFile();
	// // imgPath2=img+imgPath1.substring(2,imgPath2.length());
	// imgPath1 = path + "\\images\\" + img1[img1.length - 1];
	// imgPath2 = path + "\\images\\" + img2[img2.length - 1];
	// // System.out.println(imgPath1.substring(2,imgPath1.length()));
	//
	// String[] images = { imgPath1, imgPath2 };
	// System.out.println(imgPath1);
	//
	// // String path=getClass().getResourceAsStream("images/");
	// // System.out.println(path);
	//
	// // System.out.println(images[1]);
	//
	// // System.out.println(img+imgPath1.substring(2,imgPath1.length()));
	// if (images.length == 0) {
	// System.out.println("Usage >java BMPLoader ImageFile.bmp");
	// System.exit(0);
	// }
	//
	// // String filePath = path + "\\images\\cmp\\result"
	// // + img2[img2.length - 1];
	//
	// // String filePath=path+"\\images\\cmp\\cmp0001.jpg";
	// // System.out.println(filePath);
	//
	// // System.out.println(filePath);
	//
	// File file = new File(imgPath2);
	// if (!file.exists()) {
	// try {
	// file.createNewFile();
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	//
	// // File file = new File(
	// // "h:/MyEclipse/workspace/PTS/WebRoot/picManage/picSet.jsp/cmp.jpg");
	// // File file = new File("c:/src/10.jpg");
	// BufferedImage image = ImageIO.read(file);
	//
	// // int width = image.getWidth();
	// // int height = image.getHeight();
	//
	// // BufferedImage grayImage = new BufferedImage(width, height,
	// // BufferedImage.TYPE_3BYTE_BGR );
	//
	// // 分析图片相似度 begin
	// // int[][] list1 =
	// // getPX("h:/myeclipse_workplace/PTS/WebRoot/images/cmp/cmp.jpg");
	// // int[][] list2 =
	// // getPX("h:/myeclipse_workplace/PTS/WebRoot/images/cmp/cmp.jpg");
	//
	// int[][] list1 = getPX(images[0]); // 原图
	// // // System.out.println(list1);
	// int[][] list2 = getPX(images[1]); // 对比图
	// int xiangsi = 0;
	// int busi = 0;
	// int i = 0, j = 0;
	// int avg1 = 0, avg2 = 0;
	// for (i = 0; i < list1.length; i++) {// 遍历纵向的数据
	// for (j = 0; j < list1[i].length; j++) {// 遍历横向的数据
	// avg1 += list1[i][j];
	// avg2 += list2[i][j];
	// }
	// }
	// avg1 = avg1 / (320 * 240);
	// avg2 = avg2 / (320 * 240);
	//
	// for (i = 0; i < list1.length; i++) {// 遍历纵向的数据
	// for (j = 0; j < list1[i].length; j++) {// 遍历横向的数据
	// // System.out.println(list1[i][j] );
	// if (list1[i][j] == list2[i][j]) {
	// xiangsi++;
	// // if ((list1[i][j] / avg1 - list2[i][j] / avg2) > 0.99
	// // || (list1[i][j] / avg1 - list2[i][j] / avg2) < -0.99) {
	// //
	// // busi++;
	// // // Color color=new Color(255, 0, 0);
	// // // grayImage.setRGB(i, j, 65535);
	// // image.setRGB(i, j, 65535);
	// // grayImage.setRGB(i, j, list1[i][j]);
	// } else {
	// // xiangsi++;
	// busi++;
	// // Color color=new Color(255, 0, 0);
	// // grayImage.setRGB(i, j, 65535);
	// image.setRGB(i, j, 65535);
	//
	// }
	// }
	// }
	// // File newFile = new File("c:/src/mm.jpg");
	// String filePath1 = path + "\\images\\cmp\\result"
	// + img2[img2.length - 1];
	//
	// File newFile = new File(filePath1);
	// if (!newFile.exists()) {
	// try {
	// file.createNewFile();
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	// ImageIO.write(image, "jpg", newFile);
	// String baifen = "";
	// try {
	// baifen = ((Double.parseDouble(xiangsi + "") / Double
	// .parseDouble((busi + xiangsi) + "")) + "");
	// baifen = baifen.substring(baifen.indexOf(".") + 1, baifen
	// .indexOf(".") + 3);
	// } catch (Exception e) {
	// baifen = "0";
	// }
	// if (baifen.length() <= 0) {
	// baifen = "0";
	// }
	// if (busi == 0) {
	// baifen = "100";
	// }
	//
	// // System.out.println("相似像素数量：" + xiangsi + " 不相似像素数量：" + busi + " 相似率："
	// // + Integer.parseInt(baifen) + "%");
	// // int[] result = { xiangsi, busi, Integer.parseInt(baifen) };
	//
	// // return result;
	// try {
	// List<Picture> list = new ArrayList<Picture>();
	// Picture picture = new Picture();
	// picture.setXiangsi(xiangsi);
	//
	// // String[] fpath=filePath1.split("\\");
	// // String fpath0=fpath[fpath.length-1];
	// picture.setPhoid("result" + img2[img2.length - 1]);
	// picture.setBusi(busi);
	// picture.setRate(Integer.parseInt(baifen));
	// // System.out.println(img2[img2.length-1]);
	// list.add(picture);
	// return list;
	// } finally {
	// this.closeAll();
	// }
	// }
	public void compareImage(String imgPath1, String imgPath2, String picid)
			throws IOException {

		int thresh = 30;
		String path = System.getProperty("user.dir").replace("bin", "webapps")
				+ "\\PTS";
		String img1[] = imgPath1.split("/");
		String img2[] = imgPath2.split("/");
		String sql = "update Photo set Result_Location=? where Photo_Id=?";

		// imgPath1=img1[img1.length-1];
		// imgPath2=img2[img2.length-1];

		// System.out.println(img1[img1.length-1]);

		// File img = new File("images");
		// img=img.getAbsoluteFile();
		// imgPath2=img+imgPath1.substring(2,imgPath2.length());
		imgPath1 = path + "\\images\\photo\\" + img1[img1.length - 1];
		imgPath2 = path + "\\images\\photo\\" + img2[img2.length - 1];
		// System.out.println(imgPath1.substring(2,imgPath1.length()));

		// String[] images = { imgPath1, imgPath2 };
		// System.out.println(imgPath1);
		String result = path + "\\images\\result\\" + img2[img2.length - 1];

		Runtime rn = Runtime.getRuntime();
		Process p = null;
		try {
			p = rn.exec(path + "\\images\\cmp.exe " + imgPath1 + " " + imgPath2
					+ " " + result + " " + thresh);
			// p =
			// p = rn.exec("\"h:/aa.exe\"");
			// p = rn.exec("h:\\bb.exe");
			// p = rn.exec("\"h:/aa.exe\"");
		} catch (Exception e) {
			System.out.println("Error exec AnyQ");
		}
		String result1 = "../images/result/" + img2[img2.length - 1];
		Object[] a = new Object[] { result1, picid };
		// System.out.println(pid+"?"+pname+"?"+plocation
		// +"?"+pdate+"?"+setdate+"?"+sid);
		this.update(sql, a);
	}

	// public static void main(String[] args) throws IOException {
	public void cutarea(int x1, int y1, int x2, int y2, String srcImg,
			String selid) throws IOException {
		CutArea image = new CutArea(x1, y1, x2, y2);
		String path = System.getProperty("user.dir").replace("bin", "webapps")
				+ "\\PTS";
		String img[] = srcImg.split("/");
		srcImg = path + "\\images\\" + img[img.length - 1];
		String cutImg = path + "\\images\\" + "cutImg\\" + selid
				+ img[img.length - 1];
		// srcImg="D:\\Software\\apache-tomcat-6.0.14\\webapps\\PTS"+
		// srcImg.substring(2, srcImg.length());
		// srcImg = "h:/MyEclipse/workspace/PTS/WebRoot"
		// + srcImg.substring(2, srcImg.length());
		// System.out.println(srcImg);
		// srcImg="D:\\Software\\apache-tomcat-6.0.14\\webapps\\PTS\\imgaes\\0000.jpg";
		// cutImg="D:\\Software\\apache-tomcat-6.0.14\\webapps\\PTS\\images\\cutImg\\11.jpg";

		// System.out.println(cutImg);
		// System.out.println(srcImg);

		image.setSrcpath(srcImg);
		image.setSubpath(cutImg);
		// System.out.println("bbb");
		// srcImg="h:/MyEclipse/workspace/PTS/WebRoot/images/0000.jpg";
		image.setLastdir("jpg");
		image.cut();

	}

	private String srcpath;
	private String subpath;
	private String lastdir;
	private int x;
	private int y;
	private int width;
	private int height;

	public void CutArea(int x, int y, int width, int height) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	/**
	 * 对图片裁剪，并把裁剪完的新图片保存 。
	 */
	public void cut() throws IOException {
		FileInputStream is = null;
		ImageInputStream iis = null;
		try {
			// 读取图片文件
			is = new FileInputStream(srcpath);
			Iterator<ImageReader> it = ImageIO
					.getImageReadersByFormatName(lastdir);
			ImageReader reader = it.next();
			// 获取图片流
			iis = ImageIO.createImageInputStream(is);
			reader.setInput(iis, true);
			ImageReadParam param = reader.getDefaultReadParam();
			Rectangle rect = new Rectangle(x, y, width, height);
			param.setSourceRegion(rect);
			BufferedImage bi = reader.read(0, param);

			// 保存新图片
			ImageIO.write(bi, lastdir, new File(subpath));
		} finally {
			if (is != null)
				is.close();
			if (iis != null)
				iis.close();
		}

	}

	public int getHeight() {
		return height;
	}

	public void setHeight(int height) {
		this.height = height;
	}

	public String getSrcpath() {
		return srcpath;
	}

	public void setSrcpath(String srcpath) {
		this.srcpath = srcpath;
	}

	public String getSubpath() {
		return subpath;
	}

	public void setSubpath(String subpath) {
		this.subpath = subpath;
	}

	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	public int getX() {
		return x;
	}

	public void setX(int x) {
		this.x = x;
	}

	public int getY() {
		return y;
	}

	public void setY(int y) {
		this.y = y;
	}

	public String getLastdir() {
		return lastdir;
	}

	public void setLastdir(String lastdir) {
		this.lastdir = lastdir;
	}
}