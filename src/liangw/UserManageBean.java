package liangw;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.action.dataselect;
import liangw.PicManage;

public class UserManageBean extends dataselect {

	// �������ݿ����û���ɫ��Ϣ
	// public List<UserManage> getRole() {
	// try {
	// List<UserManage> list = new ArrayList<UserManage>();
	// Connection conn = this.getCon();
	// String sql = "select * from Role";
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// ResultSet rs = pstmt.executeQuery();
	// while (rs.next()) {
	// UserManage usermanage = new UserManage();
	// usermanage.setRow(rs.getRow());
	// usermanage.setRoleId(rs.getString("Role_ID"));
	// usermanage.setRoleName(rs.getString("Role_Name"));
	// usermanage.setRoleRem(rs.getString("rem"));
	// list.add(usermanage);
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

	// �����û��������û������ҵ�������Ϊtrue������ʧ�ܣ�����false
	public boolean findUser(String name) {
		String sql = "select * from Users where User_Login=?";
		boolean result = false;
		try {
			Connection conn = this.getCon();
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			} else {
				result = false;
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

	// �����û��������û������ҵ�������Ϊtrue������ʧ�ܣ�����false
	public boolean findUser0(String name, String name0) {
		String sql = "select * from Users where User_Login=? and User_Login !=?";
		boolean result = false;
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, name0);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			} else {
				result = false;
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

	// �������ݿ�����û���Ϣ,���ص���list���͵Ľ����
	public List<UserManage> getUserInfo() {
		try {
			String sql = "select * from Users";
			ResultSet rs = this.query(sql);
			//System.out.println(rs);
			List<UserManage> list = new ArrayList<UserManage>();
			while (rs.next()) {
				UserManage usermanage = new UserManage();
				usermanage.setRow(rs.getRow());
				usermanage.setId(rs.getInt("User_ID"));
				// usermanage.setSubid(rs.getString("Substation_ID"));
				// usermanage.setSubname(rs.getString("Substation_Name"));
				usermanage.setName(rs.getString("User_Name"));
				usermanage.setLogin(rs.getString("User_Login"));
				usermanage.setPwd(rs.getString("User_Password"));
				usermanage.setBegindate(rs.getString("Begin_Date"));
				usermanage.setEnddate(rs.getString("End_Date"));
				usermanage.setRight(rs.getString("User_Right"));
				// usermanage.setRole(rs.getString("Role_Name"));
				usermanage.setLock(rs.getString("User_Lock"));
				usermanage.setRemark(rs.getString("rem"));
				list.add(usermanage);
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

	// д���û������Ϣ,������û�
	public boolean insertAddUser(String name, String loginname, String pwd,
			String lock, String remark) {
		boolean result = false;

		// ��ȡ��ǰ������ʱ��
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());

		String sql = "insert into Users(User_Name,User_Login,User_Password,Begin_Date,"
				+ "User_Lock,rem)values(?,?,?,?,?,?)";
		// System.out.println(name+"?"+loginname+"?"+pwd+"?"+date+"?"+right+"?"+substation+"?"+role+"?"+lock+"?"+remark);

		Object[] a = new Object[] { name, loginname, pwd, date, lock, remark };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// �����û���¼�������û�ID
	public String findUserId(String name) {
		String id = null;
		String sql = "select User_ID from Users where User_Login=?";
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getString("User_ID");
			} else {
				id = null;
			}
			System.out.println(id);
			return id;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return id;
	}

	// д���û�Ȩ����Ϣ
	public boolean insertRight(String id, String subid, String right) {
		boolean result = false;
		String sql = "insert into ACL(User_ID,Substation_ID,User_Right)values(?,?,?)";
		System.out.println(right);

		Object[] a = new Object[] { id, subid, right };
		result = this.update(sql, a);
		System.out.println(result);
		this.closeAll();
		return result;
	}

	// ɾ���û�
	public boolean deleteUser(String ids) {
		String[] id = ids.split(",");
		boolean result = false;
		// insert Users.User_ID into USERID select Users.User_ID from Users,ACL
		// where Users.User_ID=ACL.User_ID delete from Users where Users.User_ID
		// ='20' delete from ACL where ACL.User_ID ='20'

		String sql = "delete from Users where User_ID =? delete from ACL where User_ID =?";
		// String sql1 = "delete from ACL where User_ID =?";
		Connection conn = this.getCon();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			// PreparedStatement pstmt1 = conn.prepareStatement(sql1);
			for (int i = 0; i < id.length; i++) {
				pstmt.setString(1, id[i].trim());
				pstmt.setString(2, id[i].trim());
				// pstmt1.setString(1, id[i].trim());
				pstmt.addBatch();
				// pstmt1.addBatch();
			}
			pstmt.executeBatch(); // ����ִ��
			// pstmt1.executeBatch(); // ����ִ��
			conn.commit();// �ύ����
			result = true;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback(); // ��������ع�
			} catch (SQLException ex) {
			}
		} finally {
			this.closeAll();
		}
		return result;
	}

	// ɾ��ACL���е��û���Ϣ
	// public boolean deleteACL(String ids) {
	// String[] id = ids.split(",");
	// boolean result = false;
	// String sql = "delete from ACL where User_ID =?";
	// Connection conn = this.getCon();
	// PreparedStatement pstmt;
	// try {
	// pstmt = conn.prepareStatement(sql);
	// for (int i = 0; i < id.length; i++) {
	// pstmt.setString(1, id[i].trim());
	// pstmt.addBatch();
	// }
	// pstmt.executeBatch(); // ����ִ��
	// conn.commit();// �ύ����
	// result = true;
	//
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// try {
	// conn.rollback(); // ��������ع�
	// } catch (SQLException ex) {
	// }
	// } finally {
	// this.closeAll();
	// }
	// return result;
	// }

	// �����û���Ϣ
	public boolean updateAddUser(String name, String loginname, String pwd,
			String begintime, String right, String lock, String remark) {
		boolean result = false;
		String sql = "update Users set User_Name=?, User_Login=?, User_Password=?, Begin_Date=?, User_Right=?,"
				+ "User_Lock=?, rem=?";

		// String ddate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
		// .format(Calendar.getInstance().getTime());
		// System.out.println(ddate);

		Object[] a = new Object[] { name, loginname, pwd, begintime, right,
				lock, remark };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// // �鿴�û�Ȩ����Ϣ
	// public String findRight(String userId) {
	// String sql = "select User_Right from Users where User_ID=?";
	// String right = null;
	// try {
	// Connection conn = this.getCon();
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// pstmt.setString(1, userId);
	// ResultSet rs = pstmt.executeQuery();
	// if (rs.next()) {
	// right = rs.getString("User_Right");
	// }
	// return right;
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally {
	// this.closeAll();
	// }
	// return right;
	// }

	// // �鿴�û�Ȩ����Ϣ,�����û�ID������Ȩ��
	// public List<UserManage> findRight(String userId) {
	// String sql =
	// "select * from ACL,Substation where User_ID=? and ACL.Substation_ID=Substation.Substation_ID";
	// // System.out.println(userId);
	// try {
	// Connection conn = this.getCon();
	// PreparedStatement pstmt = conn.prepareStatement(sql);
	// pstmt.setString(1, userId);
	// ResultSet rs = pstmt.executeQuery();
	// // ResultSet rs = this.query(sql);
	// List<UserManage> list = new ArrayList<UserManage>();
	// while (rs.next()) {
	// UserManage usermanage = new UserManage();
	// usermanage.setRight(rs.getString("User_Right"));
	// usermanage.setSubname(rs.getString("Substation_Name"));
	// usermanage.setSubid(rs.getString("Substation_ID"));
	// list.add(usermanage);
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

	// �鿴�û�Ȩ����Ϣ,�����û�ID������Ȩ��
	public List<UserManage> findRight(String userId) {
		String sql = "select * from ACL,Substation where User_ID=? and Substation.Substation_ID=ACL.Substation_ID";
		// System.out.println(userId);
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			// ResultSet rs = this.query(sql);
			List<UserManage> list = new ArrayList<UserManage>();
			while (rs.next()) {
				UserManage usermanage = new UserManage();
				usermanage.setRight(rs.getString("User_Right"));
				usermanage.setSubid(rs.getString("Substation_ID"));
				usermanage.setSubname(rs.getString("Substation_Name"));
				list.add(usermanage);
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

	// �޸�/�����û�Ȩ����Ϣ
	public boolean changeRight(String right, String id, String subid) {
		// System.out.println(right+"/"+id+"/"+subid);
		boolean result = false;
		String sql = "update ACL set User_Right=? where User_ID=? and Substation_ID=?";
		try {
			Object[] a = new Object[] { right, id, subid };
			result = this.update(sql, a);
			this.closeAll();
			return result;
		} finally {
			this.closeAll();
		}
	}

	// �������б�������Ƴ�ȥACL�ж�ӦUSERID���еģ���������ֵ
	public List<PicManage> getSubstation(String userid) {
		try {
			List<PicManage> list = new ArrayList<PicManage>();
			Connection conn = this.getCon();
			// System.out.println(userid);
			String sql = "select * from Substation where Substation_ID not in (select Substation_ID from ACL "
					+ "where User_ID=?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
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

	// �������б�������Ʋ�������ֵ
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

	// ����û�Ȩ����Ϣ
	public boolean addRight(String userid, String subid, String right) {
		boolean result = false;
		String sql = "insert into ACL(User_ID,Substation_ID,User_Right) values(?,?,?)";
		try {
			Object[] a = new Object[] { userid, subid, right };
			result = this.update(sql, a);
			this.closeAll();
			return result;
		} finally {
			this.closeAll();
		}
	}

	// �����û���Ų����û���Ϣ
	public List<UserManage> findUserInfo(int id) {
		String sql = "select * from Users where User_ID=?";
		int userid;
		String username, userlogin, userpwd, begindate, enddate, rem = null;
		try {
			List<UserManage> list = new ArrayList<UserManage>();
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				UserManage usermanage = new UserManage();
				userid = rs.getInt("User_ID");
				username = rs.getString("User_Name");
				userlogin = rs.getString("User_Login");
				userpwd = rs.getString("User_Password");
				begindate = rs.getString("Begin_Date");
				enddate = rs.getString("End_Date");
				// userlock = rs.getString("User_Lock");
				// System.out.println(userlock);
				rem = rs.getString("rem");
				if (username == null)
					username = "";
				if (userlogin == null)
					userlogin = "";
				if (userpwd == null)
					userpwd = "";
				if (begindate == null)
					begindate = "";
				if (enddate == null)
					enddate = "";
				if (rem == null)
					rem = "";
				usermanage.setId(userid);
				usermanage.setLogin(userlogin);
				usermanage.setName(username);
				usermanage.setPwd(userpwd);
				usermanage.setBegindate(begindate);
				usermanage.setEnddate(enddate);
				usermanage.setLock(rs.getString("User_Lock"));
				usermanage.setRemark(rem);

				// usermanage.setPwd(rs.getString("User_Password"));
				// usermanage.setBegindate(rs.getString("Begin_Date"));
				// usermanage.setEnddate(rs.getString("End_Date"));
				// usermanage.setSubid(rs.getString("Substation_ID"));
				// usermanage.setSubname(rs.getString("Substation_Name"));
				// usermanage.setRight(rs.getString("User_Right"));
				// usermanage.setLock(rs.getString("User_Lock"));
				// usermanage.setRemark(rs.getString("rem"));
				list.add(usermanage);
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

	// �����û���Ų������¼���룬������ֵ
	public String findPwd(String userId) {
		String sql = "select User_Password from Users where User_ID=?";
		String oldSec = null;
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				oldSec = rs.getString("User_Password");
			}
			return oldSec;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			this.closeAll();
		}
		return oldSec;
	}

	// �����û���ʹ��
	public boolean endUserInfo(String id) {
		boolean result = false;

		// ��ȡ��ǰ������ʱ��
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
				.format(Calendar.getInstance().getTime());
		String sql = "update Users set End_Date=?, User_Lock='0' where User_ID=?";
		Object[] a = new Object[] { date, id };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// �޸��û���Ϣ
	public boolean changeUserInfo(String userid, String name, String clogin,
			String newpwd, String status, String remark) {
		boolean result = false;
		// System.out.println(name + "," + clogin + "," + newpwd + "," + status
		// + "," + "," + userid);
		String sql = "update Users set User_Name=? ,User_Login=?, User_Password=? , User_Lock=?, rem=? "
				+ "where User_ID=?";
		try {
			Object[] a = new Object[] { name, clogin, newpwd, status, remark,
					userid };
			result = this.update(sql, a);
			this.closeAll();
			return result;
		} finally {
			this.closeAll();
		}
	}

	// �޸��û���Ϣ������������
	public boolean changeUserInfoNopwd(String userid, String name,
			String clogin, String status, String remark) {
		boolean result = false;
		String sql = "update Users set User_Name=? ,User_Login=?, User_Lock=?,rem=? "
				+ "where User_ID=?";
		try {
			Object[] a = new Object[] { name, clogin, status, remark, userid };
			result = this.update(sql, a);
			this.closeAll();
			return result;
		} finally {
			this.closeAll();
		}
	}
}