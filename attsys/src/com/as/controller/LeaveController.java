package com.as.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import java_cup.runtime.virtual_parse_stack;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.as.entity.Leave;
import com.as.entity.User;
import com.as.service.LeaveService;
import com.as.service.UserService;
import com.as.util.PropertiesUtil;
import com.as.util.StringUtil;
import com.as.util.WriterUtil;

@Controller
@RequestMapping("leave")
public class LeaveController {

	@Autowired
	private LeaveService<Leave> leaveService;
	@Autowired
	private UserService<User> userService;
	private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private final static int classLeadRoleID = Integer.parseInt(PropertiesUtil.getProperty("classLeadRoleID"));     // 班主任角色ID
	private final static int APPLYDAY = Integer.parseInt(PropertiesUtil.getProperty("applyday")); //超时天数
	private final static int schoolLeadRoleID = Integer.parseInt(PropertiesUtil.getProperty("schoolLeadRoleID")); //学校领导角色ID
	
	// 学生进入的看到的”我的申请历史的界面“
	@RequestMapping("studentApplyIndex")
	private String studentApplyIndex(){
		return "leaveStudent";
	}
	
	@RequestMapping("studentApplyList")
	public void studentApplyList(HttpServletRequest request,HttpServletResponse response){
		try {
			User student = (User)request.getSession().getAttribute("currentUser");
			Leave leave = new Leave();
			leave.setStudent(student);
			leave.setResult(request.getParameter("result"));
			leave.setStart(request.getParameter("start"));
			leave.setEnd(request.getParameter("end"));
			leave.setType(request.getParameter("type"));
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			leave.setPage((page-1)*rows);
			leave.setRows(rows);
			List<Leave> list = leaveService.findLeaveList(leave);
			int total = leaveService.countLeaveList(leave);
			JSONObject r = new JSONObject();
			r.put("rows", list);
			r.put("total", total);
			WriterUtil.write(response, r.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 待审批列表
	@RequestMapping("myTodoIndex")
	public String myTodoIndex(HttpServletRequest request,HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("currentUser"); // 获得登录用户
		if(user.getRoleId() == classLeadRoleID){  // 说明是班主任
			return "leaveTodoTeacher";
		} else { // 说明是校领导
			return "leaveTodoLeader";
		}
	}
	
	// 班主任看到的待审列表
	@RequestMapping("teacherTodoList")
	public void teacherTodoList(HttpServletRequest request,HttpServletResponse response){
		User teacher = (User)request.getSession().getAttribute("currentUser"); 
		try {
			Leave leave = new Leave();
			leave.setTeacher(teacher);
			leave.setTeacherresult("待审批");
			List<Leave> list = leaveService.findLeaveList(leave);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 班主任审批保存
	/** 班主任同意
	 *      看天数，天数少于3直接OK，多余3，继续审批
	 *  班主任不同意 直接结束    
	 */
	@RequestMapping("updateLeaveTeacher")
	public void updateLeaveTeacher(HttpServletResponse response,HttpServletRequest request){
		JSONObject r = new JSONObject();
		try {
			String id = request.getParameter("id");
			String teacherresult = request.getParameter("teacherresult");
			String applyday = request.getParameter("applyday");
			String teachertime = sdf.format(new Date());
			String teachercommand = request.getParameter("teachercommand");
			
			Leave leave = new Leave();
			leave.setId(Integer.parseInt(id));
			leave.setTeacherresult(teacherresult);
			leave.setTeachertime(teachertime);
			leave.setTeachercommand(teachercommand);
			
			if("不同意".equals(teacherresult)){
				leave.setResult("不同意");
			} else {
				if(Integer.parseInt(applyday) >= APPLYDAY){ // 大于3天
					leave.setResult("审批中");
					
					// 根据学校领导角色ID找到该用户
					User searchUser = new User();
					searchUser.setRoleId(schoolLeadRoleID);
					searchUser.setPage(0);searchUser.setRows(1);
					User leader = userService.findUser(searchUser).get(0); 
					leave.setLeader(leader);
				} else {
					leave.setResult("同意");
				}
			}
			leaveService.updateTeacherLeave(leave);
			r.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			r.put("errorMsg", "保存失败");
		}
		WriterUtil.write(response, r.toString());
	}
	
	
	
	
	// 学校看到的待审列表
	@RequestMapping("leaderTodoList")
	public void leaderTodoList(HttpServletRequest request,	HttpServletResponse response) {
		User leader = (User) request.getSession().getAttribute("currentUser");
		try {
			Leave leave = new Leave();
			leave.setLeader(leader);
			leave.setLeaderresult("待审批");
			List<Leave> list = leaveService.findLeaveList(leave);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
	// 学校领导审批保存
	@RequestMapping("updateLeaveLeader")
	public void updateLeaveLeader(HttpServletResponse response,HttpServletRequest request) {
		JSONObject r = new JSONObject();
		try {
			String id = request.getParameter("id");
			String leaderresult = request.getParameter("leaderresult");
			String leadertime = sdf.format(new Date());
			String leadercommand = request.getParameter("leadercommand");

			Leave leave = new Leave();
			leave.setId(Integer.parseInt(id));
			leave.setLeaderresult(leaderresult);
			leave.setLeadertime(leadertime);
			leave.setLeadercommand(leadercommand);
			leave.setResult(leaderresult);
			leaveService.updateLeaderLeave(leave);
			r.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			r.put("errorMsg", "保存失败");
		}
		WriterUtil.write(response, r.toString());
	}
	
	
	
	
	
	
	
	// 已审批列表
	@RequestMapping("myHisIndex")
	public String myHisIndex(HttpServletRequest request,HttpServletResponse response){
		User user = (User)request.getSession().getAttribute("currentUser"); // 获得登录用户
		if(user.getRoleId() == classLeadRoleID){  // 说明是班主任
			return "leaveHisTeacher";
		} else { // 说明是校领导
			return "leaveHisLeader";
		}
	}
	
	
	// 班主任看到的审批历史列表
	@RequestMapping("teacherHisList")
	public void teacherHisList(HttpServletRequest request,HttpServletResponse response) {
		User teacher = (User) request.getSession().getAttribute("currentUser");
		try {
			Leave leave = new Leave();
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			leave.setTeacher(teacher);
			leave.setPage((page-1)*rows);
			leave.setRows(rows);
			leave.setKeyword(request.getParameter("keyword"));
			leave.setTeacherHis("待审批"); 
			leave.setResult(request.getParameter("result"));
			leave.setStart(request.getParameter("start"));
			leave.setEnd(request.getParameter("end"));
			leave.setType(request.getParameter("type"));
			List<Leave> list = leaveService.findLeaveList(leave);
			int total = leaveService.countLeaveList(leave);
			JSONObject o = new JSONObject();
			o.put("total", total);
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	// 学校领导看到的审批历史列表
	@RequestMapping("leaderHisList")
	public void leaderHisList(HttpServletRequest request,HttpServletResponse response) {
		User leader = (User) request.getSession().getAttribute("currentUser");
		try {
			Leave leave = new Leave();
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			leave.setLeader(leader);
			leave.setPage((page - 1) * rows);
			leave.setRows(rows);
			leave.setKeyword(request.getParameter("keyword"));
			leave.setLeaderHis("待审批");
			leave.setResult(request.getParameter("result"));
			leave.setStart(request.getParameter("start"));
			leave.setEnd(request.getParameter("end"));
			leave.setType(request.getParameter("type"));
			List<Leave> list = leaveService.findLeaveList(leave);
			int total = leaveService.countLeaveList(leave);
			JSONObject o = new JSONObject();
			o.put("total", total);
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	// 新建或者修改审批
	@RequestMapping("addLeave")
	public void addLeave(HttpServletRequest request,HttpServletResponse response,Leave leave){
		String id = request.getParameter("id");
		JSONObject result = new JSONObject();
		String applytime = sdf.format(new Date());
		leave.setApplytime(applytime);
		User student = (User)request.getSession().getAttribute("currentUser");
		leave.setResult("待审批");
		leave.setTeacherresult("待审批");
		try {
			User teacher = userService.findOneDeptLeaderByStudentid(student.getUserId());
			if(StringUtil.isEmpty(id)){
				leave.setStudent(student);
				leave.setTeacher(teacher);
				leaveService.addLeave(leave);
				result.put("success", true);
			} else {
				leave.setId(Integer.parseInt(id));
				leaveService.updateStudentLeave(leave);
				result.put("success", true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("errorMsg", "保存失败");
		}
		WriterUtil.write(response, result.toString());
	}
	
	
	
	// 根据ID加载单个的请假信息
	@RequestMapping("loadOneLeaveById")
	public void loadOneLeaveById(HttpServletRequest request,HttpServletResponse response){
		String id = request.getParameter("id");
		JSONObject r = new JSONObject();
		try {
			Leave leave = leaveService.findOneLeaveById(Integer.parseInt(id));
			r.put("leave", leave);
			WriterUtil.write(response, r.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
}
