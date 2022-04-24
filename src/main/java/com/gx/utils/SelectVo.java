package com.gx.utils;

public class SelectVo {
	private int id ;
	private String text;

	private Integer value;
	private String name;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

	public Integer getValue() {
		return value;
	}
	public void setValue(Integer value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public SelectVo(int id, String text) {
		super();
		this.id = id;
		this.text = text;
	}

	public SelectVo() {
		super();
	}

/*	public SelectVo(Integer value, String name) {
		super();
		this.value = value;
		this.name = name;
	}*/
}
