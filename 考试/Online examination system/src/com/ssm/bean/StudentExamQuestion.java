package com.ssm.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.ssm.util.FD;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

@Entity
@Table(name = "t_student_exam_question")
@NameStyle(Style.normal)
public class StudentExamQuestion {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer		id;
	@FD("考试")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "examId")
	private StudentExam	exam;
	private Integer		examId;

	@FD("题目")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "questionId")
	private Question	question;
	private Integer		questionId;

	@Column(length = 1000)
	@FD("考生答案")
	private String		answer;
	@FD("是否正确")
	private Boolean		correct;
	//简答题得分
	@FD("简答题得分")
	private Integer		jiandascore;

	//题目的分值
	@FD("题目分值")
	private Integer		questionScore;

	public Integer getId() {
		return id;
	}

	public StudentExam getExam() {
		return exam;
	}

	public Integer getExamId() {
		return examId;
	}

	public Question getQuestion() {
		return question;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public String getAnswer() {
		return answer;
	}

	public Boolean getCorrect() {
		return correct;
	}

	public Integer getJiandascore() {
		return jiandascore;
	}

	public Integer getQuestionScore() {
		return questionScore;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setExam(StudentExam exam) {
		this.exam = exam;
	}

	public void setExamId(Integer examId) {
		this.examId = examId;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public void setCorrect(Boolean correct) {
		this.correct = correct;
	}

	public void setJiandascore(Integer jiandascore) {
		this.jiandascore = jiandascore;
	}

	public void setQuestionScore(Integer questionScore) {
		this.questionScore = questionScore;
	}

}
