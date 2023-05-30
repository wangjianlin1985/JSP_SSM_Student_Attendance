package com.as.service;

import java.util.List;

import com.as.entity.Period;


public interface PeriodService<T> {
	
	public List<Period> findPeriod(T t);
	
	public int countPeriod(T t);
	
	public void addPeriod(T t);
	
	public void updatePeriod(T t);
	
	public void deletePeriod(T t);
	
}
