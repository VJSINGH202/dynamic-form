package com.adject.dynamicform.model;

public class DynamicForm {
	
	private String className;
	private String id;

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	@Override
	public String toString() {
		return "DynamicForm [className=" + className + "]";
	}

}
