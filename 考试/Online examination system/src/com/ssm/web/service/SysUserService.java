package com.ssm.web.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.SimpleUser;
import com.ssm.bean.SysUser;
import com.ssm.bean.Teacher;
import com.ssm.util.MD5;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.SimpleUserMapper;
import com.ssm.web.dao.SysUserMapper;
import com.ssm.web.dao.TeacherMapper;

@Service
@Transactional
public class SysUserService extends BaseService<SysUser> {

	@Autowired
	private SysUserMapper		sysUserMapper;
	@Autowired
	private SimpleUserMapper	simpleUserMapper;
	@Autowired
	private TeacherMapper		teacherMapper;

	public Object login(String name, String password, String type) {
		Object obj = null;

		if (type.equals(SysUser.class.getSimpleName())) {
			SysUser temp = new SysUser();
			temp.setUname(name);
			temp.setUserPassword(password);
			obj = sysUserMapper.selectOne(temp);
		} else if (type.equals(SimpleUser.class.getSimpleName())) {
			SimpleUser temp = new SimpleUser();
			temp.setUname(name);
			temp.setUserPassword(password);
			obj = simpleUserMapper.selectOne(temp);
		} else if (type.equals(Teacher.class.getSimpleName())) {
			Teacher temp = new Teacher();
			temp.setUname(name);
			temp.setUserPassword(password);
			obj = teacherMapper.selectOne(temp);
		}
		if (obj != null) {
			autoObjectFiled(obj);
		}

		return obj;
	}

	public void deleteSysUser(String ids) {
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

	public void addSysUser(SysUser bean) {
		MD5 md = new MD5();
		bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		mapper.insert(bean);
	}

	public void updateSysUser(SysUser bean) {
		SysUser temp = mapper.selectByPrimaryKey(bean.getId());
		if (StringUtils.isNotBlank(bean.getUserPassword())) {
			MD5 md = new MD5();
			bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		} else {
			bean.setUserPassword(temp.getUserPassword());
		}
		super.updateAll(bean);
	}

}
