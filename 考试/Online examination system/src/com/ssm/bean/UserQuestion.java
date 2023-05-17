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

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

@Entity
@Table(name = "t_user_question")
@NameStyle(Style.normal)
public class UserQuestion {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer		id;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "userId")
	private SimpleUser	user;
	private Integer		userId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "questionId")
	private Question	question;
	private Integer		questionId;

	public Integer getId() {
		return id;
	}

	public SimpleUser getUser() {
		return user;
	}

	public Integer getUserId() {
		return userId;
	}

	public Question getQuestion() {
		return question;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setUser(SimpleUser user) {
		this.user = user;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
	}

}
