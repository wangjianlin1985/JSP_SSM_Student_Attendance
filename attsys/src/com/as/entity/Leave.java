package com.as.entity;

public class Leave extends BaseEntity{

	private Integer id;      // 主键
	private User student;     // 申请学生
	private String applystart;   // 请假开始时间 
	private String applyend;     // 请假结束时间
	private String applytime;    // 申请时间
	private Integer applyday; //天数
	private String type; // 请假类型
	private String reason; // 理由备注
	private User teacher; //审批教师信息
	private String teacherresult; // 教师审批结果
	private String teachertime;     // 教师审批时间
	private String teachercommand;    // 教师审批备注
	private User leader;    // 学校领导信息
	private String leaderresult; // 校领导审批结果
	private String leadertime;     // 校领导审批时间
	private String leadercommand; // 意见
	private String result;    // 总得审批结果（待审批，审批中，通过，不通过）
	private String teacherHis; // 规定：若该值不为空，则在查询的时候视为在查询教师已经审批过的历史列表
	private String leaderHis; // 校领导，同上
	
	
	
	public String getTeacherHis() {
		return teacherHis;
	}
	public void setTeacherHis(String teacherHis) {
		this.teacherHis = teacherHis;
	}
	public String getLeaderHis() {
		return leaderHis;
	}
	public void setLeaderHis(String leaderHis) {
		this.leaderHis = leaderHis;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getStudent() {
		return student;
	}
	public void setStudent(User student) {
		this.student = student;
	}
	public String getApplystart() {
		return applystart;
	}
	public void setApplystart(String applystart) {
		this.applystart = applystart;
	}
	public String getApplyend() {
		return applyend;
	}
	public void setApplyend(String applyend) {
		this.applyend = applyend;
	}
	public String getApplytime() {
		return applytime;
	}
	public void setApplytime(String applytime) {
		this.applytime = applytime;
	}
	public Integer getApplyday() {
		return applyday;
	}
	public void setApplyday(Integer applyday) {
		this.applyday = applyday;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public User getTeacher() {
		return teacher;
	}
	public void setTeacher(User teacher) {
		this.teacher = teacher;
	}
	public String getTeacherresult() {
		return teacherresult;
	}
	public void setTeacherresult(String teacherresult) {
		this.teacherresult = teacherresult;
	}
	public String getTeachertime() {
		return teachertime;
	}
	public void setTeachertime(String teachertime) {
		this.teachertime = teachertime;
	}
	public String getTeachercommand() {
		return teachercommand;
	}
	public void setTeachercommand(String teachercommand) {
		this.teachercommand = teachercommand;
	}
	public User getLeader() {
		return leader;
	}
	public void setLeader(User leader) {
		this.leader = leader;
	}
	public String getLeaderresult() {
		return leaderresult;
	}
	public void setLeaderresult(String leaderresult) {
		this.leaderresult = leaderresult;
	}
	public String getLeadertime() {
		return leadertime;
	}
	public void setLeadertime(String leadertime) {
		this.leadertime = leadertime;
	}
	public String getLeadercommand() {
		return leadercommand;
	}
	public void setLeadercommand(String leadercommand) {
		this.leadercommand = leadercommand;
	}
	
}
