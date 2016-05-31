package com.fmy.core.mybatis.dto;

import java.io.Serializable;
import java.util.List;

public class PageInfo<E> implements Serializable {

	private static final long serialVersionUID = -7457822353324524388L;

	/**
	 * data connection.
	 */
	private List<E> rows;
	/**
	 * pagination information
	 */
	private PageDto pageable;

	private int total;// 总页数

	public List<E> getRows() {
		return rows;
	}

	public void setRows(List<E> rows) {
		this.rows = rows;
	}

	public PageDto getPageable() {
		return pageable;
	}

	public void setPageable(PageDto pageable) {
		this.pageable = pageable;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
}
