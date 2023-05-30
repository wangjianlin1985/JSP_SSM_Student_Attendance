package com.as.service;

import java.util.List;

import com.as.entity.Schedular;


public interface SchedularService<T> {

	public List<Schedular> findSchedular(T t);
	
	public int countSchedular(T t);
	
	public void addSchedular(T t);
	
	public void updateSchedular(T t);
	
	public void deleteSchedular(T t);
	
}
