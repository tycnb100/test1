package com.ssm.web.action;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.ssm.bean.SimpleUser;
import com.ssm.bean.SysUser;
import com.ssm.bean.Teacher;
import com.ssm.util.Constant;
import com.ssm.util.MD5;
import com.ssm.util.MessageUtil;
import com.ssm.util.SessionBean;
import com.ssm.util.StringUtil;
import com.ssm.util.common.BaseAction;
import com.ssm.util.menu.MenuBean;
import com.ssm.util.menu.SubMenu;
import com.ssm.web.service.SimpleUserService;
import com.ssm.web.service.SysUserService;
import com.ssm.web.service.TeacherService;

@Controller
@RequestMapping("/com")
public class LoginAction extends BaseAction {
	@Autowired
	private SysUserService		sysUserService;

	@Autowired
	private SimpleUserService	simpleUserService;
	@Autowired
	private TeacherService		teacherService;

	@RequestMapping(value = "/menu.do")
	@ResponseBody
	public Object menu() {

		int index = 0;

		List<MenuBean> list = new ArrayList<MenuBean>();
		if (getSessionUser() instanceof SysUser) {
			MenuBean m1 = new MenuBean("系统管理");
			m1.addChild(new SubMenu("navtab" + (index++), "班级管理", "navtab", request.getContextPath() + "/sys/queryClazz.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "学生管理", "navtab", request.getContextPath() + "/sys/querySimpleUser.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "教师管理", "navtab", request.getContextPath() + "/sys/queryTeacher.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "科目管理", "navtab", request.getContextPath() + "/sys/queryCourse.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "管理员管理", "navtab", request.getContextPath() + "/sys/querySysUser.do"));
//			m1.addChild(new SubMenu("navtab" + (index++), "敏感词管理", "navtab", request.getContextPath() + "/sys/querySensitive.do"));
			list.add(m1);
		}
		if (getSessionUser() instanceof Teacher) {
			MenuBean m1 = new MenuBean("系统管理");
			m1.addChild(new SubMenu("navtab" + (index++), "我的课程", "navtab", request.getContextPath() + "/sys/queryCourseOfTeacher.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "题目管理", "navtab", request.getContextPath() + "/sys/queryQuestion.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "导入题目", "navtab", request.getContextPath() + "/sys/import2Question.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "试卷管理", "navtab", request.getContextPath() + "/sys/queryPaper.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "阅卷管理", "navtab", request.getContextPath() + "/sys/queryStudentExamAll.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "考试成绩统计", "navtab", request.getContextPath() + "/sys/anlExamScore.do"));
			list.add(m1);

		}
		if (getSessionUser() instanceof SimpleUser) {
			MenuBean m1 = new MenuBean("考试管理");
			m1.addChild(new SubMenu("navtab" + (index++), "我的科目", "navtab", request.getContextPath() + "/sys/queryExamCourse.do"));
			m1.addChild(new SubMenu("navtab" + (index++), "我的考试", "navtab", request.getContextPath() + "/sys/queryStudentExam.do"));
			list.add(m1);
		}
		return list;
	}

	@RequestMapping(value = "/login.do")
	public String login(String username, String password, String loginType, String checkcode) throws Exception {
		log.info(username + " " + password + " " + loginType);
		String errorMessage = "登录失败,请稍候重试";
		try {
			String code = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
			if (code == null) {
				request.getSession(false).invalidate();
				return "redirect:/index.jsp";
			} else {
			}
			checkcode = StringUtil.stringVerification(checkcode);
			do {
				if (!code.toLowerCase().equals(checkcode.toLowerCase())) {
					errorMessage = "验证码错误";
					break;
				}
				username = StringUtil.stringVerification(username).toLowerCase();
				MD5 md = new MD5();
				password = md.getMD5ofStr(password);
				Object bean = sysUserService.login(username, password, loginType);
				if (bean == null) {
					errorMessage = "账号或者密码错误";
					break;
				}

				SessionBean sb = new SessionBean();
				sb.setUser(bean);
				session.setAttribute(Constant.SESSION_BEAN, sb);

				if (loginType.equals(SimpleUser.class.getSimpleName())) {
					return "main";
				}
				return "main";

			} while (false);

		} catch (Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("signErrorMessage", errorMessage);
		return "redirect:/index.jsp";
	}

	@RequestMapping(value = "/reg.do")
	public String add(SimpleUser bean) {
		try {
			SimpleUser temp = simpleUserService.findByUname(bean.getUname());
			if (temp != null) {
				putSessionValue("signErrorMessage", "很遗憾,账号已经被使用.");
			} else {
				bean.setUserGender("男");
				simpleUserService.addSimpleUser(bean);
				putSessionValue("signErrorMessage", "恭喜您! 注册成功.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			putSessionValue("signErrorMessage", "很遗憾,注册失败.");
		}

		return "redirect:/reg.jsp";

	}

	@RequestMapping(value = "/update2Password.do")
	public String toSelf() {
		return "msg/changepassword";
	}

	@RequestMapping(value = "/updateSysUserPassword.do")
	public String updateSysUserPassword(String oldpassword, String password) {
		SysUser user = getSysUser();
		user = sysUserService.get(user.getId());
		MD5 md = new MD5();
		oldpassword = md.getMD5ofStr(oldpassword);

		if (!user.getUserPassword().equals(oldpassword)) {
			MessageUtil.addMessage(request, "旧密码错误.");
			return ERROR;
		}

		password = md.getMD5ofStr(password);
		user.setUserPassword(password);

		sysUserService.updateAll(user);

		MessageUtil.addMessage(request, "修改成功.");
		return SUCCESS;
	}

	@RequestMapping(value = "/updateTeacherPassword.do")
	public String updateTeacherPassword(String oldpassword, String password) {
		Teacher user = getTeacher();
		user = teacherService.get(user.getId());
		MD5 md = new MD5();
		oldpassword = md.getMD5ofStr(oldpassword);

		if (!user.getUserPassword().equals(oldpassword)) {
			MessageUtil.addMessage(request, "旧密码错误.");
			return ERROR;
		}

		password = md.getMD5ofStr(password);
		user.setUserPassword(password);

		teacherService.updateAll(user);

		MessageUtil.addMessage(request, "修改成功.");
		return SUCCESS;
	}

	@RequestMapping(value = "/updateSimpleUserPassword.do")
	public String updateSimpleUserPassword(String oldpassword, String password) {
		SimpleUser user = getSimpleUser();
		user = simpleUserService.get(user.getId());
		MD5 md = new MD5();
		oldpassword = md.getMD5ofStr(oldpassword);

		if (!user.getUserPassword().equals(oldpassword)) {
			MessageUtil.addMessage(request, "旧密码错误.");
			return ERROR;
		}

		password = md.getMD5ofStr(password);
		user.setUserPassword(password);

		simpleUserService.updateAll(user);

		MessageUtil.addMessage(request, "修改成功.");
		return SUCCESS;
	}

	@RequestMapping(value = "/logout.do")
	public String logout() {
		session.invalidate();
		return "redirect:/exit.jsp";
	}

	@RequestMapping(value = "/fileUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public Object image(HttpServletRequest request, HttpSession session, @RequestParam("file") MultipartFile file) throws Exception {

		final String prefix = "resource";

		final String realPath = session.getServletContext().getRealPath(prefix);
		File dir = new File(realPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		// 取得原文件名	
		String originName = file.getOriginalFilename();
		// 取得文件后缀
		String fileExt = originName.substring(originName.lastIndexOf(".") + 1);
		// 按时间戳生成图片文件名
		String picture = new Date().getTime() + "." + fileExt;
		try {
			IOUtils.copy(file.getInputStream(), new FileOutputStream(new File(dir, picture)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		// {'err':'',msg:{'url':'XXX/upload/images/2012/11_11/20121111015039.jpg','localname':'我的头像.jpg','id':'63'}}
		//String json = String.format("{'statusCode':200,'message':'上传成功!','filename':'%s'}", picture);
		JSONObject obj = new JSONObject();
		obj.put("statusCode", 200);
		obj.put("message", "");
		obj.put("filename", picture);
		return obj;
	}
	/**
		<label class="row-label">文件上传</label>
		<div class="row-input">
			<input type="file" data-name="upload" name="upload" data-toggle="webuploader"
				data-options="
		               {
		                   pick: {label: '点击选择文件'},
		                   server: '${ctx}/com/fileUpload.do',
		                   fileNumLimit: 1,
		                   formData: {dir:'upload'},
		                   required: true,
		                   uploaded: '',
		                   basePath: '',
		                   upunit: '个文件',
		                   accept: {
		                       title: '文件',
		                       extensions: 'jpg,png',
		                       mimeTypes: '.jpg,.png'
		                   }
		               }">
		</div>
		<br />
	*/

	/**
		<br />
		<label class="row-label">内容编辑</label>
		<div class="row-input">
			<textarea name="content" id="j_form_content" class="j-content" style="width: 700px;" data-toggle="kindeditor"
				data-items="fontname, fontsize, |, forecolor, hilitecolor, bold, italic, underline, removeformat, |, justifyleft, justifycenter, justifyright, insertorderedlist, insertunorderedlist, |, emoticons, image, link"
				data-minheight="200px">${modifybean.content}</textarea>
		</div>
	*/
}
