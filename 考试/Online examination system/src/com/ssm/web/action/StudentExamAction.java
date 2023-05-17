package com.ssm.web.action;

import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.StudentExam;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.StudentExamService;

@Controller
@RequestMapping("/sys")
public class StudentExamAction extends BaseAction {
	private String				actionname	= "考试";
	private String				actionclass	= "StudentExam";
	@Autowired
	private StudentExamService	service;

	@RequestMapping(value = "/add2StudentExam.do")
	public String add2() {
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addStudentExam";
	}



	@RequestMapping(value = "/deleteStudentExam.do")
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

	@RequestMapping(value = "/addStudentExam.do")
	public String add(StudentExam bean) {
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

	//	@RequestMapping(value = "/updateStudentExam.do")
	//	public String update(StudentExam bean) {
	//		try {
	//			service.update(bean);
	//			MessageUtil.addMessage(request, "更新成功.");
	//			return SUCCESS;
	//		} catch (Exception e) {
	//			e.printStackTrace();
	//			MessageUtil.addMessage(request, "更新失败.");
	//			return ERROR;
	//		}
	//	}

	@RequestMapping(value = "/queryStudentExam.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, StudentExam.class, parmnames, parmvalues);

			parmnames.add("studentId");
			parmvalues.add(getSimpleUser().getId());

			Page page = service.selectPage(p, StudentExam.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listStudentExam";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryStudentExamAll.do")
	public String queryStudentExamAll() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, StudentExam.class, parmnames, parmvalues);

			parmnames.add("checkTeacherId");
			parmvalues.add(getTeacher().getId());

			Page page = service.selectPage(p, StudentExam.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "queryStudentExamAll";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
