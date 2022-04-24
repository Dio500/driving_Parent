package com.gx.utils;

import com.gx.pojo.TbUser;

import java.io.Serializable;
import java.util.List;

public class JsonReturns<T> implements Serializable{
	/**
	 *
	 */
	private static final long serialVersionUID = -3950809440601671181L;

	private Boolean state;
	private String msg;
	private List<T> date;
	private String rememberme;//是否记住账号

	public List<T> getDate() {
		return date;
	}

	public void setDate(List<T> date) {
		this.date = date;
	}

	public String getRememberme() {
		return rememberme;
	}

	public void setRememberme(String rememberme) {
		this.rememberme = rememberme;
	}

	public Boolean getState() {
		return state;
	}
	public void setState(Boolean state) {
		this.state = state;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
}
