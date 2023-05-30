package com.as.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.as.dao.PeriodDao;
import com.as.entity.Period;
import com.as.service.PeriodService;

@Service("periodService")
public class PeriodServiceImpl<T> implements PeriodService<T> {

	@Autowired
	private PeriodDao<T> dao;
	
	@Override
	public List<Period> findPeriod(T t) {
		return dao.findPeriod(t);
	}

	@Override
	public int countPeriod(T t) {
		return dao.countPeriod(t);
	}

	@Override
	public void addPeriod(T t) {
		dao.addPeriod(t);
	}

	@Override
	public void updatePeriod(T t) {
		dao.updatePeriod(t);
	}

	@Override
	public void deletePeriod(T t) {
		dao.deletePeriod(t);
	}

}
