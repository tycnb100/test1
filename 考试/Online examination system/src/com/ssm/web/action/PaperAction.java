package com.ssm.web.action;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Course;
import com.ssm.bean.Paper;
import com.ssm.bean.PaperQuestion;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MapUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.CourseService;
import com.ssm.web.service.PaperQuestionService;
import com.ssm.web.service.PaperService;
import com.ssm.web.service.QuestionService;
import com.ssm.web.service.TeacherService;

@Controller
@RequestMapping("/sys")
public class PaperAction extends BaseAction {
	private String					actionname	= "试卷";
	private String					actionclass	= "Paper";
	@Autowired
	private PaperService			service;

	@Autowired
	private QuestionService			questionService;

	@Autowired
	private CourseService			courseService;

	@Autowired
	private TeacherService			teacherService;

	@Autowired
	private PaperQuestionService	paperQuestionService;

	@RequestMapping(value = "/add2Paper.do")
	public String add2() {
		putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addPaper";
	}

	@RequestMapping(value = "/getPaper.do")
	public String get(int uid) {
		try {
			putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));
			Paper temp = service.get(uid);
			request.setAttribute("modifybean", temp);

			putRequestValue("qlist", paperQuestionService.selectAll(PaperQuestion.class, MapUtil.createMap("paperId", uid), "id"));

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyPaper";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deletePaper.do")
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

	@RequestMapping(value = "/addPaper.do")
	public String add(Paper bean, int danxuan, int duoxuan, int panduan, int tiankong, int jianda, int danxuanfen, int duoxuanfen, int panduanfen,
			int tiankongfen, int jiandafen) {
		try {
			List list = service.selectAll(Paper.class, MapUtil.createMap("courseId", bean.getCourseId(), "youxiao", "是"));
			if (list.size() > 0) {
				MessageUtil.addMessage(request, "组卷失败.科目已经有一套有效试卷了");
				return ERROR;
			}

			bean.setTeacherId(getTeacher().getId());
			String ret = service.addPaper(bean, danxuan, duoxuan, panduan, tiankong, jianda, danxuanfen, duoxuanfen, panduanfen, tiankongfen, jiandafen);
			if (ret != null) {
				MessageUtil.addMessage(request, "组卷失败." + ret);
				return ERROR;
			}
			MessageUtil.addMessage(request, "组卷成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "组卷失败." + e.getMessage());
			return ERROR;
		}

	}

	@RequestMapping(value = "/updatePaper.do")
	public String update(Paper bean) {
		try {
			bean.setTeacherId(getTeacher().getId());
			service.update(bean);
			MessageUtil.addMessage(request, "更新成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "更新失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryPaper.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, Paper.class, parmnames, parmvalues);

			parmnames.add("teacherId");
			parmvalues.add(getTeacher().getId());

			Page page = service.selectPage(p, Paper.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "listPaper";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
