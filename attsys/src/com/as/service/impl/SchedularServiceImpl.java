package com.as.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.as.dao.SchedularDao;
import com.as.entity.Schedular;
import com.as.service.SchedularService;

@Service("schedularService")
public class SchedularServiceImpl<T> implements SchedularService<T> {

	@Autowired
	private SchedularDao<T> dao;
	
	@Override
	public List<Schedular> findSchedular(T t) {
		return dao.findSchedular(t);
	}

	@Override
	public int countSchedular(T t) {
		return dao.countSchedular(t);
	}

	@Override
	public void addSchedular(T t) {
		dao.addSchedular(t);
	}

	@Override
	public void updateSchedular(T t) {
		dao.updateSchedular(t);
	}

	@Override
	public void deleteSchedular(T t) {
		dao.deleteSchedular(t);
	}

}
