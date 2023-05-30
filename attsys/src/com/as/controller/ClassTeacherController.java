package com.as.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.as.entity.ClassTeacher;
import com.as.entity.Course;
import com.as.entity.Dept;
import com.as.entity.User;
import com.as.service.ClassTeacherService;
import com.as.util.WriterUtil;


@RequestMapping("ct")
@Controller
public class ClassTeacherController {

	@Autowired
	private ClassTeacherService<ClassTeacher> ctService;
	
	
	@RequestMapping("index")
	public String index(){
		return "classteacher";
	}
	
	@RequestMapping("list")
	public void list(HttpServletRequest request,HttpServletResponse response){
		try {
			String start = request.getParameter("start");  // 关键字搜索
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			ClassTeacher ct = new ClassTeacher();
			ct.setPage((page-1)*rows);
			ct.setRows(rows);
			ct.setStart(start);
			String deptid = request.getParameter("deptid");
			if(StringUtils.isNotEmpty(deptid)){
				Dept d = new Dept();
				d.setId(Integer.parseInt(deptid));
				ct.setDept(d);
			}
			String userid = request.getParameter("userid");
			if(StringUtils.isNotEmpty(userid)){
				User u = new User();
				u.setUserId(Integer.parseInt(userid));
				ct.setUser(u);
			}
			String courseid = request.getParameter("courseid");
			if(StringUtils.isNotEmpty(courseid)){
				Course c = new Course();
				c.setId(Integer.parseInt(courseid));
				ct.setCourse(c);
			}
			List<ClassTeacher> list = ctService.findClassTeacher(ct);
			int total = ctService.countClassTeacher(ct);
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("total",total );
			jsonObj.put("rows", list);
	        WriterUtil.write(response,jsonObj.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("reserve")
	public void reserve(HttpServletRequest request,HttpServletResponse response,ClassTeacher ct){
		JSONObject r = new JSONObject();
		String id = request.getParameter("id");
		try {
			if(StringUtils.isNotEmpty(id)){
				ct.setId(Integer.parseInt(id));
				ctService.updateClassTeacher(ct);
			} else {
				ctService.addClassTeacher(ct);
			}
			r.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			r.put("errorMsg", "保存失败");
		}
		WriterUtil.write(response, r.toString());
	}
	
	
	@RequestMapping("delete")
	public void delete(HttpServletResponse response,HttpServletRequest request){
		JSONObject result = new JSONObject();
		try {
			String ids[] = request.getParameter("ids").split(",");
			for(String id : ids){
				ClassTeacher ct = new ClassTeacher();
				ct.setId(Integer.parseInt(id));
				ctService.deleteClassTeacher(ct);
			}
			result.put("success", true);
			WriterUtil.write(response, result.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
