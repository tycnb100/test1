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
@Table(name = "t_paper_question")
@NameStyle(Style.normal)
public class PaperQuestion {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer		id;
	@FD("试卷")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "paperId")
	private Paper		paper;
	private Integer		paperId;

	@FD("题目")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "questionId")
	private Question	question;
	private Integer		questionId;
	@FD("分值")
	private Integer		questionScore;

	public Integer getId() {
		return id;
	}

	public Paper getPaper() {
		return paper;
	}

	public Integer getPaperId() {
		return paperId;
	}

	public Question getQuestion() {
		return question;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public Integer getQuestionScore() {
		return questionScore;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}

	public void setPaperId(Integer paperId) {
		this.paperId = paperId;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

	public void setQuestionScore(Integer questionScore) {
		this.questionScore = questionScore;
	}

}
