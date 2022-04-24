package com.gx.utils;

import java.io.Serializable;
import java.util.List;
/**
 * 
 * @author qzly
 *
 * @param <T>
 */
public class PageBean<T>  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8138184679341404159L;
	private boolean success;
	private int totalRows;//总记录数
	private int curPage;//当前页码
	private List<T> data;//每页的数据list集合
	private int pageSize; //每页显示的条数
	private int  totalPage; // 总页数
	
	
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	@Override
	public String toString() {
		return "Bsgrid [success=" + success + ", totalRows=" + totalRows + ", curPage=" + curPage + ", data=" + data
				+ ", pageSize=" + pageSize + ", totalPage=" + totalPage + "]";
	}
	
	
	
}
