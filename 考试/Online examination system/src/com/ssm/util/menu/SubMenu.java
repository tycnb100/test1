package com.ssm.util.menu;

public class SubMenu {
	private String	id;
	private String	name;
	private String	target;
	private String	url;
	private boolean	fresh	= true;

	public SubMenu(String id, String name, String target, String url) {
		super();
		this.id = id;
		this.name = name;
		this.target = target;
		this.url = url;
	}

	public boolean isFresh() {
		return fresh;
	}

	public void setFresh(boolean fresh) {
		this.fresh = fresh;
	}

	public SubMenu() {
		super();
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getTarget() {
		return target;
	}

	public String getUrl() {
		return url;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
