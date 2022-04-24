package com.gx.utils;

import com.gx.pojo.TbUser;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.Serializable;
import java.util.List;

public class JsonReturn implements Serializable{
	private static final long serialVersionUID = -3950809440601671181L;

	private Boolean state;
	private String msg;

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
