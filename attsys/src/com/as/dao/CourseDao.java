package com.as.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

import com.as.entity.Course;

@Mapper("courseDao")
public interface CourseDao<T> {

	public List<Course> findCourse(T t);
	
	public int countCourse(T t);
	
	public void addCourse(T t);
	
	public void updateCourse(T t);
	
	public void deleteCourse(T t);
	
}
