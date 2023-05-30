package com.as.service;

import java.util.List;

import com.as.entity.Course;

public interface CourseService<T> {

	public List<Course> findCourse(T t);
	
	public int countCourse(T t);
	
	public void addCourse(T t);
	
	public void updateCourse(T t);
	
	public void deleteCourse(T t);
	
}
