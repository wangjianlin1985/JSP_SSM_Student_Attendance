package com.as.controller;

import java.awt.Font;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.general.DefaultPieDataset;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.as.entity.Att;
import com.as.entity.Dept;
import com.as.service.AttService;
import com.as.service.DeptService;
import com.as.util.PropertiesUtil;
import com.as.util.WriterUtil;

@Controller
@RequestMapping("stats")
public class AttstatsController {

	@Autowired
	private AttService<Att> attService;
	@Autowired
	private DeptService<Dept> deptService;
	private static String[] attresults = { "正常", "迟到", "早退", "旷课", "请假" };
	private List<Dept> listAll;
	private final static int classdept = Integer.parseInt(PropertiesUtil
			.getProperty("classdept")); // 顶级的班级ID

	// 查询异常列表，如早退超过10次等等。
	@RequestMapping("unusualAttIndex")
	public String unusualAttIndex() {
		return "attunusual";
	}

	@RequestMapping("unusualAttList")
	public void unusualAttList(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			Map map = new HashMap();
			String keyword = request.getParameter("keyword");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			String result = request.getParameter("result");
			map.put("keyword", keyword);
			String total = request.getParameter("total");
			int t = 3;
			if (StringUtils.isNotEmpty(total)) {
				t = Integer.parseInt(total);
			}
			map.put("total", t);
			map.put("start", start);
			map.put("end", end);
			map.put("page", (page - 1) * rows);
			map.put("rows", rows);
			map.put("result", result);
			List<Att> list = attService.findUnusualAtt(map);
			int z = attService.countUnusualAtt(map);
			JSONObject o = new JSONObject();
			o.put("rows", list);
			o.put("total", z);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 查询各班级各状态考勤数量。
	@RequestMapping("deptAttIndex")
	public String deptAttIndex() {
		return "attDept";
	}

	@RequestMapping("deptAttList")
	public void deptAttList(HttpServletRequest request,HttpServletResponse response) {
		try {
			String start = request.getParameter("start");
			String end = request.getParameter("end");

			List<Map> list = new ArrayList<Map>();

			// 获取部门ID并将所有其所有子部门ID查询出来
			String deptid = request.getParameter("deptid");
			if (StringUtils.isEmpty(deptid)) {
				deptid = classdept + ""; // 若为空，则默认查询全部学生
			}
			listAll = new ArrayList<Dept>();
			listAll.add(deptService.findOneDeptById(Integer.parseInt(deptid)));
			getDept(Integer.parseInt(deptid));

			Att att = new Att();
			att.setStart(start);
			att.setEnd(end);
			
			for (String result : attresults) {
				att.setResult(result);
				int count = 0;
				for(Dept dept : listAll){
					att.setDept(dept);
					count += attService.countAtt(att);					
				}
				Map map = new HashMap();
				map.put("result", result);
				map.put("total", count); // 该班各考勤状态下的人数
				list.add(map);
			}
			JSONObject o = new JSONObject();
			o.put("rows", list);
			WriterUtil.write(response, o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * // 饼状图
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping("deptAttPie")
	public void deptAttPie(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			String start = request.getParameter("start");
			String end = request.getParameter("end");

			// 获取部门ID并将所有其所有子部门ID查询出来
			String deptid = request.getParameter("deptid");
			if (StringUtils.isEmpty(deptid)) {
				deptid = classdept + ""; // 若为空，则默认查询全部学生
			}
			listAll = new ArrayList<Dept>();
			listAll.add(deptService.findOneDeptById(Integer.parseInt(deptid)));
			getDept(Integer.parseInt(deptid));

			Att att = new Att();
			att.setStart(start);
			att.setEnd(end);

			DefaultPieDataset dateset = new DefaultPieDataset();
			/**
			 * 双循环 查询各个状态下每个班的人数总和
			 */
			for (String result : attresults) {
				int count = 0;
				att.setResult(result);
				for (Dept dept : listAll) {
					att.setDept(dept);
					count += attService.countAtt(att);
				}
				dateset.setValue(result, count); // 组建饼状图数据
			}
			// 创建图
			JFreeChart chart = ChartFactory.createPieChart("班级考勤统计图", dateset,
					true, true, true);
			// 副标题
			String subtitle = "";
			if (StringUtils.isNotEmpty(start)) {
				subtitle += "从" + start;
			}
			if (StringUtils.isNotEmpty(end)) {
				subtitle += "到" + end;
			}
			chart.getTitle().setFont(new Font("宋体", Font.BOLD, 12));
			chart.addSubtitle(new TextTitle(subtitle));

			PiePlot piePlot = (PiePlot) chart.getPlot();
			// 设置字体大小等
			piePlot.setLabelFont(new Font("宋体", Font.BOLD, 11));
			chart.getLegend().setItemFont(new Font("宋体", Font.BOLD, 10));
			piePlot.setCircular(true); // true圆，flase椭圆
			piePlot.setNoDataMessage("无数据显示");
			StandardPieSectionLabelGenerator standerPieIG = new StandardPieSectionLabelGenerator(
					"{0}:({1},{2})", NumberFormat.getNumberInstance(),
					NumberFormat.getPercentInstance());
			piePlot.setLabelGenerator(standerPieIG);
			ChartUtilities.writeChartAsPNG(response.getOutputStream(), chart,
					500, 300); // 500,300是长和宽

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Dept> getDept(int pid) throws Exception {
		Dept d = new Dept();
		d.setPid(pid);
		List<Dept> list = deptService.findDeptByPid(d);
		listAll.addAll(list);
		for (Dept d2 : list) {
			getDept(d2.getId());
		}
		return listAll;
	}

}
