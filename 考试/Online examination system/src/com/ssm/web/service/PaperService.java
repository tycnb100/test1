package com.ssm.web.service;

import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssm.bean.Paper;
import com.ssm.bean.PaperQuestion;
import com.ssm.bean.Question;
import com.ssm.util.StringUtil;
import com.ssm.util.common.BaseService;
import com.ssm.web.dao.PaperMapper;
import com.ssm.web.dao.PaperQuestionMapper;
import com.ssm.web.dao.QuestionMapper;

@Service
@Transactional
public class PaperService extends BaseService<Paper> {

	@Autowired
	private PaperMapper			PaperMapper;
	@Autowired
	private QuestionMapper		questionMapper;

	@Autowired
	private PaperQuestionMapper	paperQuestionMapper;

	public String addPaper(Paper bean, int danxuan, int duoxuan, int panduan, int tiankong, int jianda, int danxuanfen, int duoxuanfen, int panduanfen,
			int tiankongfen, int jiandafen) {
		Question exm = new Question();
		exm.setCourseId(bean.getCourseId());
		exm.setQuesType("单选题");
		List<Question> danxuanlist = questionMapper.select(exm);
		if (danxuanlist.size() < danxuan) {
			return "单选题题目数量不够";
		}

		exm = new Question();
		exm.setQuesType("多选题");
		List<Question> duoxuanlist = questionMapper.select(exm);
		if (duoxuanlist.size() < duoxuan) {
			return "多选题题目数量不够";
		}

		exm = new Question();
		exm.setQuesType("判断题");
		List<Question> panduanlist = questionMapper.select(exm);
		if (duoxuanlist.size() < panduan) {
			return "判断题题目数量不够";
		}

		exm = new Question();
		exm.setQuesType("填空题");
		List<Question> tiankonglist = questionMapper.select(exm);
		if (duoxuanlist.size() < tiankong) {
			return "填空题题目数量不够";
		}

		exm = new Question();
		exm.setQuesType("简答题");
		List<Question> jiandalist = questionMapper.select(exm);
		if (duoxuanlist.size() < jianda) {
			return "简答题题目数量不够";
		}

		PaperMapper.insert(bean);
		String sid = StringUtil.format0String(5, bean.getId());
		bean.setSid(sid);
		PaperMapper.updateByPrimaryKey(bean);

		Random ran = new Random();
		Collections.shuffle(danxuanlist);

		int index = ran.nextInt(danxuanlist.size());
		for (int i = 0; i < danxuan; i++) {
			Question question = danxuanlist.get((index + i) % danxuanlist.size());
			PaperQuestion pp = new PaperQuestion();
			pp.setPaperId(bean.getId());
			pp.setQuestionId(question.getId());
			pp.setQuestionScore(danxuanfen);
			paperQuestionMapper.insert(pp);
		}

		Collections.shuffle(duoxuanlist);
		index = ran.nextInt(duoxuanlist.size());
		for (int i = 0; i < duoxuan; i++) {
			Question question = duoxuanlist.get((index + i) % duoxuanlist.size());
			PaperQuestion pp = new PaperQuestion();
			pp.setPaperId(bean.getId());
			pp.setQuestionId(question.getId());
			pp.setQuestionScore(duoxuanfen);
			paperQuestionMapper.insert(pp);
		}
		Collections.shuffle(panduanlist);
		index = ran.nextInt(panduanlist.size());
		for (int i = 0; i < panduan; i++) {
			Question question = panduanlist.get((index + i) % panduanlist.size());
			PaperQuestion pp = new PaperQuestion();
			pp.setPaperId(bean.getId());
			pp.setQuestionId(question.getId());
			pp.setQuestionScore(panduanfen);
			paperQuestionMapper.insert(pp);
		}
		Collections.shuffle(tiankonglist);
		index = ran.nextInt(tiankonglist.size());
		for (int i = 0; i < tiankong; i++) {
			Question question = tiankonglist.get((index + i) % tiankonglist.size());
			PaperQuestion pp = new PaperQuestion();
			pp.setPaperId(bean.getId());
			pp.setQuestionId(question.getId());
			pp.setQuestionScore(tiankongfen);
			paperQuestionMapper.insert(pp);
		}
		Collections.shuffle(jiandalist);
		index = ran.nextInt(jiandalist.size());
		for (int i = 0; i < jianda; i++) {
			Question question = jiandalist.get((index + i) % jiandalist.size());
			PaperQuestion pp = new PaperQuestion();
			pp.setPaperId(bean.getId());
			pp.setQuestionId(question.getId());
			pp.setQuestionScore(jiandafen);
			paperQuestionMapper.insert(pp);
		}

		return null;

	}

}
