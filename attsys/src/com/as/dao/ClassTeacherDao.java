package com.as.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

@Mapper("classTeacherDao")
public interface ClassTeacherDao<T> {
	
	public List<T> findClassTeacher(T t) throws Exception;
	
	public int countClassTeacher(T t) throws Exception;
	
	public void addClassTeacher(T t) throws Exception;
	
	public void updateClassTeacher(T t) throws Exception;
	
	public void deleteClassTeacher(T t) throws Exception;
	
	public T findOneByLeadTeacher(T t) throws Exception;//查找该人所带班主任的班级

}
