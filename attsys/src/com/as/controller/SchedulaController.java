package com.as.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.as.entity.ClassTeacher;
import com.as.entity.Dept;
import com.as.entity.Period;
import com.as.entity.Schedular;
import com.as.entity.User;
import com.as.service.ClassTeacherService;
import com.as.service.DeptService;
import com.as.service.PeriodService;
import com.as.service.SchedularService;
import com.as.util.WriterUtil;

@RequestMapping("schedular")
@Controller
public class SchedulaController {
	
	@Autowired
	private SchedularService<Schedular> schedularService;
	@Autowired
	private ClassTeacherService<ClassTeacher> ctService;
	@Autowired
	private DeptService<Dept> deptService;
	@Autowired
	private PeriodService<Period> periodService;
	private final static String[] weeks = {"周一","周二","周三","周四","周五"};

	@RequestMapping("index")
	public String index(){
		return "schedular";
	}
	
	
	@RequestMapping("loadOneDeptSchedular")
	public void loadOneDeptSchedular(HttpServletRequest request,HttpServletResponse response){
		String deptid = request.getParameter("deptid");
		if(StringUtils.isEmpty(deptid)){
			deptid = "0";
		}
		Dept d = new Dept();d.setId(Integer.parseInt(deptid));
		
		List<Period> periodList = periodService.findPeriod(new Period());  // 节次
		List<String> l = new ArrayList<String>();
		for(Period period : periodList){
			String string = "";
			for(String week : weeks){
				Schedular s = new Schedular();	
				s.setDept(d);
				s.setPeriod(period);
				s.setWeek(week);
				List<Schedular> list = schedularService.findSchedular(s);
				if(list.size() > 0){
					Schedular schedular = list.get(0);
					string += ("," + schedular.getCt().getUser().getRealName() + "<br/>" + schedular.getCt().getCourse().getName());
				} else {
					string += ",";
				}
			}
			string = string.substring(1);
			l.add(string);
		}
		JSONObject r = new JSONObject();r.put("rows", l);
		r.put("periodList", periodList);
		WriterUtil.write(response, r.toString());
	}
	
	
	
	@RequestMapping("searchIfExist")
	public void searchIfExist(HttpServletResponse response,HttpServletRequest request){
		try {
			String periodid = request.getParameter("periodid");
			String xingqi = request.getParameter("xingqi");
			String deptid = request.getParameter("deptid");
			Schedular searchSchedular = new Schedular();
			Period p = new Period();p.setId(Integer.parseInt(periodid));
			searchSchedular.setPeriod(p);
			searchSchedular.setWeek(xingqi);
			Dept d = new Dept();d.setId(Integer.parseInt(deptid));
			searchSchedular.setDept(d);
			List<Schedular> list = schedularService.findSchedular(searchSchedular);
			JSONObject r = new JSONObject();
			if(list.size() >0){
				r.put("update", true);  // 说明是修改
				r.put("schedular", list.get(0));
			} else {
				r.put("update", false); // 说明是新增
			}
			WriterUtil.write(response, r.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	// 加载该班级的课程和教师
	@RequestMapping("loadCourseByDeptid")
	public void loadCourseByDeptid(HttpServletRequest request,HttpServletResponse response){
		String deptid = request.getParameter("deptid");
		try {
			ClassTeacher ct = new ClassTeacher();
			Dept d = new Dept();
			d.setId(Integer.parseInt(deptid));
			ct.setDept(d);
			List<ClassTeacher> list = ctService.findClassTeacher(ct);
			JSONObject r = new JSONObject();
			r.put("rows", list);
			WriterUtil.write(response, r.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping("reserve")
	public void reserve(Schedular schedular,HttpServletRequest request,HttpServletResponse response){
		JSONObject r = new JSONObject();
		try {
			String id = request.getParameter("id");
			String deptid = request.getParameter("deptid");
			Dept d = new Dept();d.setId(Integer.parseInt(deptid));
			schedular.setDept(d);
			if(StringUtils.isEmpty(id)){
				schedularService.addSchedular(schedular);
			} else {
				schedular.setId(Integer.parseInt(id));
				schedularService.updateSchedular(schedular);
			}
			r.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			r.put("errorMsg", "保存失败");
		}
		WriterUtil.write(response, r.toString());
	}
	
	
	
	@RequestMapping("delete")
	public void delete(HttpServletRequest request,HttpServletResponse response){
		JSONObject r = new JSONObject();
		try {
			String id = request.getParameter("id");
			Schedular s = new Schedular();s.setId(Integer.parseInt(id));
			schedularService.deleteSchedular(s);
			r.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			r.put("errorMsg", "删除失败");
		}
		WriterUtil.write(response, r.toString());
	}
	
	
	
	
	// 教师课表
	@RequestMapping("teacherIndex")
	public String teacherIndex(HttpServletRequest request,HttpServletResponse response){
		return "teacherKebiao";
	}
	
	@RequestMapping("teacherList")
	public void teacherList(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User currentUser = (User)request.getSession().getAttribute("currentUser");
		List<Period> periodList = periodService.findPeriod(new Period());  // 节次
		List<String> l = new ArrayList<String>();  // 班级名称+课程名称
		List<String> dl = new ArrayList<String>();  // 班级ID
		for(Period period : periodList){
			String string = "";
			String deptids = "";
			for(String week : weeks){
				Schedular s = new Schedular();	
				ClassTeacher ct = new ClassTeacher();
				ct.setUser(currentUser);
				s.setCt(ct);
				s.setPeriod(period);
				s.setWeek(week);
				List<Schedular> list = schedularService.findSchedular(s);
				if(list.size() > 0){
					Schedular schedular = list.get(0);
					int deptid = schedular.getDept().getId();
					Dept d = deptService.findOneDeptById(deptService.findOneDeptById(deptid).getPid());
					string += ("," + d.getName()+schedular.getDept().getName() + "<br/>" + schedular.getCt().getCourse().getName());
					deptids+=(","+deptid);
				} else {
					string += ",";
					deptids+=",";
				}
			}
			string = string.substring(1);
			deptids=deptids.substring(1);
			l.add(string);
			dl.add(deptids);
		}
		JSONObject r = new JSONObject();r.put("rows", l);r.put("dl",dl);
		r.put("periodList", periodList);
		WriterUtil.write(response, r.toString());
		
	}
	
	
	
	
	
}
