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
@Table(name = "t_question")
@NameStyle(Style.normal)
public class Question {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer	id;
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "courseId")
	@FD("科目")
	private Course	course;
	private Integer	courseId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "teacherId")
	@FD("教师")
	private Teacher	teacher;
	private Integer	teacherId;

	@FD("题目类型")
	private String	quesType;	//单选题,多选题,判断题，填空题，简答题
	@FD("难度")
	private String	userType;	//难度, 简单1,中等2,困难3,极难4
	@FD("分值")
	private Integer	score;		//分数
	@FD("题目")
	@Column(length = 1000)
	private String	title;
	@FD("答案")
	private String	answer;
	@FD("选项A")
	@Column(length = 1000)
	private String	option1;
	@FD("选项B")
	@Column(length = 1000)
	private String	option2;
	@FD("选项C")
	@Column(length = 1000)
	private String	option3;
	@FD("选项D")
	@Column(length = 1000)
	private String	option4;

	@Column(updatable = false)
	private Double	zqlv;

	public Double getZqlv() {
		return zqlv;
	}

	public void setZqlv(Double zqlv) {
		this.zqlv = zqlv;
	}

	public Integer getId() {
		return id;
	}

	public Course getCourse() {
		return course;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public String getQuesType() {
		return quesType;
	}

	public String getUserType() {
		return userType;
	}

	public Integer getScore() {
		return score;
	}

	public String getTitle() {
		return title;
	}

	public String getAnswer() {
		return answer;
	}

	public String getOption1() {
		return option1;
	}

	public String getOption2() {
		return option2;
	}

	public String getOption3() {
		return option3;
	}

	public String getOption4() {
		return option4;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setCourse(Course course) {
		this.course = course;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public void setQuesType(String quesType) {
		this.quesType = quesType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public void setOption1(String option1) {
		this.option1 = option1;
	}

	public void setOption2(String option2) {
		this.option2 = option2;
	}

	public void setOption3(String option3) {
		this.option3 = option3;
	}

	public void setOption4(String option4) {
		this.option4 = option4;
	}

}
