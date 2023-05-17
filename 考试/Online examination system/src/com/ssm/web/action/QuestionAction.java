package com.ssm.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Course;
import com.ssm.bean.Question;
import com.ssm.bean.Sensitive;
import com.ssm.bean.Teacher;
import com.ssm.util.Constant;
import com.ssm.util.FieldUtil;
import com.ssm.util.MapUtil;
import com.ssm.util.MessageUtil;
import com.ssm.util.Page;
import com.ssm.util.common.BaseAction;
import com.ssm.util.excel.ExcelUtil;
import com.ssm.web.service.CourseService;
import com.ssm.web.service.QuestionService;
import com.ssm.web.service.SensitiveService;
import com.ssm.web.service.TeacherService;

@Controller
@RequestMapping("/sys")
public class QuestionAction extends BaseAction {
	private String				actionname	= "题目";
	private String				actionclass	= "Question";
	@Autowired
	private QuestionService		service;

	@Autowired
	private CourseService		courseService;

	@Autowired
	private TeacherService		teacherService;

	@Autowired
	private SensitiveService	sensitiveService;

	@RequestMapping(value = "/import2Question.do")
	public String import2Question() {
		putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "import2Question";
	}

	@RequestMapping(value = "/add2Question.do")
	public String add2() {
		putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));
		request.setAttribute("actionname", actionname);
		request.setAttribute("actionclass", actionclass);
		return "addQuestion";
	}

	@RequestMapping(value = "/getQuestion.do")
	public String get(int uid) {
		try {
			putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));
			Question temp = service.get(uid);
			request.setAttribute("modifybean", temp);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);
			return "modifyQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "获取信息失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/importQuestion.do")
	public String importQuestion(int courseId, String excelFile) {
		try {
			InputStream in = new FileInputStream(new File(getResourceFile() + File.separator + excelFile));
			String sheetName = "Sheet1";
			LinkedHashMap<String, String> fieldMap = new LinkedHashMap<String, String>();
			fieldMap.put("题目类型", "quesType");
			fieldMap.put("难度", "userType");
			fieldMap.put("题目", "title");
			fieldMap.put("答案", "answer");
			fieldMap.put("选项A", "option1");
			fieldMap.put("选项B", "option2");
			fieldMap.put("选项C", "option3");
			fieldMap.put("选项D", "option4");

			List<Question> list = ExcelUtil.excelToList(in, sheetName, Question.class, fieldMap, null);
			List<Sensitive> slist = sensitiveService.selectAll();
			for (Question bean : list) {
				String title = bean.getTitle() + "," + bean.getAnswer() + "," + bean.getOption1() + "," + bean.getOption2() + "," + bean.getOption3() + ","
						+ bean.getOption4();
				for (Sensitive s : slist) {
					if (title.contains(s.getWord())) {
						MessageUtil.addMessage(request, "导入失败. 题目中包含敏感词: " + s.getWord());
						return ERROR;
					}
				}

				Teacher user = getTeacher();
				bean.setTeacherId(user.getId());
				setQuestionScore(bean);
				bean.setCourseId(courseId);
				if (bean.getQuesType().equals("单选题") || bean.getQuesType().equals("多选题")) {
					if (StringUtils.isBlank(bean.getOption1()) || StringUtils.isBlank(bean.getOption2()) || StringUtils.isBlank(bean.getOption3())
							|| StringUtils.isBlank(bean.getOption4())) {
						MessageUtil.addMessage(request, "添加失败,选择题必须有4个答案选项");
						return ERROR;
					}

					String ans = bean.getAnswer();
					ans = ans.toLowerCase();
					char[] ary = ans.toCharArray();
					for (char c : ary) {
						if (c < 'a' || c > 'd') {
							MessageUtil.addMessage(request, "添加失败,答案输入有误");
							return ERROR;
						}
					}
					Arrays.sort(ary);
					ans = new String(ary);
					bean.setAnswer(ans);
				}
				if (bean.getQuesType().equals("判断题")) {
					if (!bean.getAnswer().trim().equals("1")) {
						bean.setAnswer("0");
					}
				}
				bean.setZqlv(0d);
			}

			service.addQuesionList(list);

			MessageUtil.addRelMessage(request, "操作成功.", "mainquery");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "操作失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/deleteQuestion.do")
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

	@RequestMapping(value = "/addQuestion.do")
	public String add(Question bean) {
		try {

			List<Sensitive> slist = sensitiveService.selectAll();
			String title = bean.getTitle() + "," + bean.getAnswer() + "," + bean.getOption1() + "," + bean.getOption2() + "," + bean.getOption3() + ","
					+ bean.getOption4();
			for (Sensitive s : slist) {
				if (title.contains(s.getWord())) {
					MessageUtil.addMessage(request, "添加失败. 题目中包含敏感词: " + s.getWord());
					return ERROR;
				}
			}

			Teacher user = getTeacher();
			bean.setTeacherId(user.getId());
			setQuestionScore(bean);
			if (bean.getQuesType().equals("单选题") || bean.getQuesType().equals("多选题")) {
				if (StringUtils.isBlank(bean.getOption1()) || StringUtils.isBlank(bean.getOption2()) || StringUtils.isBlank(bean.getOption3())
						|| StringUtils.isBlank(bean.getOption4())) {
					MessageUtil.addMessage(request, "添加失败,选择题必须有4个答案选项");
					return ERROR;
				}

				String ans = bean.getAnswer();
				ans = ans.toLowerCase();
				char[] ary = ans.toCharArray();
				for (char c : ary) {
					if (c < 'a' || c > 'd') {
						MessageUtil.addMessage(request, "添加失败,答案输入有误");
						return ERROR;
					}
				}
				Arrays.sort(ary);
				ans = new String(ary);
				bean.setAnswer(ans);
			}
			if (bean.getQuesType().equals("判断题")) {
				if (!bean.getAnswer().trim().equals("1")) {
					bean.setAnswer("0");
				}
			}
			bean.setZqlv(0d);
			service.add(bean);
			MessageUtil.addMessage(request, "添加成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "添加失败.");
			return ERROR;
		}

	}

	private static void setQuestionScore(Question q) {
		if ("单选题".equals(q.getQuesType())) {
			q.setScore(Constant.danxuan);
		} else if ("多选题".equals(q.getQuesType())) {
			q.setScore(Constant.duoxuan);
		} else if ("判断题".equals(q.getQuesType())) {
			q.setScore(Constant.panduan);
		} else if ("填空题".equals(q.getQuesType())) {
			q.setScore(Constant.tiankong);
		} else if ("简答题".equals(q.getQuesType())) {
			q.setScore(Constant.jianda);
		}
	}

	@RequestMapping(value = "/updateQuestion.do")
	public String update(Question bean) {
		try {
			List<Sensitive> slist = sensitiveService.selectAll();
			String title = bean.getTitle() + "," + bean.getAnswer() + "," + bean.getOption1() + "," + bean.getOption2() + "," + bean.getOption3() + ","
					+ bean.getOption4();
			for (Sensitive s : slist) {
				if (title.contains(s.getWord())) {
					MessageUtil.addMessage(request, "添加失败. 题目中包含敏感词: " + s.getWord());
					return ERROR;
				}
			}
			Teacher user = getTeacher();
			bean.setTeacherId(user.getId());
			setQuestionScore(bean);
			if (bean.getQuesType().equals("单选题") || bean.getQuesType().equals("多选题")) {
				if (StringUtils.isBlank(bean.getOption1()) || StringUtils.isBlank(bean.getOption2()) || StringUtils.isBlank(bean.getOption3())
						|| StringUtils.isBlank(bean.getOption4())) {
					MessageUtil.addMessage(request, "添加失败,选择题必须有4个答案选项");
					return ERROR;
				}

				String ans = bean.getAnswer();
				ans = ans.toLowerCase();
				char[] ary = ans.toCharArray();
				for (char c : ary) {
					if (c < 'a' || c > 'd') {
						MessageUtil.addMessage(request, "添加失败,答案输入有误");
						return ERROR;
					}
				}
				Arrays.sort(ary);
				ans = new String(ary);
				bean.setAnswer(ans);
			}
			if (bean.getQuesType().equals("判断题")) {
				if (!bean.getAnswer().trim().equals("1")) {
					bean.setAnswer("0");
				}
			}
			service.update(bean);
			MessageUtil.addMessage(request, "更新成功.");
			return SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
			MessageUtil.addMessage(request, "更新失败.");
			return ERROR;
		}
	}

	@RequestMapping(value = "/queryQuestion.do")
	public String query() {
		try {
			// 字段名称集合
			LinkedList<String> parmnames = new LinkedList<String>();
			// 字段值集合
			LinkedList<Object> parmvalues = new LinkedList<Object>();
			Page p = FieldUtil.createPage(request, Question.class, parmnames, parmvalues);

			//			if (parmnames.contains("type")) {
			//				actionname1 = (String) parmvalues.get(parmnames.indexOf("type"));
			//			}

			Page page = service.selectPage(p, Question.class);
			session.setAttribute(Constant.SESSION_PAGE, page);

			request.setAttribute("actionname", actionname);
			request.setAttribute("actionclass", actionclass);

			putRequestValue("list", courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId())));

			return "listQuestion";
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
	}

}
