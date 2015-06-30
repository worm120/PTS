package liangw;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.action.dataselect;

public class SysManageBean extends dataselect {
	// 参数设置时判断表内有无数据
	public boolean getSrcData(String id) {
		boolean result = false;
		String sql = "select * from Parameter where Substation_ID=?";
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

	// 按条件查找，返回的是list类型的结果集
	public List<SysManage> findBy(String id) {
		try {
			String sql = "select * from Parameter,Substation where Parameter.Substation_ID=Substation.Substation_ID "
					+ "and Parameter.Substation_ID=?";
			List<SysManage> list = new ArrayList<SysManage>();
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				SysManage sysmanage = new SysManage();
				sysmanage.setRow(rs.getRow());
				sysmanage.setId(rs.getString("Para_ID"));
				sysmanage.setSubid(rs.getString("Substation_ID"));
				sysmanage.setName(rs.getString("Substation_Name"));
				sysmanage.setSample(rs.getString("Para_Sample"));
				sysmanage.setCheck(rs.getString("Para_Check"));
				sysmanage.setSave(rs.getString("Para_Save"));
				sysmanage.setPreextem(rs.getString("Para_PreExceed_Tem"));
				sysmanage.setExtem(rs.getString("Para_Exceed_Tem"));
				sysmanage.setPrelowtem(rs.getString("Para_PreLow_Tem"));
				sysmanage.setLowtem(rs.getString("Para_Low_Tem"));
				sysmanage.setPredifftem(rs.getString("Para_PreDiffTemper"));
				sysmanage.setDifftem(rs.getString("Para_DiffTemper"));
				sysmanage.setPreexhum(rs.getString("Para_PreExceed_Hum"));
				sysmanage.setExhum(rs.getString("Para_Exceed_Hum"));
				sysmanage.setPrelowhum(rs.getString("Para_PreLow_Hum"));
				sysmanage.setLowhum(rs.getString("Para_Low_Hum"));
				sysmanage.setConti(rs.getString("Para_Continue"));
				sysmanage.setAbnortem(rs.getString("Para_Abnormal"));
				sysmanage.setAlarmtime(rs.getString("Para_Alarm"));
				sysmanage.setVoice(rs.getString("Para_Voice"));
				sysmanage.setMessage(rs.getString("Para_Message"));
				sysmanage.setPort(rs.getString("Para_Port"));
				sysmanage.setAlarmframe(rs.getString("Para_Alarm_Frame"));
				sysmanage.setPreframe(rs.getString("Para_Abnormal_Frame"));
				sysmanage.setVoiceframe(rs.getString("Para_Voice_Frame"));
				sysmanage.setMessageframe(rs.getString("Para_Message_Frame"));
				sysmanage.setPhotorate(rs.getString("Para_Photo_Rate"));
				sysmanage.setChangetime(rs.getString("Para_Photo_Change_Rate"));
				sysmanage.setRem(rs.getString("rem"));
				list.add(sysmanage);
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

	// 基本参数信息设置更新
	public boolean updateBasicPara(String subid, String sampleTime,
			String checkTime, String saveTime, String preTemper,
			String exceedTemper, String preHum, String exceedHum,
			String picRate, String changeRate, String rem) {
		boolean result = false;
		if (sampleTime.equals(""))
			sampleTime = null;
		if (checkTime.equals(""))
			checkTime = null;
		if (saveTime.equals(""))
			saveTime = null;
		if (preTemper.equals(""))
			preTemper = null;
		if (exceedTemper.equals(""))
			exceedTemper = null;
		if (preHum.equals(""))
			preHum = null;
		if (exceedHum.equals(""))
			exceedHum = null;
		if (picRate.equals(""))
			picRate = null;
		if (changeRate.equals(""))
			changeRate = null;
		String sql = "update Parameter set Para_Sample=?,Para_Check=?,Para_Save=?,Para_PreExceed_Tem=?,Para_Exceed_Tem=?,"
				+ "Para_PreExceed_Hum=?,Para_Exceed_Hum=?,Para_Photo_Rate=?,Para_Photo_Change_Rate=?, rem=? "
				+ "where Substation_ID=?";
		Object[] a = new Object[] { sampleTime, checkTime, saveTime, preTemper,
				exceedTemper, preHum, exceedHum, picRate, changeRate, rem,
				subid };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 插入基本参数信息设置
	public boolean insertBasicPara(String subid, String sampleTime,
			String checkTime, String saveTime, String preTemper,
			String exceedTemper, String preHum, String exceedHum,
			String picRate, String changeRate, String rem) {
		boolean result = false;
		if (sampleTime.equals(""))
			sampleTime = null;
		if (checkTime.equals(""))
			checkTime = null;
		if (saveTime.equals(""))
			saveTime = null;
		if (preTemper.equals(""))
			preTemper = null;
		if (exceedTemper.equals(""))
			exceedTemper = null;
		if (preHum.equals(""))
			preHum = null;
		if (exceedHum.equals(""))
			exceedHum = null;
		if (picRate.equals(""))
			picRate = null;
		if (changeRate.equals(""))
			changeRate = null;
		// System.out.println(subid + "," + sampleTime + "," + checkTime + ","
		// + saveTime + "," + preTemper + "," + exceedTemper + ","
		// + preLowTemper + "," + lowTemper + "," + preDiffTemper + ","
		// + diffTemper + "," + preHumidity + "," + exceedHumidity + ","
		// + preLowHumidity + "," + lowHumidity + "," + timeGap + ","
		// + temperRise + "," + picRate + "," + changeRate + "," + rem);
		String sql = "insert into Parameter(Substation_ID,Para_Sample,Para_Check,Para_Save,Para_PreExceed_Tem,"
				+ "Para_Exceed_Tem,Para_PreExceed_Hum,Para_Exceed_Hum,Para_Photo_Rate,Para_Photo_Change_Rate, rem) "
				+ "values(?,?,?,?,?,?,?,?,?,?)";
		Object[] a = new Object[] { subid, sampleTime, checkTime, saveTime,
				preTemper, exceedTemper, preHum, exceedHum, picRate,
				changeRate, rem };
		result = this.update(sql, a);
		// System.out.println(result);
		this.closeAll();
		return result;
	}

	// 更新报警设置信息
	public boolean updateAlarmSet(String continueTime, String voiceSet,
			String smNum, String port, String alarm, String preAlarm,
			String voice, String sm, String subid) {
		boolean result = false;
		if (continueTime.equals(""))
			continueTime = null;
		if (smNum.equals(""))
			smNum = null;
		if (voiceSet.equals(""))
			voiceSet = null;
		if (port.equals(""))
			port = null;
		String sql = "update Parameter set Para_Alarm=?,Para_Voice=?,Para_Message=?,Para_Port=?,Para_Alarm_Frame=?,"
				+ "Para_Abnormal_Frame=?,Para_Voice_Frame=?,Para_Message_Frame=? where Substation_ID=?";
		Object[] a = new Object[] { continueTime, voiceSet, smNum, port, alarm,
				preAlarm, voice, sm, subid };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 插入报警设置信息
	public boolean insertAlarmSet(String continueTime, String voiceSet,
			String smNum, String port, String alarm, String preAlarm,
			String voice, String sm, String subid) {
		boolean result = false;
		if (continueTime.equals(""))
			continueTime = null;
		if (smNum.equals(""))
			smNum = null;
		if (voiceSet.equals(""))
			voiceSet = null;
		if (port.equals(""))
			port = null;
		String sql = "insert into Parameter (Substation_ID,Para_Alarm,Para_Voice,Para_Message,Para_Port,Para_Alarm_Frame,"
				+ "Para_Abnormal_Frame,Para_Voice_Frame,Para_Message_Frame) values(?,?,?,?,?,?,?,?,?)";
		Object[] a = new Object[] { subid, continueTime, voiceSet, smNum, port,
				alarm, preAlarm, voice, sm };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}

	// 根据用户编号查找其登录密码，返回其值
	public String findSec(String userId) {
		String sql = "select User_Password from aUser where User_ID=?";
		String oldSec = null;
		try {
			Connection conn = this.getCon();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				oldSec = rs.getString(2);
			} else {
				oldSec = null;
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

	// 写入用户设置信息
	public boolean updateUserSet(String newSec, String status, String userId) {
		boolean result = false;
		String sql = "update aUser set User_Password=?,User_Lock=? where User_ID=?";
		Object[] a = new Object[] { newSec, status, userId };
		result = this.update(sql, a);
		this.closeAll();
		return result;
	}
}