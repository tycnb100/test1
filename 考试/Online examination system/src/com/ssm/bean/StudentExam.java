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
@Table(name = "t_student_exam")
@NameStyle(Style.normal)
public class StudentExam {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer		id;
	@FD("学生")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "studentId")
	private SimpleUser	student;
	private Integer		studentId;
	@FD("试卷")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "paperId")
	private Paper		paper;
	private Integer		paperId;
	@FD("阅卷完毕")
	private String		finished;		//阅卷完毕
	@FD("客观题分值")
	private Integer		keguan;
	@FD("主观题分值")
	private Integer		zhuguan;
	@FD("总分")
	private Integer		zong;

	@FD("考试日期")
	private String		addDate;

	@FD("阅卷教师")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "checkTeacherId")
	private Teacher		checkTeacher;
	private Integer		checkTeacherId;

	private Integer		courseId;

	public Integer getId() {
		return id;
	}

	public SimpleUser getStudent() {
		return student;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public Paper getPaper() {
		return paper;
	}

	public Integer getPaperId() {
		return paperId;
	}

	public String getFinished() {
		return finished;
	}

	public Integer getKeguan() {
		return keguan;
	}

	public Integer getZhuguan() {
		return zhuguan;
	}

	public Integer getZong() {
		return zong;
	}

	public String getAddDate() {
		return addDate;
	}

	public Teacher getCheckTeacher() {
		return checkTeacher;
	}

	public Integer getCheckTeacherId() {
		return checkTeacherId;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setStudent(SimpleUser student) {
		this.student = student;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public void setPaper(Paper paper) {
		this.paper = paper;
	}

	public void setPaperId(Integer paperId) {
		this.paperId = paperId;
	}

	public void setFinished(String finished) {
		this.finished = finished;
	}

	public void setKeguan(Integer keguan) {
		this.keguan = keguan;
	}

	public void setZhuguan(Integer zhuguan) {
		this.zhuguan = zhuguan;
	}

	public void setZong(Integer zong) {
		this.zong = zong;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}

	public void setCheckTeacher(Teacher checkTeacher) {
		this.checkTeacher = checkTeacher;
	}

	public void setCheckTeacherId(Integer checkTeacherId) {
		this.checkTeacherId = checkTeacherId;
	}

	public void setCourseId(Integer courseId) {
		this.courseId = courseId;
	}

}
