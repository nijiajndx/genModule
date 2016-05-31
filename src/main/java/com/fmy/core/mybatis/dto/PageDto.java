package com.fmy.core.mybatis.dto;


import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

public class PageDto extends BaseDto {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5049450362712885869L;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	/**
	 * 总页数.
	 */
	public int getTotalPage() {
		if (count == 0) {
			return 0;
		}
		int pageNum = count / pageSize;
		if (count % pageSize > 0) {
			pageNum++;
		}
		total = pageNum;
		return total;
	}
	
	private int pageNo=1;// 当前页数
	private int pageSize = 30; //每页条数
	public static final  int defaultPageSize = 30; //每页条数
	private int total;// 总页数
	private int count;// 总记录数
	
	public int hashCode(){
		return HashCodeBuilder.reflectionHashCode(this);
	}
	
	public boolean equals(Object object) {
		if (!(object instanceof PageDto)) {
			return false;
		}
		PageDto rhs = (PageDto) object;
		return EqualsBuilder.reflectionEquals(this,rhs);
	}
}
