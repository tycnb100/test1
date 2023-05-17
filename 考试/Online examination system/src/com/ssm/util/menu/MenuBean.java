package com.ssm.util.menu;

import java.util.ArrayList;
import java.util.List;

public class MenuBean {
	private String			name;
	private List<SubMenu>	children	= new ArrayList<SubMenu>();

	public MenuBean(String name) {
		super();
		this.name = name;
	}

	public MenuBean() {
		super();
	}

	public String getName() {
		return name;
	}

	public List<SubMenu> getChildren() {
		return children;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setChildren(List<SubMenu> children) {
		this.children = children;
	}

	public void addChild(SubMenu sm) {
		children.add(sm);
	}

	
}
