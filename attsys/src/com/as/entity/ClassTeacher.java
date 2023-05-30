package com.as.entity;

public class ClassTeacher extends BaseEntity{

	private Integer id;      // 主键
	private Dept dept;       // 班级ID
	private User user;       // 教师ID
	private Course course;   // 课程ID
	private String islead;   // 是否班主任
	
	
	public Course getCourse() {
		return course;
	}
	public void setCourse(Course course) {
		this.course = course;
	}
	public String getIslead() {
		return islead;
	}
	public void setIslead(String islead) {
		this.islead = islead;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Dept getDept() {
		return dept;
	}
	public void setDept(Dept dept) {
		this.dept = dept;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
}
