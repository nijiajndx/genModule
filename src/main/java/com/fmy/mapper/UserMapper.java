package com.fmy.mapper;

import com.fmy.core.mybatis.dto.PageMyBatis;
import com.fmy.pojo.User;
import com.sun.org.apache.xpath.internal.operations.String;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Desc:    用户mapper
 * Author: joe
 * Date:    2016/6/10
 */
@Repository
public interface UserMapper {

    /**
     *  查询用户分页
     * @param user 查询条件
     * @return 用户分页
     */
    PageMyBatis<User> findByPage(User user);

    /**
     * 添加用户
     * @param user 待添加用户
     */
    void insert(User user);

    /**
     * 修改用户
     * @param user 待修改用户
     */
    void update(User user);

    /**
     * 删除用户
     * @param ids 待删除用户主键列表
     * @return 成功删除用户记录数
     */
    int delete(List<String> ids);

}
