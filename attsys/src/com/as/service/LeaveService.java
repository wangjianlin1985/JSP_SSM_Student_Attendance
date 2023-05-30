package com.as.service;

import java.util.List;


public interface LeaveService<T> {

	public List<T> findLeaveList(T t) throws Exception;
	
	public int countLeaveList(T t) throws Exception;
	
	public T findOneLeaveById(int id) throws Exception;
	
	public void addLeave(T t) throws Exception;
	
	public void updateTeacherLeave(T t) throws Exception;
	
	public void updateLeaderLeave(T t) throws Exception;
	
	public void deleteLeave(T t) throws Exception;
	
	public void updateStudentLeave(T t) throws Exception;
}
