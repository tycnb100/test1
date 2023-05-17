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
@Table(name = "t_course_clazz")
@NameStyle(Style.normal)
public class CourseClazz {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer	id;
	@FD("课程")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "courseId")
	private Course	course;
	private Integer	courseId;

	@FD("班级")
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "clazzId")
	private Clazz	clazz;
	private Integer	clazzId;

	public Integer getId() {
		return id;
	}

	public Course getCourse() {
		return course;
	}

	public Integer getCourseId() {
		return courseId;
	}

	public Clazz getClazz() {
		return clazz;
	}

	public Integer getClazzId() {
		return clazzId;
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

	public void setClazz(Clazz clazz) {
		this.clazz = clazz;
	}

	public void setClazzId(Integer clazzId) {
		this.clazzId = clazzId;
	}

}
