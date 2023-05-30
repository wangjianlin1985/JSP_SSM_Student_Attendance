package com.as.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

@Mapper("leaveDao")
public interface LeaveDao<T> {

	public List<T> findLeaveList(T t) throws Exception;
	
	public int countLeaveList(T t) throws Exception;
	
	public T findOneLeaveById(int id) throws Exception;
	
	public void addLeave(T t) throws Exception;
	
	public void updateTeacherLeave(T t) throws Exception;
	
	public void updateLeaderLeave(T t) throws Exception;
	
	public void deleteLeave(T t) throws Exception;
	
	public void updateStudentLeave(T t) throws Exception;
	
}
