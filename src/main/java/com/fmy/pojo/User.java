package com.fmy.pojo;

import com.fmy.core.mybatis.dto.BaseDto;
import com.fmy.core.mybatis.dto.PageDto;
import com.fmy.core.mybatis.dto.Paginationable;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * Desc:    用户实体
 * Author: joe
 * Date:    2016/6/10
 */
public class User extends BaseDto implements Paginationable {

    private PageDto page = new PageDto();
    private String id;
    private String name;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birth;
    private String gender;
    private String qualification;
    private String interest;
    private String Introduction;

    //search condition fields
    private String birthStart;
    private String birthEnd;

    public PageDto getPage() {
        return page;
    }

    public void setPage(PageDto page) {
        this.page = page;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    public String getIntroduction() {
        return Introduction;
    }

    public void setIntroduction(String introduction) {
        Introduction = introduction;
    }

    public String getBirthStart() {
        return birthStart;
    }

    public void setBirthStart(String birthStart) {
        this.birthStart = birthStart;
    }

    public String getBirthEnd() {
        return birthEnd;
    }

    public void setBirthEnd(String birthEnd) {
        this.birthEnd = birthEnd;
    }

    @Override
    public PageDto getPageDto() {
        return this.page;
    }
}
