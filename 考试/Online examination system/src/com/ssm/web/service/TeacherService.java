package com.ssm.web.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.Teacher;
import com.ssm.util.MD5;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.TeacherMapper;

@Service
@Transactional
public class TeacherService extends BaseService<Teacher> {

	@Autowired
	private TeacherMapper TeacherMapper;

	public void deleteTeacher(String ids) {
		if (ids != null) {
			String[] temp = ids.split(",");
			if (temp == null || temp.length <= 0) {
				throw new RuntimeException("ids error");
			}
			for (String str : temp) {
				mapper.deleteByPrimaryKey(Integer.valueOf(str));
			}
		}
	}

	public void addTeacher(Teacher bean) {
		MD5 md = new MD5();
		bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		mapper.insert(bean);
	}

	public void updateTeacher(Teacher bean) {
		Teacher temp = mapper.selectByPrimaryKey(bean.getId());
		if (StringUtils.isNotBlank(bean.getUserPassword())) {
			MD5 md = new MD5();
			bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		} else {
			bean.setUserPassword(temp.getUserPassword());
		}
		super.updateAll(bean);
	}

	public Teacher findByUname(String uname) {
		Teacher temp = new Teacher();
		temp.setUname(uname);
		return TeacherMapper.selectOne(temp);
	}

}
