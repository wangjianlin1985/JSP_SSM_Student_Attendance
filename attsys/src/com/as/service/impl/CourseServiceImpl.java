package com.as.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import com.as.dao.CourseDao;
import com.as.entity.Course;
import com.as.service.CourseService;

@Service("courseService")
public class CourseServiceImpl<T> implements CourseService<T>{

	@Autowired
	private CourseDao<T> dao;	
	@Override
	public List<Course> findCourse(T t) {
		return dao.findCourse(t);
	}

	@Override
	public int countCourse(T t) {
		return dao.countCourse(t);
	}

	@Override
	public void addCourse(T t) {
		dao.addCourse(t);
	}

	@Override
	public void updateCourse(T t) {
		dao.updateCourse(t);
	}

	@Override
	public void deleteCourse(T t) {
		dao.deleteCourse(t);
	}
	
	

}
