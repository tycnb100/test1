package com.ssm.web.action;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Course;
import com.ssm.bean.CourseClazz;
import com.ssm.bean.SimpleUser;
import com.ssm.bean.SysUser;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MapUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.ClazzService;
import com.ssm.web.service.CourseClazzService;
import com.ssm.web.service.CourseService;
import com.ssm.web.service.SimpleUserService;
import com.ssm.web.service.TeacherService;

@Controller
@RequestMapping("/sys")
public class CourseAction extends BaseAction {
	private String				actionname	= "科目";
	private String				actionclass	= "Course";
	@Autowired
	private CourseService		service;

	@Autowired
	private TeacherService		teacherService;

	@Autowired
	private ClazzService		clazzService;

	@Autowired
	private CourseClazzService	courseClazzService;
	@Autowired
	private SimpleUserService	simpleUserService;

	@RequestMapping(value = "/add2Course.do")
	public String add2() {
		if (getSessionUser() instanceof SysUser) {
			putRequestValue("list", teacherService.selectAll());
		} else {
			List list = new ArrayList();
			list.add(getTeacher());
			putRequestValue("list", list);
		}
		putRequestValue("list1", clazzService.selectAll());
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addCourse";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getCourse.do")
	public String get(int uid) {
		try {
			if (getSessionUser() instanceof SysUser) {
				putRequestValue("list", teacherService.selectAll());
			} else {
				List list = new ArrayList();
				list.add(getTeacher());
				putRequestValue("list", list);
			}
			putRequestValue("list1", clazzService.selectAll());

			Course temp = service.get(uid);
			request.setAttribute("modifybean", temp);

			List<SimpleUser> stuList = new ArrayList<SimpleUser>();
			List<CourseClazz> cslist = courseClazzService.selectAll(CourseClazz.class, MapUtil.createMap("courseId", uid));

			for (CourseClazz courseClazz : cslist) {
				List<SimpleUser> templist = simpleUserService.selectAll(SimpleUser.class, MapUtil.createMap("clazzId", courseClazz.getClazzId()));
				stuList.addAll(templist);
			}
			putRequestValue("stuList", stuList);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyCourse";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteCourse.do")
	public String delete(String ids) {
		try {
			service.deleteAll(ids);
			MessageUtil.addRelMessage(request, "操作成功.", "mainquery");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "操作失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/addCourse.do")
	public String add(Course bean) {
		try {
			service.add(bean);
			MessageUtil.addMessage(request, "添加成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "添加失败.");
			return ERROR;
		}

	}

	@RequestMapping(value = "/updateCourse.do")
	public String update(Course bean) {
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

	@RequestMapping(value = "/queryCourse.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, Course.class, parmnames, parmvalues);

			Page page = service.selectPage(p, Course.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listCourse";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryCourseOfTeacher.do")
	public String queryCourseOfTeacher() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, Course.class, parmnames, parmvalues);

			parmnames.add("teacherId");
			parmvalues.add(getTeacher().getId());

			Page page = service.selectPage(p, Course.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "queryCourseOfTeacher";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryExamCourse.do")
	public String queryExamCourse() {
		try {
			List<Course> list = new ArrayList<Course>();

			List<CourseClazz> cslist = courseClazzService.selectAll(CourseClazz.class, MapUtil.createMap("clazzId", getSimpleUser().getClazzId()));
			for (CourseClazz cs : cslist) {
				list.add(cs.getCourse());
			}
			putRequestValue("list", list);
			return "queryExamCourse";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
