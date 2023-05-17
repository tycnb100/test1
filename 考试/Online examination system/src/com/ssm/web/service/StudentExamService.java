package com.ssm.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.Question;
import com.ssm.bean.StudentExam;
import com.ssm.bean.StudentExamQuestion;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.QuestionMapper;
import com.ssm.web.dao.SQLMapper;
import com.ssm.web.dao.StudentExamMapper;
import com.ssm.web.dao.StudentExamQuestionMapper;

@Service
@Transactional
public class StudentExamService extends BaseService<StudentExam> {

	@Autowired
	private StudentExamMapper			studentExamMapper;

	@Autowired
	private StudentExamQuestionMapper	studentExamQuestionMapper;

	@Autowired
	private QuestionMapper				questionMapper;

	@Autowired
	private SQLMapper					sqlMapper;

	public StudentExam updateStudentExam(StudentExam exam, List<StudentExamQuestion> questexamList) {
		studentExamMapper.insert(exam);

		int keguan = 0;
		for (StudentExamQuestion bean : questexamList) {
			Question tempq = questionMapper.selectByPrimaryKey(bean.getQuestionId());
			if (!tempq.getQuesType().equals("简答题") && bean.getCorrect()) {
				keguan += bean.getQuestionScore();
			}
			bean.setExamId(exam.getId());
			studentExamQuestionMapper.insert(bean);
		}
		exam.setKeguan(keguan);
		studentExamMapper.updateByPrimaryKey(exam);

		return exam;
	}

	public Long getScoreCount(Integer uid, int i, int j) {
		return sqlMapper.getScoreCount(uid, i, j);
	}

}
