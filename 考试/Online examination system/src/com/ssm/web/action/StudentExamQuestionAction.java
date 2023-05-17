package com.ssm.web.action;

import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.StudentExamQuestion;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.StudentExamQuestionService;

@Controller
@RequestMapping("/sys")
public class StudentExamQuestionAction extends BaseAction {
	private String						actionname	= "考试题目";
	private String						actionclass	= "StudentExamQuestion";
	@Autowired
	private StudentExamQuestionService	service;

	@RequestMapping(value = "/add2StudentExamQuestion.do")
	public String add2() {
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addStudentExamQuestion";
	}

	@RequestMapping(value = "/getStudentExamQuestion.do")
	public String get(int uid) {
		try {
			StudentExamQuestion temp = service.get(uid);
			request.setAttribute("modifybean", temp);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyStudentExamQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteStudentExamQuestion.do")
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

	@RequestMapping(value = "/addStudentExamQuestion.do")
	public String add(StudentExamQuestion bean) {
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

	@RequestMapping(value = "/updateStudentExamQuestion.do")
	public String update(StudentExamQuestion bean) {
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

	@RequestMapping(value = "/queryStudentExamQuestion.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, StudentExamQuestion.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, StudentExamQuestion.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listStudentExamQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
