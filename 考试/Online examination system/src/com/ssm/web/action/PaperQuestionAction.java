package com.ssm.web.action;

import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.PaperQuestion;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.PaperQuestionService;

@Controller
@RequestMapping("/sys")
public class PaperQuestionAction extends BaseAction {
	private String					actionname	= "试卷题目";
	private String					actionclass	= "PaperQuestion";
	@Autowired
	private PaperQuestionService	service;

	@RequestMapping(value = "/add2PaperQuestion.do")
	public String add2() {
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addPaperQuestion";
	}

	@RequestMapping(value = "/getPaperQuestion.do")
	public String get(int uid) {
		try {
			PaperQuestion temp = service.get(uid);
			request.setAttribute("modifybean", temp);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyPaperQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deletePaperQuestion.do")
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

	@RequestMapping(value = "/addPaperQuestion.do")
	public String add(PaperQuestion bean) {
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

	@RequestMapping(value = "/updatePaperQuestion.do")
	public String update(PaperQuestion bean) {
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

	@RequestMapping(value = "/queryPaperQuestion.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, PaperQuestion.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, PaperQuestion.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listPaperQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
