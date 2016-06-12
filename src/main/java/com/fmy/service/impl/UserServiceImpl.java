package com.fmy.service.impl;

import com.fmy.core.mybatis.dto.PageInfo;
import com.fmy.mapper.UserMapper;
import com.fmy.pojo.User;
import com.fmy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Desc:    用户service实现类
 * Author: joe
 * Date:    2016/6/10
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public PageInfo<User> findPage(User user) {
        return userMapper.findByPage(user).getPageInfo();
    }
}
