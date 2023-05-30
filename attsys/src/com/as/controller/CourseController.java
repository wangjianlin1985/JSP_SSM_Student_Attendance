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
import com.as.entity.Course;
import com.as.service.CourseService;
import com.as.util.WriterUtil;

@RequestMapping("course")
@Controller
public class CourseController {

	@Autowired
	private CourseService<Course> courseService;
	
	// 加载全部的课程
	@RequestMapping("loadAllCourse")
	public void loadAllCourse(HttpServletRequest request,HttpServletResponse response){
		Course course = new Course();
		course.setPage(0);
		course.setRows(999);
		List<Course> list = courseService.findCourse(course);
		JSONArray a = new JSONArray();
		a.addAll(list);
		WriterUtil.write(response, a.toString());
	}
	
	// 进入主页
	@RequestMapping("index")
	public String index(){
		return "course";
	}
	
	// 数据列表
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		int page = Integer.parseInt(request.getParameter("page"));
		int rows = Integer.parseInt(request.getParameter("rows"));
		Course course = new Course();
		course.setPage((page-1)*rows);
		course.setRows(rows);
		course.setName(request.getParameter("name"));
		List<Course> list = courseService.findCourse(course);
		int total = courseService.countCourse(course);
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("total",total );
		jsonObj.put("rows", list);
        WriterUtil.write(response,jsonObj.toString());
	}
	
	
	// 保存
	@RequestMapping("reserveCourse")
	public void reserveCourse(HttpServletRequest request,HttpServletResponse response,Course course){
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		if(StringUtils.isEmpty(id)){
			courseService.addCourse(course);
		} else {
			course.setId(Integer.parseInt(id));
			courseService.updateCourse(course);;
		}
		result.put("success", true);
		WriterUtil.write(response,result.toString());
	}
	
	
	// 删除
	@RequestMapping("deleteCourse")
	public void reserveCourse(HttpServletRequest request,HttpServletResponse response){
		String ids[] = request.getParameter("ids").split(",");
		JSONObject result = new JSONObject();
		for(String id : ids){
			Course c = new Course();
			c.setId(Integer.parseInt(id));
			courseService.deleteCourse(c);
		}
		result.put("success", true);
		WriterUtil.write(response,result.toString());
	}
	
	
	
	
}
