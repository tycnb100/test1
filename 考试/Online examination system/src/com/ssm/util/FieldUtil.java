package com.ssm.util;

import java.lang.reflect.Field;
import java.util.LinkedList;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

public class FieldUtil {

	/**
	 * 把fieldValue转换为c类中fieldName属性对应的类型
	 * 
	 * @param c
	 * @param fieldName
	 * @param fieldValue
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static Object format(Class c, String fieldName, String fieldValue) throws Exception {
		Field f = null;
		if (fieldName.contains(".")) {
			String[] ary = fieldName.split("\\.");
			Class tempclass = c;
			for (int i = 0; i < ary.length - 1; i++) {
				f = tempclass.getDeclaredField(ary[i]);
				tempclass = f.getType();
			}
			f = tempclass.getDeclaredField(ary[ary.length - 1]);
		} else {
			f = c.getDeclaredField(fieldName);
		}

		String type = f.getType().getSimpleName();
		if (type.equals("int") || type.equals("Integer")) {
			return Integer.valueOf(fieldValue);
		} else if (type.equals("long") || type.equals("Long")) {
			return Long.valueOf(fieldValue);
		} else if (type.equals("float") || type.equals("Float")) {
			return Float.valueOf(fieldValue);
		} else if (fieldName.endsWith("Time") || fieldName.endsWith("Date")) {
			return fieldValue;
		} else {
			return "%" + fieldValue + "%";
		}
	}

	public static Page createPage(HttpServletRequest request, Class<?> c, LinkedList<String> parmnames, LinkedList<Object> parmvalues) throws Exception {
		return createPage(request, c, parmnames, parmvalues, Constant.SESSION_PAGE);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static Page createPage(HttpServletRequest request, Class<?> c, LinkedList<String> parmnames, LinkedList<Object> parmvalues, String sessionName)
			throws Exception {
		int pageNum = 1;
		String t = request.getParameter("pageCurrent");
		if (StringUtils.isNotBlank(t)) {
			pageNum = Integer.valueOf(t);
		}
		Page p = (Page) request.getSession().getAttribute(sessionName);
		if (pageNum == 1 || p == null) {
			p = new Page();
			p.setCurrentPageNumber(0);
			p.setTotalNumber(0l);
			p.setItemsPerPage(Constant.SESSION_PAGE_NUMBER);

			//			Map<String, String> textmap = new HashMap<String, String>();

			// 页面参数集合
			Set valueset = request.getParameterMap().entrySet();
			for (Object o : valueset) {
				Entry<String, Object> e = (Entry<String, Object>) o;
				String name = e.getKey();// 页面字段名称
				if (name.startsWith("s_")) {
					String fieldValue = request.getParameter(name);// 页面字段值
					if (StringUtils.isNotBlank(fieldValue)) {
						name = name.substring(2, name.length());// 实体字段名称
						parmnames.add(name);
						parmvalues.add(FieldUtil.format(c, name, fieldValue));
						//						textmap.put(name.replaceAll("\\.", ""), fieldValue);
					}
				}
			}
			SearchParamBean sbean = new SearchParamBean();
			sbean.setParmnames(parmnames);
			sbean.setParmvalues(parmvalues);

			p.setConditonObject(sbean);
		} else {
			p.setCurrentPageNumber(pageNum);
		}
		return p;
	}

}
