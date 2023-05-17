package com.ssm.web.action;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Clazz;
import com.ssm.bean.Course;
import com.ssm.bean.CourseClazz;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MapUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.ClazzService;
import com.ssm.web.service.CourseClazzService;
import com.ssm.web.service.CourseService;

@Controller
@RequestMapping("/sys")
public class CourseClazzAction extends BaseAction {
	private String				actionname	= "XXXXXX";
	private String				actionclass	= "CourseClazz";
	@Autowired
	private CourseClazzService	service;
	@Autowired
	private CourseService		courseService;
	@Autowired
	private ClazzService		clazzService;

	@RequestMapping(value = "/add2CourseClazz.do")
	public String add2() {
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addCourseClazz";
	}

	@RequestMapping(value = "/getCourseClazz.do")
	public String get(int uid) {
		try {
			Course course = courseService.get(uid);
			request.setAttribute("modifybean", course);

			List<CourseClazz> list = service.selectAll(CourseClazz.class, MapUtil.createMap("courseId", uid));
			putRequestValue("cclist", list);

			putRequestValue("clist", clazzService.selectAll(Clazz.class, "id desc"));

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyCourseClazz";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/addCourseClazz.do")
	public String add(CourseClazz bean) {
		try {
			List<CourseClazz> list = service.selectAll(CourseClazz.class, MapUtil.createMap("courseId", bean.getCourseId(), "clazzId", bean.getClazzId()));
			if (list.size() > 0) {
				MessageUtil.addMessage(request, "添加失败.已经加入过了");
				return ERROR;
			}
			service.add(bean);
			MessageUtil.addMessage(request, "添加成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "添加失败.");
			return ERROR;
		}

	}

	@RequestMapping(value = "/updateCourseClazz.do")
	public String update(CourseClazz bean) {
		try {
			service.update(bean);
			MessageUtil.addMessage(request, "更新成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "更新失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteCourseClazz.do")
	public String delete(String ids) {
		try {
			service.deleteAll(ids);
			MessageUtil.addMessage(request, "操作成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "操作失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryCourseClazz.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, CourseClazz.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, CourseClazz.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listCourseClazz";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
