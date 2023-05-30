package com.as.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.as.dao.LeaveDao;
import com.as.service.LeaveService;

@Service("leaveService")
public class LeaveServiceImpl<T> implements LeaveService<T> {
	
	@Autowired
	private LeaveDao<T> dao;

	@Override
	public List<T> findLeaveList(T t) throws Exception {
		return dao.findLeaveList(t);
	}

	@Override
	public int countLeaveList(T t) throws Exception {
		return dao.countLeaveList(t);
	}

	@Override
	public void addLeave(T t) throws Exception {
		dao.addLeave(t);
	}

	@Override
	public void updateTeacherLeave(T t) throws Exception {
		dao.updateTeacherLeave(t);
	}

	@Override
	public void updateLeaderLeave(T t) throws Exception {
		dao.updateLeaderLeave(t);
	}

	@Override
	public void deleteLeave(T t) throws Exception {
		dao.deleteLeave(t);
	}

	@Override
	public void updateStudentLeave(T t) throws Exception {
		dao.updateStudentLeave(t);
	}

	@Override
	public T findOneLeaveById(int id) throws Exception {
		return dao.findOneLeaveById(id);
	}

}
