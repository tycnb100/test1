package com.ssm.web.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssm.bean.Course;
import com.ssm.bean.Paper;
import com.ssm.bean.PaperQuestion;
import com.ssm.bean.Question;
import com.ssm.bean.Sensitive;
import com.ssm.bean.SimpleUser;
import com.ssm.bean.StudentExam;
import com.ssm.bean.StudentExamQuestion;
import com.ssm.bean.UserQuestion;
import com.ssm.util.DateUtil;
import com.ssm.util.MapUtil;
import com.ssm.util.common.BaseAction;
import com.ssm.web.service.CourseService;
import com.ssm.web.service.PaperQuestionService;
import com.ssm.web.service.PaperService;
import com.ssm.web.service.QuestionService;
import com.ssm.web.service.SensitiveService;
import com.ssm.web.service.StudentExamQuestionService;
import com.ssm.web.service.StudentExamService;
import com.ssm.web.service.UserQuestionService;

@Controller
@RequestMapping("/sys")
public class ExamAction extends BaseAction {

	@Autowired
	private CourseService				courseService;

	@Autowired
	private PaperService				paperService;

	@Autowired
	private PaperQuestionService		paperQuestionService;

	@Autowired
	private StudentExamService			studentExamService;

	@Autowired
	private StudentExamQuestionService	studentExamQuestionService;
	@Autowired
	private SensitiveService			sensitiveService;
	@Autowired
	private QuestionService				questionService;
	@Autowired
	private UserQuestionService			userQuestionService;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cuoti.do")
	public String cuoti(String ids) {
		Course course = courseService.get(Integer.valueOf(ids));
		putRequestValue("course", course);
		List<Question> list = new ArrayList<Question>();
		List<UserQuestion> selectAll = userQuestionService.selectAll(UserQuestion.class, MapUtil.createMap("userId", getSimpleUser().getId()));
		for (UserQuestion userQuestion : selectAll) {
			if (userQuestion.getQuestion().getCourseId().intValue() == course.getId()) {
				list.add(userQuestion.getQuestion());
			}
		}
		putRequestValue("quesList", list);
		putRequestValue("quesListSize", list.size());

		return "forward:/qiantai/test.jsp";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toLianxi.do")
	public String toLianxi(String ids) {
		Course course = courseService.get(Integer.valueOf(ids));
		putRequestValue("course", course);
		List<Question> quesList = questionService.selectAll(Question.class, MapUtil.createMap("courseId", course.getId()));
		putRequestValue("quesList", quesList);
		putRequestValue("quesListSize", quesList.size());

		return "forward:/qiantai/test.jsp";
	}

	@RequestMapping(value = "/lianxiAns.do")
	public String lianxiAns(String qid, String ans) {
		int id = Integer.valueOf(qid.substring("item_".length()));
		Question q = questionService.get(id);
		boolean cuo = checkAns(ans, q.getAnswer());
		questionService.updateUserAnswer(q, cuo, getSimpleUser());
		return null;
	}

	private boolean checkAns(String userAns, String quesAns) {
		userAns = userAns.trim();
		quesAns = quesAns.trim();
		if (userAns.length() != quesAns.length())
			return false;
		char[] c1 = userAns.toUpperCase().toCharArray();
		char[] c2 = quesAns.toUpperCase().toCharArray();
		Arrays.sort(c1);
		Arrays.sort(c2);
		for (int i = 0; i < c1.length; i++) {
			if (c1[i] != c2[i])
				return false;
		}
		return true;
	}

	@RequestMapping(value = "/anlExamScore.do")
	public String anlExamScore(Integer uid) {
		try {
			List list = courseService.selectAll(Course.class, MapUtil.createMap("teacherId", getTeacher().getId()));
			putRequestValue("list", list);
			if (uid == null) {
				return "anlExamScore";
			}

			Course course = courseService.get(uid);
			putRequestValue("course", course);

			Long count = studentExamService.getScoreCount(uid, 0, 60);
			putRequestValue("count1", count = count == null ? 0 : count);

			count = studentExamService.getScoreCount(uid, 60, 70);
			putRequestValue("count2", count = count == null ? 0 : count);

			count = studentExamService.getScoreCount(uid, 70, 90);
			putRequestValue("count3", count = count == null ? 0 : count);

			count = studentExamService.getScoreCount(uid, 90, 100);
			putRequestValue("count4", count = count == null ? 0 : count);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "anlExamScore";
	}

	@RequestMapping(value = "/finishExam.do")
	public String finishExam(int uid) {
		try {
			Paper paper1 = (Paper) getSessionValue("paper");
			if (paper1 == null) {
				getHttpSession().setAttribute("VoteErrorMessage", "提交答卷失败");
				putRequestValue("closeable", true);
				return "forward:/qiantai/exam.jsp";
			}
			SimpleUser student = getSimpleUser();
			Paper paper = paperService.get(uid);

			StudentExam exam = new StudentExam();
			exam.setAddDate(DateUtil.getCurrentTime());
			exam.setPaperId(paper.getId());
			exam.setFinished("未阅卷");
			exam.setCheckTeacherId(paper.getCourse().getTeacherId());
			exam.setCourseId(paper.getCourseId());
			exam.setStudentId(student.getId());

			List<StudentExamQuestion> questexamList = new ArrayList<StudentExamQuestion>();

			List<PaperQuestion> list = paperQuestionService.selectAll(PaperQuestion.class, MapUtil.createMap("paperId", paper.getId()));
			for (PaperQuestion pques : list) {
				Question ques = pques.getQuestion();
				int score = pques.getQuestionScore();
				StudentExamQuestion temp = new StudentExamQuestion();
				temp.setQuestionId(ques.getId());
				temp.setQuestionScore(score);
				String answer = "";
				boolean correct = false;
				if (ques.getQuesType().equals("单选题")) {
					answer = getHttpServletRequest().getParameter("item_" + ques.getId());
					if (StringUtils.isBlank(answer)) {
						correct = false;
					} else {
						if (answer.trim().toLowerCase().equals(ques.getAnswer())) {
							correct = true;
						}
					}
				} else if (ques.getQuesType().equals("多选题")) {
					String[] tempary = getHttpServletRequest().getParameterValues("item_" + ques.getId());
					if (tempary == null || tempary.length == 0) {
						correct = false;
					} else {
						Arrays.sort(tempary);
						for (String tempa : tempary) {
							answer += tempa;
						}
						if (answer.trim().toLowerCase().equals(ques.getAnswer())) {
							correct = true;
						}
					}
				} else if (ques.getQuesType().equals("判断题")) {
					answer = getHttpServletRequest().getParameter("item_" + ques.getId());
					if (StringUtils.isBlank(answer)) {
						correct = false;
					} else {
						if (answer.trim().toLowerCase().equals(ques.getAnswer())) {
							correct = true;
						}
					}
				} else if (ques.getQuesType().equals("填空题")) {
					answer = getHttpServletRequest().getParameter("item_" + ques.getId());
					if (StringUtils.isBlank(answer)) {
						correct = false;
					} else {
						if (answer.trim().toLowerCase().equals(ques.getAnswer())) {
							correct = true;
						}
					}
				} else if (ques.getQuesType().equals("简答题")) {
					List<Sensitive> slist = sensitiveService.selectAll();
					answer = getHttpServletRequest().getParameter("item_" + ques.getId());
					for (Sensitive s : slist) {
						answer = answer.replaceAll(s.getWord(), "***");
					}

				}
				temp.setAnswer(answer);
				temp.setCorrect(correct);
				questexamList.add(temp);
			} //end for

			StudentExam exam1 = studentExamService.updateStudentExam(exam, questexamList);

			getHttpSession().setAttribute("VoteErrorMessage", "提交答卷完成");
			getHttpSession().removeAttribute("paper");
			getHttpSession().removeAttribute("examstarttime");
			getHttpSession().removeAttribute("examtime");
			getHttpSession().removeAttribute("danxuanlist_exam");
			getHttpSession().removeAttribute("duoxuanlist_exam");
			getHttpSession().removeAttribute("panduanlist_exam");
			getHttpSession().removeAttribute("tiankonglist_exam");
			getHttpSession().removeAttribute("panduanlist_exam");
			putRequestValue("closeable", true);
			return "redirect:/sys/getStudentExamSelf.do?uid=" + exam1.getId();

		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().setAttribute("VoteErrorMessage", "提交答卷失败");
		}
		return "forward:/qiantai/exam.jsp";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/toExam.do")
	public String toExamDo(String ids) {
		try {
			Paper paper = (Paper) getSessionValue("paper");
			if (paper == null) {
				Course course = courseService.get(Integer.valueOf(ids));
				SimpleUser student = getSimpleUser();

				List<Paper> plist = paperService.selectAll(Paper.class, MapUtil.createMap("youxiao", "是", "courseId", course.getId()));
				if (plist.size() <= 0) {
					getHttpSession().setAttribute("VoteErrorMessage", course.getName() + " 科目没有找到考试试卷");
					putRequestValue("closeable", true);
					return "forward:/qiantai/exam.jsp";
				}
				paper = plist.get(0);
				List<?> templist = studentExamService.selectAll(StudentExam.class, MapUtil.createMap("studentId", student.getId(), "paperId", paper.getId()));
				if (templist.size() > 0) {
					getHttpSession().setAttribute("VoteErrorMessage", course.getName() + " 科目试卷提交后不能再重考");
					putRequestValue("closeable", true);
					return "forward:/qiantai/exam.jsp";
				}

				List<PaperQuestion> allqList = paperQuestionService.selectAll(PaperQuestion.class, MapUtil.createMap("paperId", paper.getId()));
				List<Question> danxuanlist = new ArrayList<Question>();
				List<Question> duoxuanlist = new ArrayList<Question>();
				List<Question> panduanlist = new ArrayList<Question>();
				List<Question> tiankonglist = new ArrayList<Question>();
				List<Question> jiandalist = new ArrayList<Question>();
				for (PaperQuestion p : allqList) {
					switch (p.getQuestion().getQuesType()) {
					case "单选题":
						danxuanlist.add(p.getQuestion());
						break;
					case "多选题":
						duoxuanlist.add(p.getQuestion());
						break;
					case "判断题":
						panduanlist.add(p.getQuestion());
						break;
					case "填空题":
						tiankonglist.add(p.getQuestion());
						break;
					case "简答题":
						jiandalist.add(p.getQuestion());
						break;
					}
				}

				putSessionValue("danxuanlist_exam", danxuanlist);
				putSessionValue("duoxuanlist_exam", duoxuanlist);
				putSessionValue("panduanlist_exam", panduanlist);
				putSessionValue("tiankonglist_exam", tiankonglist);
				putSessionValue("jiandalist_exam", jiandalist);
				putSessionValue("paper", paper);
				putSessionValue("examstarttime", new Date().getTime());
				putSessionValue("examtime", paper.getExamTime() * 60);
				log.info("组卷完成");
				return "forward:/qiantai/exam.jsp";

			} else {
				long start = (long) getSessionValue("examstarttime");
				long current = System.currentTimeMillis();
				Long temp = paper.getExamTime() * 60 - ((current - start) / 1000);
				putSessionValue("examtime", temp - 1);
				return "forward:/qiantai/exam.jsp";
			}
		} catch (Exception e) {
			e.printStackTrace();
			putRequestValue("closeable", true);
			getHttpSession().setAttribute("VoteErrorMessage", "试卷生成失败");
		}
		return "forward:/qiantai/exam.jsp";
	}

	@RequestMapping(value = "/flushtime.do")
	public String flushtime() {
		try {
			Paper paper = (Paper) getSessionValue("paper");
			if (paper != null) {
				getHttpServletResponse().getWriter().print("{\"time\":" + 0 + "}");
				getHttpServletResponse().getWriter().flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/getStudentExamSelf.do")
	public String getStudentExamSelf(int uid) {
		try {
			StudentExam temp = studentExamService.get(uid);
			putRequestValue("modifybean", temp);

			List<StudentExamQuestion> allqList = studentExamQuestionService.selectAll(StudentExamQuestion.class, MapUtil.createMap("examId", uid));
			List<StudentExamQuestion> danxuanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> duoxuanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> panduanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> tiankonglist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> jiandalist = new ArrayList<StudentExamQuestion>();
			for (StudentExamQuestion p : allqList) {
				switch (p.getQuestion().getQuesType()) {
				case "单选题":
					danxuanlist.add(p);
					break;
				case "多选题":
					duoxuanlist.add(p);
					break;
				case "判断题":
					panduanlist.add(p);
					break;
				case "填空题":
					tiankonglist.add(p);
					break;
				case "简答题":
					jiandalist.add(p);
					break;
				}
			}

			putRequestValue("danxuanlist", danxuanlist);
			putRequestValue("duoxuanlist", duoxuanlist);
			putRequestValue("panduanlist", panduanlist);
			putRequestValue("tiankonglist", tiankonglist);
			putRequestValue("jiandalist", jiandalist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "forward:/qiantai/studentExamSelf.jsp";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updateStudentExam.do")
	public String updateStudentExam(int uid) {
		try {
			StudentExam temp = studentExamService.get(uid);
			putRequestValue("modifybean", temp);

			List<StudentExamQuestion> jiandalist = studentExamQuestionService.selectAll(StudentExamQuestion.class, MapUtil.createMap("examId", uid));

			int zhuguan = 0;
			for (StudentExamQuestion jianda : jiandalist) {
				if (jianda.getQuestion().getQuesType().equals("简答题")) {
					String answer = getHttpServletRequest().getParameter("item_" + jianda.getId());
					jianda.setJiandascore(Integer.valueOf(answer));
					zhuguan += jianda.getJiandascore();
					studentExamQuestionService.update(jianda);
				}
			}
			temp.setFinished("已阅卷");
			temp.setZhuguan(zhuguan);
			temp.setZong(temp.getKeguan() + temp.getZhuguan());
			studentExamService.update(temp);

			getHttpSession().setAttribute("VoteErrorMessage", "阅卷提交成功");
		} catch (Exception e) {
			e.printStackTrace();
			getHttpSession().setAttribute("VoteErrorMessage", "阅卷提交失败");
		}
		return "redirect:/sys/getStudentExam.do?uid=" + uid;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/getStudentExam.do")
	public String getStudentExam(int uid) {
		try {
			StudentExam temp = studentExamService.get(uid);
			putRequestValue("modifybean", temp);

			List<StudentExamQuestion> allqList = studentExamQuestionService.selectAll(StudentExamQuestion.class, MapUtil.createMap("examId", uid));
			List<StudentExamQuestion> danxuanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> duoxuanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> panduanlist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> tiankonglist = new ArrayList<StudentExamQuestion>();
			List<StudentExamQuestion> jiandalist = new ArrayList<StudentExamQuestion>();
			for (StudentExamQuestion p : allqList) {
				switch (p.getQuestion().getQuesType()) {
				case "单选题":
					danxuanlist.add(p);
					break;
				case "多选题":
					duoxuanlist.add(p);
					break;
				case "判断题":
					panduanlist.add(p);
					break;
				case "填空题":
					tiankonglist.add(p);
					break;
				case "简答题":
					jiandalist.add(p);
					break;
				}
			}
			putRequestValue("danxuanlist", danxuanlist);
			putRequestValue("duoxuanlist", duoxuanlist);
			putRequestValue("panduanlist", panduanlist);
			putRequestValue("tiankonglist", tiankonglist);
			putRequestValue("jiandalist", jiandalist);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "forward:/qiantai/studentExam.jsp";
	}

}
