package com.ssm.bean;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.ssm.util.FD;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

@Entity
@Table(name = "t_teacher")
@NameStyle(Style.normal)
public class Teacher {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	private Integer	id;
	@FD("工号")
	@Column(name = "uname", nullable = false, unique = true, length = 20)
	private String	uname;
	@FD("姓名")
	@Column(name = "userName", nullable = false, length = 20)
	private String	userName;
	@Column(name = "userPassword", nullable = false, length = 250)
	private String	userPassword;
	private String	userGender;
	private String	userPhone;
	private String	userEmail;
	private String	userAddress;
	private String	userBirth;

	private String	photo;

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Transient
	public String getFname() {
		return userName + "(" + uname + ")";
	}

	@Transient
	public String getRole() {
		return "教师";
	}

	public Teacher() {
	}

	public Integer getId() {
		return id;
	}

	public String getUname() {
		return uname;
	}

	public String getUserName() {
		return userName;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public String getUserGender() {
		return userGender;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public String getUserBirth() {
		return userBirth;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}

}