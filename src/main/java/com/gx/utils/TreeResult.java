package com.gx.utils;

import java.util.List;

public class TreeResult {

	private String name;

    private String value;

    private String pvalue;

    private boolean disabled;

    private boolean selected;

    List<TreeResult> children;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getPvalue() {
		return pvalue;
	}

	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}

	public boolean isDisabled() {
		return disabled;
	}

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}

	public boolean isSelected() {
		return selected;
	}

	public void setSelected(boolean selected) {
		this.selected = selected;
	}
	
	public List<TreeResult> getChildren() {
		return children;
	}

	public void setChildren(List<TreeResult> children) {
		this.children = children;
	}

	public TreeResult(String name, String value, String pvalue, boolean disabled, boolean selected,
			List<TreeResult> children) {
		super();
		this.name = name;
		this.value = value;
		this.pvalue = pvalue;
		this.disabled = disabled;
		this.selected = selected;
		this.children = children;
	}

	public TreeResult() {
		super();
	}

	@Override
	public String toString() {
		return "TreeResult [name=" + name + ", value=" + value + ", pvalue=" + pvalue + ", disabled=" + disabled
				+ ", selected=" + selected + ", children=" + children + "]";
	}
}
