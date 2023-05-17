package com.ssm.web.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.SimpleUser;
import com.ssm.util.MD5;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.SimpleUserMapper;

@Service
@Transactional
public class SimpleUserService extends BaseService<SimpleUser> {

	@Autowired
	private SimpleUserMapper simpleUserMapper;

	public void deleteSimpleUser(String ids) {
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

	public void addSimpleUser(SimpleUser bean) {
		MD5 md = new MD5();
		bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		mapper.insert(bean);
	}

	public void updateSimpleUser(SimpleUser bean) {
		SimpleUser temp = mapper.selectByPrimaryKey(bean.getId());
		if (StringUtils.isNotBlank(bean.getUserPassword())) {
			MD5 md = new MD5();
			bean.setUserPassword(md.getMD5ofStr(bean.getUserPassword()));
		} else {
			bean.setUserPassword(temp.getUserPassword());
		}
		super.updateAll(bean);
	}

	public SimpleUser findByUname(String uname) {
		SimpleUser temp = new SimpleUser();
		temp.setUname(uname);
		return simpleUserMapper.selectOne(temp);
	}

}
