package liangw;

public class SysManage {

	// 属性名称与表单元素相同时，可实现自省(即将表单中的参数值自动赋给JavaBean中的同名属性)
	String preextem, extem, prelowtem, lowtem, predifftem, difftem, preexhum,
			exhum, prelowhum, lowhum, abnortem;
	String id, sample, check, save, conti, alarmtime, photorate, changetime;
	String subid, name, voice, message, port, alarmframe, preframe, voiceframe,
			messageframe, rem = null;
	int row;

	// 无参数的构造方法
	public SysManage() {
	}

	public void setCheck(String check) {
		this.check = check;
	}

	public String getCheck() {
		return check;
	}

	public void setSave(String save) {
		this.save = save;
	}

	public String getSave() {
		return save;
	}

	public void setConti(String conti) {
		this.conti = conti;
	}

	public String getConti() {
		return conti;
	}

	public void setAlarmtime(String alarmtime) {
		this.alarmtime = alarmtime;
	}

	public String getAlarmtime() {
		return alarmtime;
	}

	public void setPhotorate(String photorate) {
		this.photorate = photorate;
	}

	public String getPhotorate() {
		return photorate;
	}

	public void setChangetime(String changetime) {
		this.changetime = changetime;
	}

	public String getChangetime() {
		return changetime;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSample() {
		return sample;
	}

	public void setSample(String sample) {
		this.sample = sample;
	}

	public String getPreextem() {
		return preextem;
	}

	public void setPreextem(String preextem) {
		this.preextem = preextem;
	}

	public String getExtem() {
		return extem;
	}

	public void setExtem(String extem) {
		this.extem = extem;
	}

	public String getPrelowtem() {
		return prelowtem;
	}

	public void setPrelowtem(String prelowtem) {
		this.prelowtem = prelowtem;
	}

	public String getLowtem() {
		return lowtem;
	}

	public void setLowtem(String lowtem) {
		this.lowtem = lowtem;
	}

	public String getPredifftem() {
		return predifftem;
	}

	public void setPredifftem(String predifftem) {
		this.predifftem = predifftem;
	}

	public String getDifftem() {
		return difftem;
	}

	public void setDifftem(String difftem) {
		this.difftem = difftem;
	}

	public String getPreexhum() {
		return preexhum;
	}

	public void setPreexhum(String preexhum) {
		this.preexhum = preexhum;
	}

	public String getExhum() {
		return exhum;
	}

	public void setExhum(String exhum) {
		this.exhum = exhum;
	}

	public String getPrelowhum() {
		return prelowhum;
	}

	public void setPrelowhum(String prelowhum) {
		this.prelowhum = prelowhum;
	}

	public String getLowhum() {
		return lowhum;
	}

	public void setLowhum(String lowhum) {
		this.lowhum = lowhum;
	}

	public String getAbnortem() {
		return abnortem;
	}

	public void setAbnortem(String abnortem) {
		this.abnortem = abnortem;
	}

	public String getSubid() {
		return subid;
	}

	public void setSubid(String subid) {
		this.subid = subid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getVoice() {
		return voice;
	}

	public void setVoice(String voice) {
		this.voice = voice;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getAlarmframe() {
		return alarmframe;
	}

	public void setAlarmframe(String alarmframe) {
		this.alarmframe = alarmframe;
	}

	public String getPreframe() {
		return preframe;
	}

	public void setPreframe(String preframe) {
		this.preframe = preframe;
	}

	public String getVoiceframe() {
		return voiceframe;
	}

	public void setVoiceframe(String voiceframe) {
		this.voiceframe = voiceframe;
	}

	public String getMessageframe() {
		return messageframe;
	}

	public void setMessageframe(String messageframe) {
		this.messageframe = messageframe;
	}

	public String getRem() {
		return rem;
	}

	public void setRem(String rem) {
		this.rem = rem;
	}
}
