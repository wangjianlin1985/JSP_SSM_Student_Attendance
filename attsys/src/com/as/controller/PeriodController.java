package com.as.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.as.entity.Period;
import com.as.service.PeriodService;
import com.as.util.WriterUtil;

@RequestMapping("period")
@Controller
public class PeriodController {

	@Autowired
	private PeriodService<Period> periodService;
	
	
	@RequestMapping("loadAllPeriod")
	public void loadAllPeriod(HttpServletRequest request,HttpServletResponse response){
		Period period = new Period();
		period.setPage(0);
		period.setRows(999);
		List<Period> list = periodService.findPeriod(period);
		JSONArray a = new JSONArray();
		a.addAll(list);
		WriterUtil.write(response, a.toString());
	}
	
	
	@RequestMapping("index")
	public String index(){
		return "period";
	}
	
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		Period period = new Period();
		period.setPage((page-1)*rows);
		period.setRows(rows);
		List<Period> list = periodService.findPeriod(period);
		int total = periodService.countPeriod(period);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total",total );
		jsonObj.put("rows", list);
        WriterUtil.write(response,jsonObj.toString());
	}
	
	
	@RequestMapping("reservePeriod")
	public void reservePeriod(HttpServletRequest request,HttpServletResponse response,Period period){
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		if(StringUtils.isEmpty(id)){
			periodService.addPeriod(period);
		} else {
			period.setId(Integer.parseInt(id));
			periodService.updatePeriod(period);;
		}
		result.put("success", true);
		WriterUtil.write(response,result.toString());
	}
	
	
	
	@RequestMapping("deletePeriod")
	public void reservePeriod(HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameter("ids").split(",");
		JSONObject result = new JSONObject();
		for(String id : ids){
			Period c = new Period();
			c.setId(Integer.parseInt(id));
			periodService.deletePeriod(c);
		}
		result.put("success", true);
		WriterUtil.write(response,result.toString());
	}
	
	
	
	
}
