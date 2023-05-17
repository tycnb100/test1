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
@Table(name = "t_paper")
@NameStyle(Style.normal)
public class Paper {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer	id;
	@FD("所属科目")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "courseId")
	private Course	course;
	@Column(updatable = false)
	private Integer	courseId;

	private Integer	teacherId;

	@FD("试卷编号")
	@Column(unique = true)
	private String	sid;
	@FD("试卷名称")
	private String	name;
	@FD("考试时长")
	private Integer	examTime;
	@FD("有效")
	private String	youxiao;	//默认:是

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
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

	public String getSid() {
		return sid;
	}

	public String getName() {
		return name;
	}

	public Integer getExamTime() {
		return examTime;
	}

	public String getYouxiao() {
		return youxiao;
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

	public void setSid(String sid) {
		this.sid = sid;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setExamTime(Integer examTime) {
		this.examTime = examTime;
	}

	public void setYouxiao(String youxiao) {
		this.youxiao = youxiao;
	}

}
