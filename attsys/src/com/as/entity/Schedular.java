package com.as.entity;

public class Schedular extends BaseEntity{

	private Integer id;
	private Dept dept;
	private String week;
	private Period period;
	private ClassTeacher ct;
	
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
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public Period getPeriod() {
		return period;
	}
	public void setPeriod(Period period) {
		this.period = period;
	}
	public ClassTeacher getCt() {
		return ct;
	}
	public void setCt(ClassTeacher ct) {
		this.ct = ct;
	}
	
}
