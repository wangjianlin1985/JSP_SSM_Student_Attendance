package com.as.service;

import java.util.List;


public interface ClassTeacherService<T> {

	
	public List<T> findClassTeacher(T t) throws Exception;
	
	public int countClassTeacher(T t) throws Exception;
	
	public void addClassTeacher(T t) throws Exception;
	
	public void updateClassTeacher(T t) throws Exception;
	
	public void deleteClassTeacher(T t) throws Exception;
	
	public T findOneByLeadTeacher(T t) throws Exception;//查找该人所带班主任的班级

	
}
