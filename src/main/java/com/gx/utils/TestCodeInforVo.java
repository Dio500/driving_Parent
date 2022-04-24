package com.gx.utils;

import java.io.Serializable;
import java.util.Date;

public class TestCodeInforVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;//验证码
	
	private String phone;//验证码
	
	private long date;//验证码

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public long getDate() {
		return date;
	}

	public void setDate(long date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "TestCodeInforVo [code=" + code + ", phone=" + phone + ", date=" + date + "]";
	}

	
}
