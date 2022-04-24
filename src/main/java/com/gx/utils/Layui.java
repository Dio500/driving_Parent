package com.gx.utils;

import java.util.HashMap;
import java.util.List;

public class Layui extends HashMap<String, Object> {
    //private static final long serialVersionUID = 1L;
	public static Layui data(PageBean<?> pages){
        Layui Layui = new Layui();
        Layui.put("code", 0);
        Layui.put("msg", "");
        Layui.put("count", pages.getTotalRows());
        Layui.put("data", pages.getData());
        return Layui;
    }
}

