package liangw;

public class PicManage {

	// 属性名称与表单元素相同时，可实现自省(即将表单中的参数值自动赋给JavaBean中的同名属性)
	int row, id, photoid;
	// 图片PHOTO表
	String pid, psampleid, pname, plocation, relocation, pdate, prem, fam,
			total, rate = null;
	// String photox, photoy, photowidth, photoheight = null;
	String subid, subname, subplace, subtele, subdevice, subrem = null;

	// 图片特征数据PhotoFeature表
	String pfsampleid, pfid, select, x1, x2, y1, y2, width, height = null;

	// 开关柜表
	int did;
	String deviceid, dsubid, dcard, dname, dplace, drem = null;

	// 采样点表
	String sid, substationid, sdeviceid, sname, splace, stype, srem = null;

	// 图像信息PHOTO,SUBSTATION,SAMPLE,Device表，用于dataManage
	String photosubid, photosubname, photosid, photossubid, photosname,
			photostype, photopsid, photopname, photoplocation, photopdate,
			photoprem = null;
	int photophotoid;

	// 无参数的构造方法
	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public int getPhotoid() {
		return photoid;
	}

	public void setPhotoid(int photoid) {
		this.photoid = photoid;
	}

	public PicManage() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	// 图片PHOTO表
	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public void setPsampleid(String psampleid) {
		this.psampleid = psampleid;
	}

	public String getPsampleid() {
		return psampleid;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getPname() {
		return pname;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getPdate() {
		return pdate;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getPlocation() {
		return plocation;
	}

	public void setPlocation(String plocation) {
		this.plocation = plocation;
	}

	public String getRelocation() {
		return relocation;
	}

	public void setRelocation(String relocation) {
		this.relocation = relocation;
	}

	public String getFam() {
		return fam;
	}

	public void setFam(String fam) {
		this.fam = fam;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getPrem() {
		return prem;
	}

	public void setPrem(String prem) {
		this.prem = prem;
	}

	public String getSubid() {
		return subid;
	}

	public void setSubid(String subid) {
		this.subid = subid;
	}

	public String getSubname() {
		return subname;
	}

	public void setSubname(String subname) {
		this.subname = subname;
	}

	public String getSubplace() {
		return subplace;
	}

	public void setSubplace(String subplace) {
		this.subplace = subplace;
	}

	public String getSubtele() {
		return subtele;
	}

	public void setSubtele(String subtele) {
		this.subtele = subtele;
	}

	public String getSubdevice() {
		return subdevice;
	}

	public void setSubdevice(String subdevice) {
		this.subdevice = subdevice;
	}

	public String getSubrem() {
		return subrem;
	}

	public void setSubrem(String subrem) {
		this.subrem = subrem;
	}

	// 开关柜表
	public int getDid() {
		return did;
	}

	public void setDid(int did) {
		this.did = did;
	}

	public String getDeviceid() {
		return deviceid;
	}

	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}

	public String getDsubid() {
		return dsubid;
	}

	public void setDsubid(String dsubid) {
		this.dsubid = dsubid;
	}

	public String getDcard() {
		return dcard;
	}

	public void setDcard(String dcard) {
		this.dcard = dcard;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getDplace() {
		return dplace;
	}

	public void setDplace(String dplace) {
		this.dplace = dplace;
	}

	public String getDrem() {
		return drem;
	}

	public void setDrem(String drem) {
		this.drem = drem;
	}

	// 采样点
	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getSubstationid() {
		return substationid;
	}

	public void setSubstationid(String substationid) {
		this.substationid = substationid;
	}

	public String getSdeviceid() {
		return sdeviceid;
	}

	public void setSdeviceid(String sdeviceid) {
		this.sdeviceid = sdeviceid;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getSplace() {
		return splace;
	}

	public void setSplace(String splace) {
		this.splace = splace;
	}

	public String getStype() {
		return stype;
	}

	public void setStype(String stype) {
		this.stype = stype;
	}

	public String getPhotosubid() {
		return photosubid;
	}

	public void setPhotosubid(String photosubid) {
		this.photosubid = photosubid;
	}

	public String getPhotosubname() {
		return photosubname;
	}

	public void setPhotosubname(String photosubname) {
		this.photosubname = photosubname;
	}

	public String getPhotosid() {
		return photosid;
	}

	public void setPhotosid(String photosid) {
		this.photosid = photosid;
	}

	public String getPhotossubid() {
		return photossubid;
	}

	public void setPhotossubid(String photossubid) {
		this.photossubid = photossubid;
	}

	public String getPhotosname() {
		return photosname;
	}

	public void setPhotosname(String photosname) {
		this.photosname = photosname;
	}

	public String getPhotostype() {
		return photostype;
	}

	public void setSrem(String srem) {
		this.srem = srem;
	}

	public String getSrem() {
		return srem;
	}

	// PHOTO,SAMPLE,SUBSTATION三表同时查询
	public void setPhotostype(String photostype) {
		this.photostype = photostype;
	}

	public String getPhotopsid() {
		return photopsid;
	}

	public void setPhotopsid(String photopsid) {
		this.photopsid = photopsid;
	}

	public String getPhotopname() {
		return photopname;
	}

	public void setPhotopname(String photopname) {
		this.photopname = photopname;
	}

	public String getPhotoplocation() {
		return photoplocation;
	}

	public void setPhotoplocation(String photoplocation) {
		this.photoplocation = photoplocation;
	}

	public String getPhotopdate() {
		return photopdate;
	}

	public void setPhotopdate(String photopdate) {
		this.photopdate = photopdate;
	}

	public String getPhotoprem() {
		return photoprem;
	}

	public void setPhotoprem(String photoprem) {
		this.photoprem = photoprem;
	}

	public int getPhotophotoid() {
		return photophotoid;
	}

	public void setPhotophotoid(int photophotoid) {
		this.photophotoid = photophotoid;
	}

	// 特征数据表
	public String getPfsampleid() {
		return pfsampleid;
	}

	public void setPfsampleid(String pfsampleid) {
		this.pfsampleid = pfsampleid;
	}

	public String getPfid() {
		return pfid;
	}

	public void setPfid(String pfid) {
		this.pfid = pfid;
	}

	public String getSelect() {
		return select;
	}

	public void setSelect(String select) {
		this.select = select;
	}

	public String getX1() {
		return x1;
	}

	public void setX1(String x1) {
		this.x1 = x1;
	}

	public String getX2() {
		return x2;
	}

	public void setX2(String x2) {
		this.x2 = x2;
	}

	public String getY1() {
		return y1;
	}

	public void setY1(String y1) {
		this.y1 = y1;
	}

	public String getY2() {
		return y2;
	}

	public void setY2(String y2) {
		this.y2 = y2;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

}
