package com.ssm.web.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.Question;
import com.ssm.bean.SimpleUser;
import com.ssm.bean.UserQuestion;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.QuestionMapper;
import com.ssm.web.dao.SQLMapper;
import com.ssm.web.dao.UserQuestionMapper;

@Service
@Transactional
public class QuestionService extends BaseService<Question> {

	@Autowired
	QuestionMapper questionMapper;
	@Autowired
	private SQLMapper			sqlMapper;
	@Autowired
	private UserQuestionMapper	userQuestionMapper;

	public void addQuesionList(List<Question> list) {
		for (Question question : list) {
			questionMapper.insert(question);
		}
	}


	public void updateUserAnswer(Question q, boolean checkAns, SimpleUser user) {
		//		if (checkAns) {
		//			sqlMapper.updateZheng(q.getId());
		//		} else {
		//			sqlMapper.updateCuo(q.getId());
		//		}
		if (user != null) {
			UserQuestion uq = new UserQuestion();
			uq.setUserId(user.getId());
			uq.setQuestionId(q.getId());
			if (checkAns) {
				userQuestionMapper.delete(uq);
			} else {
				UserQuestion temp = userQuestionMapper.selectOne(uq);
				if (temp == null) {
					userQuestionMapper.insert(uq);
				}
			}
		}
	}

}
