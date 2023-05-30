package com.as.dao;

import java.util.List;

import org.mybatis.spring.annotation.Mapper;

import com.as.entity.Period;

@Mapper("PeriodDao")
public interface PeriodDao<T> {
	
	public List<Period> findPeriod(T t);
	
	public int countPeriod(T t);
	
	public void addPeriod(T t);
	
	public void updatePeriod(T t);
	
	public void deletePeriod(T t);
}
