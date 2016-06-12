package com.fmy.service;

import com.fmy.core.mybatis.dto.PageInfo;
import com.fmy.pojo.User;

/**
 * Desc:    用户service接口
 * Author: joe
 * Date:    2016/6/10
 */
public interface UserService {
    PageInfo<User> findPage(User user);
}
