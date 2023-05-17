package com.ssm.web.action;

import java.util.LinkedList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.SysUser;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.SysUserService;

@Controller
@RequestMapping("/sys")
public class SysUserAction extends BaseAction {
	private String				actionname	= "管理员";
	private String			actionclass	= "SysUser";
	@Autowired
	private SysUserService	service;

	@RequestMapping(value = "/add2SysUser.do")
	public String add2() {
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addSysUser";
	}

	@RequestMapping(value = "/getSysUser.do")
	public String get(int uid) {
		try {
			SysUser bean = service.get(uid);
			request.setAttribute("modifybean", bean);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifySysUser";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteSysUser.do")
	public String delete(String ids) {
		try {
			service.deleteSysUser(ids);
			MessageUtil.addRelMessage(request, "删除信息成功.", "mainquery");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "删除信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/addSysUser.do")
	public String add(SysUser bean) {
		try {
			service.addSysUser(bean);
			MessageUtil.addMessage(request, "添加成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "添加失败.");
			return ERROR;
		}

	}

	@RequestMapping(value = "/updateSysUser.do")
	public String update(SysUser bean) {
		try {
			service.updateSysUser(bean);
			MessageUtil.addMessage(request, "更新成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "更新失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/querySysUser.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, SysUser.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, SysUser.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listSysUser";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
