package com.fmy.core.mybatis.dto;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@SuppressWarnings("serial")
public class BaseDto implements Serializable {

	/**
	 * CREATE_TM
	 */
	protected Date createTm;
	/**
	 * CREATE_EMP
	 */
	protected String createEmp;

	/**
	 * UPDATE_EMP
	 */
	protected String updateEmp;

	/**
	 * UPDATE_TM
	 */
	protected Date updateTm;

	protected String orderClause;// 排序字段

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date effcTm; // 生效日期

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date expiredTm; // 失效时间

	public Date getCreateTm() {
		return createTm;
	}

	public void setCreateTm(Date createTm) {
		this.createTm = createTm;
	}

	public String getCreateEmp() {
		return createEmp;
	}

	public void setCreateEmp(String createEmp) {
		this.createEmp = createEmp;
	}

	public String getUpdateEmp() {
		return updateEmp;
	}

	public void setUpdateEmp(String updateEmp) {
		this.updateEmp = updateEmp;
	}

	public Date getUpdateTm() {
		return updateTm;
	}

	public void setUpdateTm(Date updateTm) {
		this.updateTm = updateTm;
	}

	public String getOrderClause() {
		return orderClause;
	}

	public void setOrderClause(String orderClause) {
		this.orderClause = orderClause;
	}

	public Date getEffcTm() {
		return effcTm;
	}

	public void setEffcTm(Date effcTm) {
		this.effcTm = effcTm;
	}

	public Date getExpiredTm() {
		return expiredTm;
	}

	public void setExpiredTm(Date expiredTm) {
		this.expiredTm = expiredTm;
	}

}
