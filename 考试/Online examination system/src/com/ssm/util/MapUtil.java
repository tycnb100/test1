package com.ssm.util;

import java.util.HashMap;

public class MapUtil {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static HashMap createMap(Object one, Object... objs) {
		HashMap map = new HashMap();

		map.put(one, objs[0]);
		for (int i = 1; i < objs.length;) {
			map.put(objs[i], objs[i + 1]);
			i = i + 2;
		}

		return map;
	}

	public static void main(String[] args) {
		//		Map map = createMap("1", "2");
		//		for (Object k : map.keySet()) {
		//			System.out.println(k + ":" + map.get(k));
		//		}
	}
}
