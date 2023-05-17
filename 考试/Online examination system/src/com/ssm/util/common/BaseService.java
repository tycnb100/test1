package com.ssm.util.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.persistence.ManyToOne;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.PageHelper;
import com.ssm.util.Page;
import com.ssm.util.SearchParamBean;
import com.ssm.util.SpringBeanFactoryUtils;

import tk.mybatis.mapper.common.Mapper;
import tk.mybatis.mapper.entity.Example;

public abstract class BaseService<T> {
	protected static Logger	log	= Logger.getLogger(BaseService.class);
	@Autowired
	protected Mapper<T>		mapper;

	public Mapper<T> getMapper() {
		return mapper;
	}

	public T get(Object key) {
		T ret = mapper.selectByPrimaryKey(key);
		autoObjectFiled(ret);
		return ret;
	}

	public int save(T entity) {
		return mapper.insert(entity);
	}

	public int add(T entity) {
		return mapper.insert(entity);
	}

	public int delete(Object key) {
		return mapper.deleteByPrimaryKey(key);
	}

	public void deleteAll(String ids) {
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

	public int updateAll(T entity) {
		return mapper.updateByPrimaryKey(entity);
	}

	public int update(T entity) {
		return mapper.updateByPrimaryKey(entity);
	}

	public int updateNotNull(T entity) {
		return mapper.updateByPrimaryKeySelective(entity);
	}

	public List<T> selectByExample(Object example) {
		return mapper.selectByExample(example);
	}

	public List<T> selectAll() {
		List<T> list = mapper.selectAll();
		for (Object t : list) {
			autoObjectFiled(t);
		}
		return list;
	}

	public List<T> selectAll(T t) {
		List<T> list = mapper.select(t);
		for (Object o : list) {
			autoObjectFiled(o);
		}
		return list;
	}

	public List<T> selectAll(Class<T> c, String orderby) {
		return selectAll(c, null, orderby);
	}


	public List<T> selectAll(Class<T> c, Map<String, Object> param) {
		return selectAll(c, param, null);
	}

	public List<T> selectAll(Class<T> c, Map<String, Object> param, String orderby) {
		Example example = new Example(c);

		if (param != null && param.size() > 0) {
			Example.Criteria criteria = example.createCriteria();
			for (String key : param.keySet()) {
				if (param.get(key) instanceof String) {
					criteria.andLike(key, (String) param.get(key));
				} else {
					criteria.andEqualTo(key, param.get(key));
				}
			}
		}
		if (orderby != null)
			example.setOrderByClause(orderby);
		List<T> list = (List<T>) selectByExample(example);
		if (list != null) {
			for (Object t : list) {
				autoObjectFiled(t);
			}
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public Page selectPage(Page p, Class<?> c) {
		Example example = new Example(c);
		Example.Criteria criteria = example.createCriteria();

		SearchParamBean bean = (SearchParamBean) p.getConditonObject();
		LinkedList<String> parmnames = bean.getParmnames();
		LinkedList<Object> parmvalues = bean.getParmvalues();

		for (int i = 0; i < parmnames.size(); i++) {
			String name = parmnames.get(i);
			log.info(name);
			if (parmvalues.get(i) instanceof String) {
				criteria.andLike(name, (String) parmvalues.get(i));
			} else {
				criteria.andEqualTo(name, parmvalues.get(i));
			}
		}

		PageHelper.startPage((p.getCurrentPageNumber()), p.getItemsPerPage());
		example.setOrderByClause("id desc");

		List<Object> list = (List<Object>) selectByExample(example);
		if (list != null) {
			for (Object t : list) {
				autoObjectFiled(t);
			}
		}
		p.setList(list);

		if (p.getTotalNumber() <= 0) {
			int count = mapper.selectCountByExample(example);
			//			log.info("分页总数: " + count);

			p.setTotalNumber(count);
		}

		return p;
	}

	@SuppressWarnings({ "unchecked" })
	public Page selectPage(Page p, Class<?> c, String orderby) {
		Example example = new Example(c);
		Example.Criteria criteria = example.createCriteria();

		SearchParamBean bean = (SearchParamBean) p.getConditonObject();
		LinkedList<String> parmnames = bean.getParmnames();
		LinkedList<Object> parmvalues = bean.getParmvalues();

		for (int i = 0; i < parmnames.size(); i++) {
			String name = parmnames.get(i);
			if (parmvalues.get(i) instanceof String) {
				criteria.andLike(name, (String) parmvalues.get(i));
			} else {
				criteria.andEqualTo(name, parmvalues.get(i));
			}
		}

		PageHelper.startPage((p.getCurrentPageNumber()), p.getItemsPerPage());
		//PageHelper.orderBy("name desc , id asc");

		example.setOrderByClause(orderby);
		List<Object> list = (List<Object>) selectByExample(example);
		if (list != null) {
			for (Object t : list) {
				autoObjectFiled(t);
			}
		}
		p.setList(list);

		if (p.getTotalNumber() <= 0) {
			int count = mapper.selectCountByExample(example);
			//			log.info("分页总数: " + count);

			p.setTotalNumber(count);
		}

		return p;
	}

	protected void autoObjectFiled(Object obj) {
		if (obj == null)
			return;
		try {
			Field[] fs = obj.getClass().getDeclaredFields();
			for (Field field : fs) {
				ManyToOne annotation = field.getAnnotation(ManyToOne.class);
				if (annotation != null) {
					String fieldName = field.getName();
					fieldName = (fieldName.charAt(0) + "").toUpperCase() + fieldName.substring(1, fieldName.length());
					String fetch = annotation.fetch().name();
					if (fetch.equals("EAGER")) {
						//属性的类名
						String className = field.getType().getSimpleName();
						//属性的ServiceID
						String className_ = (className.charAt(0) + "").toLowerCase() + className.substring(1, className.length());
						Object serviceObj = SpringBeanFactoryUtils.getBeanById(className_ + "Service");
						//获取属性的数据库ID
						Method getIdMethod = obj.getClass().getDeclaredMethod("get" + fieldName + "Id");
						Object refId = getIdMethod.invoke(obj);
						if (refId == null) {
							continue;
						}
						//通过Service获取到属性对象值
						//						log.info(serviceObj.getClass());
						//						log.info(serviceObj.getClass().getSuperclass());

						Method getObjectMethod = serviceObj.getClass().getMethod("get", Object.class);
						Object refObject = getObjectMethod.invoke(serviceObj, refId);
						//将属性对象值写入到对象中
						Method setMethod = obj.getClass().getDeclaredMethod("set" + fieldName, field.getType());
						setMethod.invoke(obj, refObject);

						//递归写入对象属性值
						autoObjectFiled(refObject);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
