package com.as.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.as.dao.AttDao;
import com.as.service.AttService;

@Service("attService")
public class AttServiceImpl<T> implements AttService<T>{
	
	@Autowired
	private AttDao<T> dao;

	@Override
	public List<T> findAtt(T t) {
		return dao.findAtt(t);
	}

	@Override
	public int countAtt(T t) {
		return dao.countAtt(t);
	}

	@Override
	public void addAtt(T t) {
		dao.addAtt(t);
	}

	@Override
	public void updateAttResult(T t) {
		dao.updateAttResult(t);
	}

	@Override
	public List<T> findUnusualAtt(Map t) {
		return dao.findUnusualAtt(t);
	}

	@Override
	public int countUnusualAtt(Map t) {
		return dao.countUnusualAtt(t);
	}

}
