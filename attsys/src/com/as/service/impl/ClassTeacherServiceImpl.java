package com.as.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.as.dao.ClassTeacherDao;
import com.as.service.ClassTeacherService;

@Service("classTeacherService")
public class ClassTeacherServiceImpl<T> implements ClassTeacherService<T>{

	@Autowired
	private ClassTeacherDao<T> dao;

	@Override
	public List<T> findClassTeacher(T t) throws Exception {
		return dao.findClassTeacher(t);
	}

	@Override
	public int countClassTeacher(T t) throws Exception {
		return dao.countClassTeacher(t);
	}

	@Override
	public void addClassTeacher(T t) throws Exception {
		dao.addClassTeacher(t);
	}

	@Override
	public void updateClassTeacher(T t) throws Exception {
		dao.updateClassTeacher(t);
	}

	@Override
	public void deleteClassTeacher(T t) throws Exception {
		dao.deleteClassTeacher(t);
	}

	@Override
	public T findOneByLeadTeacher(T t) throws Exception {
		return dao.findOneByLeadTeacher(t);
	}
	
}
