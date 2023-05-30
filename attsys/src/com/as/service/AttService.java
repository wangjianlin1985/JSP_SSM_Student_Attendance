package com.as.service;

import java.util.List;
import java.util.Map;

public interface AttService<T> {

	public List<T> findAtt(T t);
	
	public int countAtt(T t);
	
	public void addAtt(T t);
	
	public void updateAttResult(T t);
	
	public List<T> findUnusualAtt(Map map);
	
	public int countUnusualAtt(Map map);
}
