package com.as.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

import com.as.entity.Schedular;

@Mapper("schedularDao")
public interface SchedularDao<T> {
	
	public List<Schedular> findSchedular(T t);
	
	public int countSchedular(T t);
	
	public void addSchedular(T t);
	
	public void updateSchedular(T t);
	
	public void deleteSchedular(T t);
}
