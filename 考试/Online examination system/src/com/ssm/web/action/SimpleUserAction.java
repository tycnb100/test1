package com.ssm.web.action;

import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Clazz;
import com.ssm.bean.SimpleUser;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.ClazzService;
import com.ssm.web.service.SimpleUserService;

@Controller
@RequestMapping("/sys")
public class SimpleUserAction extends BaseAction {
	private String				actionname	= "学生";
	private String				actionclass	= "SimpleUser";
	@Autowired
	private SimpleUserService	service;

	@Autowired
	private ClazzService		clazzService;

	@RequestMapping(value = "/add2SimpleUser.do")
	public String add2() {
		putRequestValue("list", clazzService.selectAll(Clazz.class, "id desc"));
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addSimpleUser";
	}

	@RequestMapping(value = "/getSimpleUser.do")
	public String get(int uid) {
		try {
			putRequestValue("list", clazzService.selectAll(Clazz.class, "id desc"));
			SimpleUser bean = service.get(uid);
			request.setAttribute("modifybean", bean);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifySimpleUser";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteSimpleUser.do")
	public String delete(String ids) {
		try {
			service.deleteSimpleUser(ids);
			MessageUtil.addRelMessage(request, "删除信息成功.", "mainquery");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "删除信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/addSimpleUser.do")
	public String add(SimpleUser bean) {
		try {
			service.addSimpleUser(bean);
			MessageUtil.addMessage(request, "添加成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "添加失败.");
			return ERROR;
		}

	}

	@RequestMapping(value = "/updateSimpleUser.do")
	public String update(SimpleUser bean) {
		try {
			service.updateSimpleUser(bean);
			MessageUtil.addMessage(request, "更新成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "更新失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/querySimpleUser.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, SimpleUser.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, SimpleUser.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listSimpleUser";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
