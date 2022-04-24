package com.gx.utils;

import java.util.ArrayList;
import java.util.List;

import com.gx.utils.PageBean;

public class PageService<T> {
	public PageBean<T> findByPage(List<T> li, int pageNum, int pageSize) {
		// 封装一个pageBean
		PageBean<T> pageBean = new PageBean<T>();

		//总条数
		int count = li.size();
		
		// 总页数
		int totalPage = count % pageSize == 0 ? count / pageSize : count / pageSize + 1;

		if (pageNum > totalPage) {
			pageNum = totalPage;
		}
		if (pageNum < 1) {
			pageNum = 1;
		}
		
		List<T> list = new ArrayList<T>();
		int num = (pageNum - 1) * pageSize;//每页的起始位置
		int total = count - num >= pageSize ? pageSize : count - num;//每页的条数
		for (int i = num; i < num+total; i++) {
			list.add(li.get(i));
		}

		pageBean.setData(list);
		pageBean.setCurPage(pageNum);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(count);
		pageBean.setTotalPage(totalPage);
		pageBean.setSuccess(true);

		return pageBean;
	}
}
