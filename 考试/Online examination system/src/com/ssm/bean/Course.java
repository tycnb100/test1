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
@Table(name = "t_course")
@NameStyle(Style.normal)
public class Course {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer	id;
	@FD("科目名称")
	private String	name;
	@FD("授课教师")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "teacherId")
	private Teacher	teacher;
	private Integer	teacherId;

	public Integer getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

}
